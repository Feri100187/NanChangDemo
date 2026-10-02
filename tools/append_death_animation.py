"""Append only Death tracks; preserve existing GLB mesh, skin and clip indices."""
import copy
import json
import struct


def read_glb(path):
    data = path.read_bytes()
    magic, version, length = struct.unpack_from('<III', data)
    if magic != 0x46546C67 or version != 2 or length != len(data):
        raise ValueError(f'Invalid GLB: {path}')
    size = struct.unpack_from('<I', data, 12)[0]
    document = json.loads(data[20:20+size])
    offset = 20 + size
    bin_size, kind = struct.unpack_from('<II', data, offset)
    if kind != 0x004E4942:
        raise ValueError('Expected embedded GLB buffer')
    return document, data[offset+8:offset+8+bin_size]


def append_death_animation(target, exported):
    original, binary = read_glb(target)
    source, source_binary = read_glb(exported)
    animation = copy.deepcopy(next(a for a in source['animations'] if a['name'] == 'Death'))
    nodes = {node.get('name'): i for i, node in enumerate(original['nodes'])}
    # All channels must address the same local bind frame; never silently apply
    # tracks from a changed/replaced rig to a hand-edited runtime skeleton.
    for channel in animation['channels']:
        node = source['nodes'][channel['target']['node']]
        index = nodes[node['name']]
        for key, default in [('translation', [0, 0, 0]), ('rotation', [0, 0, 0, 1]), ('scale', [1, 1, 1])]:
            a, b = node.get(key, default), original['nodes'][index].get(key, default)
            if any(abs(x-y) > 1e-5 for x, y in zip(a, b)):
                raise ValueError(f'Bind frame differs: {node["name"]}/{key}')
        channel['target']['node'] = index
    clips = original.setdefault('animations', [])
    existing = next((i for i, a in enumerate(clips) if a['name'] == 'Death'), None)
    marker = original.get('extras', {}).get('nanChangDeathAppend')
    if marker:
        # Replace the previous generated tail without accumulating orphan data.
        used = {s[k] for a in clips if a['name'] != 'Death' for s in a['samplers'] for k in ['input', 'output']}
        for mesh in original['meshes']:
            for primitive in mesh['primitives']:
                used.update(primitive['attributes'].values())
                if 'indices' in primitive:
                    used.add(primitive['indices'])
                for morph in primitive.get('targets', []):
                    used.update(morph.values())
        used.update(s['inverseBindMatrices'] for s in original['skins'] if 'inverseBindMatrices' in s)
        if any(i >= marker['accessors'] for i in used):
            raise ValueError('Other resources reference generated Death data; preserve the edited GLB')
        view_users = [a['bufferView'] for a in original['accessors'][:marker['accessors']] if 'bufferView' in a]
        view_users += [image['bufferView'] for image in original.get('images', []) if 'bufferView' in image]
        if any(i >= marker['views'] for i in view_users):
            raise ValueError('Other resources reference generated Death buffer views; preserve the edited GLB')
        original['accessors'] = original['accessors'][:marker['accessors']]
        original['bufferViews'] = original['bufferViews'][:marker['views']]
        binary = binary[:marker['bytes']]
    binary = bytearray(binary)
    marker = {'accessors': len(original['accessors']), 'views': len(original['bufferViews']), 'bytes': len(binary)}
    accessors, views = {}, {}
    for sampler in animation['samplers']:
        for key in ['input', 'output']:
            old = sampler[key]
            if old not in accessors:
                accessor = copy.deepcopy(source['accessors'][old])
                if 'sparse' in accessor:
                    raise ValueError('Sparse animation accessor unsupported')
                view_index = accessor['bufferView']
                if view_index not in views:
                    view = copy.deepcopy(source['bufferViews'][view_index])
                    start, size = view.get('byteOffset', 0), view['byteLength']
                    binary.extend(b'\0' * (-len(binary) % 4))
                    view['byteOffset'], view['buffer'] = len(binary), 0
                    binary.extend(source_binary[start:start+size])
                    views[view_index] = len(original['bufferViews'])
                    original['bufferViews'].append(view)
                accessor['bufferView'] = views[view_index]
                accessors[old] = len(original['accessors'])
                original['accessors'].append(accessor)
            sampler[key] = accessors[old]
    animation['extras'] = {**animation.get('extras', {}), 'loop': False}
    if existing is None:
        clips.append(animation)
    else:
        clips[existing] = animation
    original.setdefault('extras', {})['nanChangDeathAppend'] = marker
    original['buffers'][0]['byteLength'] = len(binary)
    binary.extend(b'\0' * (-len(binary) % 4))
    encoded = json.dumps(original, separators=(',', ':')).encode()
    encoded += b' ' * (-len(encoded) % 4)
    result = struct.pack('<III', 0x46546C67, 2, 28+len(encoded)+len(binary))
    result += struct.pack('<II', len(encoded), 0x4E4F534A) + encoded
    result += struct.pack('<II', len(binary), 0x004E4942) + binary
    target.write_bytes(result)
