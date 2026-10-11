import { EnemyAI } from "./EnemyAI";
import { PlayerController } from "./PlayerController";
import { PlayerHealth } from "./PlayerHealth";
import { RifleController } from "./RifleController";
import { CombatFeedback } from "./CombatFeedback";
import { GameClock } from "./GameClock";
import { EncounterWave } from "./EncounterWave";
import { MissionRoute } from "./MissionRoute";
import { Openable } from "./Openable";

const { regClass, property } = Laya;
type LevelState = "Ready" | "Playing" | "Paused" | "Won" | "Lost" | "Restarting";

/** 单关卡会话；可选分组清敌/取文件任务，结算后重载完整场景。 */
@regClass()
export class LevelController extends Laya.Script {
    // 3.4.1 的公开物理更新开关为全局属性。重载期间可能同时存在两个场景，
    // 只有最后一个暂停持有者释放时才恢复它，旧场景销毁不会解冻新开始界面。
    private static readonly physicsHolders = new Set<LevelController>();
    private static savedPhysicsUpdate = true;
    @property({ type: Laya.Sprite3D })
    player: Laya.Sprite3D;
    @property({ type: [Laya.Sprite3D], caption: "本关指定敌人" })
    enemies: Laya.Sprite3D[] = [];
    @property({ type: [Laya.Sprite3D], caption: "任务：街口敌人（可选）" })
    streetEnemies: Laya.Sprite3D[] = [];
    @property({ type: [Laya.Sprite3D], caption: "任务：院落敌人（可选）" })
    courtyardEnemies: Laya.Sprite3D[] = [];
    @property({ type: Laya.Sprite3D, caption: "任务：虚构文件物件（可选）" })
    missionDocument: Laya.Sprite3D;
    @property({ type: Number, min: 0.1, caption: "文件交互距离（米）" })
    documentRange = 2.2;
    @property({ type: Number, min: 0.01, caption: "文件瞄准容差半径（米）" })
    documentAimRadius = 0.3;
    @property({ type: Laya.Sprite3D, caption: "终点区域中心" })
    exitZone: Laya.Sprite3D;
    @property({ type: Laya.Vector3, caption: "终点区域半尺寸" })
    exitHalfSize = new Laya.Vector3(2.5, 2, 2.5);
    @property({ type: String, caption: "战斗目标提示" })
    combatObjective = "目标：清除全部敌人，再进入通道尽头的橙色终点区";
    @property({ type: String, caption: "重开场景（无 URL 时）" })
    restartScene = "Scene.ls";
    @property({ type: [Laya.Sprite3D], caption: "路线提示点（节点名为提示）" })
    routePoints: Laya.Sprite3D[] = [];
    @property({ type: Laya.GTextField })
    routeText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    remainingText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    objectiveText: Laya.GTextField;
    @property({ type: Laya.GBox })
    resultPanel: Laya.GBox;
    @property({ type: Laya.GTextField })
    resultTitle: Laya.GTextField;
    @property({ type: Laya.GTextField })
    resultDetail: Laya.GTextField;
    @property({ type: Laya.GButton })
    restartButton: Laya.GButton;
    @property({ type: Laya.GButton, caption: "开始/继续按钮（可选）" })
    continueButton: Laya.GButton;
    @property({ type: Laya.GButton, caption: "设置按钮（可选）" })
    settingsButton: Laya.GButton;

    private state: LevelState = "Playing";
    private readonly remaining = new Set<EnemyAI>();
    private targets: EnemyAI[] = [];
    @property({ type: [Laya.Sprite3D], caption: "增援预备队（初始隐藏）" })
    reinforcementEnemies: Laya.Sprite3D[] = [];
    @property({ type: [Laya.Sprite3D], caption: "增援候选出生点" })
    reinforcementSpawns: Laya.Sprite3D[] = [];
    @property({ type: Number, caption: "增援与玩家最小距离" })
    reinforcementDistance = 35;
    @property({ type: Number, caption: "增援呼叫延迟（秒）" })
    reinforcementDelay = 6;
    @property({ type: Number, caption: "增援呼叫冷却（秒）" })
    reinforcementCooldown = 45;
    private reserveIndex = 0;
    private nextCallAt = 0;
    private pendingCall: { caller: EnemyAI; at: number; location: Laya.Vector3 };
    private spawnProbe: Laya.BoxColliderShape;
    private readonly spawnHits: Laya.HitResult[] = [];

    @property({ type: [Laya.Sprite3D], caption: "队友" })
    teammates: Laya.Sprite3D[] = [];
    @property({ type: [Laya.Sprite3D], caption: "顺序遭遇波次（可选）" })
    encounterWaves: Laya.Sprite3D[] = [];
    @property({ type: [Laya.Sprite3D], caption: "小巷主路线（按行进顺序）" })
    missionRoutePoints: Laya.Sprite3D[] = [];
    private waves: EncounterWave[] = [];
    private missionRoute: MissionRoute;
    private nextWave = 0;
    private waveActive = false;
    private health: PlayerHealth;
    private playerControl: PlayerController;
    private rifle: RifleController;
    private wasInsideExit = false;
    private routeIndex = 0;
    private clock: GameClock;
    private world: Laya.Scene3D;
    private previousTimer: Laya.Timer;
    private awaitingControls = false;
    private streetTargets: EnemyAI[] = [];
    private courtyardTargets: EnemyAI[] = [];
    private documentCollected = false;
    private interactHeld = false;
    private readonly interactionRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3());
    private readonly interactionHit = new Laya.HitResult();
    private readonly interactionAim = new Laya.Vector2();
    private readonly openingHits: Laya.HitResult[] = [];
    private openings: Openable[] = [];

    private get hasMission(): boolean { return !!this.missionDocument; }
    private get exitUnlocked(): boolean {
        return !this.pendingCall && this.remaining.size === 0 && (!this.hasMission || this.documentCollected);
    }

    onAwake(): void {
        this.health = this.player.getComponent(PlayerHealth);
        this.playerControl = this.player.getComponent(PlayerController);
        this.rifle = this.player.getComponent(RifleController);
        this.clock = new GameClock();
        this.world = this.player.scene as Laya.Scene3D;
        this.previousTimer = this.world.timer;
        this.world.timer = this.clock.timer;
        this.targets = Array.from(new Set(this.enemies.map(node => node.getComponent(EnemyAI))));
        this.playerControl.clock = this.rifle.clock = this.health.clock = this.clock;
        for (const enemy of [...this.targets, ...this.teammates.map(n => n.getComponent(EnemyAI))]) if (enemy) enemy.clock = this.clock;
        (this.owner as Laya.Scene).autoDestroyAtClosed = true;
        this.resultPanel.visible = false;
        if (this.continueButton) {
            this.playerControl.useMenuFocus();
            this.state = "Ready";
            this.setGameplayPaused(true);
            this.showSessionMenu();
        }
    }

    onEnable(): void {
        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.onInteractDown);
        Laya.stage.on(Laya.Event.KEY_UP, this, this.onInteractUp);
        this.restartButton.on(Laya.Event.CLICK, this, this.restart);
        if (this.continueButton) {
            this.continueButton.on(Laya.Event.CLICK, this, this.beginContinue);
            this.player.on(PlayerController.CONTROL_ACQUIRED, this, this.onControlsAcquired);
            this.player.on(PlayerController.CONTROL_LOST, this, this.onControlsLost);
            window.addEventListener("blur", this.onControlsLost);
            document.addEventListener("visibilitychange", this.onVisibilityChanged);
            window.addEventListener("keydown", this.onEscape, true);
            Laya.Browser.mainCanvas.source.addEventListener("blur", this.onControlsLost);
        }
        Laya.stage.on(Laya.Event.RESIZE, this, this.layoutResult);
        this.layoutResult();
    }

    onStart(): void {
        this.openings = Array.from(Openable.instances).filter(o => o.owner.scene === this.world);
        for (const opening of this.openings) {
            opening.clock = this.clock;
            opening.isBlocked = angle => opening.overlapsActor(this.player.transform.position, .96, 1.92, angle)
                || this.allBots().some(b => b.isAlive && b.owner.activeInHierarchy
                    && opening.overlapsActor((b.owner as Laya.Sprite3D).transform.position, 0, 1.84, angle));
        }
        // 显式场景引用定义任务目标；Set 同时防止重复配置和重复死亡通知。
        if (!this.targets.length || this.targets.some(enemy => !enemy)) {
            throw new Error("LevelController 的指定敌人必须挂有 EnemyAI，且不能留空。");
        }
        if (this.encounterWaves.length) this.initializeWaves();
        else if (this.hasMission || this.streetEnemies.length || this.courtyardEnemies.length) {
            this.streetTargets = this.streetEnemies.map(node => node?.getComponent(EnemyAI));
            this.courtyardTargets = this.courtyardEnemies.map(node => node?.getComponent(EnemyAI));
            const grouped = [...this.streetTargets, ...this.courtyardTargets];
            if (!this.hasMission || !this.streetTargets.length || !this.courtyardTargets.length
                || grouped.some(enemy => !enemy || this.targets.indexOf(enemy) < 0)
                || new Set(grouped).size !== grouped.length || grouped.length !== this.targets.length) {
                throw new Error("分阶段任务须配置文件及互不重复的两组敌人，并完整覆盖本关指定敌人。");
            }
        }
        for (const enemy of this.targets) {
            if (enemy.isAlive) this.remaining.add(enemy);
            enemy.owner.on(EnemyAI.DIED, this, this.onEnemyDied);
        }
        for (const bot of this.allBots()) bot.owner.on(EnemyAI.FIRED, this, this.onBotGunfire);
        this.player.on(RifleController.FIRED, this, this.onPlayerGunfire);
        this.player.on(PlayerHealth.DIED, this, this.onPlayerDied);
        this.player.on(PlayerController.RESPAWNED, this, this.onPlayerRespawned);
        this.wasInsideExit = this.isInsideExit();
        this.updateObjective();
        this.updateRouteHint();
    }

    onUpdate(): void {
        if (this.state !== "Playing") return;
        // 失败优先，也覆盖组件启动前生命就已归零的情况。
        if (!this.health.isAlive) {
            this.finish(false);
            return;
        }
        if (this.waves.length) {
            this.updateWaves();
            this.updateSquadFollow();
        } else this.updateReinforcements();
        const inside = this.isInsideExit();
        if (this.exitUnlocked && inside && !this.wasInsideExit) {
            this.finish(true);
            return;
        }
        this.wasInsideExit = inside;
        this.updateObjective();
        this.updateRouteHint();
    }

    private allBots(): EnemyAI[] {
        return [...this.targets, ...this.teammates.map(n=>n.getComponent(EnemyAI))].filter(b=>!!b);
    }

    private onPlayerGunfire(): void { this.broadcastGunfire(this.player); }
    private onBotGunfire(bot: EnemyAI): void { this.broadcastGunfire(bot.owner as Laya.Sprite3D); }

    private broadcastGunfire(shooter: Laya.Sprite3D): void {
        if (this.state !== "Playing" || this.clock.paused) return;
        const location = shooter.transform.position.clone(), now = this.clock.now();
        if (this.waves.length) {
            const region = this.regionAt(location);
            for (const bot of this.allBots()) {
                if (bot.isAlive && bot.enabled && bot.owner.activeInHierarchy
                    && this.regionAt((bot.owner as Laya.Sprite3D).transform.position) === region
                    && Laya.Vector3.distance(location, (bot.owner as Laya.Sprite3D).transform.position) <= 40)
                    bot.hearGunshot(location);
            }
            return;
        }
        const caller = this.targets.find(b=>b.isAlive && b.enabled && (b.state === "Patrol" || b.state === "Idle"));
        // A living patrol can place one call; gunfire cannot reset the deadline each frame.
        if (caller && !this.pendingCall && now >= this.nextCallAt && this.reserveIndex < this.reinforcementEnemies.length) {
            this.pendingCall = {caller, at:now+this.reinforcementDelay*1000, location:location.clone()};
            this.nextCallAt = now + this.reinforcementCooldown*1000;
        }
        for (const bot of this.allBots()) if (bot.isAlive && bot.enabled) bot.hearGunshot(location);
    }

    private initializeWaves(): void {
        this.waves = this.encounterWaves.map(n => n.getComponent(EncounterWave));
        const nodes: Laya.Sprite3D[] = [];
        for (const wave of this.waves) nodes.push(...(wave?.enemies || []));
        if (this.missionRoutePoints.length < 2 || this.waves.some(w => !w || !w.triggerPoint || !w.enemies.length)
            || new Set(nodes).size !== nodes.length || nodes.length !== this.enemies.length
            || this.enemies.some(n => nodes.indexOf(n) < 0)) throw new Error("波次必须完整且不重复地引用敌人，并配置主路线和接近触发点。");
        this.missionRoute = new MissionRoute(this.missionRoutePoints.map(n => n.transform.position.clone()));
        this.waves.forEach((wave, index) => wave.enemies.forEach(node => {
            node.active = false;
            const bot = node.getComponent(EnemyAI);
            bot.clock = this.clock;
            bot.canEngage = target => this.regionAt(target.transform.position) === index;
        }));
        this.teammates.forEach(node => {
            const bot = node.getComponent(EnemyAI);
            bot.canEngage = target => this.waveActive
                && this.waves[this.nextWave]?.enemies.indexOf(target) >= 0;
        });
        this.updateSquadFollow();
    }

    private regionAt(position: Laya.Vector3): number {
        const progress = this.missionRoute.progress(position);
        return this.waves.findIndex(w => progress >= w.regionStart && progress < w.regionEnd);
    }

    private updateWaves(): void {
        if (this.nextWave >= this.waves.length) return;
        const wave = this.waves[this.nextWave];
        if (this.waveActive) {
            if (wave.enemies.some(n => n.getComponent(EnemyAI).isAlive)) return;
            this.waveActive = false;
            this.nextWave++;
            for (const node of this.teammates) node.getComponent(EnemyAI)?.resumePatrol();
            return;
        }
        const p = this.player.transform.position, trigger = wave.triggerPoint.transform.position;
        if (Math.abs(p.y - trigger.y) > 3 || Math.hypot(p.x - trigger.x, p.z - trigger.z) > wave.triggerRadius) return;
        for (const node of wave.enemies) node.active = true;
        this.waveActive = true;
    }

    private updateSquadFollow(): void {
        const progress = this.missionRoute.progress(this.player.transform.position);
        const wave = this.waves[this.nextWave];
        // Move independently along the route to the current fight or the next
        // assembly point. The player still exclusively triggers each new wave.
        const destination = wave
            ? this.missionRoute.progress((this.waveActive ? wave.owner as Laya.Sprite3D : wave.triggerPoint).transform.position)
                + (this.waveActive ? 3 : -2)
            : this.missionRoute.progress(this.missionDocument.transform.position);
        this.teammates.forEach((node, i) => {
            const bot = node.getComponent(EnemyAI);
            const goal = bot?.followTarget;
            if (!goal) return;
            const slot = i % 5;
            const phase = (Math.floor(this.clock.now() / 4000) + slot) % 3;
            const ahead = [5, 5, 8, 8, 11][slot] + [0, 1.5, -1.5][phase];
            const ownProgress = this.missionRoute.progress(node.transform.position);
            const staging = Math.max(0, destination - Math.floor(slot / 2) * 1.8);
            const next = Math.min(staging, Math.max(progress, ownProgress) + ahead);
            // The rear scout uses the outer lane instead of aiming through the
            // stationary player's capsule at the middle of the street.
            const p = this.missionRoute.sample(next, slot === 4 ? -2.8 : (slot % 2 ? 1 : -1) * 1.5);
            goal.transform.position = new Laya.Vector3(p.x, 0, p.z);
        });
    }

    private safeReinforcementPoints(count: number): Laya.Vector3[] {
        this.spawnProbe ||= new Laya.BoxColliderShape(.75,1.85,.75);
        const player = this.player.transform.position, sim = this.world.physicsSimulation;
        const result: Laya.Vector3[] = [];
        const choices = this.reinforcementSpawns.filter(n=>n && !n.destroyed).map(n=>n.transform.position.clone())
            .sort((a,b)=>Math.hypot(b.x-player.x,b.z-player.z)-Math.hypot(a.x-player.x,a.z-player.z));
        for (const p of choices) {
            if (Math.hypot(p.x-player.x,p.z-player.z) < this.reinforcementDistance) continue;
            if (result.some(q=>Math.hypot(p.x-q.x,p.z-q.z)<3)) continue;
            if (this.allBots().some(b=>b.isAlive && Math.hypot(p.x-(b.owner as Laya.Sprite3D).transform.position.x,
                p.z-(b.owner as Laya.Sprite3D).transform.position.z)<3)) continue;
            const ray = new Laya.Ray(new Laya.Vector3(p.x,p.y+3,p.z),new Laya.Vector3(0,-1,0));
            this.spawnHits.length=0;sim.rayCastAll(ray,this.spawnHits,4,-1,1);
            const floor = this.spawnHits.sort((a,b)=>a.hitFraction-b.hitFraction)[0];
            if (!floor || Math.abs(floor.point.y-p.y)>.2) continue;
            p.y=floor.point.y+.01;
            this.spawnHits.length=0;
            sim.shapeCastAll(this.spawnProbe.shape,new Laya.Vector3(p.x,p.y+3,p.z),
                new Laya.Vector3(p.x,p.y+.94,p.z),this.spawnHits,null,null,-1,1);
            if (this.spawnHits.length) continue;
            if (!this.isSpawnHidden(p)) continue;
            result.push(p);
            if(result.length===count)break;
        }
        return result;
    }

    private isSpawnHidden(position: Laya.Vector3): boolean {
        const eye = this.playerControl.followCamera.transform.position;
        const ray = new Laya.Ray(eye.clone(),new Laya.Vector3());
        // Require building cover for the head, body and both exposed edges;
        // being far away or outside the current camera FOV is not sufficient.
        for (const [x,y,z] of [[0,1.7,0],[-.35,1.7,0],[.35,1.7,0],[0,1.7,-.35],[0,1.7,.35],[0,.7,0]]) {
            ray.direction.setValue(position.x+x-eye.x,position.y+y-eye.y,position.z+z-eye.z);
            const distance=ray.direction.length();
            Laya.Vector3.scale(ray.direction,1/distance,ray.direction);
            this.spawnHits.length=0;
            this.world.physicsSimulation.rayCastAll(ray,this.spawnHits,Math.max(0,distance-.4),-1,1);
            if (!this.spawnHits.length) return false;
        }
        return true;
    }

    private updateReinforcements(): void {
        const call = this.pendingCall;
        if (!call) return;
        if (!call.caller.isAlive) { this.pendingCall=null; return; }
        if (this.clock.now()<call.at) return;
        const count=Math.min(2,this.reinforcementEnemies.length-this.reserveIndex);
        const points=this.safeReinforcementPoints(count);
        if (points.length<count) { call.at=this.clock.now()+1000; return; }
        const group=this.streetTargets.indexOf(call.caller)>=0 ? this.streetTargets : this.courtyardTargets;
        for(let i=0;i<count;i++) {
            const node=this.reinforcementEnemies[this.reserveIndex++];
            node.transform.position=points[i];
            const bot=node.getComponent(EnemyAI);bot.clock=this.clock;
            this.targets.push(bot);this.remaining.add(bot);group.push(bot);
            node.on(EnemyAI.DIED,this,this.onEnemyDied);node.on(EnemyAI.FIRED,this,this.onBotGunfire);
            node.active=true;
            bot.hearGunshot(call.location);
        }
        this.pendingCall=null;
    }

    private setGameplayPaused(paused: boolean): void {
        this.clock.setPaused(paused);
        const holders = LevelController.physicsHolders;
        if (paused && !holders.has(this)) {
            if (holders.size === 0) LevelController.savedPhysicsUpdate = Laya.Stat.enablePhysicsUpdate;
            holders.add(this);
            Laya.Stat.enablePhysicsUpdate = false;
        } else if (!paused && holders.delete(this) && holders.size === 0) {
            Laya.Stat.enablePhysicsUpdate = LevelController.savedPhysicsUpdate;
        }
        this.owner.getComponent(CombatFeedback)?.setPaused(paused);
        if (paused) {
            this.interactHeld = false;
            this.rifle.clearGameplayInput();
            this.playerControl.releaseGameplayFocus();
        }
    }

    private showSessionMenu(): void {
        if (!this.continueButton) return;
        const ready = this.state === "Ready";
        this.resultTitle.text = ready ? "旧城街巷 · DEMO 01" : "游戏已暂停";
        this.resultTitle.color = "#ffcf80";
        this.resultDetail.text = ready
            ? (this.encounterWaves.length
                ? `虚构小巷任务 · ${this.encounterWaves.length} 个交战区 · ${this.teammates.length} 名队友随行。\n清完当前区域，再沿小巷进入下一区；枪声只惊动本区敌人。\n逐区清敌 → 按 F 取得任务屋内文件 → 白色撤离圈。`
                : this.hasMission
                ? `虚构布局与任务文件，仅用于玩法设计。\n敌军在远处巡逻；枪声会暴露位置，并可能招来增援。\n清除${this.targets.length}名初始敌军及到达的增援 → 按 F 取文件 → 橙色终点。`
                : "虚构布局的玩法原型，不复原真实历史地点。\n清除全部敌人，抵达橙色终点。")
                + "\n\nWASD 移动 · 左键单发 / 轻击 · 右键开镜 / 重击\n1 汉阳造 · 3 短刀 · R 装填 · Space 跳跃\nQ/E 左右探头 · F 开关门窗 / 拾取 · Shift 疾跑 · C 切换蹲下/站起 · Esc 暂停"
            : "战斗与换弹已冻结。\n点击继续，取得鼠标控制后恢复游戏。\n\n鼠标锁定受限时，仍可在画面内移动鼠标转向。";
        this.continueButton.title = ready ? "开始游戏" : "继续游戏";
        this.continueButton.enabled = true;
        this.continueButton.visible = true;
        if (this.settingsButton) {
            this.settingsButton.visible = true;
            this.settingsButton.enabled = true;
        }
        this.restartButton.visible = !ready;
        this.restartButton.enabled = true;
        this.restartButton.title = "重新开始";
        this.resultPanel.visible = true;
        this.layoutResult();
    }

    private beginContinue(): void {
        if (this.awaitingControls || (this.state !== "Ready" && this.state !== "Paused")
            || document.hidden || !document.hasFocus()) return;
        this.awaitingControls = true;
        if (this.settingsButton) this.settingsButton.enabled = false;
        this.continueButton.enabled = false;
        this.continueButton.title = "正在取得鼠标控制…";
        this.owner.getComponent(CombatFeedback)?.requestAudioUnlock();
        this.playerControl.requestGameplayFocus();
    }

    private onControlsAcquired(): void {
        if (!this.awaitingControls || (this.state !== "Ready" && this.state !== "Paused")) return;
        this.awaitingControls = false;
        this.state = "Playing";
        this.setGameplayPaused(false);
        this.resultPanel.visible = false;
    }

    private readonly onControlsLost = () => {
        if (this.state === "Playing") {
            this.state = "Paused"; // 先转状态，再释放鼠标，避免失焦回调重入。
            this.awaitingControls = false;
            this.setGameplayPaused(true);
            this.showSessionMenu();
        } else if (this.awaitingControls && (this.state === "Ready" || this.state === "Paused")) {
            this.awaitingControls = false;
            this.setGameplayPaused(true);
            this.showSessionMenu();
        }
    };

    private readonly onVisibilityChanged = () => { if (document.hidden) this.onControlsLost(); };
    private readonly onEscape = (event: KeyboardEvent) => {
        if (event.key === "Escape") this.onControlsLost();
    };

    private onEnemyDied(enemy: EnemyAI): void {
        // 记账不受菜单状态影响，防止状态切换同帧丢失已发生的死亡；结算仍只在 Playing。
        if (enemy.isAlive || !this.remaining.delete(enemy)) return;
        // 在终点内击杀最后一个目标，仍须离开后再进入，不能原地直接获胜。
        if (this.remaining.size === 0) this.wasInsideExit = this.isInsideExit();
        this.updateObjective();
    }

    private onInteractDown(event: Laya.Event): void {
        if (event.keyCode !== 70) return;
        const held = this.interactHeld;
        this.interactHeld = true;
        if (held || (event.nativeEvent as KeyboardEvent)?.repeat || this.state !== "Playing"
            || !this.health.isAlive || !this.playerControl.isGameplayFocused()) return;
        if (!this.canCollectDocument()) {
            this.findOpening()?.toggle();
            return;
        }
        this.documentCollected = true;
        this.missionDocument.active = false;
        // 解锁当刻只采样边界，必须在解锁后重新进入终点。
        this.wasInsideExit = this.isInsideExit();
        this.updateObjective();
    }

    private onInteractUp(event: Laya.Event): void {
        if (event.keyCode === 70) this.interactHeld = false;
    }

    private findOpening(): Openable {
        if (!this.openings.length || this.state !== "Playing" || !this.playerControl.isGameplayFocused()) return null;
        this.playerControl.syncCameraForShot();
        this.interactionAim.setValue(Laya.stage.width / 2, Laya.stage.height / 2);
        const camera = this.playerControl.followCamera;
        camera.viewportPointToRay(this.interactionAim, this.interactionRay);
        camera.transform.position.cloneTo(this.interactionRay.origin);
        Laya.Vector3.normalize(this.interactionRay.direction, this.interactionRay.direction);
        let nearest: Openable = null, distance = Infinity;
        for (const opening of this.openings) {
            if (!opening.enabled || !opening.owner.activeInHierarchy) continue;
            const t = opening.interactionDistance(this.interactionRay);
            if (t < distance) { nearest = opening; distance = t; }
        }
        if (!nearest) return null;
        this.openingHits.length = 0;
        this.world.physicsSimulation.rayCastAll(this.interactionRay, this.openingHits, Math.max(.01, distance - .02), -1,
            ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER);
        for (const hit of this.openingHits) {
            const n = hit.collider?.owner;
            if (!n || n === this.player || this.player.isAncestorOf(n) || Openable.fromNode(n) === nearest) continue;
            return null;
        }
        return nearest;
    }

    private canCollectDocument(): boolean {
        if (!this.hasMission || this.pendingCall || this.documentCollected || this.remaining.size !== 0
            || this.state !== "Playing" || !this.health.isAlive || !this.playerControl.isGameplayFocused()
            || !this.missionDocument.activeInHierarchy) return false;
        this.playerControl.syncCameraForShot();
        const camera = this.playerControl.followCamera;
        const origin = camera.transform.position;
        const target = this.missionDocument.transform.position;
        const dx = target.x - origin.x, dy = target.y - origin.y, dz = target.z - origin.z;
        const distance = Math.hypot(dx, dy, dz);
        if (distance <= 0 || distance > this.documentRange) return false;
        this.interactionAim.setValue(Laya.stage.width / 2, Laya.stage.height / 2);
        camera.viewportPointToRay(this.interactionAim, this.interactionRay);
        const ray = this.interactionRay;
        Laya.Vector3.normalize(ray.direction, ray.direction);
        const along = dx * ray.direction.x + dy * ray.direction.y + dz * ray.direction.z;
        if (along <= 0 || distance * distance - along * along > this.documentAimRadius ** 2) return false;
        // 文件不添加碰撞体；以中心为目标检查现有墙地面，排除玩家胶囊。
        ray.origin.setValue(origin.x, origin.y, origin.z);
        ray.direction.setValue(dx / distance, dy / distance, dz / distance);
        return !this.world.physicsSimulation.rayCast(ray, this.interactionHit, distance,
            -1, ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER);
    }

    private onPlayerDied(): void {
        this.finish(false);
    }

    private onPlayerRespawned(): void {
        this.routeIndex = 0;
        this.wasInsideExit = this.isInsideExit();
        this.updateRouteHint();
    }

    private updateRouteHint(): void {
        if (!this.routeText || !this.routePoints.length) return;
        const p = this.player.transform.position;
        // 提示点只引导路线，不另设通关条件；跳过前面的点也能接上后续提示。
        for (let i = this.routeIndex; i < this.routePoints.length; i++) {
            const point = this.routePoints[i].transform.position;
            if (Math.abs(p.y - point.y) < 3 && Math.hypot(p.x - point.x, p.z - point.z) <= 2.5) {
                this.routeIndex = Math.min(i + 1, this.routePoints.length - 1);
            }
        }
        this.routeText.text = `路线：${this.routePoints[this.routeIndex].name}`;
        const opening = this.findOpening();
        if (opening && !this.canCollectDocument()) this.routeText.text = opening.hint;
    }

    private isInsideExit(): boolean {
        const p = this.player.transform.position;
        const exit = this.exitZone.transform.position;
        return Math.abs(p.x - exit.x) <= this.exitHalfSize.x
            && Math.abs(p.y - exit.y) <= this.exitHalfSize.y
            && Math.abs(p.z - exit.z) <= this.exitHalfSize.z;
    }

    private updateObjective(): void {
        if (this.waves.length) {
            const wave = this.waves[this.nextWave];
            const left = wave?.enemies.filter(n => n.getComponent(EnemyAI).isAlive).length || 0;
            this.remainingText.text = `区域 ${Math.min(this.nextWave + 1, this.waves.length)}/${this.waves.length} · 剩余敌人 ${this.remaining.size} · 文件 ${this.documentCollected ? 1 : 0}/1`;
            this.objectiveText.text = wave
                ? this.waveActive ? `清理第 ${this.nextWave + 1} 区：剩余 ${left} 人` : `沿小巷前往第 ${this.nextWave + 1} 区，队友随行`
                : !this.documentCollected ? this.canCollectDocument() ? "按 F 取得任务文件" : "前往尽头任务屋，取得桌上的文件"
                    : this.isInsideExit() ? "请离开并重新进入白色撤离区" : "携带文件，前往白色撤离区";
            this.objectiveText.color = this.exitUnlocked ? "#8fffb0" : "#ffcf80";
            return;
        }
        if (this.hasMission) {
            const street = this.streetTargets.filter(enemy => !this.remaining.has(enemy)).length;
            const courtyard = this.courtyardTargets.filter(enemy => !this.remaining.has(enemy)).length;
            this.remainingText.text = `一组 ${street}/${this.streetTargets.length} · 二组 ${courtyard}/${this.courtyardTargets.length} · 文件 ${this.documentCollected ? 1 : 0}/1`;
            const inside = this.isInsideExit();
            let task: string;
            if (street < this.streetTargets.length) task = `任务 1/4：清理第一组敌人 ${street}/${this.streetTargets.length}`;
            else if (courtyard < this.courtyardTargets.length) task = `任务 2/4：清理第二组敌人 ${courtyard}/${this.courtyardTargets.length}`;
            else if (!this.documentCollected) task = this.canCollectDocument()
                ? "任务 3/4：F 取得文件（虚构任务物件）"
                : "任务 3/4：取得建筑内西侧木桌上的文件 · 0/1";
            else task = inside ? "任务 4/4：请先离开终点区，再进入完成任务" : "任务 4/4：携带文件抵达建筑后方橙色终点 · 0/1";
            this.objectiveText.text = inside && !this.exitUnlocked
                ? `终点未解锁：${this.remaining.size ? "尚有敌人；" : ""}${this.documentCollected ? "" : "未取得文件；"}${task}` : task;
            if (this.pendingCall) this.objectiveText.text += ` · 敌方增援呼叫中（${Math.max(0,Math.ceil((this.pendingCall.at-this.clock.now())/1000))}秒）`;
            this.objectiveText.color = this.exitUnlocked ? "#8fffb0" : "#ffcf80";
            return;
        }
        this.remainingText.text = `剩余敌人  ${this.remaining.size} / ${this.targets.length}`;
        const inside = this.isInsideExit();
        if (this.remaining.size > 0) {
            this.objectiveText.text = inside
                ? "终点尚未解锁：先清除本关全部敌人"
                : this.combatObjective;
            this.objectiveText.color = "#ffcf80";
        } else {
            const p = this.player.transform.position;
            const exit = this.exitZone.transform.position;
            const distance = Math.hypot(p.x - exit.x, p.z - exit.z);
            this.objectiveText.text = inside
                ? "敌人已清除：请先离开终点区，再进入完成任务"
                : `敌人已清除：前往橙色终点区 · 距离 ${distance.toFixed(0)} 米`;
            this.objectiveText.color = "#8fffb0";
        }
    }

    private finish(won: boolean): void {
        if (this.state !== "Playing") return;
        this.state = won ? "Won" : "Lost";
        this.awaitingControls = false;
        this.setGameplayPaused(true);
        if (this.continueButton) this.continueButton.visible = false;
        if (this.settingsButton) this.settingsButton.visible = false;
        this.restartButton.visible = true;
        this.owner.getComponent(CombatFeedback)?.stop();
        // 同步关停：同一帧里其他敌人和残留射击都不能再造成伤害。
        this.health.enabled = false;
        for (const enemy of [...this.targets, ...this.teammates.map(n => n.getComponent(EnemyAI))]) if (enemy) enemy.enabled = false;
        this.rifle.stopCombat();
        this.playerControl.stopGameplay();
        this.resultTitle.text = won ? "任务完成" : "任务失败";
        this.resultTitle.color = won ? "#8fffb0" : "#ff7777";
        this.resultDetail.text = (won
            ? `已清除全部 ${this.targets.length} 名敌人，${this.hasMission ? "取得虚构任务文件，并" : "并"}抵达终点。`
            : `玩家已阵亡，本关还剩 ${this.remaining.size} 名敌人。`)
            + (this.continueButton ? "\n重新开始后返回开始界面。" : "\n重新开始后，点击画面取得鼠标控制。");
        this.restartButton.title = "重新开始";
        this.resultPanel.visible = true;
        this.layoutResult();
    }

    private async restart(): Promise<void> {
        if (this.state !== "Won" && this.state !== "Lost" && this.state !== "Paused") return;
        const endedState = this.state;
        this.state = "Restarting";
        this.awaitingControls = false;
        this.setGameplayPaused(true);
        if (this.settingsButton) this.settingsButton.enabled = false;
        if (this.continueButton) this.continueButton.enabled = false;
        this.restartButton.enabled = false;
        this.restartButton.title = "正在重新开始…";
        const currentScene = this.owner as Laya.Scene;
        let nextScene: Laya.Scene;
        try {
            // 先加载成功再销毁旧关卡；加载失败时保留结算界面供重试。
            // 优先重载当前关卡；无运行时 URL 的实例使用本关配置的资源路径。
            nextScene = await Laya.Scene.load(currentScene.url || this.restartScene, null);
            if (this.destroyed || currentScene.destroyed) {
                nextScene.destroy(true);
                return;
            }
            // close 会销毁 2D、3D 及全部脚本；先解绑旧输入，再激活新实例。
            currentScene.close();
            nextScene.open(false);
        } catch (error) {
            if (nextScene && !nextScene.destroyed) nextScene.destroy(true);
            console.error("重新加载关卡失败", error);
            if (this.destroyed || currentScene.destroyed) return;
            this.state = endedState;
            if (endedState === "Paused") this.showSessionMenu();
            this.restartButton.enabled = true;
            this.restartButton.title = "重试重新开始";
            this.resultDetail.text = "关卡加载失败，请点击按钮重试。";
        }
    }

    private layoutResult(): void {
        const width = Laya.stage.width;
        const height = Laya.stage.height;
        // 先按设计宽度排版，再统一缩放内容，避免窄窗口换行挤掉按钮。
        const textWidth = 720;
        this.resultPanel.size(width, height);
        this.resultTitle.width = this.resultDetail.width = textWidth;
        const sessionMenu = this.state === "Ready" || this.state === "Paused" ||
            (this.state === "Restarting" && this.continueButton?.visible);
        if (sessionMenu && this.continueButton) {
            this.resultTitle.pos(-textWidth / 2, -205);
            this.resultDetail.height = 210;
            this.resultDetail.pos(-textWidth / 2, -125);
            this.continueButton.pos(-this.continueButton.width / 2, 120);
            this.restartButton.pos(-this.restartButton.width / 2, 194);
            if (this.settingsButton) {
                const ready = this.state === "Ready";
                this.settingsButton.pos(ready ? -this.settingsButton.width / 2 : 8, 194);
                if (!ready) this.restartButton.x = -this.restartButton.width - 8;
            }
        } else {
            this.resultDetail.height = 72;
            this.resultTitle.pos(-textWidth / 2, -130);
            this.resultDetail.pos(-textWidth / 2, -52);
            this.restartButton.pos(-this.restartButton.width / 2, 38);
        }

        // 背景始终铺满舞台；标题、说明与所有可见按钮作为一个内容组适配。
        const widgets = [this.resultTitle, this.resultDetail, this.continueButton,
            this.restartButton, this.settingsButton].filter(widget => widget?.visible);
        const left = Math.min(...widgets.map(widget => widget.x));
        const top = Math.min(...widgets.map(widget => widget.y));
        const contentWidth = Math.max(...widgets.map(widget => widget.x + widget.width)) - left;
        const contentHeight = Math.max(...widgets.map(widget => widget.y + widget.height)) - top;
        const scale = Math.min(1, Math.max(1, width - 32) / contentWidth,
            Math.max(1, height - 32) / contentHeight);
        const x = (width - contentWidth * scale) / 2;
        const y = (height - contentHeight * scale) / 2;
        for (const widget of widgets) {
            widget.scale(scale, scale);
            widget.pos(x + (widget.x - left) * scale, y + (widget.y - top) * scale);
        }
    }

    onDisable(): void {
        for (const opening of this.openings) opening.isBlocked = null;
        this.openings.length = 0;
        this.interactHeld = false;
        this.awaitingControls = false;
        this.player.off(PlayerController.CONTROL_ACQUIRED, this, this.onControlsAcquired);
        this.player.off(PlayerController.CONTROL_LOST, this, this.onControlsLost);
        window.removeEventListener("blur", this.onControlsLost);
        document.removeEventListener("visibilitychange", this.onVisibilityChanged);
        window.removeEventListener("keydown", this.onEscape, true);
        Laya.Browser.mainCanvas.source.removeEventListener("blur", this.onControlsLost);
        this.continueButton?.offAllCaller(this);
        this.player.off(PlayerHealth.DIED, this, this.onPlayerDied);
        this.player.off(PlayerController.RESPAWNED, this, this.onPlayerRespawned);
        this.player.off(RifleController.FIRED,this,this.onPlayerGunfire);
        for (const bot of this.allBots()) bot.owner?.off(EnemyAI.FIRED,this,this.onBotGunfire);
        this.spawnProbe?.destroy();
        this.pendingCall=null;
        for (const enemy of this.targets) {
            enemy.owner?.off(EnemyAI.DIED, this, this.onEnemyDied);
        }
        this.restartButton.offAllCaller(this);
        Laya.stage.offAllCaller(this);
        if (LevelController.physicsHolders.delete(this) && LevelController.physicsHolders.size === 0)
            Laya.Stat.enablePhysicsUpdate = LevelController.savedPhysicsUpdate;
        if (this.world && !this.world.destroyed) this.world.timer = this.previousTimer;
        this.clock?.destroy();
    }
}
