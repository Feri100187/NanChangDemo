// Real keyboard/physics regression; reload restores the disposable preview.
async page => {
    await page.goto('http://127.0.0.1:18090');
    await page.waitForFunction(()=>window.Laya?.stage?.getChildByName('root')?.getChildAt(0)?.components?.some(c=>c.playerControl));
    await page.evaluate(()=>{
        window.level=Laya.stage.getChildByName('root').getChildAt(0).components.find(c=>c.playerControl);
        window.pc=level.playerControl;
        for(const b of [...level.targets,...level.teammates.map(n=>n.components.find(c=>c.opponents))])b.onUpdate=()=>{};
    });
    const button=await page.evaluate(()=>{const b=level.continueButton,p=b.localToGlobal(new Laya.Point(b.width/2,b.height/2)),r=pc.canvas.getBoundingClientRect();return{x:r.x+p.x*r.width/Laya.stage.width,y:r.y+p.y*r.height/Laya.stage.height};});
    await page.mouse.click(button.x,button.y);
    await page.waitForFunction(()=>pc.isGrounded);
    await page.keyboard.press('c');await page.waitForTimeout(300);
    const before=await page.evaluate(()=>({crouch:pc.isCrouching,y:pc.owner.transform.position.y}));
    await page.keyboard.down('Space');await page.waitForTimeout(250);
    const crouched=await page.evaluate(()=>({ground:pc.isGrounded,y:pc.owner.transform.position.y}));
    if(!before.crouch||!crouched.ground||Math.abs(crouched.y-before.y)>.05)throw Error('Crouching player jumped');
    // Standing up while still holding Space must not replay the rejected jump.
    await page.keyboard.press('c');await page.waitForTimeout(350);
    const stood=await page.evaluate(()=>({ground:pc.isGrounded,crouch:pc.isCrouching}));
    if(!stood.ground||stood.crouch)throw Error('Rejected jump was queued');
    await page.keyboard.up('Space');await page.keyboard.press('Space');await page.waitForTimeout(120);
    const standingJump=await page.evaluate(()=>!pc.isGrounded);
    if(!standingJump)throw Error('Standing jump stopped working');
    await page.reload();
    return {crouchBlocked:true,noQueuedJump:true,standingJump};
}
