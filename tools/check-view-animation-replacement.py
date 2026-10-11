"""Prove scoped GLB replacement preserves runtime resources and rejects rig drift.

Run: python -B tools/check-view-animation-replacement.py
Only disposable copies in the OS temporary directory are written.
"""
import copy
import json
import struct
import tempfile
import unittest
from pathlib import Path

from replace_view_animations import VIEW_CLIPS, read_glb, replace_view_animations


def write_glb(path, document, binary):
    document = copy.deepcopy(document)
    document['buffers'][0]['byteLength'] = len(binary)
    binary += b'\0' * (-len(binary) % 4)
    encoded = json.dumps(document, separators=(',', ':')).encode()
    encoded += b' ' * (-len(encoded) % 4)
    data = struct.pack('<III', 0x46546C67, 2, 28 + len(encoded) + len(binary))
    data += struct.pack('<II', len(encoded), 0x4E4F534A) + encoded
    data += struct.pack('<II', len(binary), 0x004E4942) + binary
    path.write_bytes(data)


def fixture():
    identity = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]
    geometry = struct.pack('<3f', 5, 6, 7)
    matrices = struct.pack('<32f', *(identity * 2))
    times = struct.pack('<2f', 0, 1)
    poses = struct.pack('<6f', 0, 0, 0, 1, 2, 3)
    parts = [geometry, matrices, times, poses]
    views, offset = [], 0
    for part in parts:
        views.append({'buffer': 0, 'byteOffset': offset, 'byteLength': len(part)})
        offset += len(part)
    animation = {'channels': [{'sampler': 0, 'target': {'node': 1, 'path': 'translation'}}],
                 'samplers': [{'input': 2, 'output': 3, 'interpolation': 'LINEAR'}]}
    doc = {'asset': {'version': '2.0'}, 'buffers': [{'byteLength': offset}],
           'bufferViews': views,
           'accessors': [
               {'bufferView': 0, 'componentType': 5126, 'count': 1, 'type': 'VEC3'},
               {'bufferView': 1, 'componentType': 5126, 'count': 2, 'type': 'MAT4'},
               {'bufferView': 2, 'componentType': 5126, 'count': 2, 'type': 'SCALAR'},
               {'bufferView': 3, 'componentType': 5126, 'count': 2, 'type': 'VEC3'}],
           'nodes': [{'name': 'Root', 'children': [1]}, {'name': 'Hand'},
                     {'name': 'Body', 'mesh': 0, 'skin': 0}, {'name': 'PlayerRig', 'children': [0, 2]}],
           'skins': [{'name': 'PlayerRig', 'joints': [0, 1], 'inverseBindMatrices': 1}],
           'meshes': [{'primitives': [{'attributes': {'POSITION': 0}, 'material': 0}]}],
           'materials': [{'name': 'HandEditedMaterial', 'doubleSided': True}],
           'scenes': [{'nodes': [3]}], 'scene': 0,
           'extras': {'handEditedResource': True},
           'animations': [{**copy.deepcopy(animation), 'name': name}
                          for name in ['Idle', *VIEW_CLIPS, 'ViewKnifeLight']]}
    return doc, b''.join(parts)


class ReplacementTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='nanchang-view-clips-')
        self.addCleanup(self.temp.cleanup)
        self.target = Path(self.temp.name) / 'target.glb'
        self.exported = Path(self.temp.name) / 'exported.glb'
        self.doc, self.binary = fixture()
        write_glb(self.target, self.doc, self.binary)

    def assert_preserved(self, original, binary, updated, updated_binary):
        self.assertEqual(updated_binary[:len(binary)], binary)
        self.assertEqual(updated['accessors'][:len(original['accessors'])], original['accessors'])
        self.assertEqual(updated['bufferViews'][:len(original['bufferViews'])], original['bufferViews'])
        self.assertEqual([a['name'] for a in updated['animations']], [a['name'] for a in original['animations']])
        for old, new in zip(original['animations'], updated['animations']):
            if old['name'] not in VIEW_CLIPS:
                self.assertEqual(new, old)
        exempt = {'animations', 'accessors', 'bufferViews', 'buffers'}
        self.assertEqual({k: v for k, v in updated.items() if k not in exempt},
                         {k: v for k, v in original.items() if k not in exempt})
        for old, new in zip(original['buffers'], updated['buffers']):
            self.assertEqual({k: v for k, v in old.items() if k != 'byteLength'},
                             {k: v for k, v in new.items() if k != 'byteLength'})

    def assert_rejected(self, source, binary=None):
        original = self.target.read_bytes()
        write_glb(self.exported, source, self.binary if binary is None else binary)
        with self.assertRaises(ValueError):
            replace_view_animations(self.target, self.exported)
        self.assertEqual(self.target.read_bytes(), original)

    def test_remaps_nodes_and_retains_all_existing_resources(self):
        source = copy.deepcopy(self.doc)
        # Different exporter order must not change runtime nodes or clip indices.
        permutation = [1, 2, 3, 0]
        mapping = {old: new for new, old in enumerate(permutation)}
        source['nodes'] = [source['nodes'][old] for old in permutation]
        for node in source['nodes']:
            if 'children' in node:
                node['children'] = [mapping[index] for index in node['children']]
        source['skins'][0]['joints'] = [mapping[index] for index in reversed(source['skins'][0]['joints'])]
        source['scenes'][0]['nodes'] = [mapping[3]]
        source['animations'].reverse()
        for animation in source['animations']:
            animation['channels'][0]['target']['node'] = mapping[1]
        source['materials'][0]['name'] = 'MustNotReplaceTheRuntimeMaterial'
        replacement = self.binary[:-24] + struct.pack('<6f', 8, 9, 10, 11, 12, 13)
        write_glb(self.exported, source, replacement)
        indices = replace_view_animations(self.target, self.exported)
        updated, binary = read_glb(self.target)
        self.assertEqual(indices, dict(zip(VIEW_CLIPS, range(1, 5))))
        self.assert_preserved(self.doc, self.binary, updated, binary)
        # All four clips share two appended accessors/views; no mesh data copied.
        self.assertEqual(len(updated['accessors']), 6)
        self.assertEqual(len(updated['bufferViews']), 6)
        for name, index in indices.items():
            animation = updated['animations'][index]
            self.assertEqual(animation['channels'][0]['target']['node'], 1)
            self.assertEqual(animation['name'], name)
            accessor = updated['accessors'][animation['samplers'][0]['output']]
            view = updated['bufferViews'][accessor['bufferView']]
            self.assertEqual(struct.unpack_from('<6f', binary, view['byteOffset']), (8, 9, 10, 11, 12, 13))

    def test_rejects_bind_pose_and_hierarchy_drift_before_writing(self):
        for mutation in ('pose', 'hierarchy', 'name', 'duplicate_name', 'inverse_bind'):
            with self.subTest(mutation=mutation):
                source, binary = copy.deepcopy(self.doc), self.binary
                if mutation == 'pose':
                    source['nodes'][1]['translation'] = [0, 0.2, 0]
                elif mutation == 'hierarchy':
                    source['nodes'][0]['children'] = []
                    source['nodes'][3]['children'].append(1)
                elif mutation == 'name':
                    source['nodes'][1]['name'] = 'WrongHand'
                elif mutation == 'duplicate_name':
                    source['nodes'][2]['name'] = 'Hand'
                else:
                    binary = binary[:12] + struct.pack('<f', 2) + binary[16:]
                self.assert_rejected(source, binary)

    def test_rejects_missing_duplicate_and_non_skeleton_clips(self):
        for mutation in ('missing', 'duplicate', 'mesh_target', 'sparse', 'truncated_view'):
            with self.subTest(mutation=mutation):
                source = copy.deepcopy(self.doc)
                if mutation == 'missing':
                    del source['animations'][1]
                elif mutation == 'duplicate':
                    source['animations'].append(copy.deepcopy(source['animations'][1]))
                elif mutation == 'mesh_target':
                    source['animations'][1]['channels'][0]['target']['node'] = 2
                elif mutation == 'sparse':
                    source['accessors'][3]['sparse'] = {}
                else:
                    source['bufferViews'][3]['byteLength'] = 999999
                self.assert_rejected(source)

    def test_current_player_roundtrip_retains_non_view_clips(self):
        asset = Path(__file__).resolve().parents[1] / 'assets/resources/characters/Player/AnimatedPlayer.glb'
        original, binary = read_glb(asset)
        self.target.write_bytes(asset.read_bytes())
        self.exported.write_bytes(asset.read_bytes())
        indices = replace_view_animations(self.target, self.exported)
        updated, updated_binary = read_glb(self.target)
        self.assert_preserved(original, binary, updated, updated_binary)
        self.assertEqual(indices, {name: next(i for i, a in enumerate(original['animations']) if a['name'] == name)
                                   for name in VIEW_CLIPS})


if __name__ == '__main__':
    unittest.main(verbosity=2)
