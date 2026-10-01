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
        this.visit(this.owner, node => {
            this.animator ||= node.getComponent(Laya.Animator);
            if (this.player && node.name === "FirstPersonHiddenHead") node.active = false;
        });
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
        if (stopped) return;
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
                ? dx > 0 ? "StrafeLeft" : "StrafeRight"
                : this.enemy.state === "Combat" || this.enemy.state === "Alert" ? "Aim" : "Idle";
        } else if (this.player) {
            state = !this.player.isGrounded ? "Jump"
                : crouch ? this.player.movementSpeed > 0 ? "CrouchWalk" : "CrouchIdle"
                : this.player.movementSpeed > this.player.walkSpeed ? "Run"
                : this.player.movementSpeed > 0 ? "Walk"
                : this.player.isAimActive ? "Aim" : "Idle";
        }
        this.setState(state);
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
        this.resetAction();
    }
}
