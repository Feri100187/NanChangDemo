// Run against this branch's complete Web build:
// playwright-cli -s=hands run-code --filename tools/check-rifle-hands-runtime.js
// Temporary ammo/pitch setup stays in this browser; reload restores the scene.
async page => {
  await page.bringToFront();
  await page.setViewportSize({width:1334,height:750});
  await page.reload();
  await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
  await page.evaluate(()=>{
    window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
    window.pc=level.playerControl;window.r=level.rifle;
    window.findNode=(n,name)=>{if(n.name===name)return n;for(let i=0;i<n.numChildren;i++){const hit=findNode(n.getChildAt(i),name);if(hit)return hit;}};
    const visit=n=>{for(const c of n.components)if(c.animator&&c.player)window.ca=c;for(let i=0;i<n.numChildren;i++)visit(n.getChildAt(i));};visit(pc.owner);
    window.handSample=()=>{
      const inv=new Laya.Matrix4x4(),gun=new Laya.Matrix4x4(),s=pc.viewModelScale;
      Laya.Matrix4x4.createAffineTransformation(r.rifleModel.transform.position,r.rifleModel.transform.rotation,new Laya.Vector3(s,s,s),gun);gun.invert(inv);
      const local=v=>{const out=new Laya.Vector3();Laya.Vector3.transformCoordinate(v,inv,out);return [out.x,out.y,out.z];};
      const tip=(name,length)=>{const out=new Laya.Vector3();Laya.Vector3.transformCoordinate(new Laya.Vector3(0,length,0),findNode(ca.animator.owner,name).transform.worldMatrix,out);return local(out);};
      const body=findNode(ca.animator.owner,'L_Hand'),target=findNode(ca.viewArms,'L_Hand');
      return {phase:r.reloadPhase,step:r.reloadStep,progress:r.reloadStageProgress,
        clip:ca.viewAnimator.getControllerLayer(0).getCurrentPlayState().normalizedTime,
        active:ca.reloadCartridge.active,cartridge:local(ca.reloadCartridge.transform.position),
        thumb:tip('R_Thumb_03',.02563664),index:tip('R_Index_03',.01917306),
        wristError:Laya.Vector3.distance(body.transform.position,target.transform.position),
        twist:ca.armIK.arms.map(a=>a.twistRadians),mag:r.magazine,reserve:r.reserve};
    };
    window.runtimePose=()=>{
      const inv=new Laya.Matrix4x4(),m=new Laya.Matrix4x4(),s=pc.viewModelScale,out={};
      Laya.Matrix4x4.createAffineTransformation(r.rifleModel.transform.position,r.rifleModel.transform.rotation,new Laya.Vector3(s,s,s),m);m.invert(inv);
      const walk=n=>{if(n.transform){Laya.Matrix4x4.multiply(inv,n.transform.worldMatrix,m);out[n.name]=Array.from(m.elements);}for(let i=0;i<n.numChildren;i++)walk(n.getChildAt(i));};walk(ca.animator.owner);return out;
    };
    window.beginSamples=()=>{window.handFrames=[];window.samplingHands=true;
      const tick=()=>{if(!window.samplingHands)return;handFrames.push(handSample());requestAnimationFrame(tick);};requestAnimationFrame(tick);};
  });
  const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),rect=pc.canvas.getBoundingClientRect();return {x:rect.x+p.x*rect.width/Laya.stage.width,y:rect.y+p.y*rect.height/Laya.stage.height};});
  await page.waitForTimeout(400);
  await page.mouse.click(button.x,button.y);
  await page.waitForFunction(()=>pc.isGameplayFocused()&&pc.isGrounded);
  const results=[];
  const check=(v,label)=>{if(!v)throw Error(label);results.push(label);};
  const samples=()=>page.evaluate(()=>{window.samplingHands=false;return handFrames;});
  const reload=async (mag,reserve=45)=>{await page.evaluate(([m,b])=>{r.magazine=m;r.reserve=b;beginSamples();},[mag,reserve]);await page.keyboard.press('r');};
  const inspect=(frames,count)=>{
    const active=frames.filter(f=>f.active);
    check(active.length>=count*5,'enough visible frames for '+count+' rounds');
    check(frames.every(f=>!f.active||f.phase==='insert'),'no loose round in prepare/finish');
    const steps=[...new Set(active.map(f=>f.step))];check(steps.length===count,'one visible round per committed insertion: '+count);
    for(const f of active){
      const distances=[f.thumb,f.index].map(t=>Math.hypot(t[0]-f.cartridge[0],t[1]-f.cartridge[1],t[2]-f.cartridge[2]));
      check(distances.every(d=>d<.021),'both fingers remain at the cartridge');
    }
    for(const step of steps){
      const v=active.filter(f=>f.step===step),first=v[0],last=v[v.length-1];
      check(first.cartridge[1]-last.cartridge[1]>.085,'hand carries the round down to the receiver');
      check(Math.abs(last.cartridge[0])<.012&&last.cartridge[1]<.178,'round reaches the receiver before release');
      check(last.clip<.78,'release precedes empty-hand return');
    }
  };
  await reload(4);await page.waitForFunction(()=>!r.isReloading);const one=await samples();inspect(one,1);
  check(await page.evaluate(()=>r.magazine===5&&r.reserve===44),'one-round top-up conserves ammo');
  await reload(3);await page.waitForFunction(()=>!r.isReloading);inspect(await samples(),2);
  check(await page.evaluate(()=>r.magazine===5&&r.reserve===43),'two-round top-up conserves ammo');
  await reload(1);await page.waitForFunction(()=>r.reloadPhase==='insert'&&r.reloadStageProgress>.18);await page.keyboard.press('r');
  await page.waitForFunction(()=>!r.isReloading);inspect(await samples(),1);
  check(await page.evaluate(()=>r.magazine===2&&r.reserve===44),'early finish inserts the held round only');
  await reload(2);await page.waitForFunction(()=>r.reloadPhase==='insert'&&r.reloadStageProgress>.22);
  await page.keyboard.press('Escape');await page.waitForTimeout(80);const frozen=await page.evaluate(()=>handSample());
  await page.waitForTimeout(350);const still=await page.evaluate(()=>handSample());
  check(still.progress===frozen.progress&&JSON.stringify(still.cartridge)===JSON.stringify(frozen.cartridge),'pause freezes hand and cartridge');
  check(still.active===frozen.active,'pause preserves cartridge visibility');
  await page.mouse.click(button.x,button.y);await page.waitForFunction(()=>pc.isGameplayFocused());
  await page.keyboard.press('3');await page.waitForTimeout(100);
  check(await page.evaluate(()=>r.currentWeapon==='knife'&&!r.isReloading&&!ca.reloadCartridge.active&&r.magazine===2&&r.reserve===45),'switching cancels held round without ammo credit');
  await samples();await page.keyboard.press('1');await page.waitForTimeout(200);
  check(await page.evaluate(()=>!ca.reloadCartridge.active),'switching back leaves no floating round');
  const poses=[];
  for(const pitch of [0,-45,-70]){
    await page.evaluate(p=>{pc.pitch=p;pc.updateCameraRotation();},pitch);
    for(const aim of [false,true]){
      if(aim)await page.mouse.down({button:'right'});
      for(let cycle=0;cycle<4;cycle++){
        await page.keyboard.press('c');await page.waitForTimeout(310);
        const sample=await page.evaluate(()=>handSample());poses.push({pitch,aim,cycle,...sample,
          bones:cycle===0?await page.evaluate(()=>runtimePose()):undefined});
        check(sample.wristError<.006,'left grip stays reachable through look/crouch/ADS');
        check(sample.twist.every(Number.isFinite)&&sample.twist.every(x=>Math.abs(x)<4.72),'arm twist stays finite and bounded');
      }
      if(aim)await page.mouse.up({button:'right'});
    }
  }
  await page.evaluate(()=>{pc.pitch=0;pc.updateCameraRotation();});await page.waitForTimeout(250);
  await page.mouse.click(670,370);await page.waitForTimeout(150);
  check(await page.evaluate(()=>r.magazine===1&&r.boltCycleProgress>=0),'fire and bolt cycle still run');
  await page.waitForTimeout(1300);
  check(await page.evaluate(()=>ca.viewState==='ViewHold'&&!ca.reloadCartridge.active),'bolt returns to hold without a loose round');
  await page.keyboard.press('Escape');
  return {passed:results.length,checks:[...new Set(results)],oneRound:one,poses};
}
