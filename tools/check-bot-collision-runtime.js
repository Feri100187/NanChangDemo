// Real Bullet regression. Run in a disposable IDE browser preview:
// playwright-cli -s=wall run-code --filename=tools/check-bot-collision-runtime.js
async page => {
    await page.reload();
    await page.waitForFunction(() => window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c => c.playerControl));
    await page.evaluate(() => {
        window.level = Laya.stage.getChildByName('root').getChildAt(0).components.find(c => c.playerControl);
        window.actors = [level.targets[0], level.teammates[0].components.find(c => c.opponents)];
        for (const b of [...level.targets, ...level.teammates.map(n => n.components.find(c => c.opponents))]) b.enabled = false;
        window.testWalls = [];
        const box = (name,x,y,z,sx,sy,sz,yaw=0) => {
            const n = new Laya.Sprite3D(name); level.world.addChild(n);
            n.transform.position = new Laya.Vector3(x,y,z);
            n.transform.rotationEuler = new Laya.Vector3(0,yaw,0);
            n.addComponent(Laya.PhysicsCollider).colliderShape = new Laya.BoxColliderShape(sx,sy,sz);
            testWalls.push(n);
        };
        box('WallX',100,1.5,100,.2,3,200);
        box('WallZ',220,1.5,100,20,3,.2);
        box('ThinWall',240,1.5,100,.01,3,20);
        box('DiagonalWall',260,1.5,100,.2,3,20,45);
        box('Support',280,-.05,100,10,.1,10);
        // Ground-aware movement must have real support in the isolated lane.
        box('MovementSupport',210,-.05,100,240,.1,220);
        level.setGameplayPaused(false);
    });
    // Let Bullet synchronize the newly created static colliders.
    await page.waitForTimeout(150);
    const report = await page.evaluate(() => {
        level.setGameplayPaused(true);
        const tests = [
            ['+X',98,100,102,100,false], ['-X',102,100,98,100,false],
            ['+Z',220,98,220,102,false], ['-Z',220,102,220,98,false],
            ['diagonal approach',98,99,102,101,false],
            ['thin wall',238,100,242,100,false],
            ['rotated wall',258,100,262,100,false],
            ['leave contact',99.59,100,99.49,100,true],
            ['enter contact',99.59,100,99.69,100,false],
            ['parallel to wall',99.5,100,99.5,101,true],
            ['walk on support',278,100,282,100,true]
        ];
        const report = { checks: [], movement: [] };
        for (const actor of actors) {
            for (const [name,x,z,tx,tz,expected] of tests) {
                for (const navigation of [false,true]) {
                    const actual = actor.patrolSegmentClear(new Laya.Vector3(x,0,z),new Laya.Vector3(tx,0,tz),navigation);
                    if (actual !== expected) throw Error(`${actor.friendly ? 'ally' : 'enemy'} ${name} navigation=${navigation}: ${actual}`);
                    report.checks.push(`${actor.friendly ? 'ally' : 'enemy'} ${name} ${navigation ? 'route' : 'movement'}`);
                }
            }
            // A stale/invalid path must still be stopped by the final movement gate.
            // Run the normal side-step fallback too, from both sides of the wall.
            const originalStep = actor.navigation.step;
            try {
                for (const speed of [2.2,9]) for (const direction of [1,-1]) {
                    actor.owner.transform.position = new Laya.Vector3(100-2*direction,0,100);
                    const goal = new Laya.Vector3(100+2*direction,0,100);
                    actor.navigation.step = () => goal;
                    for (let i=0;i<240;i++) {
                        actor.moveTowards(goal,.05,speed,false);
                        if ((100-actor.owner.transform.position.x)*direction < .395)
                            throw Error('Crossed wall during movement/avoidance');
                    }
                    report.movement.push({friendly:actor.friendly,speed,direction,position:{...actor.owner.transform.position}});
                }
            } finally { actor.navigation.step = originalStep; }
        }
        for (const wall of testWalls) wall.destroy();
        return report;
    });
    await page.reload();
    return report;
}
