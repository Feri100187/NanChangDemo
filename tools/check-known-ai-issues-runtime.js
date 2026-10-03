// Run in a disposable Demo01 browser preview (the runner reloads afterwards):
// playwright-cli run-code --filename=tools/check-known-ai-issues-runtime.js
async page => {
    await page.reload();
    await page.waitForFunction(() => window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c => c.playerControl));
    try {
        return await page.evaluate(async () => {
            const level = Laya.stage.getChildByName('root').getChildAt(0).components.find(c => c.playerControl);
            const bots = level.allBots(), actors = [bots.find(b => !b.friendly), bots.find(b => b.friendly)];
            if (actors.some(b => !b.walkSegmentClear)) throw Error('Preview contains stale controller code');
            for (const b of bots) { b.onUpdate = () => {}; b._health = 10000; }
            level.setGameplayPaused(false);
            const fixtures = [], report = {checks:[], actors:[]};
            const v = (x,y,z) => new Laya.Vector3(x,y,z);
            const check = (name, condition) => { if (!condition) throw Error(name); report.checks.push(name); };
            const sync = () => new Promise(resolve => setTimeout(resolve,100));
            const box = (name,x,y,z,sx,sy,sz,yaw=0) => {
                const n = new Laya.Sprite3D(name); level.world.addChild(n);
                n.transform.position = v(x,y,z); n.transform.rotationEuler = v(0,yaw,0);
                n.addComponent(Laya.PhysicsCollider).colliderShape = new Laya.BoxColliderShape(sx,sy,sz);
                fixtures.push(n); return n;
            };
            box('RegressionGround',450,-.1,450,180,.2,180);
            const corner = box('PeekCorner',400.28,1.5,401.5,.62,3,.2);
            const lowWall = box('EyeAboveMuzzleBelow',420,.725,441,6,1.45,.2);
            const barrelWall = box('BarrelOnly',420.07,1.32,420.35,.3,.18,.05);
            box('EightCentimeterFloor',460,.04,450,5,.08,6);
            box('TooHighStep',480,.2,450,5,.4,6);
            box('FullWall',490,1.5,450,.2,3,10);
            box('ThinWall',510,1.5,450,.01,3,10);
            box('RotatedWall',520,1.5,450,.2,3,10,45);
            box('LowCeilingStep',500,.04,450,5,.08,6);
            box('LowCeiling',500,2,450,5,.2,6);
            await sync();
            for (const b of actors) {
                const target = actors.find(other => other !== b);
                const label = b.friendly ? 'ally' : 'enemy';
                b.enabled=true; b.owner.transform.position=v(400,0,400); b.owner.transform.rotationEuler=v(0,0,0);
                target.owner.transform.position=v(400,0,410); target.owner.transform.rotationEuler=v(0,180,0);
                b.target=target.owner; b.crouching=false; b.crouchBlend=0; b.leaning.value=0; b.updatePosture(0);
                await sync();
                check(label+' unleaned eye blocked by corner',!b.canSeePlayer(false));
                let now=10000, shots=0;
                b.clock={paused:false,timer:{delta:50},now:()=>now};
                b._state='Alert'; b.suspicion=.3; b.cover=b.owner.transform.position.clone(); b.coverLean=1;
                b.nextDecision=now+1000; b.nextScan=Infinity; b.nextAttackAt=0; b.attackInterval=.1;
                b.aimAtHead=false; b.targetPosition().cloneTo(b.lastKnownPosition); b.hasLastKnown=true; b.lastSeenAt=now;
                const fired=()=>shots++; b.owner.on('enemy-fired',report,fired);
                for (let i=0;i<12;i++) {
                    now+=50; Object.getPrototypeOf(b).onUpdate.call(b);
                    if (i>=4) check(label+' leaned eye remains visible frame '+i,b.canSeePlayer(false));
                    check(label+' eye offset does not accumulate '+i,Math.abs(b.observationPoint.transform.position.x-400)<=.1201);
                }
                b.owner.off('enemy-fired',report,fired);
                check(label+' corner peek enters Combat and fires',b.state==='Combat'&&shots>0);
                const projected=b.coverPoint(b.standingMuzzle,b.owner.transform.position,0,b.leanAmount,true);
                const muzzle=b.shotPoint.transform.position;
                check(label+' virtual muzzle matches real leaned rifle',Math.hypot(projected.x-muzzle.x,projected.y-muzzle.y,projected.z-muzzle.z)<.001);
                report.actors.push({label,shots,lean:b.leanAmount});
                b.leaning.value=.5; b.coverLean=0; b._state='Combat'; b.suspicion=1; b.nextAttackAt=0;
                let retractedShots=0; const retractedFire=()=>retractedShots++;
                b.owner.on('enemy-fired',report,retractedFire); now+=50;
                Object.getPrototypeOf(b).onUpdate.call(b);
                b.owner.off('enemy-fired',report,retractedFire);
                check(label+' retracting behind corner never fires using old visibility',!b.canSeePlayer(false)&&retractedShots===0);

                b.owner.transform.position=v(420,0,420); b.owner.transform.rotationEuler=v(0,0,0);
                target.owner.transform.position=v(420,0,430); b.leaning.value=0; b.crouchBlend=0; b.crouching=false;
                b.updatePosture(0); b.updateLean(0); await sync();
                check(label+' barrel fixture leaves eye visibility clear',b.canSeePlayer(false));
                check(label+' barrel obstruction rejects cover',!b.coverCanFire(v(420,0,420),0,0,b.targetPosition()));
                barrelWall.active=false; await sync();
                check(label+' clear barrel accepts firing position',b.coverCanFire(v(420,0,420),0,0,b.targetPosition()));
                barrelWall.active=true;

                b.owner.transform.position=v(420,0,440); target.owner.transform.position=v(421,0,450);
                b.updatePosture(0); b.updateLean(0); await sync();
                check(label+' eyes clear a 1.45m wall',b.canSeePlayer(false));
                const realRandom=Math.random;
                try {
                    Math.random=()=>0; b.nextDecision=0; b.hasLastKnown=true; b.targetPosition().cloneTo(b.lastKnownPosition);
                    b.updateCombatMovement(0,now,true);
                    check(label+' cover selection rejects exposed eye but blocked muzzle',b.cover===null);
                    lowWall.getComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(6,1.05,.2);
                    lowWall.transform.position=v(420,.525,441); await sync();
                    b.nextDecision=0; b.updateCombatMovement(0,now,true);
                    check(label+' cover selection accepts usable low cover',!!b.cover);
                } finally { Math.random=realRandom; }
                lowWall.getComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(6,1.45,.2);
                lowWall.transform.position=v(420,.725,441);

                b.owner.transform.position=v(455,0,450); b.navigation.invalidate();
                const into=v(461,0,450);
                check(label+' route allows 8cm floor riser',b.walkSegmentClear(b.owner.transform.position,into,true));
                for(let i=0;i<65;i++){b.updateGround(.05); b.moveTowards(into,.05,2.2,false);}
                check(label+' walks onto 8cm floor',b.owner.transform.position.x>460.9&&Math.abs(b.owner.transform.position.y-.08)<.005);
                const out=v(455,0,450);
                for(let i=0;i<65;i++){b.updateGround(.05); b.moveTowards(out,.05,2.2,false);}
                check(label+' walks off floor and returns to ground',b.owner.transform.position.x<455.1&&Math.abs(b.owner.transform.position.y)<.005);
                b.owner.transform.position=v(450,1,460); b.verticalSpeed=0;
                for(let i=0;i<30;i++) b.updateGround(.05);
                check(label+' unsupported actor falls and lands',Math.abs(b.owner.transform.position.y)<.005);
                check(label+' 40cm step remains blocked',!b.walkSegmentClear(v(475,0,450),v(480,0,450),true));
                check(label+' stepping up cannot clip low ceiling',!b.walkSegmentClear(v(495,0,450),v(500,0,450),true));
                for(const [name,a,c] of [
                    ['+X',v(488,0,450),v(492,0,450)], ['-X',v(492,0,450),v(488,0,450)],
                    ['diagonal',v(488,0,449),v(492,0,451)], ['thin',v(508,0,450),v(512,0,450)],
                    ['rotated',v(518,0,450),v(522,0,450)]
                ]) check(label+' walking still blocks '+name+' wall',!b.walkSegmentClear(a,c,true));
                b.owner.transform.position=v(488,0,450); b.navigation.invalidate();
                let penetrated=false;
                for(let i=0;i<120;i++){
                    b.updateGround(.05); b.moveTowards(v(492,0,450),.05,9,false);
                    const p=b.owner.transform.position;
                    if(Math.abs(p.z-450)<5.3&&Math.abs(p.x-490)<.39)penetrated=true;
                }
                check(label+' movement and side avoidance never penetrate wall',!penetrated);
            }
            // Normalized support queries in the actual imported church floor.
            const floor = (() => {
                const visit=n=>{
                    if(n.name==='COL_Landmark_RoomFloor')return n;
                    for(let i=0;i<n.numChildren;i++){const found=visit(n.getChildAt(i));if(found)return found;}
                }; return visit(level.world);
            })();
            check('imported church floor fixture exists',!!floor);
            const floorPosition=floor.transform.position.clone(), b=actors[0];
            b.owner.transform.position=v(floorPosition.x,0,floorPosition.z); b.verticalSpeed=0;
            await sync(); b.updateGround(.05);
            check('zero-height actor settles on actual church floor',Math.abs(b.owner.transform.position.y-.08)<.01);
            report.churchFloor={name:floor.name,actorY:b.owner.transform.position.y};
            for(const n of fixtures)n.destroy();
            return report;
        });
    } finally { await page.reload(); }
}
