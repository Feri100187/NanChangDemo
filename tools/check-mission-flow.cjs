// 执行真实 LevelController；物理、UI 和场景加载使用替身，不代替 IDE 实机验收。
// node tools/check-mission-flow.cjs <LayaAirIDE/resources/node_modules/typescript>
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const ts = require(process.argv[2] || 'typescript');
const root = path.resolve(__dirname, '..');
class Events {
    constructor() { this.listeners = []; }
    on(type, caller, fn) { this.listeners.push({type, caller, fn}); }
    off(type, caller, fn) { this.listeners = this.listeners.filter(h => h.type !== type || h.caller !== caller || h.fn !== fn); }
    offAllCaller(caller) { this.listeners = this.listeners.filter(h => h.caller !== caller); }
    event(type, data) { for (const h of [...this.listeners]) if (h.type === type) h.fn.call(h.caller, data); }
    addEventListener(type, fn) { this.on(type, null, fn); }
    removeEventListener(type, fn) { this.off(type, null, fn); }
}
class V3 {
    constructor(x=0,y=0,z=0) { this.setValue(x,y,z); }
    setValue(x,y,z) { Object.assign(this,{x,y,z}); }
    static normalize(v,out) { const d=Math.hypot(v.x,v.y,v.z); out.setValue(v.x/d,v.y/d,v.z/d); }
}
function widget() { return {visible:true, width:250, height:60, x:0,y:0, text:'',size(){},scale(){},pos(x,y){this.x=x;this.y=y;},...new Events(),on:Events.prototype.on,offAllCaller:Events.prototype.offAllCaller}; }
const node = (x=0,y=0,z=0) => Object.assign(new Events(),{active:true,activeInHierarchy:true,transform:{position:new V3(x,y,z)}});
function environment(mission=true, menu=true) {
    class EnemyAI {} EnemyAI.DIED='died';
    class PlayerController {} Object.assign(PlayerController,{CONTROL_ACQUIRED:'acquired',CONTROL_LOST:'lost',RESPAWNED:'respawn'});
    class PlayerHealth {} PlayerHealth.DIED='player-died';
    class RifleController {} class CombatFeedback {}
    class GameClock { constructor(){this.timer={};} setPaused(v){this.paused=v;} destroy(){this.destroyed=true;} }
    const modules={EnemyAI:{EnemyAI},PlayerController:{PlayerController},PlayerHealth:{PlayerHealth},RifleController:{RifleController},CombatFeedback:{CombatFeedback},GameClock:{GameClock}};
    const stage=Object.assign(new Events(),{width:1334,height:750}), canvas=new Events();
    const win=new Events(), doc=Object.assign(new Events(),{hidden:false,hasFocus:()=>true});
    const Laya={Script:class{},Sprite3D:class{},GTextField:class{},GButton:class{},GBox:class{},
        regClass:()=>v=>v,property:()=>()=>{},Vector3:V3,Vector2:V3,Ray:class{constructor(origin,direction){Object.assign(this,{origin,direction});}},HitResult:class{},
        Event:{KEY_DOWN:'down',KEY_UP:'up',CLICK:'click',RESIZE:'resize'},stage,Browser:{mainCanvas:{source:canvas}},
        Stat:{enablePhysicsUpdate:true},Physics3DUtils:{COLLISIONFILTERGROUP_CHARACTERFILTER:32},Scene:{}};
    const context=vm.createContext({Laya,window:win,document:doc,console});
    const source=ts.transpileModule(fs.readFileSync(path.join(root,'src/LevelController.ts'),'utf8'),{compilerOptions:{module:ts.ModuleKind.CommonJS,target:ts.ScriptTarget.ES2020,experimentalDecorators:true}}).outputText;
    const exports={}; vm.runInContext(`(function(require,exports){${source}\n})`,context)(s=>modules[s.slice(2)],exports);
    const level=new exports.LevelController(), player=node(), health={isAlive:true};
    const physics={blocked:false,calls:0,rayCast(ray,hit,range,group,mask){this.calls++;assert.equal(mask,~32);assert.ok(range>0);return this.blocked;}};
    const world={timer:{},physicsSimulation:physics}; player.scene=world;
    const camera={transform:{position:new V3(0,1.7,0)},direction:new V3(0,0,-1),viewportPointToRay(p,ray){ray.direction.setValue(this.direction.x,this.direction.y,this.direction.z);}};
    const control={focused:true,followCamera:camera,useMenuFocus(){},isGameplayFocused(){return this.focused&&!this.clock.paused;},syncCameraForShot(){},releaseGameplayFocus(){},stopGameplay(){},requestGameplayFocus(){player.event('acquired');}};
    const rifle={clearGameplayInput(){},stopCombat(){}};
    player.getComponent=type=>type===PlayerController?control:type===PlayerHealth?health:rifle;
    const enemies=Array.from({length:4},()=>{const n=node(),e={owner:n,isAlive:true};n.getComponent=()=>e;return e;});
    const owner={url:'Demo01.ls',getComponent:()=>null,close(){level.onDisable();this.destroyed=true;}};
    Object.assign(level,{owner,player,enemies:enemies.map(e=>e.owner),exitZone:node(10,0,0),exitHalfSize:new V3(1,2,1),
        resultPanel:widget(),resultTitle:widget(),resultDetail:widget(),restartButton:widget(),remainingText:widget(),objectiveText:widget()});
    if(menu)level.continueButton=widget();
    if(mission)Object.assign(level,{streetEnemies:enemies.slice(0,2).map(e=>e.owner),courtyardEnemies:enemies.slice(2).map(e=>e.owner),missionDocument:node(0,1.7,-1)});
    level.onAwake();level.onEnable();level.onStart();
    const e={level,player,enemies,physics,camera,control,health,stage,win,doc,canvas,Laya,
        start(){level.beginContinue();},kill(i){enemies[i].isAlive=false;enemies[i].owner.event('died',enemies[i]);},
        down(repeat=false){stage.event('down',{keyCode:69,nativeEvent:{repeat}});},up(){stage.event('up',{keyCode:69});},
        enter(){player.transform.position.x=10;level.onUpdate();},leave(){player.transform.position.x=0;level.onUpdate();}};
    return e;
}
function permutations(a){if(!a.length)return [[]];return a.flatMap((x,i)=>permutations(a.filter((_,j)=>i!==j)).map(p=>[x,...p]));}
let passed=0;
async function check(name,fn){await fn();passed++;console.log('PASS',name);}
(async()=>{
await check('24 种击杀顺序、重复通知、一次跨越两阶段',()=>{
    for(const order of permutations([0,1,2,3])){
        const e=environment();e.start();
        e.enemies[0].owner.event('died',e.enemies[0]);assert.equal(e.level.remaining.size,4);
        order.forEach((i,n)=>{e.kill(i);e.kill(i);assert.equal(e.level.remaining.size,3-n);});
        assert.match(e.level.objectiveText.text,/任务 3\/4/);assert.match(e.level.remainingText.text,/街口 2\/2 · 院落 2\/2/);
    }
});
await check('开始菜单、清敌前、距离、背向、遮挡、焦点、长按限制',()=>{
    const e=environment();e.down();assert.equal(e.level.documentCollected,false);e.up();e.start();
    e.down();e.up();assert.equal(e.level.documentCollected,false);[0,1,2,3].forEach(i=>e.kill(i));
    e.physics.blocked=true;e.down();assert.equal(e.level.documentCollected,false);e.up();
    e.physics.blocked=false;e.camera.transform.position.z=4;e.down();assert.equal(e.level.documentCollected,false);e.up();
    e.camera.transform.position.z=0;e.camera.direction.z=1;e.down();assert.equal(e.level.documentCollected,false);e.up();
    e.camera.direction.z=-1;e.control.focused=false;e.down();assert.equal(e.level.documentCollected,false);e.up();e.control.focused=true;
    e.down(true);assert.equal(e.level.documentCollected,false);e.up();
    e.down();assert.equal(e.level.documentCollected,true);assert.equal(e.level.missionDocument.active,false);
    const count=e.physics.calls;e.down();e.down(true);assert.equal(e.physics.calls,count);
});
await check('未取文件进入终点；原地解锁后必须重新进入',()=>{
    const e=environment();e.start();e.enter();[0,1,2,3].forEach(i=>e.kill(i));e.level.onUpdate();
    assert.equal(e.level.state,'Playing');assert.match(e.level.objectiveText.text,/未取得文件/);
    e.down();e.level.onUpdate();assert.equal(e.level.state,'Playing');
    e.leave();e.enter();assert.equal(e.level.state,'Won');assert.match(e.level.resultDetail.text,/取得虚构任务文件/);
});
await check('暂停长按不跨越继续；跌落不撤销任务；失败时不可交互',()=>{
    const e=environment();e.start();[0,1,2,3].forEach(i=>e.kill(i));
    e.level.onControlsLost();e.down();assert.equal(e.level.documentCollected,false);e.start();e.down(true);assert.equal(e.level.documentCollected,false);
    e.up();e.down();assert.equal(e.level.documentCollected,true);e.level.onControlsLost();e.start();
    e.player.event('respawn');assert.equal(e.level.remaining.size,0);assert.equal(e.level.documentCollected,true);
    const f=environment();f.start();[0,1,2,3].forEach(i=>f.kill(i));f.health.isAlive=false;f.level.onUpdate();f.down();
    assert.equal(f.level.state,'Lost');assert.equal(f.level.documentCollected,false);
});
await check('暂停/胜利/失败重开：加载当前场景，清理监听器，初始状态恢复',async()=>{
    for(const state of ['Paused','Won','Lost']){
        const e=environment();e.start();e.kill(0);e.level.state=state;
        let opened=false;e.Laya.Scene.load=async url=>{assert.equal(url,'Demo01.ls');return {open(){opened=true;}};};
        await e.level.restart();assert.equal(opened,true);assert.equal(e.level.clock.destroyed,true);
        for(const source of [e.stage,e.player,e.win,e.doc,e.canvas,...e.enemies.map(x=>x.owner)])assert.equal(source.listeners.length,0);
        const fresh=environment();assert.equal(fresh.level.state,'Ready');assert.equal(fresh.level.remaining.size,4);assert.equal(fresh.level.documentCollected,false);assert.equal(fresh.level.missionDocument.active,true);
    }
});
await check('Scene.ls 无配置仍沿用清敌和终点重新进入规则',()=>{
    const e=environment(false,false);e.enter();[0,1,2,3].forEach(i=>e.kill(i));e.level.onUpdate();assert.equal(e.level.state,'Playing');e.leave();e.enter();assert.equal(e.level.state,'Won');
});
await check('场景显式分组、文件位置/资源、LayaAir 版本',()=>{
    const scene=JSON.parse(fs.readFileSync(path.join(root,'assets/Demo01.ls'),'utf8')),c=scene._$comp[0];
    assert.deepEqual(c.streetEnemies.map(x=>x._$ref),['target001','enemy002']);assert.deepEqual(c.courtyardEnemies.map(x=>x._$ref),['enemy003','enemy004']);
    const items=scene._$child[0]._$child,doc=items.find(x=>x._$id===c.missionDocument._$ref);
    assert.ok(doc);assert.equal(doc.transform.localPosition.z,-53.8);assert.equal(doc._$child.length,3);
    const mat=JSON.parse(fs.readFileSync(path.join(root,'assets/resources/MissionDocument.lmat.meta'),'utf8'));
    assert.equal(doc._$child[0]._$comp[1].sharedMaterials[0]._$uuid,mat.uuid);
    assert.equal(JSON.parse(fs.readFileSync(path.join(root,'NanChangDemo.laya'),'utf8')).version,'3.4.1');
});
console.log(`${passed} 组检查通过；未替代真实渲染、原生物理和 IDE 重开验收。`);
})().catch(error=>{console.error(error);process.exitCode=1;});
