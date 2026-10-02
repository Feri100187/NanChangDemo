// Run in a disposable IDE preview. Fixtures accelerate deadlines, never the saved game.
async page => {
    await page.goto('http://127.0.0.1:18090');await page.reload();
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
    await page.evaluate(()=>{
        window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
        window.pc=level.playerControl;window.report={};
        const p=level.player.transform.position;
        report.initialDistances=level.targets.map(b=>Math.hypot(b.owner.transform.position.x-p.x,b.owner.transform.position.z-p.z));
        if(report.initialDistances.some(d=>d<35))throw Error('An initial enemy spawned nearby');
        if(level.reinforcementEnemies.length!==4||level.reinforcementEnemies.some(n=>n.active))throw Error('Reserves not hidden');
        for(const b of level.allBots())b.onUpdate=()=>{};
    });
    const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=pc.canvas.getBoundingClientRect();return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
    await page.mouse.click(button.x,button.y);await page.waitForFunction(()=>pc.isGrounded);
    await page.evaluate(()=>{
        if(level.allBots().some(b=>b.hasHeardGunfire||b.target))throw Error('Actors knew targets before contact');
        const b=level.targets[0],random=Math.random;Math.random=()=>.314;
        try {
            b.patrolIndex=0;b.choosePatrolPoint();const first=b.patrolIndex;
            const p=level.player.transform.position.clone();level.player.transform.position=new Laya.Vector3(400,1,400);
            b.patrolIndex=0;b.choosePatrolPoint();level.player.transform.position=p;
            if(first!==b.patrolIndex)throw Error('Patrol route depends on hidden player position');
            report.independentPatrol=true;
        } finally {Math.random=random;}
    });
    // Real player gunfire, rather than a synthetic perception event.
    await page.mouse.down({button:'left'});await page.mouse.up({button:'left'});await page.waitForTimeout(100);
    await page.evaluate(()=>{
        const bots=level.allBots();
        if(bots.some(b=>!b.hasHeardGunfire)||!level.pendingCall)throw Error('Gunfire did not alert all actors/call reserves');
        report.alerted=bots.length;
        const heard=bots[0].heardPosition.clone(),p=level.player.transform.position.clone();
        level.player.transform.position=new Laya.Vector3(-25,p.y,25);
        if(bots.some(b=>b.heardPosition.x!==heard.x||b.heardPosition.z!==heard.z))throw Error('Hearing tracked hidden movement');
        level.player.transform.position=p;report.snapshotOnly=true;
        const old=Array.from(level.remaining);level.remaining.clear();
        if(level.exitUnlocked||level.canCollectDocument())throw Error('Pending reinforcements allowed mission completion');
        old.forEach(b=>level.remaining.add(b));
        const at=level.pendingCall.at;level.onPlayerGunfire();
        if(level.pendingCall.at!==at)throw Error('Repeated fire reset/duplicated the call');
        level.setGameplayPaused(true);report.pausedAt=level.clock.now();
    });
    await page.waitForTimeout(350);
    await page.evaluate(()=>{
        if(Math.abs(level.clock.now()-report.pausedAt)>1||level.reserveIndex!==0)throw Error('Pause advanced reinforcements');
        level.state="Playing";level.setGameplayPaused(false);
        // A killed caller cannot complete the radio call.
        const caller=level.pendingCall.caller,hp=caller._health;caller._health=0;
        level.updateReinforcements();caller._health=hp;
        if(level.pendingCall)throw Error('Dead caller still dispatched');
        level.nextCallAt=0;caller._state='Patrol';level.onPlayerGunfire();
        level.reinforcementDistance=1000;level.pendingCall.at=level.clock.now();level.updateReinforcements();
        if(level.reserveIndex!==0||!level.pendingCall)throw Error('Unsafe spawn was forced');
        level.reinforcementDistance=35;level.pendingCall.at=level.clock.now();level.updateReinforcements();
        if(level.reserveIndex!==2||level.targets.length!==10||level.remaining.size!==10)throw Error('First wave registration failed');
        const player=level.player.transform.position;
        report.waveDistances=level.reinforcementEnemies.slice(0,2).map(n=>Math.hypot(n.transform.position.x-player.x,n.transform.position.z-player.z));
        if(report.waveDistances.some(d=>d<35))throw Error('Reserve spawned close to current player');
        for(const n of level.reinforcementEnemies.slice(0,2)){
            const b=n.components.find(c=>c.opponents);b.onUpdate=()=>{};
            if(!n.active||b.clock!==level.clock||!b.hasHeardGunfire)throw Error('Spawn lifecycle/alert failed');
        }
        caller._state='Patrol';level.onPlayerGunfire();if(level.pendingCall)throw Error('Call ignored cooldown');
        level.nextCallAt=0;caller._state='Patrol';level.onPlayerGunfire();level.pendingCall.at=level.clock.now();level.updateReinforcements();
        if(level.reserveIndex!==4||level.targets.length!==12||level.remaining.size!==12)throw Error('Second wave failed');
        level.nextCallAt=0;caller._state='Patrol';level.onPlayerGunfire();if(level.pendingCall)throw Error('Unbounded reinforcement spawning');
        const reserve=level.targets[8],count=level.remaining.size;
        reserve.applyHit(reserve.owner,1000);reserve.applyHit(reserve.owner,1000);
        if(level.remaining.size!==count-1)throw Error('Reserve death not counted exactly once');
        report.waves=2;report.pause=true;report.cooldown=true;report.safeSpawnDeferral=true;report.deathCounting=true;
    });
    const result=await page.evaluate(()=>report);await page.reload();
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
    const reset=await page.evaluate(()=>{const l=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);return l.targets.length===8&&l.reserveIndex===0&&!l.pendingCall&&l.reinforcementEnemies.every(n=>!n.active);});
    if(!reset)throw Error('Restart retained reserve state');result.restart=true;return result;
}
