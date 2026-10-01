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
    const {rifle:r}=environment();assert.deepEqual([r.magazineSize,r.startingReserve,r.roundsPerMinute,r.baseDamage],[5,45,45,70]);
    assert.deepEqual([r.reloadPrepareSeconds,r.reloadRoundSeconds,r.reloadFinishSeconds],[.7,.65,.45]);
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
    e.tick(5000);assert.equal(r.currentWeapon,'knife');assert.equal(r.reloading,false);
    assert.deepEqual([r.magazine,r.reserve],[3,45]);assert.ok(e.events.events.includes('rifle-reload-ended'));
});
check('reload completion conserves ammo and does not fire a held trigger',()=>{
    const e=environment(),r=e.rifle;r.magazine=3;r.startReload(0);r.handleMouseDown({button:0});
    for(const t of [700,1350,2000,2450,9000])e.tick(t);
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
        e.events.on('rifle-reload-stage',f,f.onReloadStage);
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
check('bolt only cycles after firing, pauses, carries into reload, and closes on cancel',()=>{
    const e=environment(),r=e.rifle;
    r.bolt={transform:{}};r.boltHome=new V3(0,.14,.15);r.boltHomeRotation=new V3();
    e.tick(100);assert.equal(r.boltCycleProgress,-1);assert.equal(r.bolt.transform.localPosition.z,.15);
    r.tryFire(100);e.tick(625);assert.ok(r.bolt.transform.localPosition.z>.249);
    const open=r.bolt.transform.localPosition.z;
    r.clock.paused=true;e.tick(700);assert.equal(r.bolt.transform.localPosition.z,open);
    r.clock.paused=false;r.startReload(700);e.tick(700);
    assert.equal(r.bolt.transform.localPosition.z,open,'reload must not snap an open bolt closed');
    e.tick(2000);assert.ok(r.bolt.transform.localPosition.z>.249);
    r.selectWeapon('knife');e.tick(2001);
    assert.equal(r.reloading,false);assert.equal(r.bolt.transform.localPosition.z,.15);
});
check('equal per-round intervals update magazine and reserve one round at a time',()=>{
    const e=environment(),r=e.rifle;r.magazine=0;r.startReload(0);
    e.tick(699);assert.equal(r.magazine,0);e.tick(700);assert.equal(r.reloadPhase,'insert');
    for(let i=1;i<=5;i++){
        e.tick(700+650*i-1);assert.equal(r.magazine,i-1);
        e.tick(700+650*i);assert.deepEqual([r.magazine,r.reserve],[i,45-i]);
    }
    assert.equal(r.reloadPhase,'finish');e.tick(4399);assert.equal(r.isReloading,true);
    e.tick(4400);assert.equal(r.isReloading,false);
});
check('partial reload finishes sooner, limited reserve is conserved',()=>{
    const e=environment(),r=e.rifle;r.magazine=4;r.startReload(0);
    for(const t of [700,1350,1800])e.tick(t);
    assert.deepEqual([r.magazine,r.reserve,r.isReloading],[5,44,false]);
    r.magazine=0;r.reserve=2;r.startReload(2000);
    for(const t of [2700,3350,4000,4450])e.tick(t);
    assert.deepEqual([r.magazine,r.reserve,r.isReloading],[2,0,false]);
});
check('second R finishes the active round then closes, repeats do not request a stop',()=>{
    const e=environment(),r=e.rifle;r.magazine=0;
    const key={keyCode:82,nativeEvent:{repeat:false,preventDefault(){}}};
    r.handleKeyDown(key);r.handleKeyDown({...key,nativeEvent:{repeat:true,preventDefault(){}}});
    assert.equal(r.reloadStopRequested,false);r.handleKeyUp(key);e.tick(700);e.at(1000);r.handleKeyDown(key);
    assert.equal(r.magazine,0);e.tick(1349);assert.equal(r.magazine,0);
    e.tick(1350);assert.deepEqual([r.magazine,r.reloadPhase],[1,'finish']);
    r.handleKeyUp(key);r.handleKeyDown(key);e.tick(1800);
    assert.deepEqual([r.magazine,r.reserve,r.isReloading],[1,44,false]);
});
check('R during preparation stops after first round; switching preserves committed rounds',()=>{
    const e=environment(),r=e.rifle;r.magazine=0;r.startReload(0);
    e.at(100);r.handleKeyDown({keyCode:82});e.tick(700);e.tick(1350);
    assert.equal(r.reloadPhase,'finish');e.tick(1800);assert.equal(r.magazine,1);
    r.startReload(2000);for(const t of [2700,3350])e.tick(t);
    assert.equal(r.magazine,2);e.at(3500);r.selectWeapon('knife');e.tick(9999);
    assert.deepEqual([r.magazine,r.reserve,r.isReloading],[2,43,false]);
});
check('R on the insertion deadline closes after that round, without starting another',()=>{
    const e=environment(),r=e.rifle;r.magazine=0;r.startReload(0);e.tick(700);e.at(1350);
    r.handleKeyDown({keyCode:82});
    assert.deepEqual([r.magazine,r.reloadPhase],[1,'finish']);
    e.tick(1800);assert.equal(r.magazine,1);assert.equal(r.isReloading,false);
});
check('stalls do not batch-fill the magazine, paused or disabled reload cannot insert',()=>{
    const e=environment(),r=e.rifle;r.magazine=0;r.startReload(0);
    e.tick(10000);assert.equal(r.magazine,0);assert.equal(r.reloadPhase,'insert');
    e.tick(20000);assert.equal(r.magazine,1);e.tick(20001);assert.equal(r.magazine,1);
    r.clock.paused=true;e.tick(30000);assert.equal(r.magazine,1);
    r.clock.paused=false;r.onDisable();e.tick(40000);assert.equal(r.magazine,1);
});
check('chambering reflects the remaining rounds and never invents a last-shot round',()=>{
    const e=environment(),r=e.rifle;r.magazine=2;r.tryFire(0);
    assert.equal(r.hasRoundToChamber,true);
    e.at(1340);r.tryFire(1340);assert.equal(r.hasRoundToChamber,false);assert.equal(r.reloadPhase,'prepare');
    e.tick(2040);e.tick(2690);assert.equal(r.hasRoundToChamber,true);assert.equal(r.magazine,1);
});
check('configured timings are fixed for all rounds of an active reload',()=>{
    const e=environment(),r=e.rifle;r.magazine=0;r.reloadPrepareSeconds=.2;r.reloadRoundSeconds=.3;r.reloadFinishSeconds=.1;
    r.startReload(0);r.reloadRoundSeconds=9;e.tick(200);e.tick(500);e.tick(800);
    assert.equal(r.magazine,2);assert.equal(r.reloadStageEnd,1100);
    r.handleKeyDown({keyCode:82});e.tick(1100);e.tick(1200);
    assert.deepEqual([r.magazine,r.isReloading],[3,false]);
});
check('one spent case ejects when the bolt opens; topping up does not eject another',()=>{
    const e=environment(),r=e.rifle;r.tryFire(0);
    e.tick(200);assert.equal(e.events.events.filter(x=>x==='rifle-case-ejected').length,0);
    e.tick(450);e.tick(520);assert.equal(e.events.events.filter(x=>x==='rifle-case-ejected').length,1);
    r.startReload(1500);for(const t of [1900,2200,2850,3100,3300])e.tick(t);
    assert.deepEqual([r.magazine,r.reserve],[5,44]);
    assert.equal(e.events.events.filter(x=>x==='rifle-case-ejected').length,1);
});
check('one-round top-up hides the loose cartridge throughout reload finish',()=>{
    const e=environment(),r=e.rifle;
    const {CharacterAnimation}=e.load('CharacterAnimation');
    const a=Object.create(CharacterAnimation.prototype);
    a.rifle=r;a.reloadCartridge={active:true};r.magazine=4;r.startReload(0);
    e.tick(700);e.tick(1350);assert.equal(r.reloadPhase,'finish');
    for(const t of [1350,1450,1600,1799]){
        e.at(t);a.reloadCartridge.active=true;a.updateReloadCartridge();
        assert.equal(a.reloadCartridge.active,false);
    }
    assert.deepEqual([r.magazine,r.reserve],[5,44]);
});
check('last-shot auto-reload ejects one case and pause delays it',()=>{
    const e=environment(),r=e.rifle;r.magazine=1;r.tryFire(0);
    assert.equal(r.reloadPhase,'prepare');r.clock.paused=true;e.tick(400);
    assert.equal(e.events.events.filter(x=>x==='rifle-case-ejected').length,0);
    r.clock.paused=false;e.tick(400);e.tick(700);e.tick(1350);
    assert.equal(e.events.events.filter(x=>x==='rifle-case-ejected').length,1);
});
check('disable or a skipped bolt animation cannot replay an old case during a later reload',()=>{
    for(const stop of ['disable','stall']){
        const e=environment(),r=e.rifle;r.tryFire(0);
        if(stop==='disable')r.onDisable();else e.tick(2000);
        e.at(2200);r.startReload(2200);e.tick(2600);
        assert.equal(e.events.events.filter(x=>x==='rifle-case-ejected').length,0);
    }
});
console.log(`PASS ${passed} weapon/state/audio/settings regression groups`);
