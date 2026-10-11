"""Replace four first-person clips without re-exporting the runtime player mesh.

The existing GLB's resources and animation indices are retained. Only referenced
animation accessors/buffer views are appended; unused old clip data is harmless.
"""
import copy
import json
import math
import struct
from pathlib import Path


VIEW_CLIPS = ('ViewHold', 'ViewAim', 'ViewBolt', 'ViewReload')
_IDENTITY = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]


def read_glb(path):
    """Read the single embedded buffer used by the character exporter."""
    data = Path(path).read_bytes()
    if len(data) < 28 or struct.unpack_from('<III', data) != (0x46546C67, 2, len(data)):
        raise ValueError(f'Invalid GLB header: {path}')
    chunks = []
    offset = 12
    while offset < len(data):
        if offset + 8 > len(data):
            raise ValueError(f'Truncated GLB chunk: {path}')
        length, kind = struct.unpack_from('<II', data, offset)
        offset += 8
        if length % 4 or offset + length > len(data):
            raise ValueError(f'Invalid GLB chunk length: {path}')
        chunks.append((kind, data[offset:offset + length]))
        offset += length
    if [kind for kind, _ in chunks] != [0x4E4F534A, 0x004E4942]:
        raise ValueError('Expected JSON and one embedded BIN chunk')
    document = json.loads(chunks[0][1])
    buffers = document.get('buffers', [])
    binary = chunks[1][1]
    if len(buffers) != 1 or 'uri' in buffers[0]:
        raise ValueError('Only one embedded buffer is supported')
    size = buffers[0]['byteLength']
    if size < 0 or not size <= len(binary) <= size + 3:
        raise ValueError('Embedded buffer length differs from GLB header')
    return document, binary


def _close(a, b):
    return len(a) == len(b) and all(
        math.isfinite(x) and math.isfinite(y) and abs(x - y) <= 1e-5
        for x, y in zip(a, b))


def _view(document, binary, index):
    view = document['bufferViews'][index]
    start, size = view.get('byteOffset', 0), view['byteLength']
    if view.get('buffer') != 0 or start < 0 or size < 0 or start + size > document['buffers'][0]['byteLength']:
        raise ValueError(f'Invalid animation buffer view: {index}')
    if view.get('extensions'):
        raise ValueError('Extended/compressed animation buffer views are unsupported')
    return view, binary[start:start + size]


def _inverse_bind_matrices(document, binary, skin):
    if 'inverseBindMatrices' not in skin:
        return [_IDENTITY] * len(skin['joints'])
    accessor = document['accessors'][skin['inverseBindMatrices']]
    if accessor.get('sparse') or accessor.get('extensions') or accessor.get('normalized'):
        raise ValueError('Unsupported inverse bind matrix accessor')
    if accessor['type'] != 'MAT4' or accessor['componentType'] != 5126 or accessor['count'] != len(skin['joints']):
        raise ValueError('Invalid inverse bind matrix accessor')
    view, data = _view(document, binary, accessor['bufferView'])
    stride, start = view.get('byteStride', 64), accessor.get('byteOffset', 0)
    if start < 0 or stride < 64 or start + (accessor['count'] - 1) * stride + 64 > len(data):
        raise ValueError('Inverse bind matrices exceed their buffer view')
    return [struct.unpack_from('<16f', data, start + i * stride) for i in range(accessor['count'])]


def _rig(document):
    if len(document.get('skins', [])) != 1:
        raise ValueError('Expected exactly one player skeleton')
    nodes, parents, by_name = document['nodes'], {}, {}
    for index, node in enumerate(nodes):
        name = node.get('name')
        if name:
            by_name.setdefault(name, []).append(index)
        for child in node.get('children', []):
            if not 0 <= child < len(nodes) or child in parents:
                raise ValueError('Invalid or multiply parented skeleton node')
            parents[child] = index
    skin = document['skins'][0]
    joints = skin['joints']
    if not joints or len(set(joints)) != len(joints):
        raise ValueError('Empty or duplicate skeleton joints')
    relevant = set()
    for joint in joints:
        ancestors = set()
        while joint is not None:
            if not 0 <= joint < len(nodes) or joint in ancestors:
                raise ValueError('Invalid or cyclic skeleton hierarchy')
            ancestors.add(joint)
            relevant.add(joint)
            joint = parents.get(joint)
    for index in relevant:
        name = nodes[index].get('name')
        if not name or len(by_name[name]) != 1:
            raise ValueError(f'Unnamed or ambiguous skeleton node: {name}')
    names = {nodes[index]['name']: index for index in relevant}
    joint_names = [nodes[index]['name'] for index in joints]
    return skin, names, parents, joint_names


def _map_skeleton(original, binary, source, source_binary):
    target_skin, target_names, target_parents, target_joints = _rig(original)
    source_skin, source_names, source_parents, source_joints = _rig(source)
    if set(target_names) != set(source_names) or set(target_joints) != set(source_joints):
        raise ValueError('Exported skeleton names differ from the runtime player')
    node_map = {index: target_names[name] for name, index in source_names.items()}
    for name, source_index in source_names.items():
        target_index = target_names[name]
        if node_map.get(source_parents.get(source_index)) != target_parents.get(target_index):
            raise ValueError(f'Skeleton parent differs: {name}')
        a, b = source['nodes'][source_index], original['nodes'][target_index]
        if 'matrix' in a or 'matrix' in b:
            if any(key in a or key in b for key in ('translation', 'rotation', 'scale')):
                raise ValueError(f'Incompatible matrix/TRS bind frame: {name}')
            if not _close(a.get('matrix', _IDENTITY), b.get('matrix', _IDENTITY)):
                raise ValueError(f'Bind frame differs: {name}/matrix')
        else:
            for key, default in [('translation', [0, 0, 0]), ('rotation', [0, 0, 0, 1]), ('scale', [1, 1, 1])]:
                av, bv = a.get(key, default), b.get(key, default)
                equal = _close(av, bv)
                if key == 'rotation':
                    equal = equal or _close(av, [-x for x in bv])
                if not equal:
                    raise ValueError(f'Bind frame differs: {name}/{key}')
    target_matrices = dict(zip(target_joints, _inverse_bind_matrices(original, binary, target_skin)))
    source_matrices = dict(zip(source_joints, _inverse_bind_matrices(source, source_binary, source_skin)))
    for name, matrix in source_matrices.items():
        if not _close(matrix, target_matrices[name]):
            raise ValueError(f'Inverse bind matrix differs: {name}')
    return node_map


def _clips(document):
    result = {}
    for name in VIEW_CLIPS:
        matches = [i for i, clip in enumerate(document.get('animations', [])) if clip.get('name') == name]
        if len(matches) != 1:
            raise ValueError(f'Expected exactly one animation named {name}')
        result[name] = matches[0]
    return result


def replace_view_animations(target, exported):
    """Replace ViewHold/Aim/Bolt/Reload in target; return their retained indices.

    All compatibility checks and the complete output are prepared before the
    target is written, so a validation failure leaves target unchanged. Meshes,
    textures, skin, scene nodes, non-view clips and all old BIN bytes are preserved.
    """
    original, binary = read_glb(target)
    source, source_binary = read_glb(exported)
    target_clips, source_clips = _clips(original), _clips(source)
    node_map = _map_skeleton(original, binary, source, source_binary)
    binary = bytearray(binary)
    accessors, views = {}, {}
    for name in VIEW_CLIPS:
        animation = copy.deepcopy(source['animations'][source_clips[name]])
        if animation.get('extensions'):
            raise ValueError('Animation extensions are unsupported')
        for channel in animation['channels']:
            target_node = channel['target']
            if channel.get('extensions') or target_node.get('extensions'):
                raise ValueError('Animation channel extensions are unsupported')
            if target_node.get('path') not in ('translation', 'rotation', 'scale') or target_node.get('node') not in node_map:
                raise ValueError(f'Animation targets a non-skeleton transform: {name}')
            target_node['node'] = node_map[target_node['node']]
        for sampler in animation['samplers']:
            if sampler.get('extensions'):
                raise ValueError('Animation sampler extensions are unsupported')
            for key in ('input', 'output'):
                old = sampler[key]
                if old not in accessors:
                    accessor = copy.deepcopy(source['accessors'][old])
                    if 'sparse' in accessor or accessor.get('extensions') or 'bufferView' not in accessor:
                        raise ValueError('Sparse/extended/bufferless animation accessor is unsupported')
                    view_index = accessor['bufferView']
                    if view_index not in views:
                        view, data = _view(source, source_binary, view_index)
                        view = copy.deepcopy(view)
                        binary.extend(b'\0' * (-len(binary) % 4))
                        view['byteOffset'], view['buffer'] = len(binary), 0
                        binary.extend(data)
                        views[view_index] = len(original['bufferViews'])
                        original['bufferViews'].append(view)
                    accessor['bufferView'] = views[view_index]
                    accessors[old] = len(original['accessors'])
                    original['accessors'].append(accessor)
                sampler[key] = accessors[old]
        original['animations'][target_clips[name]] = animation
    original['buffers'][0]['byteLength'] = len(binary)
    binary.extend(b'\0' * (-len(binary) % 4))
    encoded = json.dumps(original, separators=(',', ':')).encode('utf-8')
    encoded += b' ' * (-len(encoded) % 4)
    result = struct.pack('<III', 0x46546C67, 2, 28 + len(encoded) + len(binary))
    result += struct.pack('<II', len(encoded), 0x4E4F534A) + encoded
    result += struct.pack('<II', len(binary), 0x004E4942) + binary
    Path(target).write_bytes(result)
    return target_clips
