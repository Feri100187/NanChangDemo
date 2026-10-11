// Actual-engine regression for the two hand grips and view-axis retraction.
// Run via playwright-cli run-code --filename; works in Web builds and IDE preview.
async page => {
  await page.bringToFront();await page.setViewportSize({width:1334,height:750});await page.reload();
  await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
  await page.evaluate(()=>{
    window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
    window.pc=level.playerControl;window.r=level.rifle;
    const visit=n=>{for(const c of n.components)if(c.animator&&c.player)window.ca=c;for(let i=0;i<n.numChildren;i++)visit(n.getChildAt(i));};visit(pc.owner);
    window.readGrip=()=>{
      const error=[],lengths=[],reach=[];
      for(const a of ca.armIK.arms){
        const j=a.joints,s=j.Upperarm.node.transform.position,e=j.Forearm.node.transform.position,w=j.Hand.node.transform.position;
        error.push(Laya.Vector3.distance(w,a.target.transform.position));
        lengths.push([Laya.Vector3.distance(s,e),Laya.Vector3.distance(e,w)]);
        reach.push(Laya.Vector3.distance(s,a.target.transform.position));
      }
      const cam=pc.followCamera.transform,eye=pc.cameraPosition,c=cam.position,scale=pc.viewModelScale;
      const offset=new Laya.Vector3(pc.weaponPivot.transform.position.x-c.x-(eye.x-c.x)*scale,
        pc.weaponPivot.transform.position.y-c.y-(eye.y-c.y)*scale,
        pc.weaponPivot.transform.position.z-c.z-(eye.z-c.z)*scale),inverse=new Laya.Quaternion();
      Laya.Quaternion.invert(cam.rotation,inverse);Laya.Vector3.transformQuat(offset,inverse,offset);
      const p=r.rifleModel.transform.localPosition,point=new Laya.Vector3(),screen=new Laya.Vector4();
      Laya.Vector3.transformCoordinate(new Laya.Vector3(p.x,p.y+.18,p.z-.7),pc.weaponPivot.transform.worldMatrix,point);
      pc.followCamera.worldToViewportPoint(point,screen);
      return {pitch:pc.pitch,aim:r.aimBlend,crouch:pc.crouchAmount,error,lengths,reach,tuck:pc.weaponGripTuck,
        lateral:Math.hypot(offset.x,offset.y),sightPixels:Math.hypot(screen.x-Laya.stage.width/2,screen.y-Laya.stage.height/2),
        phase:r.reloadPhase,roundVisible:ca.reloadCartridge.active,weapon:r.currentWeapon};
    };
    window.gripFrames=[];window.sampleGrips=false;
    const tick=()=>{if(sampleGrips)gripFrames.push(readGrip());requestAnimationFrame(tick);};requestAnimationFrame(tick);
  });
  await page.waitForTimeout(400);
  const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),rect=pc.canvas.getBoundingClientRect();return{x:rect.x+p.x*rect.width/Laya.stage.width,y:rect.y+p.y*rect.height/Laya.stage.height};});
  await page.mouse.click(button.x,button.y);await page.waitForFunction(()=>pc.isGameplayFocused()&&pc.isGrounded);
  let assertions=0;const check=(ok,label,detail)=>{if(!ok)throw Error(label+': '+JSON.stringify(detail));assertions++;};
  const validate=s=>{
    check(s.error.every(x=>x<.001),'both wrists retain animated grip',s);
    check(s.lengths.every(([a,b])=>Math.abs(a-.33)<.001&&Math.abs(b-.31)<.001),'fixed arm lengths',s);
    check(s.lateral<.0001,'retraction stays on camera axis',s);
    check(Number.isFinite(s.tuck)&&s.tuck>=0,'finite nonnegative retraction',s);
  };
  const poses=[];
  for(const pitch of [0,15,30,45,60,75,85,-45,-70])for(const crouch of [false,true])for(const aim of [false,true]){
    await page.mouse.up({button:'right'});
    if(await page.evaluate(()=>pc.isCrouching)!==crouch)await page.keyboard.press('c');
    await page.evaluate(p=>{pc.pitch=p;pc.updateCameraRotation();},pitch);
    if(aim)await page.mouse.down({button:'right'});
    await page.waitForTimeout(450);
    const sample=await page.evaluate(()=>readGrip());validate(sample);poses.push(sample);
    if(aim)check(sample.sightPixels<1.5,'ADS remains sight aligned',sample);
    const shotSync=await page.evaluate(()=>{const p=pc.weaponPivot.transform.position.clone();pc.syncCameraForShot();return Laya.Vector3.distance(p,pc.weaponPivot.transform.position);});
    check(shotSync<.0001,'shot camera sync preserves rendered weapon position',shotSync);
    if(pitch===45&&!crouch)await page.screenshot({path:`output/playwright/upward-45-${aim?'ads':'hold'}.png`});
  }
  await page.mouse.up({button:'right'});
  if(await page.evaluate(()=>pc.isCrouching))await page.keyboard.press('c');
  await page.evaluate(()=>{pc.pitch=45;pc.updateCameraRotation();});await page.waitForTimeout(500);
  const start=await page.evaluate(()=>readGrip());await page.waitForTimeout(1500);const end=await page.evaluate(()=>readGrip());
  check(Math.abs(start.tuck-end.tuck)<.006,'static grip does not accumulate offset',{start,end});
  await page.evaluate(()=>{gripFrames=[];sampleGrips=true;});
  for(let i=0;i<8;i++){
    await page.evaluate(p=>{pc.pitch=p;pc.updateCameraRotation();},i%2?45:85);
    await page.keyboard.press('c');await page.waitForTimeout(140);
  }
  await page.waitForTimeout(400);
  await page.evaluate(()=>{sampleGrips=false;});const transitions=await page.evaluate(()=>gripFrames);
  transitions.forEach(validate);
  await page.evaluate(()=>{pc.pitch=45;pc.updateCameraRotation();r.magazine=3;r.reserve=45;gripFrames=[];sampleGrips=true;});
  await page.keyboard.press('r');await page.waitForFunction(()=>r.reloadPhase==='insert'&&r.reloadStageProgress>.25);
  await page.keyboard.press('Escape');await page.waitForTimeout(80);const frozen=await page.evaluate(()=>readGrip());
  await page.waitForTimeout(300);const still=await page.evaluate(()=>readGrip());
  check(JSON.stringify(still)===JSON.stringify(frozen),'pause freezes retraction and grip',{frozen,still});
  await page.mouse.click(button.x,button.y);await page.waitForFunction(()=>pc.isGameplayFocused());
  await page.waitForFunction(()=>!r.isReloading);await page.evaluate(()=>{sampleGrips=false;});
  const reload=await page.evaluate(()=>gripFrames);reload.forEach(validate);
  check(await page.evaluate(()=>r.magazine===5&&r.reserve===43),'upward two-round reload preserves ammo');
  await page.mouse.click(670,375);await page.waitForTimeout(100);const shot=await page.evaluate(()=>readGrip());validate(shot);
  check(await page.evaluate(()=>r.magazine===4&&r.boltCycleProgress>=0),'upward shot starts bolt cycle');
  await page.waitForTimeout(1350);validate(await page.evaluate(()=>readGrip()));
  await page.keyboard.press('3');await page.waitForTimeout(100);
  check(await page.evaluate(()=>r.currentWeapon==='knife'&&pc.weaponGripTuck===0),'knife does not inherit rifle retraction');
  await page.keyboard.press('1');await page.waitForTimeout(250);validate(await page.evaluate(()=>readGrip()));
  await page.keyboard.press('Escape');
  return {assertions,poses,transitions,reload,shot};
}
