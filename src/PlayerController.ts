import { PlayerHealth } from "./PlayerHealth";

const { regClass, property } = Laya;

/** 胶囊体第一人称控制。点击画布锁定鼠标，Esc 释放。 */
@regClass()
export class PlayerController extends Laya.Script {
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

    private readonly standingHeight = 2;
    private readonly crouchingHeight = 1.2;
    private readonly radius = 0.45;
    private readonly keys = new Set<number>();
    private readonly movement = new Laya.Vector3();
    private readonly cameraPosition = new Laya.Vector3();
    private readonly viewPosition = new Laya.Vector3();
    // 瞄具红点相对角色眼位的水平/垂直偏移，开镜时将相机移到此处。
    private readonly sightOffset = new Laya.Vector3(0.34, -0.14, 0);
    private readonly sightOffsetWorld = new Laya.Vector3();
    private readonly cameraRotation = new Laya.Vector3();
    private readonly jumpVelocity = new Laya.Vector3();
    private readonly headRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 1, 0));
    private readonly headHit = new Laya.HitResult();
    private player: Laya.Sprite3D;
    private playerHealth: PlayerHealth;
    private controller: Laya.CharacterController;
    private meshFilter: Laya.MeshFilter;
    private standingMesh: Laya.Mesh;
    private crouchingMesh: Laya.Mesh;
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

    private readonly clearInput = () => {
        this.keys.clear();
        this.jumpRequested = false;
        this.movement.setValue(0, 0, 0);
        this.controller?.move(this.movement);
    };

    private readonly visibilityChanged = () => {
        if (document.hidden) this.clearInput();
    };

    private readonly requestMouseFocus = () => {
        if (document.pointerLockElement === this.canvas) return;
        this.mouseLockError = false;
        this.canvas.focus();
        // Pointer Lock 要在真实点击事件里请求，浏览器才会允许持续接收相对鼠标位移。
        try {
            const request = this.canvas.requestPointerLock();
            if (request && typeof request.catch === "function") request.catch(this.pointerLockFailed);
        } catch (_) {
            this.pointerLockFailed();
        }
    };

    private readonly pointerLockChanged = () => {
        if (this.hasMouseFocus) this.ignoreNextMouseMove = true;
        else this.clearInput();
        this.showMousePrompt();
    };

    private readonly pointerLockFailed = () => {
        this.mouseLockError = true;
        this.showMousePrompt();
    };

    private readonly handleMouseMove = (event: MouseEvent) => {
        if (!this.hasMouseFocus) return;
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
        return this.hasMouseFocus && (!this.playerHealth || this.playerHealth.isAlive);
    }

    /** 鼠标事件和物理帧之间也能从角色当前眼位正确发射射线。 */
    syncCameraForShot(): void {
        this.updateCamera();
    }

    /** 0 为腰射视点，1 为与枪上红点共线的开镜视点。 */
    setAimProgress(value: number): void {
        this.aimProgress = Math.max(0, Math.min(1, value));
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
        this.lastRecoilAt = performance.now();
        this.updateCameraRotation();
    }

    onAwake(): void {
        this.player = this.owner as Laya.Sprite3D;
        this.playerHealth = this.player.getComponent(PlayerHealth);
        this.controller = this.player.getComponent(Laya.CharacterController);
        this.meshFilter = this.body.getComponent(Laya.MeshFilter);
        this.canvas = Laya.Browser.mainCanvas.source;
        this.canvas.tabIndex = 0;
        this.standingMesh = Laya.PrimitiveMesh.createCapsule(this.radius, this.standingHeight);
        this.crouchingMesh = Laya.PrimitiveMesh.createCapsule(this.radius, this.crouchingHeight);
        this.meshFilter.sharedMesh = this.standingMesh;
        this.body.transform.localScale = new Laya.Vector3(1, 1, 1);
        // 相机在胶囊内部；只隐藏网格，保留完整的角色碰撞体。
        this.body.getComponent(Laya.MeshRenderer).enabled = false;
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
        this.updateCamera();
        this.updateCameraRotation();
        this.showMousePrompt();
    }

    private readonly showMousePrompt = () => {
        if (!this.statusText) return;
        this.hudElapsed = 0.1;
    };

    private handleKeyDown(event: Laya.Event): void {
        if (event.keyCode === 27 && this.hasMouseFocus) {
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
        const dt = Math.min(Laya.timer.delta / 1000, 0.05);
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
        this.updateCamera();
        // 连射间隔约 86 ms：这段时间不回正，让视角随每发持续上抬。
        if (performance.now() - this.lastRecoilAt > 120
            && (this.recoilPitch !== 0 || this.recoilYaw !== 0)) {
            const dt = Math.min(Laya.timer.delta / 1000, 0.05);
            this.recoilPitch = Math.max(0, this.recoilPitch - 2.6 * dt);
            this.recoilYaw *= Math.max(0, 1 - 5 * dt);
            if (Math.abs(this.recoilYaw) < 0.001) this.recoilYaw = 0;
            this.updateCameraRotation();
        }
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
        this.meshFilter.sharedMesh = value ? this.crouchingMesh : this.standingMesh;
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
        const spawn = new Laya.Vector3(0, 1.1, 0);
        this.player.transform.position = spawn;
        this.controller.position = spawn;
        this.updateCamera();
    }

    private updateCamera(): void {
        if (!this.followCamera || !this.weaponPivot) return;
        const p = this.player.transform.position;
        const feetY = p.y - this.controller.height / 2;
        const eyeHeight = this.crouching ? 1.0 : 1.65;
        this.cameraPosition.setValue(p.x, feetY + eyeHeight, p.z);
        this.weaponPivot.transform.position = this.cameraPosition;
        Laya.Vector3.transformQuat(this.sightOffset, this.weaponPivot.transform.rotation,
            this.sightOffsetWorld);
        this.viewPosition.setValue(
            this.cameraPosition.x + this.sightOffsetWorld.x * this.aimProgress,
            this.cameraPosition.y + this.sightOffsetWorld.y * this.aimProgress,
            this.cameraPosition.z + this.sightOffsetWorld.z * this.aimProgress);
        this.followCamera.transform.position = this.viewPosition;
    }

    private updateCameraRotation(): void {
        if (!this.followCamera) return;
        this.cameraRotation.setValue(Math.max(-85, Math.min(85, this.pitch + this.recoilPitch)),
            this.yaw + this.recoilYaw, 0);
        this.followCamera.transform.rotationEuler = this.cameraRotation;
        this.weaponPivot.transform.rotationEuler = this.cameraRotation;
    }

    onDisable(): void {
        this.clearInput();
        Laya.stage.offAllCaller(this);
        window.removeEventListener("blur", this.clearInput);
        document.removeEventListener("visibilitychange", this.visibilityChanged);
        this.canvas.removeEventListener("click", this.requestMouseFocus);
        document.removeEventListener("pointerlockchange", this.pointerLockChanged);
        document.removeEventListener("pointerlockerror", this.pointerLockFailed);
        document.removeEventListener("mousemove", this.handleMouseMove);
        this.canvas.removeEventListener("pointerdown", this.handleLockedPointerDown, true);
        this.canvas.removeEventListener("contextmenu", this.preventContextMenu);
        if (document.pointerLockElement === this.canvas) document.exitPointerLock();
    }

    onDestroy(): void {
        this.standingMesh?.destroy();
        this.crouchingMesh?.destroy();
    }
}
