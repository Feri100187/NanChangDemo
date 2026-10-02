// Native scene occlusion and first-contact response, using an isolated firing lane.
async page => {
    await page.goto('http://127.0.0.1:18090');await page.reload();
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
    await page.evaluate(()=>{
        window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
        window.report={};window.bots=level.allBots();
        report.hidden=level.targets.map(b=>level.isSpawnHidden(b.owner.transform.position));
        if(report.hidden.some(v=>!v))throw Error('Initial enemy visible from spawn');
        const ids=level.targets[0].patrolPoints.map(n=>n.name);
        if(ids.length!==16)throw Error('Hostiles still patrol the player entry route');
        for(const b of bots)b.onUpdate=()=>{};
        level.reinforcementEnemies=[];
    });
    const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=level.playerControl.canvas.getBoundingClientRect();return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
    await page.mouse.click(button.x,button.y);await page.waitForTimeout(100);
    await page.evaluate(()=>{
        window.enemy=level.targets[0];window.ally=bots.find(b=>b.friendly);
        enemy.owner.transform.position=new Laya.Vector3(300,0,300);ally.owner.transform.position=new Laya.Vector3(300,0,340);
        enemy.owner.transform.rotationEuler=new Laya.Vector3();ally.owner.transform.rotationEuler=new Laya.Vector3(0,180,0);
        for(const b of [enemy,ally]){b._health=10000;b.combatSpeed=0;b.patrolSpeed=0;b.target=null;b._state='Patrol';b.suspicion=0;b.nextScan=0;b.nextAttackAt=0;b.clearPerception();}
        window.shots=[];for(const b of [enemy,ally])b.owner.on('enemy-fired',report,()=>shots.push({friendly:b.friendly,time:level.clock.now()-report.started}));
    });
    await page.waitForTimeout(100);
    await page.evaluate(()=>{report.started=level.clock.now();for(const b of [enemy,ally])b.onUpdate=Object.getPrototypeOf(b).onUpdate;});
    await page.waitForTimeout(900);
    await page.evaluate(()=>{
        report.firstShots=[false,true].map(f=>shots.find(s=>s.friendly===f)?.time);
        if(report.firstShots.some(t=>t===undefined||t>750))throw Error('Slow/no fire at visible 40m contact: '+JSON.stringify(report.firstShots));
        for(const b of [enemy,ally])b.onUpdate=()=>{};
        const wall=new Laya.Sprite3D('BarrelOnlyBlock');level.world.addChild(wall);
        wall.transform.position=new Laya.Vector3(300.07,1.32,300.35);
        wall.addComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(.3,.18,.05);
        window.wall=wall;
        enemy.nextAttackAt=0;enemy.nextDecision=Infinity;enemy.combatGoal=null;enemy.cover=null;enemy.crouching=false;
    });
    await page.waitForTimeout(100);
    await page.evaluate(()=>{enemy.onUpdate=Object.getPrototypeOf(enemy).onUpdate;report.beforeBlocked=shots.length;});
    await page.waitForTimeout(250);
    await page.evaluate(()=>{
        if(enemy.nextAttackAt!==0||shots.length!==report.beforeBlocked)throw Error('Blocked barrel consumed cooldown');
        report.blockedBarrel=true;wall.destroy();report.unblockedAt=level.clock.now();
    });
    await page.waitForTimeout(250);
    await page.evaluate(()=>{
        if(shots.length<=report.beforeBlocked)throw Error('Did not fire promptly after barrel cleared');
        report.immediateRetry=true;
    });
    await page.evaluate(()=>{
        enemy.onUpdate=()=>{};
        const cover=new Laya.Sprite3D('HeadOnlyCover');level.world.addChild(cover);
        cover.transform.position=new Laya.Vector3(300,.725,320);
        cover.addComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(6,1.45,.2);
        window.lowCover=cover;
    });
    await page.waitForTimeout(100);
    await page.evaluate(()=>{
        enemy.target=ally.owner;
        if(!enemy.canSeePlayer(false)||!enemy.aimAtHead)throw Error('Visible head above cover was ignored');
        report.exposedHead=true;
        lowCover.getComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(6,4,.2);
    });
    await page.waitForTimeout(100);
    await page.evaluate(()=>{if(enemy.canSeePlayer(false))throw Error('Saw through full cover');report.fullCoverBlocks=true;});
    const result=await page.evaluate(()=>report);await page.reload();return result;
}
