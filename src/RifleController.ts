import { PlayerController } from "./PlayerController";
import { EnemyAI } from "./EnemyAI";
import { GameClock } from "./GameClock";
import { KnifeView } from "./KnifeView";
import { BOLT_CYCLE_MS, BOLT_MECHANISM, BOLT_MOTION, motionValue } from "./WeaponMotion";

const { regClass, property } = Laya;

/** 汉阳造单发步枪与短刀；动作使用关卡时钟，切换不能跳过攻击冷却。 */
@regClass()
export class RifleController extends Laya.Script {
    static readonly FIRED = "rifle-fired";
    static readonly CASE_EJECTED = "rifle-case-ejected";
    static readonly RELOAD_STARTED = "rifle-reload-started";
    static readonly RELOAD_ENDED = "rifle-reload-ended";
    static readonly RELOAD_STAGE_CHANGED = "rifle-reload-stage";
    static readonly ROUND_INSERTED = "rifle-round-inserted";
    static readonly MELEE_SWUNG = "melee-swung";
    static readonly MELEE_HEAVY_SWUNG = "melee-heavy-swung";
    clock: GameClock;

    @property({ type: Laya.Camera })
    viewCamera: Laya.Camera;
    @property({ type: Laya.Sprite3D })
    rifleModel: Laya.Sprite3D;
    @property({ type: Laya.GTextField })
    ammoText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    crosshairText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    hitText: Laya.GTextField;

    @property({ type: Number, caption: "弹仓容量" })
    magazineSize = 5;
    @property({ type: Number, caption: "初始备弹" })
    startingReserve = 45;
    @property({ type: Number, caption: "射速（发/分钟）" })
    roundsPerMinute = 45;
    @property({ type: Number, caption: "装填准备时间（秒）" })
    reloadPrepareSeconds = 0.7;
    @property({ type: Number, caption: "每发装填时间（秒）" })
    reloadRoundSeconds = 0.65;
    @property({ type: Number, caption: "装填收尾时间（秒）" })
    reloadFinishSeconds = 0.45;
    @property({ type: Number, caption: "基础伤害" })
    baseDamage = 70;
    @property({ type: Number, caption: "腰射镜头上抬（度）" })
    hipRecoil = 1.35;
    @property({ type: Number, caption: "开镜镜头上抬（度）" })
    aimRecoil = 1.8;
    @property({ type: Number, caption: "腰射准星上抬（度）" })
    hipCrosshairRecoil = 0.45;
    @property({ type: Number, caption: "水平后坐（度）" })
    horizontalRecoil = 0.12;
    @property({ type: Number, caption: "枪身后移（米）" })
    recoilDistance = 0.10;
    @property({ type: Number, caption: "枪身回位速度（米/秒）" })
    recoilReturnSpeed = 0.32;
    @property({ type: Number, caption: "短刀基础伤害" })
    knifeDamage = 45;
    @property({ type: Number, caption: "短刀重击基础伤害" })
    heavyKnifeDamage = 90;

    private magazine = 5;
    private reserve = 45;
    private triggerHeld = false;
    private heavyHeld = false;
    private aimHeld = false;
    private reloading = false;
    private reloadStage: "idle" | "prepare" | "insert" | "finish" = "idle";
    private reloadStageStart = 0;
    private reloadStageEnd = 0;
    private reloadDurations = { prepare: 700, insert: 650, finish: 450 };
    private reloadStopRequested = false;
    private reloadSequence = 0;
    private reloadKeyHeld = false;
    private nextShotAt = 0;
    private shotCount = 0;
    private lastShotAt = 0;
    private hitMessage = "";
    private hitMessageEndAt = 0;
    private hitWasKill = false;
    private canvas: HTMLCanvasElement;
    private playerControl: PlayerController;
    private readonly ray = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 0, -1));
    private readonly aimPoint = new Laya.Vector2();
    private readonly hit = new Laya.HitResult();
    private readonly modelTarget = new Laya.Vector3();
    private readonly modelPosition = new Laya.Vector3();
    private readonly rifleHome = new Laya.Vector3(0.20, -0.32, -0.50);
    private kickBack = 0;
    private aimProgress = 0;
    private ballisticRise = 0;
    private weaponMode: "rifle" | "knife" = "rifle";
    private knife: KnifeView;
    private attackReadyAt = 0;
    private swingStartAt = -1000;
    private swingHitAt = 0;
    private pendingMeleeHit = false;
    private heavySwing = false;
    private bolt: Laya.Sprite3D;
    private boltHome: Laya.Vector3;
    private boltHomeRotation: Laya.Vector3;
    private readonly boltPosition = new Laya.Vector3();
    private readonly boltRotation = new Laya.Vector3();
    private readonly weaponRotation = new Laya.Vector3();
    private boltLift = 0;
    private boltPull = 0;
    private reloadInitialLift = 0;
    private reloadInitialPull = 0;
    private spentCasePending = false;

    get currentWeapon(): "rifle" | "knife" { return this.weaponMode; }
    get isReloading(): boolean { return this.reloading; }
    get reloadPhase(): "idle" | "prepare" | "insert" | "finish" { return this.reloadStage; }
    get reloadStep(): number { return this.reloadSequence; }
    get reloadStageSeconds(): number {
        return Math.max(0.001, (this.reloadStageEnd - this.reloadStageStart) / 1000);
    }
    get reloadStageProgress(): number {
        if (!this.reloading) return 0;
        return Math.max(0, Math.min(1, ((this.clock?.now() ?? performance.now()) - this.reloadStageStart)
            / Math.max(1, this.reloadStageEnd - this.reloadStageStart)));
    }
    get hasRoundToChamber(): boolean { return this.magazine > 0; }
    get reloadRoundCount(): number {
        return this.reloading ? Math.max(0, Math.min(this.magazineSize - this.magazine, this.reserve)) : 0;
    }
    get aimBlend(): number { return this.aimProgress; }
    get boltCycleProgress(): number {
        if (!this.shotCount || this.reloading || this.weaponMode !== "rifle") return -1;
        const progress = ((this.clock?.now() ?? performance.now()) - this.lastShotAt) / BOLT_CYCLE_MS;
        return progress >= 0 && progress < 1 ? progress : -1;
    }
    get knifeModel(): Laya.Sprite3D { return this.knife?.root; }
    /** Read-only animation timing; damage and cooldowns remain owned by this controller. */
    get meleeProgress(): number { return ((this.clock?.now() ?? performance.now()) - this.swingStartAt) / this.swingDuration; }
    get meleeDurationSeconds(): number { return this.swingDuration / 1000; }
    get meleeViewState(): "ViewKnifeLight" | "ViewKnifeHeavy" | null {
        return this.weaponMode === "knife" && this.meleeProgress >= 0 && this.meleeProgress < 1
            ? this.heavySwing ? "ViewKnifeHeavy" : "ViewKnifeLight" : null;
    }
    get reloadProgress(): number {
        // Map the logical phases onto the existing, collision-checked bolt/hand motion.
        const t = this.reloadStageProgress;
        return this.reloadStage === "prepare" ? t * 0.34
            : this.reloadStage === "insert" ? 0.34 + t * 0.14
            : this.reloadStage === "finish" ? 0.65 + t * 0.35 : 0;
    }

    private get swingDuration(): number { return this.heavySwing ? 620 : 320; }

    onAwake(): void {
        this.playerControl = (this.owner as Laya.Sprite3D).getComponent(PlayerController);
        this.canvas = Laya.Browser.mainCanvas.source;
        this.magazine = this.magazineSize;
        this.reserve = this.startingReserve;
        this.viewCamera.fieldOfView = 60;
        // Start in the same reachable pose used by the update loop. Do not blend
        // from the old scene-authored camera offset on the first gameplay frames.
        this.rifleModel.transform.localPosition = this.rifleHome;
        this.knife = new KnifeView(this.rifleModel.parent as Laya.Sprite3D);
        this.knife.setPose(0);
        this.bolt = this.findVisual(this.rifleModel, "Bolt");
        if (this.bolt) {
            this.boltHome = this.bolt.transform.localPosition.clone();
            this.boltHomeRotation = this.bolt.transform.localRotationEuler.clone();
        }
        this.updateHud((this.clock?.now() ?? performance.now()));
    }

    private findVisual(node: Laya.Sprite3D, name: string): Laya.Sprite3D {
        if (node.name === name) return node;
        for (let i = 0; i < (node.numChildren || 0); i++) {
            const found = this.findVisual(node.getChildAt(i) as Laya.Sprite3D, name);
            if (found) return found;
        }
        return null;
    }

    onEnable(): void {
        this.canvas.addEventListener("mousedown", this.handleMouseDown);
        window.addEventListener("mouseup", this.handleMouseUp);
        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.handleKeyDown);
        Laya.stage.on(Laya.Event.KEY_UP, this, this.handleKeyUp);
        document.addEventListener("pointerlockchange", this.handleFocusChange);
        window.addEventListener("blur", this.stopTrigger);
        document.addEventListener("visibilitychange", this.handleFocusChange);
    }

    private readonly handleMouseDown = (event: MouseEvent) => {
        // 首次点击仅用于锁定鼠标；锁定完成后下一次按下才开火。
        if (!this.playerControl.isGameplayFocused()) return;
        if (event.button === 0) {
            if (this.triggerHeld) return;
            this.triggerHeld = true;
            const now = this.clock?.now() ?? performance.now();
            // 两种武器都只接受按下沿；冷却期间的点击不排队，长按不连发。
            if (this.weaponMode === "knife") this.trySwing(now, false);
            else this.tryFire(now);
        } else if (event.button === 2 && this.weaponMode === "knife") {
            if (this.heavyHeld) return;
            this.heavyHeld = true;
            this.trySwing(this.clock?.now() ?? performance.now(), true);
        } else if (event.button === 2 && this.weaponMode === "rifle") {
            // 从腰射切入机械瞄具时，把准星偏移转为镜头上抬，
            // 避免红点到达屏幕中心后射线仍从红点上方穿过。
            if (this.ballisticRise > 0) {
                this.playerControl.addRecoil(this.ballisticRise, 0);
                this.ballisticRise = 0;
            }
            this.aimHeld = true;
            this.playerControl.setAiming(true);
        }
    };

    private readonly handleMouseUp = (event: MouseEvent) => {
        if (event.button === 0) this.triggerHeld = false;
        if (event.button === 2) {
            this.heavyHeld = false;
            this.aimHeld = false;
            this.playerControl.setAiming(false);
        }
    };

    private readonly stopTrigger = () => {
        this.reloadKeyHeld = false;
        this.triggerHeld = false;
        this.heavyHeld = false;
        this.aimHeld = false;
        this.playerControl?.setAiming(false);
    };

    private readonly handleFocusChange = () => {
        if (!this.playerControl.isGameplayFocused()) this.stopTrigger();
    };

    /** 暂停只清输入和短暂命中提示，保留弹药、换弹期限与后坐力。 */
    clearGameplayInput(): void {
        this.stopTrigger();
        this.hitMessage = "";
        this.hitMessageEndAt = 0;
        if (this.hitText) this.hitText.text = "";
    }

    private handleKeyDown(event: Laya.Event): void {
        if (!this.playerControl.isGameplayFocused()) return;
        if (event.keyCode === 49 || event.keyCode === 51) {
            event.nativeEvent?.preventDefault();
            this.selectWeapon(event.keyCode === 49 ? "rifle" : "knife");
            return;
        }
        if (event.keyCode !== 82 || this.weaponMode !== "rifle") return;
        event.nativeEvent?.preventDefault();
        if (this.reloadKeyHeld || (event.nativeEvent as KeyboardEvent)?.repeat) return;
        this.reloadKeyHeld = true;
        const now = this.clock?.now() ?? performance.now();
        if (this.reloading) {
            if (this.reloadStage !== "finish") this.reloadStopRequested = true;
            this.advanceReload(now);
        } else this.startReload(now);
        this.updateHud(now);
    }

    private handleKeyUp(event: Laya.Event): void {
        if (event.keyCode === 82) this.reloadKeyHeld = false;
    }

    private selectWeapon(mode: "rifle" | "knife"): void {
        const now = this.clock?.now() ?? performance.now();
        if (!this.enabled || !this.playerControl.isGameplayFocused()
            || this.weaponMode === mode || now < this.attackReadyAt) return;
        this.stopTrigger();
        this.cancelReload();
        this.weaponMode = mode;
        this.rifleModel.active = mode === "rifle";
        this.knife.root.active = mode === "knife";
        this.playerControl.setWeaponPresentationScale(mode === "rifle" ? 0.90 : 0.55);
        this.aimProgress = 0;
        this.playerControl.setAimProgress(0);
        this.ballisticRise = 0;
        this.updateHud(now);
    }

    onUpdate(): void {
        if (this.clock?.paused) return;
        const now = this.clock?.now() ?? performance.now();
        const dt = Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0.05);
        if (!this.playerControl.isGameplayFocused()) this.stopTrigger();
        if (this.reloading) this.advanceReload(now);
        if (this.pendingMeleeHit && now >= this.swingHitAt) {
            this.pendingMeleeHit = false;
            // 单次命中在动作中段结算；卡顿跨过整个动作后不追补伤害。
            if (now <= this.swingStartAt + this.swingDuration
                && this.weaponMode === "knife" && this.playerControl.isGameplayFocused()) this.resolveMeleeHit(now);
        }
        // 单发后回正不依赖松开左键，按住也不会把准星一直卡在上抬位置。
        if (now - this.lastShotAt > 120) {
            this.ballisticRise = Math.max(0, this.ballisticRise - dt * 2.6);
        }
        this.updateViewModel(dt);
        if (this.weaponMode === "knife")
            this.knife.setPose((now - this.swingStartAt) / this.swingDuration, this.heavySwing);
        this.updateHud(now);
    }

    private tryFire(now: number): void {
        if (!this.enabled || this.weaponMode !== "rifle" || !this.playerControl.isGameplayFocused()
            || this.reloading || now < this.nextShotAt || now < this.attackReadyAt) return;
        if (this.magazine === 0) {
            this.startReload(now);
            return;
        }

        this.fireOneShot(now);
        this.nextShotAt = now + 60000 / Math.max(1, this.roundsPerMinute);
        this.attackReadyAt = this.nextShotAt;
        if (this.magazine === 0) this.startReload(now);
    }

    private trySwing(now: number, heavy: boolean): void {
        if (!this.enabled || this.weaponMode !== "knife" || !this.playerControl.isGameplayFocused()
            || this.reloading || now < this.attackReadyAt) return;
        this.attackReadyAt = now + (heavy ? 1300 : 700);
        this.swingStartAt = now;
        this.heavySwing = heavy;
        this.swingHitAt = now + this.swingDuration / 2;
        this.pendingMeleeHit = true;
        this.owner.event(heavy ? RifleController.MELEE_HEAVY_SWUNG : RifleController.MELEE_SWUNG);
        this.updateHud(now);
    }

    private resolveMeleeHit(now: number): void {
        this.playerControl.syncCameraForShot();
        this.aimPoint.setValue(Laya.stage.width / 2, Laya.stage.height / 2);
        this.viewCamera.viewportPointToRay(this.aimPoint, this.ray);
        const p = this.viewCamera.transform.position;
        this.ray.origin.setValue(p.x, p.y, p.z);
        const scene = (this.owner as Laya.Sprite3D).scene as Laya.Scene3D;
        if (!scene.physicsSimulation.rayCast(this.ray, this.hit, this.heavySwing ? 2.8 : 2.5,
            -1, ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER)) return;
        const hitNode = this.hit.collider.owner as Laya.Sprite3D;
        const enemyAI = this.findEnemy(hitNode);
        if (!enemyAI) return; // 只结算最近的碰撞，墙后的敌人不受伤。
        const result = enemyAI.applyHit(hitNode, this.heavySwing ? this.heavyKnifeDamage : this.knifeDamage);
        if (result.damage <= 0) return;
        this.hitMessage = `${enemyAI.owner.name} · ` + (result.killed ? "敌军击倒"
            : `${this.heavySwing ? "短刀重击" : "短刀命中"}  -${result.damage.toFixed(1)} HP · 剩余 ${result.remainingHealth.toFixed(1)} HP`);
        this.hitMessageEndAt = now + 650;
        this.hitWasKill = result.killed;
    }

    private fireOneShot(now: number): void {
        this.magazine--;
        this.shotCount++;
        this.lastShotAt = now;
        this.spentCasePending = true;
        this.owner.event(RifleController.FIRED);
        this.playerControl.syncCameraForShot();
        const p = this.viewCamera.transform.position;
        // 与画面上同一个准星坐标生成射线；开镜时准星坐标就是红点的中心。
        this.updateAimPoint();
        this.viewCamera.viewportPointToRay(this.aimPoint, this.ray);
        this.ray.origin.setValue(p.x, p.y, p.z);

        const scene = (this.owner as Laya.Sprite3D).scene as Laya.Scene3D;
        const hitSomething = scene.physicsSimulation.rayCast(this.ray, this.hit, 150, -1,
            ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER);
        if (hitSomething) {
            const hitNode = this.hit.collider.owner as Laya.Sprite3D;
            const enemyAI = this.findEnemy(hitNode);
            if (enemyAI) {
                const result = enemyAI.applyHit(hitNode, this.baseDamage);
                if (result.damage > 0) {
                    const zone = hitNode.name === "Head" ? "头部" : hitNode.name === "Legs"
                        ? "腿部" : hitNode.name.endsWith("Arm") ? "手臂" : "躯干";
                    this.hitMessage = `${enemyAI.owner.name} · ` + (result.killed ? "敌军击倒"
                        : `${zone}命中  -${result.damage.toFixed(1)} HP · 剩余 ${result.remainingHealth.toFixed(1)} HP`);
                    this.hitMessageEndAt = now + 650;
                    this.hitWasKill = result.killed;
                }
            }
        }

        if (!this.aimHeld) this.ballisticRise = Math.min(2.5, this.ballisticRise + this.hipCrosshairRecoil);
        // 腰射时镜头和准星分担上抬；开镜时红点保持中心，由镜头承担全部上抬。
        this.playerControl.addRecoil(this.aimHeld ? this.aimRecoil : this.hipRecoil,
            (this.shotCount % 2 ? 1 : -1) * this.horizontalRecoil);
        this.kickBack = Math.min(this.recoilDistance * 1.4, this.kickBack + this.recoilDistance);
    }

    /** 部位碰撞体可以在任意层级；只结算射线实际命中的敌人。 */
    private findEnemy(hitNode: Laya.Node): EnemyAI {
        for (let node = hitNode; node; node = node.parent) {
            const enemyAI = node.getComponent(EnemyAI);
            if (enemyAI) return enemyAI;
        }
        return null;
    }

    stopCombat(): void {
        this.stopTrigger();
        this.cancelReload();
        this.pendingMeleeHit = false;
        this.hitMessage = "";
        this.hitMessageEndAt = 0;
        this.hitWasKill = false;
        if (this.crosshairText) this.crosshairText.visible = false;
        if (this.hitText) this.hitText.text = "";
        this.enabled = false;
    }

    private startReload(now: number): void {
        if (!this.enabled || this.clock?.paused || this.weaponMode !== "rifle"
            || this.reloading || this.magazine >= this.magazineSize || this.reserve <= 0) return;
        this.reloadInitialLift = this.boltLift;
        this.reloadInitialPull = this.boltPull;
        this.reloading = true;
        const duration = (value: number, fallback: number) =>
            (Number.isFinite(value) ? Math.max(0.05, value) : fallback) * 1000;
        // Snapshot once, so every round in this reload has exactly the same duration.
        this.reloadDurations = {
            prepare: duration(this.reloadPrepareSeconds, 0.7),
            insert: duration(this.reloadRoundSeconds, 0.65),
            finish: duration(this.reloadFinishSeconds, 0.45)
        };
        this.reloadStopRequested = false;
        this.owner.event(RifleController.RELOAD_STARTED);
        this.enterReloadStage("prepare", now);
    }

    private enterReloadStage(stage: "prepare" | "insert" | "finish", now: number): void {
        this.reloadStage = stage;
        this.reloadStageStart = now;
        this.reloadStageEnd = now + this.reloadDurations[stage];
        ++this.reloadSequence;
        this.owner.event(RifleController.RELOAD_STAGE_CHANGED, { stage, durationMs: this.reloadDurations[stage] });
    }

    private advanceReload(now: number): void {
        if (!this.reloading || this.clock?.paused || !this.enabled || now < this.reloadStageEnd) return;
        // At most one completed round per rendered update. A stall cannot dump several
        // rounds into the HUD at once or skip all of the remaining visible reload.
        if (this.reloadStage === "prepare") {
            this.enterReloadStage(this.reloadRoundCount > 0 ? "insert" : "finish", now);
        } else if (this.reloadStage === "insert") {
            if (this.magazine < this.magazineSize && this.reserve > 0) {
                ++this.magazine;
                --this.reserve;
                this.owner.event(RifleController.ROUND_INSERTED);
            }
            this.enterReloadStage(this.reloadStopRequested || this.reloadRoundCount === 0 ? "finish" : "insert", now);
        } else if (this.reloadStage === "finish") {
            this.cancelReload();
            this.nextShotAt = Math.max(this.nextShotAt, now);
        }
    }

    private cancelReload(): void {
        if (!this.reloading) return;
        this.reloading = false;
        this.reloadStage = "idle";
        this.reloadStageStart = this.reloadStageEnd = 0;
        this.reloadStopRequested = false;
        this.owner.event(RifleController.RELOAD_ENDED);
    }

    private updateViewModel(dt: number): void {
        const aiming = this.weaponMode === "rifle" && this.aimHeld && !this.reloading
            && this.playerControl.isGameplayFocused();
        const blend = 1 - Math.exp(-15 * dt);
        this.aimProgress += (Number(aiming) - this.aimProgress) * blend;
        this.playerControl.setAimProgress(this.aimProgress);
        this.kickBack = Math.max(0, this.kickBack - dt * this.recoilReturnSpeed);
        const phase = this.reloading ? this.reloadProgress : this.boltCycleProgress;
        const keys = this.reloading ? BOLT_MOTION.reload : BOLT_MOTION.shot;
        let lift = phase >= 0 ? motionValue(keys, phase, 1) : 0;
        let pull = phase >= 0 ? motionValue(keys, phase, 2) : 0;
        if (this.reloading && phase < 0.22) {
            lift = this.reloadInitialLift + (1 - this.reloadInitialLift) * lift;
            pull = this.reloadInitialPull + (1 - this.reloadInitialPull) * pull;
        }
        this.boltLift = lift;
        this.boltPull = pull;
        const tilt = (phase >= 0 ? motionValue(keys, phase, 3) : 0)
            * (this.reloading ? 1 : 0.65 * (1 - this.aimProgress));
        if (this.bolt) {
            this.boltPosition.setValue(this.boltHome.x, this.boltHome.y, this.boltHome.z + pull * BOLT_MECHANISM.travel);
            this.boltRotation.setValue(this.boltHomeRotation.x, this.boltHomeRotation.y,
                this.boltHomeRotation.z + lift * BOLT_MECHANISM.liftDegrees);
            this.bolt.transform.localPosition = this.boltPosition;
            this.bolt.transform.localRotationEuler = this.boltRotation;
        }
        const now = (this.clock?.now() ?? performance.now()) / 1000;
        const moving = Math.min(1, (this.playerControl.movementSpeed || 0) / 5)
            * (1 - this.aimProgress) ** 2 * (phase < 0 ? 1 : 0);
        const bobX = Math.sin(now * 10) * 0.004 * moving;
        const bobY = Math.cos(now * 20) * 0.006 * moving;
        const raiseTuck = Math.max(0, this.viewCamera.transform.rotationEuler.x - 35) * 0.002;
        // Bring the stock into the shoulder rather than stretching the character
        // to an arm's-length camera prop. At ADS, the red dot's +0.18 Y offset
        // cancels this -0.18 Y and X matches PlayerController's sight offset.
        // Bring the operating hand into view for hip-fire/reload. ADS shooting
        // has zero tilt and keeps the sight's original camera alignment.
        this.modelTarget.setValue(this.rifleHome.x - 0.02 * this.aimProgress - tilt * 0.20 + bobX,
            this.rifleHome.y + 0.14 * this.aimProgress + tilt * 0.12 + bobY,
            this.rifleHome.z + raiseTuck + this.kickBack + tilt * 0.045);
        Laya.Vector3.lerp(this.rifleModel.transform.localPosition, this.modelTarget, blend, this.modelPosition);
        this.rifleModel.transform.localPosition = this.modelPosition;
        this.weaponRotation.setValue(-7 * tilt, 8 * tilt, -18 * tilt);
        this.rifleModel.transform.localRotationEuler = this.weaponRotation;
        // The last shot enters reload preparation immediately, so follow actual
        // bolt travel rather than the standalone shot animation's progress.
        if (this.spentCasePending) {
            if (this.enabled && this.weaponMode === "rifle" && pull >= 0.65) {
                this.spentCasePending = false;
                this.owner.event(RifleController.CASE_EJECTED);
            } else if (this.weaponMode !== "rifle" || phase < 0) {
                this.spentCasePending = false; // Never replay an old ejection after a stall/switch.
            }
        }
    }

    private updateAimPoint(): void {
        const focalLength = Laya.stage.height
            / (2 * Math.tan(this.viewCamera.fieldOfView * Math.PI / 360));
        this.aimPoint.setValue(Laya.stage.width / 2,
            Laya.stage.height / 2 - focalLength * Math.tan(this.ballisticRise * Math.PI / 180));
    }

    private updateHud(now: number): void {
        if (this.ammoText) {
            if (this.weaponMode === "knife") {
                const recovery = now < this.attackReadyAt
                    ? `收招中 ${((this.attackReadyAt - now) / 1000).toFixed(1)}s` : "左键轻击 · 右键重击";
                this.ammoText.text = `短刀  ·  ${recovery}  ·  1 切回汉阳造`;
            } else {
                const reloadLabel = this.reloadStage === "prepare" ? "装填准备"
                    : this.reloadStage === "finish" ? "装填收尾" : "逐发装填";
                const action = this.reloading ? `${reloadLabel} ${Math.max(0, (this.reloadStageEnd - now) / 1000).toFixed(1)}s`
                    + (this.reloadStage === "finish" ? "" : this.reloadStopRequested ? " · 本发完成后结束" : " · 再按 R 提前收尾")
                    : now < this.nextShotAt ? `拉栓中 ${((this.nextShotAt - now) / 1000).toFixed(1)}s`
                    : this.magazine === 0 && this.reserve === 0 ? "弹药耗尽" : "单发 · R 装填";
                this.ammoText.text = `汉阳造  ${this.magazine} / ${this.reserve}   ·   ${action} · 3 切刀`;
            }
        }
        if (this.crosshairText) {
            this.updateAimPoint();
            this.crosshairText.x = (Laya.stage.width - this.crosshairText.width) / 2;
            this.crosshairText.y = this.aimPoint.y - this.crosshairText.height / 2;
            const hitActive = now < this.hitMessageEndAt;
            // 命中标记独立于普通准星的开镜隐藏；只复用真实伤害结果。
            this.crosshairText.text = hitActive ? this.hitWasKill ? "✦" : "×"
                : this.aimProgress > 0.995 ? "" : "+";
            this.crosshairText.color = hitActive
                ? this.hitWasKill ? "#ffd166" : "#ff6a4d" : "#ffffff";
        }
        if (this.hitText) this.hitText.text = now < this.hitMessageEndAt ? this.hitMessage : "";
    }

    onDisable(): void {
        this.spentCasePending = false;
        this.stopTrigger();
        this.cancelReload();
        this.pendingMeleeHit = false;
        this.canvas.removeEventListener("mousedown", this.handleMouseDown);
        window.removeEventListener("mouseup", this.handleMouseUp);
        Laya.stage.offAllCaller(this);
        document.removeEventListener("pointerlockchange", this.handleFocusChange);
        window.removeEventListener("blur", this.stopTrigger);
        document.removeEventListener("visibilitychange", this.handleFocusChange);
    }

    onDestroy(): void {
        this.knife?.destroy();
    }
}
