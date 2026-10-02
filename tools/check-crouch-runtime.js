// 浏览器定点回归：先在 LayaAir IDE 启动 Demo01 预览，再以 Playwright CLI 打开预览地址。
// playwright-cli -s=crouch run-code --filename tools/check-crouch-runtime.js
// 使用真实键盘与物理；临时屋顶只存在于测试页面。运行完暂停游戏。
async page => {
  await page.bringToFront();
  await page.setViewportSize({width:1334,height:750});
  await page.reload();
  await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
  await page.evaluate(()=>{
    window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
    window.pc=level.playerControl;
    window.ca=pc.owner.components.find(c=>c.animator);
    if(!ca){const visit=n=>{for(const c of n.components)if(c.animator&&c.player)window.ca=c;for(let i=0;i<n.numChildren;i++)visit(n.getChildAt(i));};visit(pc.owner);}
  });
  const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=pc.canvas.getBoundingClientRect();return {x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
  await page.mouse.click(button.x,button.y);
  await page.waitForFunction(()=>pc.isGameplayFocused());
  await page.waitForFunction(()=>pc.isGrounded);
  await page.waitForTimeout(250);
  await page.evaluate(()=>{const walk=n=>{if(n.name==='Hip')window.hip=n;for(let i=0;i<n.numChildren;i++)walk(n.getChildAt(i));};walk(ca.animator.owner);});
  const assert=(v,s)=>{if(!v)throw Error(s);};
  const read=()=>page.evaluate(()=>({crouch:pc.isCrouching,amount:pc.crouchAmount,height:pc.controller.height,eye:pc.followCamera.transform.position.y,state:ca?.current,ground:pc.isGrounded}));
  const report={standing:await read()};
  await page.evaluate(()=>{window.samples=[];const until=performance.now()+1500;function sample(){samples.push({amount:pc.crouchAmount,eye:pc.followCamera.transform.position.y,state:ca.current,fade:ca.animator.getControllerLayer(0)._playType,hip:window.hip?.transform.position.y});if(performance.now()<until)requestAnimationFrame(sample);}requestAnimationFrame(sample);});
  await page.keyboard.down('c');
  await page.waitForTimeout(400);
  report.held=await read();
  await page.keyboard.down('c');
  await page.waitForTimeout(100);
  report.repeat=await read();
  await page.keyboard.up('c');
  await page.waitForTimeout(100);
  report.released=await read();
  report.samples=await page.evaluate(()=>samples);
  assert(report.held.crouch&&report.repeat.crouch&&report.released.crouch,'hold/repeat/release must remain crouched');
  assert(report.samples.some(s=>s.amount>0&&s.amount<1),'missing intermediate eye positions');
  assert(report.samples.some(s=>s.fade===1||s.fade===2),'missing bone animation blend');
  await page.screenshot({path:'output/playwright/crouch-held.png'});
  await page.keyboard.press('c');await page.waitForTimeout(400);
  report.stood=await read();assert(!report.stood.crouch&&report.stood.amount===0,'second press must stand');
  await page.keyboard.press('c');await page.waitForTimeout(65);await page.keyboard.press('c');await page.waitForTimeout(400);
  report.reversal=await read();assert(!report.reversal.crouch&&report.reversal.amount===0,'rapid reversal must stand');
  await page.screenshot({path:'output/playwright/crouch-standing.png'});
  // 用运行时临时碰撞体检验真实头顶遮挡，不修改场景资产。
  await page.keyboard.press('c');await page.waitForTimeout(350);
  await page.evaluate(()=>{const roof=new Laya.Sprite3D('CrouchQARoof');pc.owner.scene.addChild(roof);const p=pc.owner.transform.position;roof.transform.position=new Laya.Vector3(p.x,1.55,p.z);roof.addComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(3,.1,3);window.qaRoof=roof;});
  await page.waitForTimeout(100);await page.keyboard.press('c');await page.waitForTimeout(350);
  report.blocked=await read();assert(report.blocked.crouch&&report.blocked.height===1.2,'roof must prevent standing');
  await page.evaluate(()=>qaRoof.destroy());await page.waitForTimeout(350);
  report.clear=await read();assert(!report.clear.crouch,'pending stand must complete after clearance');
  await page.keyboard.press('c');await page.waitForTimeout(350);await page.keyboard.press('Escape');
  await page.keyboard.press('c');await page.waitForTimeout(100);
  report.paused=await read();assert(report.paused.crouch,'paused C must not change posture');
  await page.mouse.click(button.x,button.y);await page.waitForFunction(()=>pc.isGameplayFocused());
  report.resumed=await read();assert(report.resumed.crouch,'resume must retain crouch');
  await page.keyboard.press('c');await page.waitForTimeout(350);
  await page.keyboard.press('Space');await page.waitForFunction(()=>!pc.isGrounded);await page.keyboard.press('c');
  report.air=await read();assert(!report.air.crouch,'airborne capsule must not rebuild');
  await page.waitForFunction(()=>pc.isGrounded&&pc.isCrouching);await page.waitForTimeout(350);
  report.landed=await read();assert(report.landed.crouch,'airborne request must apply on landing');
  await page.keyboard.press('c');await page.waitForTimeout(350);
  await page.keyboard.down('w');await page.keyboard.press('c');await page.waitForTimeout(70);await page.mouse.click(600,400);await page.waitForTimeout(80);
  report.fire=await read();assert(report.fire.crouch&&report.fire.state==='CrouchFire','firing must use crouched body animation');
  await page.keyboard.up('w');await page.waitForTimeout(350);await page.keyboard.press('c');await page.waitForTimeout(350);
  await page.waitForTimeout(1500);await page.keyboard.press('3');await page.waitForTimeout(150);await page.keyboard.press('c');await page.waitForTimeout(350);
  report.knife=await read();assert(report.knife.state==='CrouchKnifeHold','knife must crouch');
  await page.keyboard.press('c');await page.waitForTimeout(350);await page.keyboard.press('1');await page.waitForTimeout(150);
  await page.mouse.down({button:'right'});await page.keyboard.press('c');await page.waitForTimeout(350);
  report.aim=await read();assert(report.aim.state==='CrouchAim','aim must crouch');await page.mouse.up({button:'right'});
  await page.keyboard.press('r');await page.waitForTimeout(100);await page.keyboard.press('c');await page.waitForTimeout(350);
  report.reload=await read();assert(!report.reload.crouch&&report.reload.state.startsWith('Reload'),'reload must stand');
  const unique=report.samples.filter((s,i,a)=>!i||s.amount!==a[i-1].amount);
  report.samples=unique;
  assert(unique.some(s=>s.hip<unique[0].hip-.1&&s.amount<1),'hip must move during transition');
  await page.evaluate(()=>{pc.respawn();});await page.waitForTimeout(100);
  report.respawn=await read();assert(!report.respawn.crouch&&report.respawn.amount===0,'respawn must reset posture');
  await page.keyboard.press('Escape');
  return report;
}
