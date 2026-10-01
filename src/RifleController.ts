import { PlayerController } from "./PlayerController";
import { EnemyAI } from "./EnemyAI";
import { GameClock } from "./GameClock";
import { KnifeView } from "./KnifeView";

const { regClass, property } = Laya;

/** 汉阳造单发步枪与短刀；动作使用关卡时钟，切换不能跳过攻击冷却。 */
@regClass()
export class RifleController extends Laya.Script {
    static readonly FIRED = "rifle-fired";
    static readonly RELOAD_STARTED = "rifle-reload-started";
    static readonly RELOAD_ENDED = "rifle-reload-ended";
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
    @property({ type: Number, caption: "换弹时间（秒）" })
    reloadSeconds = 3.3;
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
    private reloadEndAt = 0;
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

    get currentWeapon(): "rifle" | "knife" { return this.weaponMode; }
    get isReloading(): boolean { return this.reloading; }
    get aimBlend(): number { return this.aimProgress; }
    get knifeModel(): Laya.Sprite3D { return this.knife?.root; }
    /** Read-only animation timing; damage and cooldowns remain owned by this controller. */
    get meleeProgress(): number { return ((this.clock?.now() ?? performance.now()) - this.swingStartAt) / this.swingDuration; }
    get meleeDurationSeconds(): number { return this.swingDuration / 1000; }
    get meleeViewState(): "ViewKnifeLight" | "ViewKnifeHeavy" | null {
        return this.weaponMode === "knife" && this.meleeProgress >= 0 && this.meleeProgress < 1
            ? this.heavySwing ? "ViewKnifeHeavy" : "ViewKnifeLight" : null;
    }
    get reloadProgress(): number {
        return this.reloading ? 1 - (this.reloadEndAt - (this.clock?.now() ?? performance.now()))
            / (this.reloadSeconds * 1000) : 0;
    }

    private get swingDuration(): number { return this.heavySwing ? 620 : 320; }

    onAwake(): void {
        this.playerControl = (this.owner as Laya.Sprite3D).getComponent(PlayerController);
        this.canvas = Laya.Browser.mainCanvas.source;
        this.magazine = this.magazineSize;
        this.reserve = this.startingReserve;
        this.viewCamera.fieldOfView = 60;
        this.knife = new KnifeView(this.rifleModel.parent as Laya.Sprite3D);
        this.knife.setPose(0);
        this.updateHud((this.clock?.now() ?? performance.now()));
    }

    onEnable(): void {
        this.canvas.addEventListener("mousedown", this.handleMouseDown);
        window.addEventListener("mouseup", this.handleMouseUp);
        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.handleKeyDown);
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
        this.startReload((this.clock?.now() ?? performance.now()));
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
        if (this.reloading && now >= this.reloadEndAt) this.finishReload(now);
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
        this.reloading = true;
        this.reloadEndAt = now + this.reloadSeconds * 1000;
        this.owner.event(RifleController.RELOAD_STARTED);
    }

    private finishReload(now: number): void {
        if (!this.reloading || this.weaponMode !== "rifle") return;
        const count = Math.min(this.magazineSize - this.magazine, this.reserve);
        this.magazine += count;
        this.reserve -= count;
        this.cancelReload();
        this.nextShotAt = Math.max(this.nextShotAt, now);
    }

    private cancelReload(): void {
        if (!this.reloading) return;
        this.reloading = false;
        this.reloadEndAt = 0;
        this.owner.event(RifleController.RELOAD_ENDED);
    }

    private updateViewModel(dt: number): void {
        const aiming = this.weaponMode === "rifle" && this.aimHeld && !this.reloading
            && this.playerControl.isGameplayFocused();
        const blend = 1 - Math.exp(-15 * dt);
        this.aimProgress += (Number(aiming) - this.aimProgress) * blend;
        this.playerControl.setAimProgress(this.aimProgress);
        this.kickBack = Math.max(0, this.kickBack - dt * this.recoilReturnSpeed);
        this.modelTarget.setValue(0.34, -0.32, -0.72 + this.kickBack);
        Laya.Vector3.lerp(this.rifleModel.transform.localPosition, this.modelTarget, blend, this.modelPosition);
        this.rifleModel.transform.localPosition = this.modelPosition;
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
                const action = this.reloading ? `装填中 ${Math.max(0, (this.reloadEndAt - now) / 1000).toFixed(1)}s`
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
