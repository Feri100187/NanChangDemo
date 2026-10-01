import { PlayerHealth } from "./PlayerHealth";
import { GameClock } from "./GameClock";
import { WeaponPresentation } from "./WeaponPresentation";

const { regClass, property } = Laya;

/** 胶囊碰撞体与可见身体分离的第一人称控制。 */
@regClass()
export class PlayerController extends Laya.Script {
    static readonly RESPAWNED = "player-respawned";
    static readonly CONTROL_ACQUIRED = "player-control-acquired";
    static readonly CONTROL_LOST = "player-control-lost";
    clock: GameClock;

    @property({ type: Number, caption: "行走速度" })
    walkSpeed = 5;
    @property({ type: Number, caption: "疾跑速度" })
    sprintSpeed = 9;
    @property({ type: Number, caption: "下蹲速度" })
    crouchSpeed = 2;
    @property({ type: Number, caption: "开镜移动速度" })
    aimWalkSpeed = 1.5;
    @property({ type: Number, caption: "起跳速度" })
    jumpSpeed = 7;
    @property({ type: Number, caption: "鼠标灵敏度（度/像素）" })
    mouseSensitivity = 0.18;
    @property({ type: Laya.Sprite3D })
    body: Laya.Sprite3D;
    @property({ type: Laya.Camera })
    followCamera: Laya.Camera;
    @property({ type: Laya.Sprite3D })
    weaponPivot: Laya.Sprite3D;
    @property({ type: Laya.GTextField })
    statusText: Laya.GTextField;
    @property({ type: Laya.Sprite3D, caption: "本关出生点（可选）" })
    spawnPoint: Laya.Sprite3D;

    private readonly standingHeight = 2;
    private readonly crouchingHeight = 1.2;
    private readonly radius = 0.45;
    private readonly keys = new Set<number>();
    private readonly movement = new Laya.Vector3();
    private readonly cameraPosition = new Laya.Vector3();
    private readonly viewPosition = new Laya.Vector3();
    // 机械瞄准线相对角色眼位的水平/垂直偏移，开镜时将相机移到此处。
    private readonly sightOffset = new Laya.Vector3(0.18, 0, 0);
    private readonly sightOffsetWorld = new Laya.Vector3();
    private readonly cameraRotation = new Laya.Vector3();
    private readonly jumpVelocity = new Laya.Vector3();
    private readonly headRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 1, 0));
    private readonly headHit = new Laya.HitResult();
    private player: Laya.Sprite3D;
    private spawnPosition: Laya.Vector3;
    private spawnYaw = 0;
    private playerHealth: PlayerHealth;
    private controller: Laya.CharacterController;
    private weaponPresentation: WeaponPresentation;
    private originalNearPlane = 0.1;
    get viewModelScale(): number { return this.weaponPresentation?.scale ?? 1; }
    private standingVisual: Laya.Sprite3D;
    private crouchingVisual: Laya.Sprite3D;
    private animatedVisual: Laya.Sprite3D;
    get isCrouching(): boolean { return this.crouching; }
    get isGrounded(): boolean { return this.controller?.isOnGround() ?? false; }
    get isAimActive(): boolean { return this.isAiming; }
    get movementSpeed(): number { return this.currentSpeed; }
    private readonly bodyPosition = new Laya.Vector3();
    private readonly bodyRotation = new Laya.Vector3();
    private readonly bodyGroundRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, -1, 0));
    private readonly bodyGroundHit = new Laya.HitResult();
    private crouching = false;
    private jumpRequested = false;
    private currentSpeed = 0;
    private hudElapsed = 0;
    private yaw = 0;
    private pitch = 0;
    private recoilPitch = 0;
    private recoilYaw = 0;
    private lastRecoilAt = 0;
    private aimProgress = 0;
    private isAiming = false;
    private canvas: HTMLCanvasElement;
    private ignoreNextMouseMove = false;
    private mouseLockError = false;
    private mouseFocusClickArmed = false;
    private menuFocus = false;
    private acquiringFocus = false;
    private focusRequest = 0;

    private readonly clearInput = () => {
        this.keys.clear();
        this.jumpRequested = false;
        this.mouseFocusClickArmed = false;
        this.movement.setValue(0, 0, 0);
        if (this.controller?.enabled) this.controller.move(this.movement);
    };

    private readonly visibilityChanged = () => {
        if (document.hidden) this.clearInput();
    };

    private readonly requestMouseFocus = () => {
        // 新场景必须收到自己的一次按下，避免“重新开始”的尾随 click 直接锁鼠标。
        if (this.menuFocus || !this.enabled || !this.mouseFocusClickArmed
            || (this.playerHealth && !this.playerHealth.isAlive)) return;
        this.mouseFocusClickArmed = false;
        this.requestGameplayFocus();
    };

    /** 菜单在真实点击回调中调用；成功取得原生锁定或 IDE 窗口内控制才通知关卡。 */
    requestGameplayFocus(): void {
        if (!this.enabled || this.destroyed || document.hidden || !document.hasFocus()) return;
        const requestId = ++this.focusRequest;
        this.acquiringFocus = true;
        this.mouseLockError = false;
        this.canvas.focus();
        if (document.pointerLockElement === this.canvas) {
            this.acceptMouseFocus();
            return;
        }
        // Pointer Lock 要在真实点击事件里请求，浏览器才会允许持续接收相对鼠标位移。
        try {
            const request = this.canvas.requestPointerLock();
            if (request && typeof request.catch === "function") request.catch(() => {
                if (requestId === this.focusRequest) this.pointerLockFailed();
            });
        } catch (_) {
            this.pointerLockFailed();
        }
    }

    useMenuFocus(): void { this.menuFocus = true; }

    releaseGameplayFocus(): void {
        ++this.focusRequest;
        this.acquiringFocus = false;
        this.mouseLockError = false;
        this.clearInput();
        this.currentSpeed = 0;
        if (document.pointerLockElement === this.canvas) document.exitPointerLock();
        // Scene2D 的关卡 onAwake 早于 3D 玩家 onAwake，初次等待开始时画布尚未绑定。
        this.canvas?.blur();
    }

    private acceptMouseFocus(): void {
        if (!this.acquiringFocus || document.hidden || !document.hasFocus() || !this.hasMouseFocus) return;
        this.acquiringFocus = false;
        this.ignoreNextMouseMove = true;
        this.owner.event(PlayerController.CONTROL_ACQUIRED);
        this.showMousePrompt();
    }

    private readonly pointerLockChanged = () => {
        if (document.pointerLockElement === this.canvas) {
            if (this.menuFocus && !this.acquiringFocus && this.clock?.paused) {
                document.exitPointerLock(); // 已取消的异步锁定不能穿过暂停或结算菜单。
                return;
            }
            this.acceptMouseFocus();
            this.ignoreNextMouseMove = true;
        } else {
            this.clearInput();
            if (!this.acquiringFocus) this.owner.event(PlayerController.CONTROL_LOST);
        }
        this.showMousePrompt();
    };

    private readonly pointerLockFailed = () => {
        if (this.destroyed || !this.enabled || !this.acquiringFocus
            || document.hidden || !document.hasFocus() || (this.playerHealth && !this.playerHealth.isAlive)) return;
        this.mouseLockError = true;
        this.acceptMouseFocus();
        this.showMousePrompt();
    };

    private readonly handleMouseMove = (event: MouseEvent) => {
        if (!this.isGameplayFocused()) return;
        if (document.pointerLockElement !== this.canvas && event.target !== this.canvas) return;
        if (this.ignoreNextMouseMove && document.pointerLockElement === this.canvas) {
            this.ignoreNextMouseMove = false;
            return;
        }
        this.yaw = (this.yaw - event.movementX * this.mouseSensitivity) % 360;
        this.pitch = Math.max(-85, Math.min(85,
            this.pitch - event.movementY * this.mouseSensitivity));
        this.updateCameraRotation();
    };

    private readonly handleLockedPointerDown = (event: PointerEvent) => {
        // LayaAir 3.4.1 会在 canvas 的 pointerdown 中调用 setPointerCapture。
        // Pointer Lock 期间浏览器禁止这项调用；只挡住该 pointerdown，
        // 独立的 mousedown/up 事件仍会交给引擎处理。
        if (document.pointerLockElement === this.canvas) {
            event.stopImmediatePropagation();
        } else if (!this.menuFocus && event.button === 0) {
            this.mouseFocusClickArmed = true;
        }
    };

    private readonly preventContextMenu = (event: MouseEvent) => {
        if (this.hasMouseFocus) event.preventDefault();
    };

    private get hasMouseFocus(): boolean {
        return document.pointerLockElement === this.canvas
            || (this.mouseLockError && document.activeElement === this.canvas);
    }

    /** 供枪械判断是否能接收战斗输入。 */
    isGameplayFocused(): boolean {
        return this.enabled && !this.clock?.paused && !document.hidden && document.hasFocus() && this.hasMouseFocus
            && (!this.playerHealth || this.playerHealth.isAlive);
    }

    /** 结算时停止控制与角色物理，onDisable 负责清输入、解绑并释放鼠标。 */
    stopGameplay(): void {
        this.currentSpeed = 0;
        this.isAiming = false;
        this.enabled = false;
        this.controller.enabled = false;
    }

    /** 鼠标事件和物理帧之间也能从角色当前眼位正确发射射线。 */
    syncCameraForShot(): void {
        this.updateCamera();
    }

    /** 0 为腰射视点，1 为沿机械瞄准线对齐的开镜视点。 */
    setAimProgress(value: number): void {
        this.aimProgress = Math.max(0, Math.min(1, value));
        this.updateCamera();
    }

    setWeaponPresentationScale(value: number): void {
        this.weaponPresentation?.setMaximumScale(value);
        this.updateCamera();
    }

    /** 右键按住期间立即限制移速，并忽略 Shift 疾跑。 */
    setAiming(value: boolean): void {
        this.isAiming = value;
    }

    /** 镜头承担总上抬的一部分；其余部分由腰射准星承担。 */
    addRecoil(pitch: number, yaw: number): void {
        this.recoilPitch = Math.min(10, this.recoilPitch + pitch);
        this.recoilYaw = Math.max(-3, Math.min(3, this.recoilYaw + yaw));
        this.lastRecoilAt = this.clock?.now() ?? performance.now();
        this.updateCameraRotation();
    }

    onAwake(): void {
        this.player = this.owner as Laya.Sprite3D;
        const spawn = this.spawnPoint || this.player;
        this.spawnPosition = spawn.transform.position.clone();
        this.spawnYaw = spawn.transform.rotationEuler.y;
        this.yaw = this.spawnYaw;
        this.playerHealth = this.player.getComponent(PlayerHealth);
        this.controller = this.player.getComponent(Laya.CharacterController);
        if (this.weaponPivot && this.followCamera) {
            this.weaponPresentation = new WeaponPresentation(this.weaponPivot, this.player.scene as Laya.Scene3D);
            this.originalNearPlane = this.followCamera.nearPlane;
            this.followCamera.nearPlane = Math.min(this.originalNearPlane, 0.01);
        }
        this.canvas = Laya.Browser.mainCanvas.source;
        this.canvas.tabIndex = 0;
        this.standingVisual = this.body.getChildByName("Standing") as Laya.Sprite3D;
        this.crouchingVisual = this.body.getChildByName("Crouching") as Laya.Sprite3D;
        this.animatedVisual = this.body.getChildByName("AnimatedModel") as Laya.Sprite3D;
        if (this.animatedVisual) {
            this.updateBodyVisual();
        } else if (this.standingVisual && this.crouchingVisual) {
            // 只隐藏头颈，保留低头时的身体和腿部；编辑器中仍显示完整人物。
            for (const visual of [this.standingVisual, this.crouchingVisual]) {
                const head = visual.getChildByName("Head");
                if (head) head.active = false;
            }
            this.updateBodyVisual();
        } else {
            // 兼容仍引用旧胶囊占位体的外部测试场景。
            this.body.active = false;
        }
    }

    onEnable(): void {
        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.handleKeyDown);
        Laya.stage.on(Laya.Event.KEY_UP, this, this.handleKeyUp);
        Laya.stage.on(Laya.Event.BLUR, this, this.clearInput);
        window.addEventListener("blur", this.clearInput);
        document.addEventListener("visibilitychange", this.visibilityChanged);
        this.canvas.addEventListener("click", this.requestMouseFocus);
        document.addEventListener("pointerlockchange", this.pointerLockChanged);
        document.addEventListener("pointerlockerror", this.pointerLockFailed);
        document.addEventListener("mousemove", this.handleMouseMove);
        this.canvas.addEventListener("pointerdown", this.handleLockedPointerDown, true);
        this.canvas.addEventListener("contextmenu", this.preventContextMenu);
    }

    onStart(): void {
        if (this.spawnPoint) {
            this.player.transform.position = this.spawnPosition;
            this.controller.position = this.spawnPosition;
        }
        this.updateCamera();
        this.updateCameraRotation();
        this.showMousePrompt();
    }

    private readonly showMousePrompt = () => {
        if (!this.statusText) return;
        this.hudElapsed = 0.1;
    };

    private handleKeyDown(event: Laya.Event): void {
        if (event.keyCode === 27 && !this.menuFocus && this.hasMouseFocus) {
            if (document.pointerLockElement === this.canvas) document.exitPointerLock();
            else this.canvas.blur();
            this.clearInput();
            return;
        }
        if (!this.isGameplayFocused()) return;
        const key = event.keyCode;
        if (key === 32 && !this.keys.has(key)) this.jumpRequested = true;
        this.keys.add(key);
        if ([87, 65, 83, 68, 32, 16, 67].indexOf(key) >= 0) event.nativeEvent?.preventDefault();
    }

    private handleKeyUp(event: Laya.Event): void {
        this.keys.delete(event.keyCode);
    }

    onUpdate(): void {
        if (this.clock?.paused) return;
        const dt = Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0.05);
        const alive = !this.playerHealth || this.playerHealth.isAlive;
        const grounded = this.controller.isOnGround();
        // 在落地时切换姿态，避免重建 Bullet 胶囊形状清掉空中垂直速度。
        const wantsCrouch = alive && this.hasMouseFocus && this.keys.has(67);
        if (grounded && wantsCrouch !== this.crouching && (wantsCrouch || this.canStand())) {
            this.setCrouching(wantsCrouch);
        }

        let x = alive ? Number(this.keys.has(68)) - Number(this.keys.has(65)) : 0;
        let z = alive ? Number(this.keys.has(83)) - Number(this.keys.has(87)) : 0;
        const length = Math.hypot(x, z);
        this.currentSpeed = length === 0 ? 0 : this.isAiming
            ? Math.min(this.aimWalkSpeed, this.crouching ? this.crouchSpeed : this.walkSpeed)
            : this.crouching ? this.crouchSpeed
            : this.keys.has(16) ? this.sprintSpeed : this.walkSpeed;
        if (length > 0) {
            x /= length;
            z /= length;
        }
        const angle = this.yaw * Math.PI / 180;
        this.movement.setValue((x * Math.cos(angle) + z * Math.sin(angle)) * this.currentSpeed * dt,
            0, (-x * Math.sin(angle) + z * Math.cos(angle)) * this.currentSpeed * dt);
        this.controller.move(this.movement);

        if (this.jumpRequested && grounded && alive) {
            this.jumpVelocity.setValue(0, this.jumpSpeed, 0);
            this.controller.jump(this.jumpVelocity);
        }
        // 空格只响应按下沿，按住不连跳，空中按键也不触发二段跳。
        this.jumpRequested = false;
        if (this.player.transform.position.y < -20) this.respawn();

        this.hudElapsed += dt;
        if (this.statusText && this.hudElapsed >= 0.1) {
            this.hudElapsed = 0;
            const p = this.player.transform.position;
            const mode = !alive ? "阵亡" : !grounded ? "空中" : this.isAiming
                ? this.crouching ? "下蹲开镜" : this.currentSpeed === 0 ? "开镜" : "开镜行走"
                : this.crouching ? "下蹲" : this.currentSpeed === 0
                ? "站立" : this.keys.has(16) ? "疾跑" : "行走";
            const mouse = document.pointerLockElement === this.canvas ? "鼠标已锁定 · Esc 释放"
                : this.hasMouseFocus ? "画面内移动鼠标转向 · Esc 释放" : this.mouseLockError
                ? "鼠标锁定受限，点击画面使用窗口内转向" : "点击游戏画面锁定鼠标";
            this.statusText.text = `${mouse}  |  ${mode}  |  速度 ${this.currentSpeed.toFixed(1)} m/s\n`
                + `位置 X ${p.x.toFixed(1)}  Y ${p.y.toFixed(1)}  Z ${p.z.toFixed(1)}`;
        }
    }

    onLateUpdate(): void {
        if (this.clock?.paused) return;
        this.updateBodyVisual();
        this.updateCamera();
        // 开火后短暂停顿再回正，保留每次射击的上抬冲击。
        if ((this.clock?.now() ?? performance.now()) - this.lastRecoilAt > 120
            && (this.recoilPitch !== 0 || this.recoilYaw !== 0)) {
            const dt = Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0.05);
            this.recoilPitch = Math.max(0, this.recoilPitch - 2.6 * dt);
            this.recoilYaw *= Math.max(0, 1 - 5 * dt);
            if (Math.abs(this.recoilYaw) < 0.001) this.recoilYaw = 0;
            this.updateCameraRotation();
        }
        this.weaponPresentation?.update(this.cameraPosition, this.followCamera, this.cameraRotation,
            this.aimProgress, Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0.05));
    }

    private setCrouching(value: boolean): void {
        const height = value ? this.crouchingHeight : this.standingHeight;
        const p = this.player.transform.position.clone();
        p.y += (height - this.controller.height) / 2;
        this.controller.enabled = false;
        // 3.4.1 Bullet 仅修改 height 不会重新绑定原生形状；重新赋予形状确保真实碰撞同步。
        this.controller.height = height;
        this.controller.colliderShape = new Laya.CapsuleColliderShape(this.radius, height);
        this.player.transform.position = p;
        this.controller.enabled = true;
        this.controller.position = p;
        this.crouching = value;
        this.updateBodyVisual();
    }

    private canStand(): boolean {
        const p = this.player.transform.position;
        const physics = (this.player.scene as Laya.Scene3D).physicsSimulation;
        // 排除玩家所属的 CHARACTERFILTER 分组，检查头顶及四周的站立余量。
        for (const x of [-this.radius, 0, this.radius]) {
            for (const z of [-this.radius, 0, this.radius]) {
                this.headRay.origin.setValue(p.x + x, p.y, p.z + z);
                if (physics.rayCast(this.headRay, this.headHit,
                    this.standingHeight - this.crouchingHeight / 2 + 0.05, -1,
                    ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER)) return false;
            }
        }
        return true;
    }

    private respawn(): void {
        this.clearInput();
        this.setCrouching(false);
        this.player.transform.position = this.spawnPosition;
        this.controller.position = this.spawnPosition;
        this.yaw = this.spawnYaw;
        this.pitch = this.recoilPitch = this.recoilYaw = 0;
        this.updateCameraRotation();
        this.updateCamera();
        this.player.event(PlayerController.RESPAWNED);
    }

    private updateCamera(): void {
        if (!this.followCamera || !this.weaponPivot) return;
        const p = this.player.transform.position;
        const feetY = p.y - this.controller.height / 2;
        const eyeHeight = this.crouching ? 1.0 : 1.65;
        // A small forward head lean at steep downward angles keeps the stock
        // and wrists in front of the chest. Move camera and weapon together so
        // ADS remains collinear; the capsule, feet and movement never move.
        const lean = 0.20 * Math.min(1, Math.max(0, (-this.cameraRotation.x - 35) / 50)) ** 2;
        const yaw = this.yaw * Math.PI / 180;
        this.cameraPosition.setValue(p.x - Math.sin(yaw) * lean, feetY + eyeHeight,
            p.z - Math.cos(yaw) * lean);
        this.weaponPivot.transform.position = this.cameraPosition;
        Laya.Vector3.transformQuat(this.sightOffset, this.followCamera.transform.rotation,
            this.sightOffsetWorld);
        this.viewPosition.setValue(
            this.cameraPosition.x + this.sightOffsetWorld.x * this.aimProgress,
            this.cameraPosition.y + this.sightOffsetWorld.y * this.aimProgress,
            this.cameraPosition.z + this.sightOffsetWorld.z * this.aimProgress);
        this.followCamera.transform.position = this.viewPosition;
        this.weaponPresentation?.apply(this.cameraPosition, this.followCamera, this.cameraRotation, this.aimProgress);
    }

    private updateCameraRotation(): void {
        if (!this.followCamera) return;
        this.cameraRotation.setValue(Math.max(-85, Math.min(85, this.pitch + this.recoilPitch)),
            this.yaw + this.recoilYaw, 0);
        this.followCamera.transform.rotationEuler = this.cameraRotation;
        this.weaponPivot.transform.rotationEuler = this.cameraRotation;
        this.updateBodyVisual();
        this.weaponPresentation?.apply(this.cameraPosition, this.followCamera, this.cameraRotation, this.aimProgress);
    }

    private updateBodyVisual(): void {
        if (!this.animatedVisual && (!this.standingVisual || !this.crouchingVisual)) return;
        if (!this.animatedVisual) {
            this.standingVisual.active = !this.crouching;
            this.crouchingVisual.active = this.crouching;
        }
        // 模型以脚底为原点，碰撞体以中心为原点；下蹲时脚底保持贴地。
        // 身体跟随水平朝向，不跟随俯仰、开镜位移和枪械后坐力。
        const angle = this.yaw * Math.PI / 180;
        const behindEyes = 0.04;
        let feetOffset = -this.controller.height / 2;
        const physics = (this.player.scene as Laya.Scene3D)?.physicsSimulation;
        if (physics && this.controller.isOnGround()) {
            // 出生和台阶处的胶囊中心可能尚在收敛；只校正外观，不移动碰撞体。
            this.bodyGroundRay.origin = this.player.transform.position;
            if (physics.rayCast(this.bodyGroundRay, this.bodyGroundHit, this.controller.height / 2 + 0.25,
                -1, ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER)) {
                const pose = this.animatedVisual || (this.crouching ? this.crouchingVisual : this.standingVisual);
                feetOffset = this.bodyGroundHit.point.y - this.player.transform.position.y
                    - pose.transform.localPosition.y;
            }
        }
        this.bodyPosition.setValue(Math.sin(angle) * behindEyes, feetOffset,
            Math.cos(angle) * behindEyes);
        this.body.transform.localPosition = this.bodyPosition;
        this.bodyRotation.setValue(0, this.yaw + 180, 0);
        this.body.transform.localRotationEuler = this.bodyRotation;
    }

    onDisable(): void {
        this.releaseGameplayFocus();
        Laya.stage.offAllCaller(this);
        window.removeEventListener("blur", this.clearInput);
        document.removeEventListener("visibilitychange", this.visibilityChanged);
        this.canvas.removeEventListener("click", this.requestMouseFocus);
        document.removeEventListener("pointerlockchange", this.pointerLockChanged);
        document.removeEventListener("pointerlockerror", this.pointerLockFailed);
        document.removeEventListener("mousemove", this.handleMouseMove);
        this.canvas.removeEventListener("pointerdown", this.handleLockedPointerDown, true);
        this.canvas.removeEventListener("contextmenu", this.preventContextMenu);
    }

    onDestroy(): void {
        this.weaponPresentation?.destroy();
        if (this.followCamera && !this.followCamera.destroyed) this.followCamera.nearPlane = this.originalNearPlane;
    }
}
