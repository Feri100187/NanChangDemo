import { PlayerController } from "./PlayerController";
import { EnemyAI } from "./EnemyAI";

const { regClass, property } = Laya;

/** 第一人称射线步枪。弹药是弹匣内子弹数与独立备弹数。 */
@regClass()
export class RifleController extends Laya.Script {
    @property({ type: Laya.Camera })
    viewCamera: Laya.Camera;
    @property({ type: Laya.Sprite3D })
    rifleModel: Laya.Sprite3D;
    @property({ type: Laya.Sprite3D })
    enemy: Laya.Sprite3D;
    @property({ type: Laya.GTextField })
    ammoText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    crosshairText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    enemyText: Laya.GTextField;

    @property({ type: Number, caption: "弹匣容量" })
    magazineSize = 40;
    @property({ type: Number, caption: "初始备弹" })
    startingReserve = 99999;
    @property({ type: Number, caption: "射速（发/分钟）" })
    roundsPerMinute = 700;
    @property({ type: Number, caption: "换弹时间（秒）" })
    reloadSeconds = 2.2;
    @property({ type: Number, caption: "基础伤害" })
    baseDamage = 28;

    private magazine = 40;
    private reserve = 99999;
    private triggerHeld = false;
    private aimHeld = false;
    private reloading = false;
    private reloadEndAt = 0;
    private nextShotAt = 0;
    private shotCount = 0;
    private lastShotAt = 0;
    private hitMessage = "";
    private hitMessageEndAt = 0;
    private canvas: HTMLCanvasElement;
    private playerControl: PlayerController;
    private enemyAI: EnemyAI;
    private readonly ray = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 0, -1));
    private readonly aimPoint = new Laya.Vector2();
    private readonly hit = new Laya.HitResult();
    private readonly modelTarget = new Laya.Vector3();
    private readonly modelPosition = new Laya.Vector3();
    private kickBack = 0;
    private aimProgress = 0;
    private ballisticRise = 0;

    onAwake(): void {
        this.playerControl = (this.owner as Laya.Sprite3D).getComponent(PlayerController);
        this.enemyAI = this.enemy.getComponent(EnemyAI);
        this.canvas = Laya.Browser.mainCanvas.source;
        this.magazine = this.magazineSize;
        this.reserve = this.startingReserve;
        this.viewCamera.fieldOfView = 60;
        this.updateHud(performance.now());
    }

    onEnable(): void {
        this.canvas.addEventListener("mousedown", this.handleMouseDown);
        window.addEventListener("mouseup", this.handleMouseUp);
        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.handleKeyDown);
        document.addEventListener("pointerlockchange", this.handleFocusChange);
        window.addEventListener("blur", this.stopTrigger);
    }

    private readonly handleMouseDown = (event: MouseEvent) => {
        // 首次点击仅用于锁定鼠标；锁定完成后下一次按下才开火。
        if (!this.playerControl.isGameplayFocused()) return;
        if (event.button === 0) {
            this.triggerHeld = true;
            const now = performance.now();
            const interval = 60000 / this.roundsPerMinute;
            if (this.nextShotAt < now - interval) this.nextShotAt = now;
            this.fireDueShots(now);
        } else if (event.button === 2) {
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
            this.aimHeld = false;
            this.playerControl.setAiming(false);
        }
    };

    private readonly stopTrigger = () => {
        this.triggerHeld = false;
        this.aimHeld = false;
        this.playerControl?.setAiming(false);
    };

    private readonly handleFocusChange = () => {
        if (!this.playerControl.isGameplayFocused()) this.stopTrigger();
    };

    private handleKeyDown(event: Laya.Event): void {
        if (event.keyCode !== 82 || !this.playerControl.isGameplayFocused()) return;
        event.nativeEvent?.preventDefault();
        this.startReload(performance.now());
    }

    onUpdate(): void {
        const now = performance.now();
        const dt = Math.min(Laya.timer.delta / 1000, 0.05);
        if (!this.playerControl.isGameplayFocused()) this.stopTrigger();
        if (this.reloading && now >= this.reloadEndAt) this.finishReload(now);
        if (this.triggerHeld) this.fireDueShots(now);
        // 连射时弹道持续爬升；松手或换弹时逐渐恢复。
        if ((!this.triggerHeld || this.reloading) && now - this.lastShotAt > 120) {
            this.ballisticRise = Math.max(0, this.ballisticRise - dt * 2.6);
        }
        this.updateViewModel(dt);
        this.updateHud(now);
    }

    private fireDueShots(now: number): void {
        if (this.reloading) return;
        if (this.magazine === 0) {
            this.startReload(now);
            return;
        }

        // 以真实时间计算射速，避免 60 FPS 的帧取整把 700 RPM 降为 600 RPM。
        const interval = 60000 / this.roundsPerMinute;
        let shots = 0;
        while (this.triggerHeld && !this.reloading && this.magazine > 0
            && now >= this.nextShotAt && shots < 4) {
            this.fireOneShot(now);
            this.nextShotAt += interval;
            shots++;
        }
        if (this.magazine === 0) this.startReload(now);
    }

    private fireOneShot(now: number): void {
        this.magazine--;
        this.shotCount++;
        this.lastShotAt = now;
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
            if (hitNode && this.enemy.isAncestorOf(hitNode)) {
                const result = this.enemyAI.applyHit(hitNode, this.baseDamage);
                if (result.damage > 0) {
                    const zone = hitNode.name === "Head" ? "头部" : hitNode.name === "Legs"
                        ? "腿部" : hitNode.name.endsWith("Arm") ? "手臂" : "躯干";
                    this.hitMessage = result.killed ? `敌军击倒  +${result.damage.toFixed(0)}`
                        : `${zone}命中  -${result.damage.toFixed(0)} HP`;
                    this.hitMessageEndAt = now + 650;
                }
            }
        }

        if (!this.aimHeld) this.ballisticRise = Math.min(2.5, this.ballisticRise + 0.18);
        // 腰射时镜头和准星分担上抬；开镜时红点保持中心，由镜头承担全部上抬。
        this.playerControl.addRecoil(this.aimHeld ? 0.28 : 0.22, 0);
        this.kickBack = Math.min(0.12, this.kickBack + 0.065);
    }

    private startReload(now: number): void {
        if (this.reloading || this.magazine >= this.magazineSize || this.reserve <= 0) return;
        this.reloading = true;
        this.reloadEndAt = now + this.reloadSeconds * 1000;
    }

    private finishReload(now: number): void {
        const count = Math.min(this.magazineSize - this.magazine, this.reserve);
        this.magazine += count;
        this.reserve -= count;
        this.reloading = false;
        this.nextShotAt = now;
    }

    private updateViewModel(dt: number): void {
        const aiming = this.aimHeld && !this.reloading && this.playerControl.isGameplayFocused();
        const blend = 1 - Math.exp(-15 * dt);
        this.aimProgress += (Number(aiming) - this.aimProgress) * blend;
        this.playerControl.setAimProgress(this.aimProgress);
        this.kickBack = Math.max(0, this.kickBack - dt * 0.48);
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
            const action = this.reloading ? `换弹中 ${Math.max(0, (this.reloadEndAt - now) / 1000).toFixed(1)}s`
                : "R 换弹";
            this.ammoText.text = `步枪  ${this.magazine} / ${this.reserve}   ·   ${action}`;
        }
        if (this.crosshairText) {
            this.updateAimPoint();
            this.crosshairText.x = (Laya.stage.width - this.crosshairText.width) / 2;
            this.crosshairText.y = this.aimPoint.y - this.crosshairText.height / 2;
            this.crosshairText.text = this.aimProgress > 0.995 ? ""
                : now < this.hitMessageEndAt ? "×" : "+";
            this.crosshairText.color = now < this.hitMessageEndAt ? "#ff6a4d" : "#ffffff";
        }
        if (this.enemyText && this.enemyAI) {
            const status = this.enemyAI.isAlive
                ? `敌军  ${this.enemyAI.health.toFixed(0)} / ${this.enemyAI.maxHealth} HP  ·  ${this.enemyAI.state}`
                : "敌军已死亡";
            this.enemyText.text = now < this.hitMessageEndAt
                ? `${status}   |   ${this.hitMessage}` : status;
        }
    }

    onDisable(): void {
        this.stopTrigger();
        this.canvas.removeEventListener("mousedown", this.handleMouseDown);
        window.removeEventListener("mouseup", this.handleMouseUp);
        Laya.stage.offAllCaller(this);
        document.removeEventListener("pointerlockchange", this.handleFocusChange);
        window.removeEventListener("blur", this.stopTrigger);
    }
}
