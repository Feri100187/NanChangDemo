// Run with playwright-cli run-code --filename=tools/check-songbaix-runtime.js
// A focused fixture: native keyboard/physics and mission gates, not a combat playthrough.
async (page) => {
  await page.bringToFront();
  const out = {};
  out.loaded = await page.evaluate(() => {
    const world = Laya.stage.getChildByName('Scene3D');
    const l = Laya.stage.getChildByName('root').getChildAt(0).components.find(c => c.constructor.name === 'LevelController');
    const pc = l.player.components.find(c => c.constructor.name === 'PlayerController');
    window.songbaixQA = {world, l, pc,
      move(x,z,y=.96) {const p=new Laya.Vector3(x,y,z);l.player.transform.position=p;pc.controller.position=p;},
      face(yaw,pitch=0) {pc.yaw=yaw;pc.pitch=pitch;pc.updateCameraRotation();pc.updateCamera();},
      aim() {pc.updateCamera();const a=pc.followCamera.transform.position,b=l.missionDocument.transform.position;
        this.face(Math.atan2(-(b.x-a.x),-(b.z-a.z))*180/Math.PI,-Math.atan2(a.y-b.y,Math.hypot(b.x-a.x,b.z-a.z))*180/Math.PI);}
    };
    const roots=world._children.map(n=>n.name);
    const before={roots,position:{...l.player.transform.position},modules:world.getChildByName('Songbaix_Environment').numChildren,
      colliders:world.getChildByName('Songbaix_StaticCollisions').numChildren,remaining:l.remaining.size,state:l.state};
    // Disable autonomous enemy updates only inside this browser fixture.
    for(const enemy of l.targets)enemy.enabled=false;
    return before;
  });
  if(out.loaded.state!=='Playing'||out.loaded.modules!==5||out.loaded.colliders<300||out.loaded.remaining!==8)throw Error('Map not loaded');
  await page.keyboard.down('w');await page.waitForTimeout(1000);await page.keyboard.up('w');
  out.walk=await page.evaluate(()=>({...songbaixQA.l.player.transform.position,grounded:songbaixQA.pc.controller.isOnGround()}));
  if(out.walk.z>=26||out.walk.y<.8||out.walk.y>1.2)throw Error('Ground/walk failed');
  await page.evaluate(()=>{songbaixQA.move(-28,21);songbaixQA.face(90);});
  await page.keyboard.down('w');await page.waitForTimeout(1400);await page.keyboard.up('w');
  out.wall=await page.evaluate(()=>({...songbaixQA.l.player.transform.position}));
  if(out.wall.x< -30.65||out.wall.x> -29.8)throw Error('Wall collision failed');
  out.rooms=[];
  for(const [name,x,y,insideY] of [['A',-35,-31.3,-30],['B',-18,-30.3,-29],['C',-35,-14.8,-13.5],['D',-18,-6.3,-5],['E',-35,7.2,8.5],['F',-4,-30.3,-29],['G',-3,24.2,25.5]]) {
    await page.evaluate(({x,y})=>{songbaixQA.move(x,-y);songbaixQA.face(0);},{x,y});
    await page.keyboard.down('w');await page.waitForTimeout(650);await page.keyboard.up('w');
    const p=await page.evaluate(()=>({...songbaixQA.l.player.transform.position,grounded:songbaixQA.pc.controller.isOnGround()}));
    if(p.z> -insideY-.5||p.y<.9)throw Error('Room not enterable: '+name+JSON.stringify(p));
    out.rooms.push({name,...p});
    if(name==='D')await page.screenshot({path:'output/playwright/songbaix-house-v2.png'});
  }
  await page.evaluate(()=>{songbaixQA.move(5,0);songbaixQA.face(-90);});
  await page.keyboard.down('w');await page.waitForTimeout(1200);await page.keyboard.up('w');
  out.church=await page.evaluate(()=>({...songbaixQA.l.player.transform.position,grounded:songbaixQA.pc.controller.isOnGround()}));
  if(out.church.x<9||out.church.y<.9)throw Error('Church not enterable');
  await page.screenshot({path:'output/playwright/songbaix-church-v2.png'});
  await page.evaluate(()=>{songbaixQA.move(-18.8,-20.5);songbaixQA.face(0);});
  await page.keyboard.down('w');await page.waitForTimeout(850);await page.keyboard.up('w');
  out.door=await page.evaluate(()=>({...songbaixQA.l.player.transform.position,grounded:songbaixQA.pc.controller.isOnGround()}));
  if(out.door.z> -22.8||out.door.y<.8)throw Error('Cannot enter mission building');
  await page.evaluate(()=>{songbaixQA.move(-21,-25.7);songbaixQA.aim();});
  await page.waitForTimeout(120);
  await page.keyboard.press('e');
  out.beforeClear=await page.evaluate(()=>({collected:songbaixQA.l.documentCollected,remaining:songbaixQA.l.remaining.size}));
  if(out.beforeClear.collected)throw Error('Document gate bypassed');
  await page.evaluate(()=>{const {l}=songbaixQA;for(const enemy of l.targets){enemy.enabled=true;enemy.applyHit(enemy.owner.getChildByName('Head'),1000);}});
  await page.evaluate(()=>{songbaixQA.move(-32,-36);});await page.waitForTimeout(150);
  out.exitLocked=await page.evaluate(()=>({state:songbaixQA.l.state,text:songbaixQA.l.objectiveText.text}));
  if(out.exitLocked.state!=='Playing'||!out.exitLocked.text.includes('未取得文件'))throw Error('Exit gate failed');
  await page.evaluate(()=>{songbaixQA.move(-2,-3);songbaixQA.face(-90,8);});await page.waitForTimeout(100);
  await page.screenshot({path:'output/playwright/songbaix-landmark-runtime.png'});
  await page.evaluate(()=>{songbaixQA.move(-21,-25.7);songbaixQA.aim();});await page.waitForTimeout(150);
  out.canCollect=await page.evaluate(()=>({canCollect:songbaixQA.l.canCollectDocument(),state:songbaixQA.l.state,prompt:songbaixQA.l.objectiveText.text}));
  await page.screenshot({path:'output/playwright/songbaix-document-runtime.png'});
  if(!out.canCollect.canCollect)throw Error('Document unreachable');
  await page.keyboard.press('e');await page.waitForTimeout(120);
  out.collected=await page.evaluate(()=>({collected:songbaixQA.l.documentCollected,visible:songbaixQA.l.missionDocument.active}));
  if(!out.collected.collected||out.collected.visible)throw Error('Real E pickup failed');
  await page.evaluate(()=>songbaixQA.move(-32,-36));await page.waitForTimeout(120);
  out.exit=await page.evaluate(()=>({state:songbaixQA.l.state,title:songbaixQA.l.resultTitle.text}));
  if(out.exit.state==='Playing')throw Error('Exit not completed');
  await page.screenshot({path:'output/playwright/songbaix-victory-runtime.png'});
  await page.evaluate(()=>songbaixQA.l.restart());
  await page.waitForFunction(()=>Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.constructor.name==='LevelController').state==='Ready');
  out.restart=await page.evaluate(()=>{const l=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.constructor.name==='LevelController');return {state:l.state,remaining:l.remaining.size,document:l.missionDocument.active,position:{...l.player.transform.position}};});
  return out;
}
