// 状态回归：执行真实控制器代码，替代渲染/物理/音频宿主；实机渲染另行验证。
// node tools/check-weapon-states.cjs <LayaAirIDE/resources/node_modules/typescript>
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const ts = require(process.argv[2] || 'typescript');
const root = path.resolve(__dirname, '..');

class Events {
    constructor() { this.listeners = new Map(); this.events = []; }
    on(type, caller, fn) { const list = this.listeners.get(type) || []; list.push({caller, fn}); this.listeners.set(type, list); }
    event(type, value) { this.events.push(type); for (const h of this.listeners.get(type) || []) h.fn.call(h.caller, value); }
    offAllCaller(caller) { for (const [type, list] of this.listeners) this.listeners.set(type, list.filter(h => h.caller !== caller)); }
    addEventListener() {}
    removeEventListener() {}
}
class V3 {
    constructor(x=0,y=0,z=0) { this.setValue(x,y,z); }
    setValue(x,y,z) { Object.assign(this,{x,y,z}); }
    static lerp(a,b,t,out) { out.setValue(a.x+(b.x-a.x)*t,a.y+(b.y-a.y)*t,a.z+(b.z-a.z)*t); }
}
function environment(saved) {
    let now = 0;
    const events = new Events(), canvas = new Events(), store = new Map();
    if(saved !== undefined)store.set('NanChangDemo.settings.v1', saved);
    const control = {focused:true,clock:{paused:false},isGameplayFocused(){return this.focused && !this.clock.paused;},
        setAiming(){},setAimProgress(){},syncCameraForShot(){},addRecoil(){}};
    class PlayerController {}
    class EnemyAI {}
    const enemy = {hits:[],owner:{name:'Target'},applyHit(node,damage){this.hits.push(damage);return {damage,remainingHealth:100-damage,killed:false};}};
    const target = {name:'Torso',parent:null,getComponent(type){return type===EnemyAI?enemy:null;}};
    const wall = {name:'Wall',parent:null,getComponent(){return null;}};
    const physics = {blocked:false,distance:2,lastRange:0,rayCast(ray,hit,range){this.lastRange=range;if(this.distance>range)return false;hit.collider={owner:this.blocked?wall:target};return true;}};
    const owner = Object.assign(events,{scene:{physicsSimulation:physics},getComponent:()=>control});
    const Laya = {Script:class{constructor(){this.enabled=true;}},Sprite3D:class{},Camera:class{},GTextField:class{},GBox:class{},GButton:class{},GSlider:class{},
        regClass:()=>cls=>cls,property:()=>()=>{},Vector3:V3,Vector2:V3,Ray:class{constructor(origin,direction){Object.assign(this,{origin,direction});}},HitResult:class{},
        Browser:{mainCanvas:{source:canvas}},stage:Object.assign(new Events(),{width:1280,height:720}),timer:{delta:16},
        Event:{KEY_DOWN:'key',RESIZE:'resize'},Physics3DUtils:{COLLISIONFILTERGROUP_CHARACTERFILTER:32},
        SoundManager:{played:[],playSound(url){const channel={isStopped:false,volume:1,stop(){this.isStopped=true;}};this.played.push(channel);return channel;}}};
    class KnifeView {constructor(){this.root={active:false};}setPose(){}destroy(){this.destroyed=true;}}
    const context=vm.createContext({Laya,console,performance:{now:()=>now},window:new Events(),document:Object.assign(new Events(),{hidden:false}),
        localStorage:{getItem:key=>store.get(key)??null,setItem:(key,value)=>store.set(key,value)}});
    const modules={PlayerController:{PlayerController},EnemyAI:{EnemyAI},KnifeView:{KnifeView},PlayerHealth:{PlayerHealth:class{}},GameClock:{}};
    function load(name){
        if(modules[name])return modules[name];
        const source=fs.readFileSync(path.join(root,'src',name+'.ts'),'utf8');
        const compiled=ts.transpileModule(source,{compilerOptions:{module:ts.ModuleKind.CommonJS,target:ts.ScriptTarget.ES2020,experimentalDecorators:true}}).outputText;
        const exports={};vm.runInContext(`(function(require,exports){${compiled}\n})`,context)(s=>load(s.replace('./','')),exports);return modules[name]=exports;
    }
    const {RifleController}=load('RifleController');
    const rifle=new RifleController();
    Object.assign(rifle,{owner,viewCamera:{fieldOfView:60,transform:{position:new V3()},viewportPointToRay(){}},
        rifleModel:{active:true,parent:{},transform:{localPosition:new V3()}},clock:{paused:false,now:()=>now,timer:{delta:16}}});
    control.clock=rifle.clock;rifle.onAwake();
    return {rifle,events,control,enemy,physics,store,Laya,load,at(value){now=value;},tick(value){now=value;rifle.onUpdate();}};
}
let passed=0;
function check(name,fn){fn();passed++;console.log('PASS',name);}
check('preserve Hanyang defaults and configurable recoil',()=>{
    const {rifle:r}=environment();assert.deepEqual([r.magazineSize,r.startingReserve,r.roundsPerMinute,r.reloadSeconds,r.baseDamage],[5,45,45,3.3,70]);
    assert.deepEqual([r.hipRecoil,r.aimRecoil,r.horizontalRecoil,r.recoilDistance],[1.35,1.8,.12,.1]);
});
check('held mouse and a one-second stall never produce catch-up shots',()=>{
    const e=environment(),r=e.rifle;r.handleMouseDown({button:0});
    for(const time of [1000,1016,1032,5000])e.tick(time);
    r.handleMouseDown({button:0});assert.equal(r.magazine,4);
    r.handleMouseUp({button:0});r.handleMouseDown({button:0});assert.equal(r.magazine,3);
});
check('click during bolt cooldown is discarded, not queued',()=>{
    const e=environment(),r=e.rifle;r.handleMouseDown({button:0});r.handleMouseUp({button:0});
    e.at(100);r.handleMouseDown({button:0});e.tick(1500);assert.equal(r.magazine,4);
    r.handleMouseUp({button:0});r.handleMouseDown({button:0});assert.equal(r.magazine,3);
});
check('switching cancels reload without changing ammo or reserve',()=>{
    const e=environment(),r=e.rifle;r.magazine=3;r.startReload(0);e.at(100);r.selectWeapon('knife');
    e.tick(5000);r.finishReload(5000);assert.equal(r.currentWeapon,'knife');assert.equal(r.reloading,false);
    assert.deepEqual([r.magazine,r.reserve],[3,45]);assert.ok(e.events.events.includes('rifle-reload-ended'));
});
check('reload completion conserves ammo and does not fire a held trigger',()=>{
    const e=environment(),r=e.rifle;r.magazine=3;r.startReload(0);r.handleMouseDown({button:0});e.tick(3300);e.tick(9000);
    assert.deepEqual([r.magazine,r.reserve],[5,43]);assert.equal(e.events.events.filter(x=>x==='rifle-fired').length,0);
});
check('rifle cooldown also prevents switching to bypass attack recovery',()=>{
    const e=environment(),r=e.rifle;r.tryFire(0);e.at(10);r.selectWeapon('knife');assert.equal(r.currentWeapon,'rifle');
    e.at(1340);r.selectWeapon('knife');assert.equal(r.currentWeapon,'knife');
});
for(const heavy of [false,true])check(`${heavy?'heavy':'light'} melee hits once at animation midpoint`,()=>{
    const e=environment(),r=e.rifle;r.selectWeapon('knife');e.at(1000);r.trySwing(1000,heavy);
    assert.equal(e.enemy.hits.length,0);const impact=1000+(heavy?310:160);
    e.tick(impact-1);assert.equal(e.enemy.hits.length,0);e.tick(impact);e.tick(impact+1);
    assert.deepEqual(e.enemy.hits,[heavy?90:45]);assert.equal(e.physics.lastRange,heavy?2.8:2.5);
});
check('heavy melee cannot cancel into a rifle shot after 10ms',()=>{
    const e=environment(),r=e.rifle;r.selectWeapon('knife');e.at(1000);r.trySwing(1000,true);
    e.at(1010);r.selectWeapon('rifle');r.tryFire(1010);assert.equal(r.currentWeapon,'knife');assert.equal(r.magazine,5);
    e.tick(1310);e.at(2299);r.selectWeapon('rifle');assert.equal(r.currentWeapon,'knife');
    e.at(2300);r.selectWeapon('rifle');r.tryFire(2300);assert.equal(r.magazine,4);
});
check('wall and range misses cannot damage an enemy',()=>{
    for(const [blocked,distance] of [[true,1],[false,4]]){
        const e=environment(),r=e.rifle;e.physics.blocked=blocked;e.physics.distance=distance;
        r.selectWeapon('knife');r.trySwing(0,true);e.tick(310);assert.equal(e.enemy.hits.length,0);
    }
});
check('a stall past the whole swing drops the pending hit',()=>{
    const e=environment(),r=e.rifle;r.selectWeapon('knife');r.trySwing(0,true);
    e.tick(2000);e.tick(2016);assert.equal(e.enemy.hits.length,0);assert.equal(r.pendingMeleeHit,false);
});
check('paused and disabled controllers cannot apply pending damage',()=>{
    const e=environment(),r=e.rifle;r.selectWeapon('knife');r.trySwing(0,true);
    r.clock.paused=true;e.tick(310);assert.equal(e.enemy.hits.length,0);
    r.clock.paused=false;e.tick(310);assert.equal(e.enemy.hits.length,1);
    e.at(2000);r.trySwing(2000,true);r.onDisable();e.tick(2310);assert.equal(e.enemy.hits.length,1);
});
check('left/right presses cannot overlap melee or queue another swing',()=>{
    const e=environment(),r=e.rifle;r.selectWeapon('knife');r.handleMouseDown({button:0});
    e.at(1);r.handleMouseDown({button:2});e.tick(160);e.tick(1400);assert.deepEqual(e.enemy.hits,[45]);
});
check('reload channel stops on switch, pause, and controller disposal',()=>{
    for(const stop of ['switch','pause','disable']){
        const e=environment(),r=e.rifle;const {CombatFeedback}=e.load('CombatFeedback');const f=new CombatFeedback();
        f.running=true;f.audioReady=true;f.reloadSound='reload';f.soundUrls.set('reload','reload.wav');
        e.events.on('rifle-reload-started',f,f.onReload);e.events.on('rifle-reload-ended',f,f.onReloadEnded);
        r.magazine=3;r.startReload(0);const channel=e.Laya.SoundManager.played[0];assert.ok(channel&&!channel.isStopped);
        if(stop==='switch')r.selectWeapon('knife');else if(stop==='pause')f.setPaused(true);else r.onDisable();
        assert.equal(channel.isStopped,true);assert.equal(f.channels.size,0);
    }
});
check('new volume controls migrate legacy settings, clamp, persist, and reset',()=>{
    const e=environment(JSON.stringify({volume:.4,sensitivity:.27})),g=e.load('GameSettings').GameSettings;
    assert.deepEqual([g.volume,g.sensitivity,g.reloadVolume,g.meleeVolume],[.4,.27,1,1]);
    g.setReloadVolume(-2);g.setMeleeVolume(5);assert.deepEqual([g.reloadVolume,g.meleeVolume],[0,1]);
    g.setReloadVolume(.35);g.setMeleeVolume(.6);const saved=JSON.parse(e.store.get('NanChangDemo.settings.v1'));
    assert.deepEqual([saved.reloadVolume,saved.meleeVolume],[.35,.6]);g.reset();assert.deepEqual([g.volume,g.reloadVolume,g.meleeVolume],[1,1,1]);
});
console.log(`PASS ${passed} weapon/state/audio/settings regression groups`);
