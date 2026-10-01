// Rebuild the editable controllers after prepare-rigged-characters.py and IDE import.
// Never edits a scene or prefab. Their model and component bindings are owned by the IDE.
const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..');
for (const role of ['Player', 'Enemy']) {
    const dir = path.join(root, 'assets/resources/characters', role);
    const file = path.join(dir, `Animated${role}.glb`);
    const bytes = fs.readFileSync(file);
    const gltf = JSON.parse(bytes.subarray(20, 20 + bytes.readUInt32LE(12)).toString());
    const uuid = JSON.parse(fs.readFileSync(file + '.meta', 'utf8')).uuid;
    const states = gltf.animations.map((clip, i) => ({
        id: String(i), name: clip.name,
        clip: { _$uuid: `${uuid}@lani${i}` },
        _isLooping: /Fire|Reload|Melee|Jump/.test(clip.name) ? 2 : 1,
        speed: 1, clipStart: 0, clipEnd: 1,
        x: 280 + (i % 4) * 220, y: 80 + Math.floor(i / 4) * 110,
        soloTransitions: []
    }));
    const idle = states.find(s => s.name === 'Idle');
    if (!idle || states.length < 11) throw new Error('Missing exported animations');
    states.unshift({ id: '-1', name: 'Entry', x: 30, y: 80, soloTransitions: [{ id: idle.id }] });
    const controller = { controllerLayers: [{ name: 'Character', defaultWeight: 1,
        blendingMode: 0, playOnWake: true, states }], animatorParams: [] };
    fs.writeFileSync(path.join(dir, `${role}Animation.controller`), JSON.stringify(controller, null, 2) + '\n');
    console.log(role, states.length - 1, 'states');
}
