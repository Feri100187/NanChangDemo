// Run in a disposable preview: playwright-cli run-code --filename=tools/check-lane-mission-runtime.js
async page => {
    await page.reload();
    await page.waitForFunction(() => window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components.some(c => c.playerControl), null, {timeout: 15000});
    const errors = [], errorHandler = e => errors.push(e.message);
    page.on('pageerror', errorHandler);
    try {
        await page.evaluate(() => {
            window.level = Laya.stage.getChildByName('root').getChildAt(0).components.find(c => c.playerControl);
            window.laneReport = {checks: [], waves: []};
            window.laneAllyStarts = level.teammates.map(n => n.transform.position.clone());
            if (level.waves.length !== 7 || level.targets.length !== 21 || level.teammates.length !== 5) throw Error('Roster mismatch');
        });
        const button = await page.evaluate(() => {
            const b=level.continueButton, p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=level.playerControl.canvas.getBoundingClientRect();
            return {x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};
        });
        await page.mouse.click(button.x,button.y);
        await page.waitForTimeout(8000);
        await page.evaluate(async () => {
            if(level.state!=='Playing'||level.health.health!==100||level.targets.some(b=>b.owner.activeInHierarchy))throw Error('Opening safety failed');
            const assembly=level.missionRoute.progress(level.waves[0].triggerPoint.transform.position);
            if(level.teammates.some(n=>level.missionRoute.progress(n.transform.position)>assembly))throw Error('Ally passed the first assembly point');
            if(level.teammates.some((n,i)=>Laya.Vector3.distance(n.transform.position,laneAllyStarts[i])<2))throw Error('Ally failed to scout while player stood still');
            if(level.teammates.some(n=>level.missionRoute.progress(n.transform.position)<2))throw Error('Ally stuck behind the stationary player');
            laneReport.checks.push('8 seconds at spawn: no enemy, no damage, five allies advance toward first assembly point');
            for(const b of level.allBots()) b.onUpdate=()=>{};
            level.playerControl.onUpdate=()=>{};
            // Pause-state fixtures keep the browser lock; releasing it would
            // enqueue an unrelated asynchronous controls-lost event.
            level.playerControl.releaseGameplayFocus=()=>{};
            level.onUpdate=()=>{};
            // Geometry fixture uses open leaves; closed/open interaction is
            // covered independently by check-openables-runtime.js.
            for(const opening of level.openings) if(!opening.isOpen) opening.toggle();
            const deadline=performance.now()+5000;
            while(level.openings.some(o=>o.currentAngle<94)&&performance.now()<deadline)
                await new Promise(resolve=>setTimeout(resolve,50));
            if(level.openings.some(o=>o.currentAngle<94))throw Error('Opening fixture failed to finish');
            window.laneCheck=(ok,name)=>{if(!ok)throw Error(name);laneReport.checks.push(name);};
            window.laneStep=()=>Object.getPrototypeOf(level).onUpdate.call(level);
            window.lanePlace=(x,z)=>{
                const p=new Laya.Vector3(x,1.1,z);level.player.transform.position=p;level.playerControl.controller.position=p;
                level.playerControl.updateCamera();
            };
            const probe=level.teammates[0].components.find(c=>c.opponents);
            const points=level.missionRoutePoints.map(n=>n.transform.position);
            for(let i=1;i<points.length;i++)laneCheck(probe.walkSegmentClear(points[i-1],points[i],true),'main route segment '+i+' traversable');
            for(const n of level.teammates)laneCheck(probe.groundHeight(n.transform.position,1)!==null,n.name+' supported by ground');
            // Door and window fixtures sample both house orientations and the mission hall.
            for(const [x,z,fx,fz] of [[-68,0,1,0],[-68,8,1,0],[88,-12,0,1]]){
                const from=new Laya.Vector3(x+fx*.8,0,z+fz*.8),to=new Laya.Vector3(x-fx*.8,0,z-fz*.8);
                laneCheck(probe.walkSegmentClear(from,to,true),`door ${x},${z} admits a standing actor`);
                const wx=x+(fz? -7.2:0),wz=z+(fx?2.4:0);
                laneCheck(!probe.trace(new Laya.Vector3(wx+fx*.7,1.55,wz+fz*.7),new Laya.Vector3(wx-fx*.7,1.55,wz-fz*.7),probe.sightRay),`window ${wx},${wz} admits a shot`);
                laneCheck(!probe.walkSegmentClear(new Laya.Vector3(wx+fx*.7,0,wz+fz*.7),new Laya.Vector3(wx-fx*.7,0,wz-fz*.7),true),`window ${wx},${wz} blocks walking`);
            }
            const last=level.waves[6].triggerPoint.transform.position;
            lanePlace(last.x,last.z);laneStep();
            laneCheck(!level.waveActive && level.nextWave===0,'cannot skip directly to wave seven');
        });
        for(let i=0;i<7;i++){
            await page.evaluate(index=>{
                const w=level.waves[index],p=w.triggerPoint.transform.position;
                lanePlace(p.x,p.z);
                level.state='Paused';level.setGameplayPaused(true);laneStep();
                laneCheck(!w.enemies.some(n=>n.activeInHierarchy),'paused trigger does not spawn wave '+(index+1));
                level.state='Playing';level.setGameplayPaused(false);laneStep();
                laneCheck(level.waveActive&&level.nextWave===index&&w.enemies.every(n=>n.activeInHierarchy),'activate wave '+(index+1));
                laneCheck(level.waves.slice(index+1).every(w=>w.enemies.every(n=>!n.activeInHierarchy)),'future waves remain inactive after '+(index+1));
            },i);
            await page.waitForTimeout(120);
            await page.evaluate(index=>{
                const w=level.waves[index];
                laneCheck(w.enemies.every(n=>level.isSpawnHidden(n.transform.position)),'wave '+(index+1)+' spawns behind building cover');
                const active=w.enemies.map(n=>n.components.find(c=>c.opponents));
                active.forEach(b=>laneCheck(b.clock===level.clock&&b.territoryCenter===w.owner,'wave actor initialized'));
                const center=w.owner.transform.position;lanePlace(center.x,center.z);
                level.broadcastGunfire(level.player);
                laneCheck(active.every(b=>b.hasHeardGunfire),'same-region gunshot alerts wave '+(index+1));
                active.forEach(b=>b.heardUntil=0);
                const other=level.waves[index===0?1:0].owner.transform.position;lanePlace(other.x,other.z);
                level.broadcastGunfire(level.player);
                laneCheck(active.every(b=>!b.hasHeardGunfire),'other-region gunshot does not alert wave '+(index+1));
                const probe=active[0], origin=probe.owner.transform.position.clone();
                for(let step=0;step<80;step++)probe.updatePatrol(.05);
                laneCheck(Laya.Vector3.distance(probe.owner.transform.position,center)<=10.1,'patrol remains local in wave '+(index+1));
                if(index<6){
                    const next=level.waves[index+1].triggerPoint.transform.position;lanePlace(next.x,next.z);laneStep();
                    laneCheck(level.nextWave===index&&!level.waves[index+1].enemies.some(n=>n.activeInHierarchy),'uncleared wave blocks next trigger '+(index+1));
                }
                lanePlace(origin.x,origin.z);
                active.forEach(b=>b.applyHit(b.owner,100000));laneStep();
                laneCheck(level.remaining.size===21-(index+1)*3,'wave '+(index+1)+' deaths counted exactly once');
                laneCheck(level.nextWave===index+1&&!level.waveActive,'clearing wave waits for next approach '+(index+1));
                active.forEach(b=>b.applyHit(b.owner,100000));
                laneCheck(level.remaining.size===21-(index+1)*3,'duplicate deaths do not advance count');
                laneReport.waves.push({wave:index+1,remaining:level.remaining.size});
            },i);
        }
        await page.evaluate(()=>{
            laneCheck(!level.exitUnlocked,'document required after all waves');
            lanePlace(104,-8);laneStep();laneCheck(level.state==='Playing','exit without document does not win');
            lanePlace(88,-20.4);
            level.playerControl.yaw=0;
            const eye=level.playerControl.followCamera.transform.position,doc=level.missionDocument.transform.position;
            level.playerControl.pitch=-Math.atan2(eye.y-doc.y,eye.z-doc.z)*180/Math.PI;
            level.playerControl.updateCameraRotation();level.playerControl.isGameplayFocused=()=>true;
            laneCheck(level.canCollectDocument(),'mission document reachable and visible from inside the hall');
            level.onInteractDown({keyCode:70,nativeEvent:{repeat:false}});
            laneCheck(level.documentCollected&&!level.missionDocument.activeInHierarchy,'F collects document');
            lanePlace(104,-8);laneStep();laneCheck(level.state==='Won','white exit completes the mission');
        });
        const report=await page.evaluate(()=>laneReport);
        await page.evaluate(async()=>{await level.restart();});
        await page.waitForTimeout(150);
        await page.evaluate(()=>{
            const fresh=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
            if(fresh.state!=='Ready'||fresh.remaining.size!==21||fresh.nextWave!==0||fresh.targets.some(b=>b.owner.activeInHierarchy)||fresh.documentCollected)throw Error('Restart did not reset waves/document');
        });
        if(errors.length)throw Error(errors.join('\n'));
        report.checks.push('restart resets all waves and document');report.errors=errors;return report;
    } finally {page.off('pageerror',errorHandler);await page.reload();}
}
