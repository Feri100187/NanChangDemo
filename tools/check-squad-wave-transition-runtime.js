// Native regression: clearing a wave must not require the player to catch up
// before allies resume marching. Fixtures are discarded by the final reload.
async page => {
    await page.reload();
    await page.waitForFunction(()=>Laya.stage.getChildByName('root')?.getChildAt(0)?.components.some(c=>c.playerControl),null,{timeout:15000});
    try {
        const before=await page.evaluate(()=>{
            window.tl=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
            tl.state='Playing';tl.resultPanel.visible=false;tl.setGameplayPaused(false);tl.health._health=10000;
            tl.playerControl.onUpdate=()=>{};
            tl.playerControl.releaseGameplayFocus=()=>{};
            for(const b of tl.targets)b.onUpdate=()=>{};
            const place=(x,z)=>{const p=new Laya.Vector3(x,1.1,z);tl.player.transform.position=p;tl.playerControl.controller.position=p;tl.playerControl.updateCamera();};
            const trigger=tl.waves[0].triggerPoint.transform.position;place(trigger.x,trigger.z);tl.updateWaves();
            if(!tl.waveActive)throw Error('Fixture did not start wave one');
            place(-48,-8);
            tl.teammates.forEach((n,i)=>{
                n.transform.position=new Laya.Vector3(-48+(i===4?-2.8:i%2?1.5:-1.5),0,-22+Math.floor(i/2)*2);
                const b=n.components.find(c=>c.opponents);b.hearGunshot(tl.waves[0].owner.transform.position);
            });
            tl.waves[0].enemies.forEach(n=>n.components.find(c=>c.opponents).applyHit(n,100000));tl.updateWaves();tl.updateSquadFollow();
            if(tl.nextWave!==1||tl.waveActive)throw Error('Wave did not clear');
            if(tl.teammates.some(n=>n.components.find(c=>c.opponents).hasHeardGunfire))throw Error('Old gunfire search survived wave clearance');
            return {player:tl.player.transform.position.clone(),progress:tl.teammates.map(n=>tl.missionRoute.progress(n.transform.position))};
        });
        await page.waitForTimeout(7500);
        const marched=await page.evaluate(old=>{
            const progress=tl.teammates.map(n=>tl.missionRoute.progress(n.transform.position));
            if(Laya.Vector3.distance(tl.player.transform.position,old.player)>.3)throw Error('Player moved during fixture');
            if(progress.some((p,i)=>p<old.progress[i]+6))throw Error('Allies waited for stationary player: '+JSON.stringify({old,progress}));
            if(tl.nextWave!==1||tl.waveActive||tl.waves[1].enemies.some(n=>n.activeInHierarchy))throw Error('Allies triggered next wave');
            return {progress,advanced:progress.map((p,i)=>p-old.progress[i])};
        },before);
        await page.waitForTimeout(6500);
        const staged=await page.evaluate(()=>{
            const next=tl.missionRoute.progress(tl.waves[1].triggerPoint.transform.position);
            const progress=tl.teammates.map(n=>tl.missionRoute.progress(n.transform.position));
            if(progress.some(p=>p>next+.1))throw Error('Allies passed the assembly point');
            if(tl.waveActive)throw Error('Wave started without player');
            const trigger=tl.waves[1].triggerPoint.transform.position,p=new Laya.Vector3(trigger.x,1.1,trigger.z);
            tl.player.transform.position=p;tl.playerControl.controller.position=p;tl.updateWaves();
            if(!tl.waveActive||tl.nextWave!==1)throw Error('Player could not activate wave two');
            return {progress,next,playerTriggered:true};
        });
        return {before,marched,staged};
    } finally {await page.reload();}
}
