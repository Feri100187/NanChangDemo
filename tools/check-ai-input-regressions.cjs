// Execute the real TypeScript controllers with a minimal host. Native Bullet
// geometry is covered separately by check-known-ai-issues-runtime.js.
// node tools/check-ai-input-regressions.cjs <LayaAirIDE/resources/node_modules/typescript>
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const ts = require(process.argv[2] || 'typescript');
const root = path.resolve(__dirname, '..');
class Vector3 {
    constructor(x=0,y=0,z=0) { this.setValue(x,y,z); }
    setValue(x,y,z) { Object.assign(this,{x,y,z}); }
    clone() { return new Vector3(this.x,this.y,this.z); }
    cloneTo(out) { out.setValue(this.x,this.y,this.z); }
    static transformQuat(v,q,out) {
        // These fixtures rotate only around the vertical axis.
        const yaw=2*Math.atan2(q.y,q.w), c=Math.cos(yaw), s=Math.sin(yaw);
        out.setValue(v.x*c+v.z*s,v.y,-v.x*s+v.z*c);
    }
}
class Shape { destroy() {} }
class LeanMotion { value=0; static distance=.12; static angle=8; }
const context = vm.createContext({performance:{now:()=>0},console,document:{},window:{},Laya:{
    Script:class {enabled=true;}, Vector3, Ray:class {constructor(origin,direction){Object.assign(this,{origin,direction});}},
    HitResult:class {}, SphereColliderShape:Shape, regClass:()=>c=>c, property:()=>()=>{},
    Sprite3D:class {}, Camera:class {}, GTextField:class {}, timer:{delta:1000/60}
}});
const modules = {LeanMotion:{LeanMotion},PlayerHealth:{PlayerHealth:class {}},GameClock:{},
    WeaponPresentation:{},EnemyPatrolPoint:{}};
function load(name) {
    if (modules[name]) return modules[name];
    const source = fs.readFileSync(path.join(root,'src',name+'.ts'),'utf8');
    const code = ts.transpileModule(source,{compilerOptions:{module:ts.ModuleKind.CommonJS,
        target:ts.ScriptTarget.ES2020,experimentalDecorators:true}}).outputText;
    const exports = {}; modules[name] = exports;
    vm.runInContext(`(function(require,exports){${code}\n})`,context)(s=>load(s.replace('./','')),exports);
    return exports;
}
const {BotNavigation} = load('BotNavigation');
const {EnemyAI} = load('EnemyAI');
const {PlayerController} = load('PlayerController');
let checks=0;
function check(name, fn) { fn(); checks++; console.log('PASS '+name); }
function cachedRoute() {
    const nav = new BotNavigation();
    nav.goal = new Vector3(1,0,1); nav.origin = new Vector3(0,0,0);
    nav.path = [new Vector3(1,0,0), nav.goal.clone()];
    return nav;
}
check('墙角附近不能跳过仍然必要的拐点',()=>{
    for (const gap of [.19,.04]) {
        const nav=cachedRoute(), p=new Vector3(1-gap,0,0);
        const next=nav.step(p,nav.goal,100,(a,b)=>b.z===0);
        assert.equal(next.x,1); assert.equal(next.z,0); assert.equal(nav.path.length,2);
    }
});
check('仅在当前位置直达下一点时消费拐点',()=>{
    const nav=cachedRoute(), p=new Vector3(.9,0,0);
    const next=nav.step(p,nav.goal,100,(a,b)=>b!==nav.goal);
    assert.equal(next.z,1); assert.equal(nav.path.length,1);
});
check('失效缓存停止返回不可直达路径点，并从当前位置重建',()=>{
    const nav=cachedRoute(), goal=nav.goal.clone(), p=new Vector3(.7,0,0);
    assert.equal(nav.step(p,goal,100,()=>false),p);
    assert.equal(nav.path.length,0); assert.equal(nav.goal,null);
    nav.step(p,goal,110,()=>false);
    assert.equal(nav.origin.x,p.x); assert.equal(nav.expanded,1);
});
check('距拐点不足 5 厘米仍然移动到拐点',()=>{
    const bot=new EnemyAI(), p=new Vector3(.97,0,0), goal=new Vector3(1,0,0);
    bot.enemy={transform:{position:p}}; bot.navigation.step=()=>goal;
    bot.walkSegmentClear=()=>true; bot.groundHeight=()=>0;
    bot.moveTowards(goal,.05,2.2,false);
    assert.equal(bot.enemy.transform.position.x,1);
});
check('地形阻塞会失效寻路缓存，临时角色阻塞保留路线',()=>{
    for (const geometry of [true,false]) {
        const bot=new EnemyAI(), goal=new Vector3(1,0,0);
        bot.enemy={transform:{position:new Vector3()}}; bot.navigation.step=()=>goal;
        let invalidated=0; bot.navigation.invalidate=()=>invalidated++;
        bot.walkSegmentClear=(a,b,ignoreActors)=>!!ignoreActors&&!geometry;
        bot.moveTowards(goal,.05,2.2,false);
        assert.equal(invalidated,geometry?1:0);
    }
});
function idleBot() {
    const bot=new EnemyAI(); bot.clock={paused:false,timer:{delta:1000/60},now:()=>0};
    for (const name of ['updateGround','updatePosture','updateLean','updateSearch']) bot[name]=()=>{};
    bot.targetAlive=node=>!!node?.alive;
    return bot;
}
check('60 帧无目标时仅按 250 毫秒间隔扫描',()=>{
    const bot=idleBot(); let scans=0; bot.selectTarget=()=>scans++;
    for(let i=0;i<60;i++){bot.clock.now=()=>i*1000/60; bot.onUpdate();}
    assert.equal(scans,4);
});
check('目标死亡立即清空，但不会提前扫描或逐帧重试',()=>{
    const bot=idleBot(); bot.target={alive:false}; bot.nextScan=250; bot.hasLastKnown=true;
    let scans=0; bot.selectTarget=()=>scans++;
    bot.onUpdate(); assert.equal(bot.target,null); assert.equal(bot.hasLastKnown,false);
    assert.equal(scans,0); bot.clock.now=()=>250; bot.onUpdate(); assert.equal(scans,1);
});
function perceptionBot() {
    const bot=idleBot();
    bot.enemy={transform:{position:new Vector3(),rotation:{y:0,w:1},rotationEuler:new Vector3()}};
    bot.fieldOfView=180;
    bot.readPoint=(_node,_offset,out)=>out.setValue(0,1.6,0);
    bot.trace=()=>null;
    bot.updatePatrol=()=>{};
    bot.updateCombatMovement=()=>{};
    bot.facePosition=()=>true;
    bot.fireAtPlayer=()=>{bot.testShots++;return true;};
    bot.testShots=0;
    return bot;
}
check('清空战斗记忆后立即恢复巡逻，不再追查已清理区域的枪声',()=>{
    const bot=idleBot();bot.target={alive:false};bot._state='Alert';bot.heardUntil=20000;
    bot.hasLastKnown=true;bot.cover=new Vector3(1,0,0);bot.searchGoal=new Vector3(2,0,0);
    let invalidated=0;bot.navigation.invalidate=()=>invalidated++;
    bot.resumePatrol();
    assert.equal(bot.state,'Patrol');assert.equal(bot.target,null);assert.equal(bot.hasLastKnown,false);
    assert.equal(bot.hasHeardGunfire,false);assert.equal(bot.cover,null);assert.equal(bot.searchGoal,null);
    assert.equal(invalidated,1);assert.equal(bot.health,100);
});
check('首选侧方被角色挡住时尝试另一侧，不穿过障碍也不重建路线',()=>{
    const bot=new EnemyAI(), goal=new Vector3(0,0,2);
    bot.enemy={transform:{position:new Vector3()}}; bot.navigation.step=()=>goal;
    bot.patrolIndex=1; let invalidated=0; bot.navigation.invalidate=()=>invalidated++;
    bot.walkSegmentClear=(_a,b,ignoreActors)=>ignoreActors||b.x>0;
    bot.groundHeight=()=>0;
    bot.moveTowards(goal,.05,2.2,false);
    assert.ok(bot.enemy.transform.position.x>0);
    assert.equal(bot.enemy.transform.position.z,0); assert.equal(invalidated,0);
});
function actor(x,z) {
    return {alive:true,transform:{position:new Vector3(x,1.6,z)},getComponent:()=>null,isAncestorOf:()=>false};
}
check('未接敌时近距离侧后方和正后方目标均不可见，正面仍可见',()=>{
    for(const distance of [.25,2,5.99,6,6.01,20]) {
        for(const degrees of [-179,-135,-91,91,135,180]) {
            const bot=perceptionBot(), angle=degrees*Math.PI/180;
            bot.target=actor(Math.sin(angle)*distance,Math.cos(angle)*distance);
            assert.equal(bot.canSeePlayer(true),false,`distance=${distance}, angle=${degrees}`);
        }
        const bot=perceptionBot();bot.target=actor(0,distance);
        assert.equal(bot.canSeePlayer(true),true);
    }
});
check('视锥随敌人旋转，窄视角、视距和墙体遮挡仍生效',()=>{
    const bot=perceptionBot(); bot.fieldOfView=120;
    bot.enemy.transform.rotation={y:Math.sin(Math.PI/4),w:Math.cos(Math.PI/4)};
    bot.target=actor(2,0);assert.equal(bot.canSeePlayer(true),true);
    bot.target=actor(0,2);assert.equal(bot.canSeePlayer(true),false);
    bot.target=actor(66,0);assert.equal(bot.canSeePlayer(true),false);
    bot.target=actor(2,0);bot.trace=()=>({});
    assert.equal(bot.canSeePlayer(true),false);
});
check('听见枪声进入警戒后，不会凭空发现侧后方新目标',()=>{
    for(const friendly of [false,true]) {
        const bot=perceptionBot(), rear=actor(2,-2);
        bot.friendly=friendly;bot.player=friendly?null:rear;bot.opponents=friendly?[rear]:[];
        bot.hearGunshot(new Vector3(0,0,20));
        assert.equal(bot.state,'Alert');
        for(let i=0;i<120;i++){bot.clock.now=()=>i*1000/60;bot.onUpdate();}
        assert.equal(bot.target,null);assert.equal(bot.hasLastKnown,false);assert.equal(bot.testShots,0);
    }
});
check('正面发现并交火，侧后方未被发现的近目标不会抢走当前目标',()=>{
    const bot=perceptionBot(), front=actor(0,20), rear=actor(1,-1);
    bot.player=front;bot.opponents=[rear];
    for(let i=0;i<60;i++){bot.clock.now=()=>i*1000/60;bot.onUpdate();}
    assert.equal(bot.target,front);assert.equal(bot.state,'Combat');assert.ok(bot.testShots>0);
});
check('已有视觉记忆时保持当前目标，记忆失效后重新发现必须通过视野',()=>{
    const bot=perceptionBot(), rear=actor(0,-2);
    bot.player=rear;bot.target=rear;bot.hasLastKnown=true;bot._state='Combat';bot.suspicion=1;
    bot.onUpdate();assert.equal(bot.hasLastKnown,true);assert.equal(bot.testShots,1);
    bot.clearPerception();bot._state='Alert';bot.testShots=0;
    bot.onUpdate();assert.equal(bot.hasLastKnown,false);assert.equal(bot.testShots,0);
});
check('暂停清输入后，空格 repeat 不起跳；松开再按仍正常跳跃',()=>{
    const pc=new PlayerController(); let jumps=0;
    pc.clock={paused:false,timer:{delta:1000/60}}; pc.player={transform:{position:new Vector3(0,1,0)}};
    pc.controller={enabled:true,isOnGround:()=>true,move(){},jump(){jumps++;}};
    pc.isGameplayFocused=()=>!pc.clock.paused;
    const event=repeat=>({keyCode:32,nativeEvent:{repeat,preventDefault(){}}});
    pc.handleKeyDown(event(false)); pc.onUpdate(); assert.equal(jumps,1);
    pc.clock.paused=true; pc.clearInput(); pc.handleKeyDown(event(true));
    pc.clock.paused=false; pc.handleKeyDown(event(true)); pc.onUpdate();
    assert.equal(jumps,1);
    pc.handleKeyUp(event(false)); pc.handleKeyDown(event(false)); pc.onUpdate(); assert.equal(jumps,2);
    pc.handleKeyDown(event(true)); pc.onUpdate(); assert.equal(jumps,2);
});
console.log(`PASS ${checks} AI/navigation/input regression groups`);
