// Rebuild the editable controllers after prepare-rigged-characters.py and IDE import.
// Never edits a scene or prefab. Their model and component bindings are owned by the IDE.
const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..');
for (const role of (process.argv[2] ? [process.argv[2]] : ['Player', 'Enemy'])) {
    if (!['Player','Enemy'].includes(role)) throw new Error('Role must be Player or Enemy');
    const dir = path.join(root, 'assets/resources/characters', role);
    const file = path.join(dir, `Animated${role}.glb`);
    const bytes = fs.readFileSync(file);
    const gltf = JSON.parse(bytes.subarray(20, 20 + bytes.readUInt32LE(12)).toString());
    const uuid = JSON.parse(fs.readFileSync(file + '.meta', 'utf8')).uuid;
    const states = gltf.animations.map((clip, i) => ({
        id: String(i), name: clip.name,
        clip: { _$uuid: `${uuid}@lani${i}` },
        _isLooping: /Fire|Reload|Melee|Jump|ViewBolt|ViewKnifeLight|ViewKnifeHeavy|Death/.test(clip.name) ? 2 : 1,
        speed: 1, clipStart: 0, clipEnd: 1,
        x: 280 + (i % 4) * 220, y: 80 + Math.floor(i / 4) * 110,
        soloTransitions: []
    }));
    const idle = states.find(s => s.name === 'Idle');
    if (!idle || states.length < 11) throw new Error('Missing exported animations');
    if (process.argv.includes('--death-only')) {
        if (role !== 'Enemy') throw new Error('--death-only requires Enemy');
        const controllerPath = path.join(dir, 'EnemyAnimation.controller');
        const controller = JSON.parse(fs.readFileSync(controllerPath, 'utf8'));
        const layer = controller.controllerLayers[0];
        const generated = states.find(s => s.name === 'Death');
        if (!generated) throw new Error('Missing exported Death');
        const existing = layer.states.find(s => s.name === 'Death');
        if (existing) Object.assign(existing, {clip:generated.clip, _isLooping:2, speed:1,
            clipStart:0, clipEnd:1, soloTransitions:[], transitions:[]});
        else layer.states.push({...generated, id:String(Math.max(...layer.states.map(s => Number(s.id)))+1)});
        fs.writeFileSync(controllerPath, JSON.stringify(controller, null, 2) + '\n');
        console.log('Enemy: updated only non-looping Death; preserved other states');
        continue;
    }
    if (role === 'Player') {
        for (const prefix of ['View', '', 'Crouch']) {
            const original = states.find(s => s.name === `${prefix}Reload`);
            for (const [phase, start, end] of [['Prepare',0,.34],['Insert',.34,.48],['Finish',.65,1]]) {
                const i = states.length;
                states.push({...original, id:String(i), name:`${prefix}Reload${phase}`,
                    clipStart:start, clipEnd:end, _isLooping:2,
                    x:280+(i%4)*220, y:80+Math.floor(i/4)*110, soloTransitions:[]});
            }
        }
    }
    states.unshift({ id: '-1', name: 'Entry', x: 30, y: 80, soloTransitions: [{ id: idle.id }] });
    const controller = { controllerLayers: [{ name: 'Character', defaultWeight: 1,
        blendingMode: 0, playOnWake: true, states }], animatorParams: [] };
    fs.writeFileSync(path.join(dir, `${role}Animation.controller`), JSON.stringify(controller, null, 2) + '\n');
    console.log(role, states.length - 1, 'states');
}
