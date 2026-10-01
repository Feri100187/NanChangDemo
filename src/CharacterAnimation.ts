import { EnemyAI } from "./EnemyAI";
import { PlayerController } from "./PlayerController";
import { PlayerHealth } from "./PlayerHealth";
import { RifleController } from "./RifleController";

const { regClass, property } = Laya;

/** Only presents existing gameplay state. Never moves the actor, applies damage or finishes reloads. */
@regClass()
export class CharacterAnimation extends Laya.Script {
    @property({ type: Number, caption: "动画融合比例" })
    blend = 0.10;

    private animator: Laya.Animator;
    private viewAnimator: Laya.Animator;
    private viewArms: Laya.Sprite3D;
    private bodyArms: Laya.Node;
    private viewState = "";
    private viewWeapon = "";
    private viewRightHand: Laya.Sprite3D;
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
        if (this.player && this.viewArms) {
            this.viewAnimator = this.viewArms.getComponent(Laya.Animator);
            this.visit(this.viewArms, node => {
                if (node.name === "R_Hand") this.viewRightHand = node as Laya.Sprite3D;
                if (node.name === "Body" || node.name === "FirstPersonHiddenHead" || node.name === "Arms") node.active = false;
                const renderer = node.getComponent(Laya.SkinnedMeshRenderer);
                if (renderer && node.name === "ViewArms") {
                    // The imported bound describes the T-pose. View poses move these
                    // same vertices around the gun; include that range in bone space.
                    renderer.localBounds = new Laya.Bounds(new Laya.Vector3(-2, -2, -2), new Laya.Vector3(2, 2, 2));
                    renderer.castShadow = false;
                }
            });
            this.viewAnimator.cullingMode = Laya.Animator.CULLINGMODE_ALWAYSANIMATE;
            this.updateArmsVisibility();
            this.viewAnimator.play("ViewHold", 0, 0);
            this.viewState = "ViewHold";
            this.viewAnimator.speed = this.clock?.paused ? 0 : 1;
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
        this.actor.on(RifleController.MELEE_SWUNG, this, this.melee);
        this.actor.on(RifleController.MELEE_HEAVY_SWUNG, this, this.heavyMelee);
        this.actor.on(PlayerController.RESPAWNED, this, this.resetAction);
    }

    private fire(): void { this.startAction("Fire", 400); }
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
        if (this.viewAnimator && this.rifle?.meleeViewState) {
            const clip = this.viewAnimator.getControllerLayer(0).getAnimatorState(this.viewState)?.clip;
            // Baked clips are frame-quantized; match the weapon's exact 320/620 ms
            // motion instead of letting that rounding separate the hand and blade.
            this.viewAnimator.speed = clip ? clip.duration() / this.rifle.meleeDurationSeconds : 1;
        }
        const crouch = this.player?.isCrouching ?? false;
        if (this.rifle?.isReloading) {
            this.setState(crouch ? "CrouchReload" : "Reload", this.rifle.reloadProgress, true);
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
        if (this.bodyArms) this.bodyArms.active = false;
    }

    private updateViewState(): void {
        if (!this.viewAnimator || !this.rifle || !this.viewArms.active) return;
        const knifeAction = this.rifle.meleeViewState;
        const state = this.rifle.currentWeapon === "knife" ? knifeAction || "ViewKnifeHold"
            : this.rifle.isReloading ? "ViewReload" : this.rifle.aimBlend > 0.5 ? "ViewAim" : "ViewHold";
        if (state === this.viewState) return;
        if (state === "ViewReload" || knifeAction || !this.viewState) this.viewAnimator.play(state, 0,
            knifeAction ? this.rifle.meleeProgress : this.rifle.isReloading ? this.rifle.reloadProgress : 0);
        else this.viewAnimator.crossFade(state, this.blend, 0, 0);
        this.viewState = state;
    }

    onLateUpdate(): void {
        if (!this.viewArms?.active || !this.rifle?.rifleModel) return;
        // The same unscaled mesh is used by the rifle prefab. Follow its actual world
        // pose so pitch, ADS camera motion and recoil never separate hands from the gun.
        const reference = this.rifle.currentWeapon === "knife"
            ? this.rifle.rifleModel.parent as Laya.Sprite3D : this.rifle.rifleModel;
        this.viewArms.transform.position = reference.transform.position;
        this.viewArms.transform.rotation = reference.transform.rotation;
    }

    onAfterSceneUpdate(): void {
        // LayaAir 3.4.1 evaluates Animator AFTER onLateUpdate. Apply the grip
        // constraint to the final bone pose, before skinned rendering is prepared.
        if (this.viewArms?.active && this.rifle?.currentWeapon === "knife") this.alignKnifeGrip();
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

    private setState(name: string, progress = 0, immediate = false): void {
        if (this.current === name || !this.animator.getControllerLayer(0)?.getAnimatorState(name)) return;
        if (immediate || !this.current) this.animator.play(name, 0, Math.max(0, Math.min(1, progress)));
        else this.animator.crossFade(name, this.blend, 0, 0);
        this.current = name;
    }

    private visit(node: Laya.Node, callback: (node: Laya.Node) => void): void {
        callback(node);
        for (let i = 0; i < node.numChildren; i++) this.visit(node.getChildAt(i), callback);
    }

    onDisable(): void {
        this.actor?.offAllCaller(this);
        if (this.animator) this.animator.speed = 0;
        if (this.viewAnimator) this.viewAnimator.speed = 0;
        this.resetAction();
    }
}
