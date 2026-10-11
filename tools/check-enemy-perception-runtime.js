// Run in a disposable Demo01 preview; fixtures are discarded by the final reload.
// playwright-cli run-code --filename=tools/check-enemy-perception-runtime.js
// Historical pre-wave fixture; lane canEngage/region policies must be isolated before reuse.
async page => {
    await page.reload();
    await page.waitForFunction(() => window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components.some(c => c.playerControl));
    try {
        return await page.evaluate(async () => {
            const level = Laya.stage.getChildByName('root').getChildAt(0).components.find(c => c.playerControl);
            const bots = level.allBots(), enemy = bots.find(b => !b.friendly), ally = bots.find(b => b.friendly);
            const player = level.player, report = {checks: []};
            const v = (x,y,z) => new Laya.Vector3(x,y,z);
            const check = (name, condition) => { if (!condition) throw Error(name); report.checks.push(name); };
            const sync = () => new Promise(resolve => setTimeout(resolve, 80));
            const box = (name,x,y,z,sx,sy,sz) => {
                const node = new Laya.Sprite3D(name); level.world.addChild(node);
                node.transform.position = v(x,y,z);
                node.addComponent(Laya.PhysicsCollider).colliderShape = new Laya.BoxColliderShape(sx,sy,sz);
                return node;
            };
            for (const b of bots) b.onUpdate = () => {};
            level.playerControl.onUpdate = () => {};
            level.setGameplayPaused(false);
            box('PerceptionGround',500,-.1,500,100,.2,100);
            const placePlayer = (x,y,z) => {
                const position = v(x,y,z);
                player.transform.position = position;
                level.playerControl.controller.position = position;
                level.playerControl.updateCamera();
            };
            let now = 10000, shots = 0;
            enemy.owner.on('enemy-fired', report, () => shots++);
            const reset = () => {
                enemy.enabled = true; enemy._health = 10000;
                enemy.owner.transform.position = v(500,0,500);
                enemy.owner.transform.rotationEuler = v(0,0,0);
                enemy.clock = {paused: false, timer: {delta: 50}, now: () => now};
                enemy.player = player; enemy.opponents = [];
                enemy.target = null; enemy.clearPerception(); enemy._state = 'Patrol';
                enemy.heardUntil = 0; enemy.searchGoal = null;
                enemy.nextScan = 0; enemy.nextAttackAt = 0; enemy.nextDecision = Infinity;
                enemy.cover = null; enemy.combatGoal = null; enemy.turnSpeed = 240;
                enemy.patrolPoints = []; enemy.patrolRadius = 0; enemy.spawnPosition = v(500,0,500);
                enemy.patrolSpeed = 0; enemy.combatSpeed = 0; enemy.sprintSpeed = 0;
                enemy.crouching = false; enemy.crouchBlend = 0; enemy.leaning.value = 0;
                enemy.updatePosture(0); shots = 0;
            };
            const tick = (count = 1) => {
                for (let i = 0; i < count; i++) { now += 50; Object.getPrototypeOf(enemy).onUpdate.call(enemy); }
            };
            reset(); await sync();
            for (const distance of [2,5.9,6,6.1,20]) {
                for (const angle of [-135,135,180]) {
                    const r = angle*Math.PI/180;
                    placePlayer(500+Math.sin(r)*distance,1.1,500+Math.cos(r)*distance);
                    await sync(); enemy.target = player;
                    check(`rear invisible at ${distance}m / ${angle}deg`, !enemy.canSeePlayer(true));
                }
                placePlayer(500,1.1,500+distance);
                await sync(); enemy.target = player;
                check(`front visible at ${distance}m`, enemy.canSeePlayer(true));
            }
            reset();
            for (let i = 0; i < 20; i++) {
                placePlayer(501,1.1,492+i*.35);
                await sync(); tick(2);
            }
            check('silent rear approach never acquired or fired', !enemy.target && !enemy.hasLastKnown && shots === 0);
            check('silent rear approach never turned toward player', Math.abs(enemy.owner.transform.rotationEuler.y) < .01);

            reset(); placePlayer(502,1.1,498); await sync();
            enemy.turnSpeed = 0; // Hold orientation while testing hearing versus sight.
            enemy.hearGunshot(v(500,0,520)); tick(40);
            check('gunshot search does not acquire an unseen rear player', !enemy.target && !enemy.hasLastKnown && shots === 0);
            check('gunshot search keeps the event position snapshot', enemy.heardPosition.z === 520);

            reset(); placePlayer(500,1.1,510); await sync(); tick(20);
            check('front contact acquires and fires with real physics', enemy.target === player && enemy.state === 'Combat' && shots > 0);
            report.frontShots = shots;
            ally.owner.transform.position = v(502,0,498); ally._health = 10000;
            enemy.opponents = [ally.owner]; await sync(); tick(20);
            check('combat does not switch to a closer unseen rear opponent', enemy.target === player);

            ally.owner.transform.position = v(530,0,530);
            placePlayer(502,1.1,498); enemy.opponents = []; await sync();
            tick(1);
            check('existing visual memory retains the current target', enemy.target === player && enemy.hasLastKnown);
            enemy.clearPerception(); enemy._state = 'Alert'; enemy.turnSpeed = 0;
            enemy.owner.transform.rotationEuler = v(0,0,0); shots = 0; tick(20);
            check('expired memory cannot reacquire a rear player through Alert', !enemy.hasLastKnown && shots === 0);

            reset(); enemy.target = player; await sync();
            const hit = enemy.applyHit(enemy.owner.getChildByName('Torso'), 1);
            check('being hit still alerts and locates an unobstructed current threat', hit.damage > 0 && enemy.state === 'Alert' && enemy.hasLastKnown);

            reset(); placePlayer(500,1.1,510);
            box('PerceptionWall',500,2,505,8,4,.3); await sync(); tick(20);
            check('opaque wall prevents front acquisition and firing', !enemy.target && !enemy.hasLastKnown && shots === 0);
            return report;
        });
    } finally {
        await page.reload();
    }
}
