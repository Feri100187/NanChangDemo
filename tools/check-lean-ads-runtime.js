// Disposable preview: real Q/E + RMB/LMB, projected sight line and native bullet hits.
// playwright-cli -s=wall run-code --filename=tools/check-lean-ads-runtime.js
async page => {
    await page.reload();
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
    await page.evaluate(()=>{
        window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
        window.pc=level.playerControl;window.rifle=level.rifle;window.target=level.targets[0];
        for(const b of [...level.targets,...level.teammates.map(n=>n.components.find(c=>c.opponents))])b.onUpdate=()=>{};
        const floor=new Laya.Sprite3D('ADS_TestFloor');level.world.addChild(floor);
        floor.transform.position=new Laya.Vector3(300,-.1,300);
        floor.addComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(60,.2,60);
    });
    const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=pc.canvas.getBoundingClientRect();return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
    await page.mouse.click(button.x,button.y);
    await page.evaluate(()=>{pc.owner.transform.position=new Laya.Vector3(300,1,300);pc.controller.position=pc.owner.transform.position;pc.yaw=pc.pitch=0;pc.updateCameraRotation();});
    await page.waitForFunction(()=>pc.isGrounded);
    const report=[];
    for(const [name,key,crouch,scale] of [['center',null,false,.9],['left','q',false,.9],['right','e',false,.9],['crouch-left','q',true,.9],['crouch-right','e',true,.9],['retracted-right','e',false,.25]]) {
        await page.mouse.up({button:'right'});
        await page.keyboard.up('q');await page.keyboard.up('e');
        if(await page.evaluate(()=>pc.isCrouching)!==crouch)await page.keyboard.press('c');
        await page.evaluate(scale=>{
            pc.setWeaponPresentationScale(scale);pc.recoilPitch=pc.recoilYaw=0;pc.updateCameraRotation();
            rifle.magazine=5;rifle.nextShotAt=0;rifle.lastShotAt=-Infinity;target._health=10000;
        },scale);
        if(key)await page.keyboard.down(key);
        // Reproduce the reported order: lean first, then aim.
        await page.waitForTimeout(300);await page.mouse.down({button:'right'});await page.waitForTimeout(900);
        const alignment=await page.evaluate(()=>{
            const p=rifle.rifleModel.transform.localPosition,world=new Laya.Vector3(),screen=new Laya.Vector4();
            // The imported rifle's iron-sight line is +0.18m above its model root.
            Laya.Vector3.transformCoordinate(new Laya.Vector3(p.x,p.y+.18,p.z-.7),pc.weaponPivot.transform.worldMatrix,world);
            pc.followCamera.worldToViewportPoint(world,screen);
            const ray=new Laya.Ray(new Laya.Vector3(),new Laya.Vector3());
            pc.followCamera.viewportPointToRay(new Laya.Vector2(screen.x,screen.y),ray);
            Laya.Vector3.normalize(ray.direction,ray.direction);
            const eye=pc.followCamera.transform.position;
            const head=target.owner.getChildByName('Head').transform.position,root=target.owner.transform.position;
            target.owner.transform.position=new Laya.Vector3(eye.x+ray.direction.x*12-(head.x-root.x),
                eye.y+ray.direction.y*12-(head.y-root.y),eye.z+ray.direction.z*12-(head.z-root.z));
            return {dx:screen.x-Laya.stage.width/2,dy:screen.y-Laya.stage.height/2,
                cameraRoll:pc.followCamera.transform.rotationEuler.z,weaponRoll:pc.weaponPivot.transform.rotationEuler.z};
        });
        if(Math.hypot(alignment.dx,alignment.dy)>1.5||Math.abs(alignment.cameraRoll-alignment.weaponRoll)>.001)
            throw Error(name+' sight/ray misalignment: '+JSON.stringify(alignment));
        await page.waitForTimeout(100);
        await page.mouse.down({button:'left'});await page.mouse.up({button:'left'});await page.waitForTimeout(100);
        const damage=await page.evaluate(()=>10000-target.health);
        if(damage<=0)throw Error(name+' sight-centered enemy was missed');
        report.push({name,...alignment,damage});
        await page.waitForTimeout(1400);
    }
    await page.mouse.up({button:'right'});await page.keyboard.up('q');await page.keyboard.up('e');
    await page.reload();
    return report;
}
