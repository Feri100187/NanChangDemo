// Real keyboard, animation and Bullet checks in a disposable preview.
// playwright-cli -s=wall run-code --filename=tools/check-lean-sprint-runtime.js
async page => {
    await page.reload();
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
    await page.evaluate(()=>{
        window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
        window.pc=level.playerControl;
        window.bots=[...level.targets,...level.teammates.map(n=>n.components.find(c=>c.opponents))];
        for(const b of bots)b.enabled=false;
        window.report={};
    });
    const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=pc.canvas.getBoundingClientRect();return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
    await page.mouse.click(button.x,button.y);
    await page.waitForFunction(()=>pc.isGrounded);
    const read=()=>page.evaluate(()=>({lean:pc.leanAmount,x:pc.followCamera.transform.position.x,z:pc.followCamera.transform.position.z,roll:pc.followCamera.transform.rotationEuler.z}));
    const base=await read();
    await page.keyboard.down('q');await page.waitForTimeout(350);const left=await read();
    await page.keyboard.up('q');await page.waitForTimeout(300);const center=await read();
    await page.keyboard.down('e');await page.waitForTimeout(350);const right=await read();
    if(left.lean>-.95||right.lean<.95||Math.abs(center.lean)>.01||left.x>=base.x-.1||right.x<=base.x+.1)throw Error('Q/E lean/release failed '+JSON.stringify({base,left,center,right}));
    await page.keyboard.down('q');await page.waitForTimeout(300);if(Math.abs((await read()).lean)>.01)throw Error('Q+E must center');
    await page.keyboard.up('q');await page.keyboard.up('e');
    await page.keyboard.down('c');await page.keyboard.up('c');await page.waitForTimeout(350);
    await page.keyboard.down('e');await page.waitForTimeout(350);
    if((await read()).lean<.95)throw Error('Crouched lean failed');
    const ammo=await page.evaluate(()=>level.rifle.magazine ?? level.rifle.ammoInMagazine);
    await page.mouse.click(600,400);await page.waitForTimeout(100);
    if(await page.evaluate(()=>level.rifle.magazine)!==ammo-1)throw Error('Cannot shoot while leaning');
    await page.screenshot({path:'output/playwright/lean-player.png'});
    await page.keyboard.up('e');await page.waitForTimeout(300);
    await page.evaluate(({base,left,right,center})=>{
        Object.assign(report,{base,left,right,center});
        window.find=(n,p)=>{if(p(n))return n;for(let i=0;i<n.numChildren;i++){const hit=find(n.getChildAt(i),p);if(hit)return hit;}};
        report.ai=[];
        for(const b of [bots[0],bots.find(b=>b.friendly)]){
            b.enabled=true;b.owner.transform.position=new Laya.Vector3(100,0,b.friendly?130:100);
            b.owner.transform.rotationEuler=new Laya.Vector3();
            b.onUpdate=()=>{};
            b.crouching=false;b.leanRequest=1;b.updatePosture(1);b.updateLean(.25);
            const head=b.observationPoint.transform.position;
            if(b.leanAmount<.95||head.x>99.9)throw Error('AI lean did not move exposed head');
            const anim=find(b.owner,n=>n.components.some(c=>c.leanPose)).components.find(c=>c.leanPose);
            anim.onUpdate();anim.onAfterSceneUpdate();
            if(!anim.leanPose.applied)throw Error('AI upper-body lean absent');
            b.leaning.value=0;b.leanRequest=0;b.updatePosture(1);
            const goal=new Laya.Vector3(120,0,b.friendly?130:100);
            b.moveTowards(goal,.05,b.sprintSpeed,false);anim.onUpdate();
            if(!b.isSprinting||b.horizontalSpeed<8.9||anim.current!=='HoldRun')throw Error('AI sprint animation failed');
            let shots=0;const fired=()=>shots++;b.owner.on('enemy-fired',report,fired);
            b._state='Combat';b.target=level.player;b.fireAtPlayer();
            if(shots!==0)throw Error('Sprint allowed shooting');
            b.sprinting=false;b.fireAtPlayer();
            if(shots!==1)throw Error('Shooting did not resume after sprint');
            b.owner.off('enemy-fired',report,fired);
            report.ai.push({friendly:b.friendly,speed:b.horizontalSpeed,animation:anim.current,sprintFireBlocked:true});
        }
        const wall=new Laya.Sprite3D('LeanWallFixture');level.world.addChild(wall);
        wall.transform.position=new Laya.Vector3(300.3,1.6,300);
        wall.addComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(.1,2,3);
        window.leanWall=wall;
    },{base,left,right,center});
    await page.waitForTimeout(100);
    await page.evaluate(()=>{
        pc.leaning.value=0;
        pc.leaning.update(1,.25,pc.owner,new Laya.Vector3(300,1.6,300),new Laya.Vector3(1,0,0));
        report.blockedLean=pc.leanAmount;
        if(pc.leanAmount*.12>.07)throw Error('Lean crossed the wall');
        leanWall.destroy();
        pc.clearInput();if(pc.leanAmount!==0)throw Error('Lost focus retained lean');
        report.focusReset=true;
    });
    const result=await page.evaluate(()=>report);
    await page.reload();
    return result;
}
