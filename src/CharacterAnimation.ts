import { EnemyAI } from "./EnemyAI";
import { PlayerController } from "./PlayerController";
import { PlayerHealth } from "./PlayerHealth";
import { RifleController } from "./RifleController";
import { BOLT_CYCLE_MS } from "./WeaponMotion";
import { CasingEjection } from "./CasingEjection";
import { FirstPersonArmIK } from "./FirstPersonArmIK";

const { regClass, property } = Laya;

/** Only presents existing gameplay state. Never moves the actor, applies damage or finishes reloads. */
@regClass()
export class CharacterAnimation extends Laya.Script {
    @property({ type: Number, caption: "动画融合比例" })
    blend = 0.06;
    @property({ type: Number, caption: "弹壳保留时间（秒）" })
    casingLifetime = 4;
    @property({ type: Number, caption: "弹壳抛出速度倍率" })
    casingSpeed = 1;

    private animator: Laya.Animator;
    private viewAnimator: Laya.Animator;
    private viewArms: Laya.Sprite3D;
    private bodyArms: Laya.Node;
    private viewState = "";
    private viewReloadStep = -1;
    private bodyReloadStep = -1;
    private viewWeapon = "";
    private viewRightHand: Laya.Sprite3D;
    private reloadCartridge: Laya.Sprite3D;
    private casings: CasingEjection;
    private armIK: FirstPersonArmIK;
    private readonly cartridgeLocal = new Laya.Vector3();
    private readonly cartridgeWorld = new Laya.Vector3();
    private readonly cartridgeRotation = new Laya.Quaternion();
    private readonly cartridgeWorldRotation = new Laya.Quaternion();
    private readonly viewScale = new Laya.Vector3(1, 1, 1);
    // Weapon-local wrist frame baked by prepare-rigged-characters.py. The hand
    // stays attached even when Animator and weapon updates land on different frames.
    private readonly knifeGrip = new Laya.Vector3(0.035, 0.050, 0.23);
    // Includes the glTF joint-axis correction (-90 degrees around local X).
    private readonly knifeGripRotation = new Laya.Quaternion(-0.6824695299, -0.1804619160, 0.6808968266, 0.1950598605);
    private readonly gripTarget = new Laya.Vector3();
    private readonly correctedPosition = new Laya.Vector3();
    private readonly gripRotation = new Laya.Quaternion();
    private readonly inverseHand = new Laya.Quaternion();
    private readonly correction = new Laya.Quaternion();
    private readonly correctedRotation = new Laya.Quaternion();
    private actor: Laya.Sprite3D;
    private player: PlayerController;
    private health: PlayerHealth;
    private enemy: EnemyAI;
    private rifle: RifleController;
    private current = "";
    private action = "";
    private actionAt = 0;
    private actionDuration = 0;
    private previousX = 0;

    private get clock() { return this.player?.clock || this.enemy?.clock; }
    private now(): number { return this.clock?.now() ?? performance.now(); }

    onAwake(): void {
        for (let node: Laya.Node = this.owner; node; node = node.parent) {
            this.player = node.getComponent(PlayerController);
            this.enemy = node.getComponent(EnemyAI);
            if (this.player || this.enemy) {
                this.actor = node as Laya.Sprite3D;
                this.health = node.getComponent(PlayerHealth);
                this.rifle = node.getComponent(RifleController);
                break;
            }
        }
        const body = this.owner.getChildByName("AnimatedModel") || this.owner;
        this.visit(body, node => {
            this.animator ||= node.getComponent(Laya.Animator);
            if (this.player && node.name === "FirstPersonHiddenHead") node.active = false;
            if (node.name === "ViewArms") node.active = false;
            if (this.player && node.name === "Arms") this.bodyArms = node;
        });
        this.viewArms = this.owner.getChildByName("FirstPersonArms") as Laya.Sprite3D;
        this.reloadCartridge = this.owner.getChildByName("ReloadCartridge") as Laya.Sprite3D;
        const casingTemplate = this.owner.getChildByName("EjectedCaseTemplate") as Laya.Sprite3D;
        if (casingTemplate && this.rifle) {
            casingTemplate.active = false;
            this.casings = new CasingEjection(casingTemplate, this.actor.scene as Laya.Scene3D);
        }
        if (this.player && this.viewArms) {
            this.viewAnimator = this.viewArms.getComponent(Laya.Animator);
            this.visit(this.viewArms, node => {
                if (node.name === "R_Hand") this.viewRightHand = node as Laya.Sprite3D;
                if (node.name === "Body" || node.name === "FirstPersonHiddenHead" || node.name === "Arms" || node.name === "ViewArms") node.active = false;
            });
            this.viewAnimator.cullingMode = Laya.Animator.CULLINGMODE_ALWAYSANIMATE;
            this.updateArmsVisibility();
            this.viewAnimator.play("ViewHold", 0, 0);
            this.viewState = "ViewHold";
            this.viewAnimator.speed = this.clock?.paused ? 0 : 1;
            this.armIK = new FirstPersonArmIK(body as Laya.Sprite3D, this.viewArms, this.actor.scene as Laya.Scene3D);
            const armRenderer = this.bodyArms?.getComponent(Laya.SkinnedMeshRenderer);
            if (armRenderer) armRenderer.localBounds = new Laya.Bounds(new Laya.Vector3(-1.5, -0.5, -1.5), new Laya.Vector3(1.5, 2.5, 1.5));
        }
        if (this.actor) this.previousX = this.actor.transform.position.x;
        if (this.animator) {
            this.animator.cullingMode = Laya.Animator.CULLINGMODE_ALWAYSANIMATE;
            this.setState("Idle", 0, true);
            this.animator.speed = this.clock?.paused ? 0 : 1;
        }
    }

    onEnable(): void {
        if (!this.actor) return;
        this.actor.on(EnemyAI.FIRED, this, this.fire);
        this.actor.on(RifleController.FIRED, this, this.fire);
        this.actor.on(RifleController.CASE_EJECTED, this, this.ejectCase);
        this.actor.on(RifleController.MELEE_SWUNG, this, this.melee);
        this.actor.on(RifleController.MELEE_HEAVY_SWUNG, this, this.heavyMelee);
        this.actor.on(PlayerController.RESPAWNED, this, this.resetAction);
    }

    private fire(): void { this.startAction("Fire", 400); }
    private ejectCase(): void {
        if (this.clock?.paused || !this.rifle?.enabled) return;
        this.casings?.eject(this.rifle.rifleModel.transform, this.now(), this.casingLifetime,
            this.casingSpeed, this.player?.viewModelScale ?? 1);
    }
    private melee(): void { this.startAction("Melee", 320); }
    private heavyMelee(): void { this.startAction("HeavyMelee", 620); }
    private startAction(name: string, duration: number): void {
        if (this.clock?.paused) return;
        this.action = name;
        this.actionAt = this.now();
        this.actionDuration = duration;
    }
    private resetAction(): void { this.action = ""; this.current = ""; }

    onUpdate(): void {
        if (this.rifle && !this.rifle.enabled) this.casings?.clear();
        else if (!this.clock?.paused) this.casings?.update(
            Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0.05), this.now());
        if (!this.animator || !this.actor) return;
        const x = this.actor.transform.position.x;
        const dx = x - this.previousX;
        this.previousX = x;
        const stopped = this.clock?.paused || (this.player && (!this.player.enabled || !this.health?.isAlive))
            || (this.enemy && (!this.enemy.enabled || !this.enemy.isAlive));
        this.animator.speed = stopped ? 0 : 1;
        if (this.viewAnimator) this.viewAnimator.speed = stopped ? 0 : 1;
        this.updateArmsVisibility();
        if (stopped) return;
        this.updateViewState();
        if (this.viewAnimator && this.rifle?.isReloading) {
            this.viewAnimator.speed = this.reloadSpeed(this.viewAnimator, this.viewState);
        } else if (this.viewAnimator && this.rifle?.meleeViewState) {
            const clip = this.viewAnimator.getControllerLayer(0).getAnimatorState(this.viewState)?.clip;
            // Baked clips are frame-quantized; match the weapon's exact 320/620 ms
            // motion instead of letting that rounding separate the hand and blade.
            this.viewAnimator.speed = clip ? clip.duration() / this.rifle.meleeDurationSeconds : 1;
        } else if (this.viewAnimator && this.viewState === "ViewBolt") {
            const clip = this.viewAnimator.getControllerLayer(0).getAnimatorState("ViewBolt")?.clip;
            this.viewAnimator.speed = clip ? clip.duration() / (BOLT_CYCLE_MS / 1000) : 1;
        }
        const crouch = this.player?.isCrouching ?? false;
        if (this.rifle?.isReloading) {
            const state = (crouch ? "CrouchReload" : "Reload") + this.reloadSuffix();
            this.setState(state, this.rifle.reloadStageProgress, true, this.bodyReloadStep !== this.rifle.reloadStep);
            this.bodyReloadStep = this.rifle.reloadStep;
            this.animator.speed = this.reloadSpeed(this.animator, state);
            return;
        }
        const actionProgress = (this.now() - this.actionAt) / this.actionDuration;
        if (this.action && actionProgress < 1) {
            this.setState((crouch ? "Crouch" : "") + this.action, actionProgress, true);
            return;
        }
        this.action = "";
        let state = "Idle";
        if (this.enemy) {
            state = this.enemy.state === "Patrol" && Math.abs(dx) > 0.00001
                ? "Walk"
                : this.enemy.state === "Combat" || this.enemy.state === "Alert" ? "Aim" : "Idle";
        } else if (this.player) {
            const holding = this.rifle?.currentWeapon === "rifle";
            const aiming = holding && this.rifle.aimBlend > 0.5;
            const moving = this.player.movementSpeed > 0;
            state = !this.player.isGrounded ? "Jump"
                : holding ? crouch
                    ? aiming ? moving ? "CrouchAimWalk" : "CrouchAim" : moving ? "CrouchHoldWalk" : "CrouchHold"
                    : aiming ? moving ? "AimWalk" : "Aim"
                    : this.player.movementSpeed > this.player.walkSpeed ? "HoldRun" : moving ? "HoldWalk" : "Hold"
                : crouch ? moving ? "CrouchKnifeWalk" : "CrouchKnifeHold"
                : this.player.movementSpeed > this.player.walkSpeed ? "KnifeRun"
                : moving ? "KnifeWalk" : "KnifeHold";
        }
        this.setState(state);
    }

    private updateArmsVisibility(): void {
        if (!this.viewArms || !this.rifle) return;
        if (!this.viewArms.active || this.viewWeapon !== this.rifle.currentWeapon) {
            this.viewArms.active = true;
            this.viewWeapon = this.rifle.currentWeapon;
            // Rifle poses are gun-local; knife poses are camera-pivot-local. Never
            // blend between these spaces when switching weapons.
            this.viewState = "";
        }
        if (this.bodyArms) this.bodyArms.active = true;
    }

    private updateViewState(): void {
        if (!this.viewAnimator || !this.rifle || !this.viewArms.active) return;
        const knifeAction = this.rifle.meleeViewState;
        const state = this.rifle.currentWeapon === "knife" ? knifeAction || "ViewKnifeHold"
            : this.rifle.isReloading ? "ViewReload" + this.reloadSuffix() : this.rifle.boltCycleProgress >= 0 ? "ViewBolt"
            : this.rifle.aimBlend > 0.5 ? "ViewAim" : "ViewHold";
        if (state === this.viewState && (!this.rifle.isReloading || this.viewReloadStep === this.rifle.reloadStep)) return;
        if (this.rifle.isReloading || state === "ViewBolt" || knifeAction || !this.viewState) this.viewAnimator.play(state, 0,
            knifeAction ? this.rifle.meleeProgress : this.rifle.isReloading ? this.rifle.reloadStageProgress
                : state === "ViewBolt" ? this.rifle.boltCycleProgress : 0);
        else this.viewAnimator.crossFade(state, this.blend, 0, 0);
        this.viewState = state;
        this.viewReloadStep = this.rifle.reloadStep;
    }

    private reloadSuffix(): string {
        return this.rifle.reloadPhase === "prepare" ? "Prepare" : this.rifle.reloadPhase === "insert" ? "Insert" : "Finish";
    }

    private reloadSpeed(animator: Laya.Animator, name: string): number {
        const state = animator.getControllerLayer(0)?.getAnimatorState(name);
        return state?.clip ? state.clip.duration() * (state.clipEnd - state.clipStart) / this.rifle.reloadStageSeconds : 1;
    }

    onLateUpdate(): void {
        if (!this.viewArms?.active || !this.rifle?.rifleModel) return;
        // Follow the weapon with the hidden hand targets. The visible arms keep
        // their body anchors and are solved after the Animator has evaluated.
        const reference = this.rifle.currentWeapon === "knife"
            ? this.rifle.rifleModel.parent as Laya.Sprite3D : this.rifle.rifleModel;
        this.viewArms.transform.position = reference.transform.position;
        this.viewArms.transform.rotation = reference.transform.rotation;
        const scale = this.player?.viewModelScale ?? 1;
        this.viewScale.setValue(scale, scale, scale);
        this.viewArms.transform.setWorldLossyScale(this.viewScale);
    }

    onAfterSceneUpdate(): void {
        // LayaAir 3.4.1 evaluates Animator AFTER onLateUpdate. Apply the grip
        // constraint to the final bone pose, before skinned rendering is prepared.
        // Re-read the final camera/clearance pose after all LateUpdate callbacks.
        this.onLateUpdate();
        if (this.viewArms?.active && this.rifle?.currentWeapon === "knife") this.alignKnifeGrip();
        if (!this.clock?.paused && this.player?.enabled) this.armIK?.update(this.player.viewModelScale,
            Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0.05));
        this.updateReloadCartridge();
    }

    private updateReloadCartridge(): void {
        if (!this.reloadCartridge) return;
        const r = this.rifle;
        this.reloadCartridge.active = false;
        if (!r?.enabled || r.currentWeapon !== "rifle") return;
        let angle = 0;
        if (r.reloadPhase === "insert") {
            const p = r.reloadStageProgress;
            if (p < 0.05 || p >= 0.99) return;
            const t = p * p * (3 - 2 * p);
            this.cartridgeLocal.setValue(0.045 * (1 - t), 0.275 - 0.12 * t, 0.13);
            angle = 1 - t;
        } else if (!r.isReloading && r.hasRoundToChamber) {
            // Reload finish only closes the bolt. Re-showing a loose round here
            // makes a one-round top-up look like two separate insertions.
            const phase = r.boltCycleProgress;
            const start = 0.48, push = 0.60, end = 0.86;
            if (phase < start || phase >= end) return;
            const rise = Math.max(0, Math.min(1, (phase - start) / 0.12));
            let t = Math.max(0, Math.min(1, (phase - push) / (end - push)));
            t = t * t * (3 - 2 * t);
            this.cartridgeLocal.setValue(0, 0.16 + 0.02 * rise - 0.027 * t, 0.18 - 0.15 * t);
        } else return;
        this.reloadCartridge.active = true;
        const gun = r.rifleModel.transform;
        Laya.Vector3.scale(this.cartridgeLocal, this.player?.viewModelScale ?? 1, this.cartridgeLocal);
        // RifleBox carries a legacy nonuniform scale; use only its world rotation/position.
        Laya.Vector3.transformQuat(this.cartridgeLocal, gun.rotation, this.cartridgeWorld);
        Laya.Vector3.add(this.cartridgeWorld, gun.position, this.cartridgeWorld);
        this.reloadCartridge.transform.position = this.cartridgeWorld;
        Laya.Quaternion.createFromYawPitchRoll(angle * Math.PI / 3, 0,
            angle * 0.12, this.cartridgeRotation);
        Laya.Quaternion.multiply(gun.rotation, this.cartridgeRotation, this.cartridgeWorldRotation);
        this.reloadCartridge.transform.rotation = this.cartridgeWorldRotation;
        this.reloadCartridge.transform.setWorldLossyScale(this.viewScale);
    }

    private alignKnifeGrip(): void {
        const knife = this.rifle.knifeModel;
        if (!knife || !this.viewRightHand) return;
        Laya.Quaternion.multiply(knife.transform.rotation, this.knifeGripRotation, this.gripRotation);
        Laya.Quaternion.invert(this.viewRightHand.transform.rotation, this.inverseHand);
        Laya.Quaternion.multiply(this.gripRotation, this.inverseHand, this.correction);
        Laya.Quaternion.multiply(this.correction, this.viewArms.transform.rotation, this.correctedRotation);
        this.viewArms.transform.rotation = this.correctedRotation;
        Laya.Vector3.transformCoordinate(this.knifeGrip, knife.transform.worldMatrix, this.gripTarget);
        const hand = this.viewRightHand.transform.position;
        const position = this.viewArms.transform.position;
        this.correctedPosition.setValue(position.x + this.gripTarget.x - hand.x,
            position.y + this.gripTarget.y - hand.y, position.z + this.gripTarget.z - hand.z);
        this.viewArms.transform.position = this.correctedPosition;
    }

    private setState(name: string, progress = 0, immediate = false, force = false): void {
        if ((!force && this.current === name) || !this.animator.getControllerLayer(0)?.getAnimatorState(name)) return;
        if (immediate || !this.current) this.animator.play(name, 0, Math.max(0, Math.min(1, progress)));
        else this.animator.crossFade(name, this.blend, 0, 0);
        this.current = name;
    }

    private visit(node: Laya.Node, callback: (node: Laya.Node) => void): void {
        callback(node);
        for (let i = 0; i < node.numChildren; i++) this.visit(node.getChildAt(i), callback);
    }

    onDisable(): void {
        this.casings?.clear();
        if (this.reloadCartridge) this.reloadCartridge.active = false;
        this.actor?.offAllCaller(this);
        if (this.animator) this.animator.speed = 0;
        if (this.viewAnimator) this.viewAnimator.speed = 0;
        this.resetAction();
    }

    onDestroy(): void { this.casings?.clear(); this.armIK?.destroy(); }
}
