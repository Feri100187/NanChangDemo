// Native input + AI regression for the fourth street corner.
async page=>{
    await page.reload();
    await page.waitForFunction(()=>Laya.stage.getChildByName('root')?.getChildAt(0)?.components.some(c=>c.playerControl),null,{timeout:15000});
    try{
        const button=await page.evaluate(()=>{
            window.qlevel=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
            const b=qlevel.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=qlevel.playerControl.canvas.getBoundingClientRect();
            return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};
        });
        await page.mouse.click(button.x,button.y);
        await page.waitForFunction(()=>qlevel.state==='Playing',null,{timeout:5000});
        const start=await page.evaluate(()=>qlevel.player.transform.position.z);
        await page.keyboard.down('Shift');await page.keyboard.down('w');await page.waitForTimeout(1000);
        await page.keyboard.up('w');await page.keyboard.up('Shift');
        const speed=await page.evaluate(z=>({distance:z-qlevel.player.transform.position.z,configured:qlevel.playerControl.sprintSpeed,allies:qlevel.teammates.map(n=>n.components.find(c=>c.opponents).sprintSpeed),enemies:qlevel.targets.map(b=>b.sprintSpeed)}),start);
        if(speed.configured!==6.5||speed.distance<5.5||speed.distance>7.5||speed.allies.some(v=>v!==6)||speed.enemies.some(v=>v!==4.5))throw Error('Sprint mismatch: '+JSON.stringify(speed));
        const contact=await page.evaluate(()=>{
            for(const b of qlevel.allBots())b.onUpdate=()=>{};
            qlevel.playerControl.onUpdate=()=>{};qlevel.health._health=10000;
            qlevel.nextWave=3;qlevel.waveActive=true;
            qlevel.waves[3].enemies.forEach(n=>{n.active=true;n.components.find(c=>c.opponents)._health=10000;});
            const p=new Laya.Vector3(0,1.1,35);qlevel.player.transform.position=p;qlevel.playerControl.controller.position=p;qlevel.playerControl.updateCamera();
            const enemy=qlevel.waves[3].enemies[0].components.find(c=>c.opponents);
            const ally=qlevel.teammates[0].components.find(c=>c.opponents);
            ally.owner.transform.position=new Laya.Vector3(1.5,0,34);ally.owner.transform.rotationEuler=new Laya.Vector3(0,180,0);ally._health=10000;
            enemy.target=qlevel.player;ally.target=enemy.owner;
            window.qenemy=enemy;window.qally=ally;window.qshots={enemy:0,ally:0};
            enemy.owner.on('enemy-fired',qshots,()=>qshots.enemy++);ally.owner.on('enemy-fired',qshots,()=>qshots.ally++);
            return{distance:Math.hypot(enemy.owner.transform.position.x,enemy.owner.transform.position.z-35),sight:enemy.sightRange};
        });
        await page.waitForTimeout(150);
        await page.evaluate(()=>{
            if(!qenemy.canSeePlayer(true)||!qally.canSeePlayer(true))throw Error('Corner contact not visible to both factions');
            qenemy.onUpdate=Object.getPrototypeOf(qenemy).onUpdate;qally.onUpdate=Object.getPrototypeOf(qally).onUpdate;
        });
        await page.waitForTimeout(4500);
        const result=await page.evaluate(()=>({shots:qshots,enemyState:qenemy.state,allyState:qally.state,enemyDamage:30000-qlevel.waves[3].enemies.reduce((s,n)=>s+n.components.find(c=>c.opponents).health,0)}));
        if(!result.shots.enemy||!result.shots.ally||result.enemyDamage<=0)throw Error('No two-sided live combat: '+JSON.stringify(result));
        return{speed,contact,...result};
    }finally{await page.reload();}
}
