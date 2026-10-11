// Real F-key input and native collision checks. Run in a disposable preview.
async page=>{
    await page.setViewportSize({width:1334,height:750});
    await page.reload();
    await page.waitForFunction(()=>Laya.stage.getChildByName('root')?.getChildAt(0)?.components.some(c=>c.playerControl),null,{timeout:15000});
    await page.waitForFunction(()=>!document.getElementById('splash'));
    const errors=[],onError=e=>errors.push(e.message);page.on('pageerror',onError);
    const clickContinue=async()=>{
        const p=await page.evaluate(()=>{const b=ol.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=ol.playerControl.canvas.getBoundingClientRect();return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
        await page.mouse.click(p.x,p.y);await page.waitForFunction(()=>ol.state==='Playing',null,{timeout:5000});
    };
    try{
        await page.evaluate(()=>{
            window.ol=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
            window.od=ol.openings.find(o=>o.owner.name==='单门民居_01房门');
            window.ow=ol.openings.find(o=>o.owner.name==='单门民居_01窗户1');
            window.or={checks:[]};window.oc=(v,name)=>{if(!v)throw Error(name);or.checks.push(name);};
            oc(ol.openings.length===285&&ol.openings.filter(o=>!o.isWindow).length===95,'95 doors and 190 windows loaded');
            oc(ol.openings.every(o=>!o.isOpen&&o.currentAngle===0&&o.clock===ol.clock),'all openings start closed with shared pause clock');
            const find=n=>{const m=n.getComponent(Laya.MeshRenderer)?.sharedMaterial;if(m?.renderQueue===3000)return m;for(let i=0;i<n.numChildren;i++){const r=find(n.getChildAt(i));if(r)return r;}};
            const glass=find(ow.owner);oc(glass&&glass.blend===1&&!glass.depthWrite,'window glass uses transparent blend without depth writes');
        });
        await clickContinue();
        await page.evaluate(()=>{
            for(const b of ol.allBots())b.onUpdate=()=>{};
            window.op=ol.teammates[0].components.find(c=>c.opponents);
            window.place=(x,z,yaw=90)=>{const p=new Laya.Vector3(x,1.1,z);ol.player.transform.position=p;ol.playerControl.controller.position=p;ol.playerControl.yaw=yaw;ol.playerControl.pitch=0;ol.playerControl.updateCamera();ol.playerControl.updateCameraRotation();};
            window.aimAtDoor=()=>{
                const target=od.hinge.getChildByName('DoorCollider').transform.position,c=ol.playerControl,eye=c.followCamera.transform.position;
                const dx=target.x-eye.x,dy=target.y-eye.y,dz=target.z-eye.z;
                c.yaw=Math.atan2(-dx,-dz)*180/Math.PI;c.pitch=Math.atan2(dy,Math.hypot(dx,dz))*180/Math.PI;
                c.updateCameraRotation();c.updateCamera();
            };
            window.aimDoorFromFace=side=>{
                const leaf=od.hinge.getChildByName('DoorCollider'),p=leaf.transform.position,normal=new Laya.Vector3();
                Laya.Vector3.TransformNormal(new Laya.Vector3(0,0,1),leaf.transform.worldMatrix,normal);Laya.Vector3.normalize(normal,normal);
                place(p.x+normal.x*side*1.1,p.z+normal.z*side*1.1);aimAtDoor();
            };
            place(-66,0);
        });
        await page.waitForTimeout(100);
        await page.evaluate(()=>{
            oc(ol.findOpening()===od,'aiming at door selects it');
            oc(!op.walkSegmentClear(new Laya.Vector3(-66,0,0),new Laya.Vector3(-70,0,0),true),'closed door blocks walking');
        });
        await page.keyboard.down('f');await page.waitForTimeout(120);await page.keyboard.down('f');
        await page.waitForTimeout(750);await page.keyboard.up('f');
        await page.evaluate(()=>{
            oc(od.isOpen&&od.currentAngle>94,'one press opens door; held/repeat F does not toggle back');
            oc(op.walkSegmentClear(new Laya.Vector3(-66,0,0),new Laya.Vector3(-70,0,0),true),'open door admits a standing actor');
            oc(ol.findOpening()!==od,'empty original doorway is not a door interaction target');
        });
        await page.keyboard.press('f');await page.waitForTimeout(100);
        await page.evaluate(()=>{oc(od.isOpen&&od.currentAngle>94,'F at empty original doorway does not close the door');aimDoorFromFace(-1);});
        await page.waitForTimeout(100);
        await page.evaluate(()=>{aimAtDoor();oc(ol.findOpening()===od,'aiming at the rotated door leaf selects it');oc(ol.routeText.text.includes('关闭房门'),'door hint follows the current leaf');});
        await page.screenshot({path:'output/playwright/door-open-target.png'});
        await page.evaluate(()=>{
            const wall=new Laya.Sprite3D('DoorInteractionQABlocker'),eye=ol.playerControl.followCamera.transform.position,target=od.hinge.getChildByName('DoorCollider').transform.position;
            ol.world.addChild(wall);wall.transform.position=new Laya.Vector3((eye.x+target.x)/2,(eye.y+target.y)/2,(eye.z+target.z)/2);
            wall.addComponent(Laya.PhysicsCollider).colliderShape=new Laya.BoxColliderShape(.2,.2,.2);window.doorQABlocker=wall;
        });
        await page.waitForTimeout(100);
        await page.evaluate(()=>oc(!ol.findOpening(),'an intervening collider blocks door interaction'));
        await page.keyboard.press('f');
        await page.evaluate(()=>{oc(od.isOpen,'F cannot close the door through an obstacle');doorQABlocker.destroy();});
        await page.waitForTimeout(100);
        await page.keyboard.press('f');await page.waitForTimeout(800);
        await page.evaluate(()=>{oc(!od.isOpen&&od.currentAngle===0,'F on the rotated door leaf closes the door');place(-64,0);});
        await page.keyboard.press('f');await page.waitForTimeout(100);
        await page.evaluate(()=>{oc(!od.isOpen,'F beyond interaction range does not open door');place(-66,2.4);});
        await page.waitForTimeout(100);
        await page.evaluate(()=>{
            oc(ol.findOpening()===ow,'aiming at glass selects window');
            const from=new Laya.Vector3(-66,1.55,2.4),to=new Laya.Vector3(-70,1.55,2.4);
            oc(op.trace(from,to,op.shotRay)?.name==='WindowCollider','closed glass blocks bullets');
            oc(!op.trace(from,to,op.sightRay,true),'vision passes through closed transparent glass');
        });
        await page.screenshot({path:'output/playwright/window-closed-glass.png'});
        await page.keyboard.press('f');await page.waitForTimeout(150);await page.keyboard.press('Escape');
        const angle=await page.evaluate(()=>ow.currentAngle);
        await page.keyboard.press('f');await page.waitForTimeout(300);
        await page.evaluate(a=>{oc(ol.state==='Paused'&&ow.currentAngle===a&&ow.isOpen,'pause freezes swing and ignores F');},angle);
        await clickContinue();await page.waitForTimeout(800);
        await page.evaluate(()=>{
            oc(ow.currentAngle>94,'window resumes opening after continue');
            oc(!op.trace(new Laya.Vector3(-66,1.55,2.4),new Laya.Vector3(-70,1.55,2.4),op.shotRay),'open window admits bullets');
        });
        await page.screenshot({path:'output/playwright/window-open.png'});
        await page.evaluate(()=>place(-70.5,2.4,-90));await page.waitForTimeout(100);
        await page.keyboard.press('f');await page.waitForTimeout(800);
        await page.evaluate(()=>{oc(!ow.isOpen&&ow.currentAngle===0,'window can be closed from inside');place(-66,0);});
        await page.waitForTimeout(100);await page.keyboard.press('f');await page.waitForTimeout(800);
        await page.evaluate(()=>{place(-69,0,-90);aimAtDoor();});await page.waitForTimeout(100);
        await page.evaluate(()=>{aimAtDoor();oc(ol.findOpening()===od,'door leaf is targetable from its other face');});
        await page.keyboard.press('f');await page.waitForTimeout(800);
        await page.evaluate(()=>{oc(!od.isOpen&&od.currentAngle>1,'closing door stops before intersecting the player');place(-66,0);});
        await page.waitForTimeout(800);
        await page.evaluate(()=>oc(od.currentAngle===0,'door finishes closing once player clears swing'));
        const result=await page.evaluate(()=>or);
        if(errors.length)throw Error(errors.join('\n'));result.errors=errors;
        await page.reload();await page.waitForFunction(()=>Laya.stage.getChildByName('root')?.getChildAt(0)?.components.some(c=>c.playerControl),null,{timeout:15000});
        await page.evaluate(()=>{
            const l=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
            if(l.openings.length!==285||l.openings.some(o=>o.isOpen||o.currentAngle))throw Error('Scene reload did not reset openings');
        });
        result.checks.push('scene reload resets openings without duplicate registrations');return result;
    }finally{page.off('pageerror',onError);await page.reload();}
}
