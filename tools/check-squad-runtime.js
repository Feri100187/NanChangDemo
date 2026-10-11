// playwright-cli -s=squad run-code --filename=tools/check-squad-runtime.js
// Uses a disposable browser preview. Reload restores all fixture-only transforms and HP.
async page => {
    await page.reload();
    await page.waitForFunction(() => window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c => c.playerControl));
    await page.evaluate(() => {
        window.level = Laya.stage.getChildByName('root').getChildAt(0).components.find(c => c.playerControl);
        window.bots = [...level.targets, ...level.teammates.map(n => n.components.find(c => c.opponents))];
        window.squadReport = {};
        if (level.teammates.length !== 5 || level.targets.length !== 8) throw Error('Roster mismatch');
        if (bots.some(b => b.clock !== level.clock)) throw Error('Unshared pause clock');
        const policy = b => [b.patrolRadius,b.patrolSpeed,b.fieldOfView,b.alertTime,b.loseTargetTime,b.turnSpeed];
        if (bots.some(b => JSON.stringify(policy(b)) !== JSON.stringify(policy(bots[0])))) throw Error('Different faction AI policy');
        const find = (n,name) => { if(n.name===name)return n; for(let i=0;i<n.numChildren;i++){const hit=find(n.getChildAt(i),name);if(hit)return hit;} };
        for (const n of level.teammates) if (!find(n,'AllyRig') || find(n,'EnemyRig')) throw Error('Ally uses enemy model');
        for (const b of bots) {
            const height = b.owner.getChildByName('Head').transform.position.y - b.owner.transform.position.y;
            if (Math.abs(height - 1.65) > .01) throw Error('NPC head height: ' + height);
        }
        squadReport.uniformHeadHeight = 1.65; squadReport.playerModelAllies = true; squadReport.sharedPolicy = true;
        level.health._health = 100000; // only the disposable test preview, to keep traversal observable
    });
    const button = await page.evaluate(() => {
        const b = level.continueButton, p = b.localToGlobal(new Laya.Point(b.width / 2, b.height / 2));
        const r = level.playerControl.canvas.getBoundingClientRect();
        return { x: r.x + p.x * r.width / Laya.stage.width, y: r.y + p.y * r.height / Laya.stage.height };
    });
    await page.mouse.click(button.x, button.y);
    await page.waitForFunction(() => level.state === 'Playing');
    await page.evaluate(() => {
        squadReport.enemyStart = level.targets.map(b => ({x:b.owner.transform.position.x,z:b.owner.transform.position.z}));
        squadReport.start = level.teammates.map(n => ({ x: n.transform.position.x, z: n.transform.position.z }));
        squadReport.shots = [];
        for (const b of bots) b.owner.on('enemy-fired', squadReport, () => squadReport.shots.push({ friendly: b.friendly, speed: b.horizontalSpeed }));
    });
    await page.waitForTimeout(9000);
    await page.evaluate(() => {
        squadReport.travel = level.teammates.map((n, i) => Math.hypot(n.transform.position.x - squadReport.start[i].x, n.transform.position.z - squadReport.start[i].z));
        squadReport.enemyTravel = level.targets.map((b,i) => Math.hypot(b.owner.transform.position.x-squadReport.enemyStart[i].x,b.owner.transform.position.z-squadReport.enemyStart[i].z));
        if (squadReport.enemyTravel.filter(d=>d>.5).length < 6) throw Error('Enemies did not actively patrol');
        if (squadReport.travel.some(d => d < .5)) throw Error('A teammate did not move');
        // Isolate two live actors for repeatable native ray/shape queries, away from the map.
        level.owner.components.find(c => c.enemyFlashes)?.stop();
        for (const b of bots) b.enabled = false;
        window.a = bots.find(b => b.friendly); window.e = level.targets[0];
        a.enabled = e.enabled = true;
        a.owner.transform.position = new Laya.Vector3(100, 0, 100);
        e.owner.transform.position = new Laya.Vector3(100, 0, 112);
        a.owner.transform.rotationEuler = new Laya.Vector3(0, 0, 0);
        e.owner.transform.rotationEuler = new Laya.Vector3(0, 180, 0);
        a.target = e.owner; e.target = a.owner;
        a._state = e._state = 'Combat'; a._health = e._health = 100000;
        a.crouching = e.crouching = false; a.updatePosture(1); e.updatePosture(1);
        // Freeze AI callbacks but allow one native physics step to synchronize transforms.
        a.onUpdate = e.onUpdate = () => {};
    });
    await page.waitForTimeout(150);
    await page.evaluate(() => {
        const random = Math.random; let seed = 5791;
        Math.random = () => ((seed = (1664525 * seed + 1013904223) >>> 0) / 4294967296);
        try {
            squadReport.accuracy = [];
            for (const [shooter, victim] of [[a, e], [e, a]]) {
                let hits = 0;
                for (let i = 0; i < 200; i++) {
                    const before = victim.health; shooter.fireAtPlayer();
                    if (victim.health < before) hits++;
                }
                squadReport.accuracy.push(hits);
                if (hits === 0 || hits === 200) throw Error('Shots must both hit and miss: ' + hits);
            }
        } finally { Math.random = random; }
        squadReport.movingFire = [];
        for (const shooter of [a,e]) {
            shooter.hasLastKnown = true; shooter.targetPosition().cloneTo(shooter.lastKnownPosition);
            shooter.cover = null; shooter.nextDecision = Infinity;
            const p = shooter.owner.transform.position;
            shooter.combatGoal = new Laya.Vector3(p.x + 2,p.y,p.z);
            shooter.updateCombatMovement(.05, level.clock.now(), true);
            const count = squadReport.shots.length;
            shooter.fireAtPlayer();
            if (shooter.horizontalSpeed <= .1 || squadReport.shots.length !== count+1) throw Error('Moving shot failed');
            squadReport.movingFire.push(shooter.horizontalSpeed);
        }
        const wall = new Laya.Sprite3D('SquadQA_Cover');
        level.world.addChild(wall); wall.transform.position = new Laya.Vector3(100, 1.5, 106);
        const collider = wall.addComponent(Laya.PhysicsCollider);
        collider.colliderShape = new Laya.BoxColliderShape(8, 3, .6);
        window.qaWall = wall;
    });
    await page.waitForTimeout(100);
    await page.evaluate(() => {
        const before = e.health; a.target = e.owner; a._state = 'Combat';
        for (let i = 0; i < 30; i++) a.fireAtPlayer();
        if (e.health !== before) throw Error('Shot crossed a wall');
        squadReport.wallBlocksDamage = true;
        if (a.patrolSegmentClear(new Laya.Vector3(100,0,100),new Laya.Vector3(100,0,112))) throw Error('Movement crossed a wall');
        squadReport.wallBlocksMovement = true;
        // Ask the incremental route finder to get around the same solid wall.
        const from = new Laya.Vector3(100,0,100), goal = new Laya.Vector3(100,0,112);
        let waypoint = from;
        for (let i=0; i<180 && waypoint === from; i++) waypoint = a.navigation.step(from, goal, 10000,
            (x,y) => a.patrolSegmentClear(x,y,true));
        if (waypoint === from || !a.patrolSegmentClear(from, waypoint, true)) throw Error('No safe route around cover');
        squadReport.detour = {x:waypoint.x,z:waypoint.z};
        qaWall.getComponent(Laya.PhysicsCollider).colliderShape = new Laya.BoxColliderShape(8,1.2,.6);
        qaWall.transform.position = new Laya.Vector3(100,.6,102);
    });
    await page.waitForTimeout(100);
    await page.evaluate(() => {
        a.hasLastKnown = true; e.targetPosition().cloneTo(e.lastKnownPosition);
        a.targetPosition().cloneTo(a.lastKnownPosition);
        a.nextDecision = 0;
        let crouched = false, coverFound = false;
        for (let i=0; i<150; i++) {
            a.updateCombatMovement(.05, 20000+i*50, true);
            coverFound ||= !!a.cover; crouched ||= a.isCrouching;
        }
        if (!coverFound || !crouched) throw Error('Did not seek and crouch behind low cover');
        squadReport.autoCover = true;
        a.crouching = true; a.updatePosture(1);
        squadReport.crouchEye = a.observationPoint.transform.position.y;
        if (squadReport.crouchEye > 1.7) throw Error('Crouch eye stayed standing');
        const anim = []; const visit = n => { for (const c of n.components) if (c.animator) anim.push(c); for (let i=0;i<n.numChildren;i++) visit(n.getChildAt(i)); }; visit(a.owner);
        for (const name of ['HoldWalk','AimWalk','CrouchAim','CrouchAimWalk','Death'])
            if (!anim[0].animator.getControllerLayer(0).getAnimatorState(name)) throw Error('Missing animation ' + name);
        squadReport.animationStates = true;
        level.setGameplayPaused(true);
        const health = e.health, pos = a.owner.transform.position.clone();
        Object.getPrototypeOf(a).onUpdate.call(a); a.fireAtPlayer();
        if (e.health !== health || a.owner.transform.position.x !== pos.x || a.owner.transform.position.z !== pos.z) throw Error('Paused AI changed state');
        squadReport.pause = true;
        qaWall.destroy();
        squadReport.shots = { total: squadReport.shots.length, moving: squadReport.shots.filter(s => s.speed > .1).length };
    });
    return await page.evaluate(() => squadReport);
}
