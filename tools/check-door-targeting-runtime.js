// Compare door picking with native Bullet hits in a disposable current-scene preview.
// playwright-cli -s=door-fix run-code --filename tools/check-door-targeting-runtime.js
async page => {
    await page.reload();
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components.some(c=>c.playerControl));
    try {
        await page.evaluate(()=>{
            const l=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
            window.doorQA={level:l,doors:l.openings.filter(o=>!o.isWindow),windows:l.openings.filter(o=>o.isWindow),hits:[],checks:0,maxError:0};
            if(doorQA.doors.length!==95||doorQA.windows.length!==190)throw Error('Unexpected current-scene openings');
            if(typeof doorQA.doors[0].doorInteractionDistance!=='function')throw Error('Preview has stale door code');
            for(const b of l.allBots())b.onUpdate=()=>{};
            for(const o of l.openings)o.onUpdate=()=>{};
            l.playerControl.onUpdate=()=>{};
            l.setGameplayPaused(false);
            doorQA.ray=(node,axis,distance)=>{
                const normal=new Laya.Vector3();Laya.Vector3.TransformNormal(new Laya.Vector3(...axis),node.transform.worldMatrix,normal);Laya.Vector3.normalize(normal,normal);
                const p=node.transform.position;
                return new Laya.Ray(new Laya.Vector3(p.x+normal.x*distance,p.y+normal.y*distance,p.z+normal.z*distance),new Laya.Vector3(-normal.x,-normal.y,-normal.z));
            };
        });
        for(const angle of [0,35,70,95]) {
            await page.evaluate(angle=>{for(const d of doorQA.doors)d.hinge.transform.localRotationEuler=new Laya.Vector3(0,angle,0);},angle);
            await page.waitForTimeout(100);
            await page.evaluate(angle=>{
                const q=doorQA;
                for(const door of q.doors) {
                    const leaf=door.hinge.getChildByName('DoorCollider');
                    for(const axis of [[0,0,1],[0,0,-1],[1,0,0],[-1,0,0]]) {
                        const ray=q.ray(leaf,axis,1.8);q.hits.length=0;
                        q.level.world.physicsSimulation.rayCastAll(ray,q.hits,5);
                        const hit=q.hits.find(h=>h.collider?.owner===leaf),actual=door.interactionDistance(ray);
                        if(!hit||!Number.isFinite(actual))throw Error(`${door.owner.name} angle=${angle} axis=${axis} missed current leaf`);
                        const nativeDistance=Laya.Vector3.distance(ray.origin,hit.point),error=Math.abs(actual-nativeDistance);
                        if(!Number.isFinite(error)||error>.005)throw Error(`${door.owner.name} distance mismatch ${actual}/${nativeDistance}`);
                        q.maxError=Math.max(q.maxError,error);
                        q.checks++;
                    }
                    if(door.interactionDistance(q.ray(leaf,[0,0,1],3.5))!==Infinity)throw Error('Door accepts a ray beyond 2.8 metres');
                    q.checks++;
                    if(angle===95)for(const side of [1,-1]) {
                        const matrix=door.owner.transform.worldMatrix,from=new Laya.Vector3(),to=new Laya.Vector3(),direction=new Laya.Vector3();
                        Laya.Vector3.transformCoordinate(new Laya.Vector3(0,door.height/2,side*2),matrix,from);
                        Laya.Vector3.transformCoordinate(new Laya.Vector3(0,door.height/2,0),matrix,to);
                        Laya.Vector3.subtract(to,from,direction);Laya.Vector3.normalize(direction,direction);
                        if(door.interactionDistance(new Laya.Ray(from,direction))!==Infinity)throw Error('Empty doorway is still targetable');
                        q.checks++;
                    }
                }
                for(const w of q.windows) {
                    w.hinge.transform.localRotationEuler=new Laya.Vector3(0,angle,0);
                    const ray=q.ray(w.owner,[0,0,1],2);ray.origin.y+=w.height/2;
                    if(Math.abs(w.interactionDistance(ray)-2)>.001)throw Error('Window aperture interaction changed');
                    q.checks++;
                }
            },angle);
        }
        return await page.evaluate(()=>({doors:doorQA.doors.length,windows:doorQA.windows.length,angles:[0,35,70,95],checks:doorQA.checks,maxNativeDistanceError:doorQA.maxError}));
    } finally { await page.reload(); }
}
