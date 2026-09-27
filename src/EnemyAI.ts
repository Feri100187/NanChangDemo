import { PlayerHealth } from "./PlayerHealth";
import { GameClock } from "./GameClock";

const { regClass, property } = Laya;

export type EnemyState = "Idle" | "Patrol" | "Alert" | "Combat" | "Dead";

export interface EnemyHitResult {
    damage: number;
    remainingHealth: number;
    killed: boolean;
}

/** 第一版敌军：站岗、巡逻、发现玩家、射线射击及永久死亡。 */
@regClass()
export class EnemyAI extends Laya.Script {
    static readonly DIED = "enemy-died";
    static readonly FIRED = "enemy-fired";
    clock: GameClock;

    @property({ type: Laya.Sprite3D, caption: "玩家" })
    player: Laya.Sprite3D;

    @property({ type: Number, caption: "最大血量" })
    maxHealth = 100;
    @property({ type: Number, caption: "视野距离" })
    sightRange = 26;
    @property({ type: Number, caption: "视野角度" })
    fieldOfView = 120;
    @property({ type: Number, caption: "进入战斗所需警戒时间（秒）" })
    alertTime = 1.6;
    @property({ type: Number, caption: "丢失目标时间（秒）" })
    loseTargetTime = 2.2;
    @property({ type: Number, caption: "射击间隔（秒）" })
    attackInterval = 0.9;
    @property({ type: Number, caption: "巡逻速度" })
    patrolSpeed = 0.75;

    private _health = 100;
    private _state: EnemyState = "Idle";
    private suspicion = 0;
    private idleElapsed = 0;
    private nextAttackAt = 0;
    private patrolIndex = 0;
    private enemy: Laya.Sprite3D;
    private playerHealth: PlayerHealth;
    private spawnPosition: Laya.Vector3;
    private readonly patrolOffsets = [0, 1.6, -1.6];
    private readonly forward = new Laya.Vector3();
    private readonly sightRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 0, 1));
    private readonly sightHit = new Laya.HitResult();
    private readonly shotRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 0, 1));
    private readonly shotHit = new Laya.HitResult();
    private readonly lookEuler = new Laya.Vector3();

    get health(): number { return this._health; }
    get isAlive(): boolean { return this._health > 0; }
    get state(): EnemyState { return this._state; }

    onAwake(): void {
        this.enemy = this.owner as Laya.Sprite3D;
        this.spawnPosition = this.enemy.transform.position.clone();
        this.playerHealth = this.player?.getComponent(PlayerHealth);
        this.maxHealth = Number.isFinite(this.maxHealth) ? Math.max(1, this.maxHealth) : 100;
        this._health = this.maxHealth;
    }

    onUpdate(): void {
        if (this.clock?.paused || !this.isAlive) return;
        const dt = Math.min(Math.max((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0), 0.05);
        if (!this.player || !this.playerHealth?.isAlive) {
            this.suspicion = 0;
            if (this._state !== "Idle") this._state = "Patrol";
            this.updatePatrol(dt);
            return;
        }

        const visible = this.canSeePlayer(this._state === "Idle" || this._state === "Patrol");
        this.suspicion = Math.max(0, Math.min(1, this.suspicion +
            (visible ? dt / Math.max(0.1, this.alertTime) : -dt / Math.max(0.1, this.loseTargetTime))));

        if (visible && this.suspicion >= 1) {
            if (this._state !== "Combat") this.nextAttackAt = (this.clock?.now() ?? performance.now()) + 200;
            this._state = "Combat";
        } else if (this.suspicion > 0.12) {
            // 失去视线后仍保持短暂警戒，数值降到阈值以下才放弃目标。
            if (this._state !== "Combat" || !visible) this._state = "Alert";
        } else if (this._state !== "Idle") {
            this._state = "Patrol";
        }

        if (this._state === "Idle") {
            this.idleElapsed += dt;
            if (this.idleElapsed >= 1.2) this._state = "Patrol";
        } else if (this._state === "Patrol") {
            this.updatePatrol(dt);
        } else {
            this.facePlayer();
            if (this._state === "Combat" && visible && (this.clock?.now() ?? performance.now()) >= this.nextAttackAt) {
                this.fireAtPlayer();
                this.nextAttackAt = (this.clock?.now() ?? performance.now()) + Math.max(0.1, this.attackInterval) * 1000;
            }
        }
    }

    /** 从枪械射线命中的 Head / Torso / Legs 节点结算部位伤害。 */
    applyHit(hitNode: Laya.Sprite3D, baseDamage: number): EnemyHitResult {
        if (this.clock?.paused || !this.enabled || !this.isAlive || !hitNode || !Number.isFinite(baseDamage) || baseDamage <= 0 ||
            (hitNode !== this.owner && !this.owner.isAncestorOf(hitNode))) {
            return { damage: 0, remainingHealth: this._health, killed: false };
        }
        const damage = Math.min(this._health, baseDamage * this.damageMultiplier(hitNode));
        this._health -= damage;
        const killed = this._health <= 0;
        if (killed) {
            this._health = 0;
            this._state = "Dead";
            this.hideBodyAndColliders(this.owner);
            // 先置为 Dead，再通知关卡；后续命中不会再次发出死亡事件。
            this.owner.event(EnemyAI.DIED, this);
        } else if (this.playerHealth?.isAlive) {
            // 中弹即可发现威胁，避免玩家在背后持续射击而敌人仍站岗。
            this.suspicion = Math.max(this.suspicion, 0.25);
            if (this._state === "Idle" || this._state === "Patrol") this._state = "Alert";
        }
        return { damage, remainingHealth: this._health, killed };
    }

    private damageMultiplier(hitNode: Laya.Node): number {
        for (let node: Laya.Node = hitNode; node && node !== this.owner; node = node.parent) {
            const name = node.name.toLowerCase();
            if (name.includes("head")) return 2.5;
            if (name.includes("leg")) return 0.65;
            if (name.includes("torso")) return 1;
        }
        return 1;
    }

    private hideBodyAndColliders(node: Laya.Node): void {
        for (const component of node.components) {
            if (component instanceof Laya.MeshRenderer || component instanceof Laya.PhysicsCollider)
                component.enabled = false;
        }
        for (let i = 0; i < node.numChildren; i++) this.hideBodyAndColliders(node.getChildAt(i));
    }

    private updatePatrol(dt: number): void {
        const position = this.enemy.transform.position;
        const targetX = this.spawnPosition.x + this.patrolOffsets[this.patrolIndex];
        const remaining = targetX - position.x;
        if (Math.abs(remaining) < 0.08) {
            this.patrolIndex = (this.patrolIndex + 1) % this.patrolOffsets.length;
        } else {
            const step = Math.min(Math.abs(remaining), Math.max(0, this.patrolSpeed) * dt);
            this.enemy.transform.position = new Laya.Vector3(position.x + Math.sign(remaining) * step,
                this.spawnPosition.y, this.spawnPosition.z);
        }
        // 巡逻时恢复朝向玩家可能出现的正面方向，以维持固定扇形视野。
        const yaw = this.enemy.transform.rotationEuler.y;
        const delta = ((-yaw + 540) % 360) - 180;
        this.lookEuler.setValue(0, yaw + Math.max(-90 * dt, Math.min(90 * dt, delta)), 0);
        this.enemy.transform.rotationEuler = this.lookEuler;
    }

    private facePlayer(): void {
        const p = this.enemy.transform.position;
        const target = this.player.transform.position;
        const yaw = Math.atan2(target.x - p.x, target.z - p.z) * 180 / Math.PI;
        this.lookEuler.setValue(0, yaw, 0);
        this.enemy.transform.rotationEuler = this.lookEuler;
    }

    private canSeePlayer(checkFieldOfView: boolean): boolean {
        const p = this.enemy.transform.position;
        const target = this.player.transform.position;
        const dx = target.x - p.x;
        const dz = target.z - p.z;
        const distance = Math.hypot(dx, dz);
        if (distance > Math.max(0, this.sightRange)) return false;
        if (checkFieldOfView && distance > 0.001) {
            Laya.Vector3.transformQuat(new Laya.Vector3(0, 0, 1), this.enemy.transform.rotation, this.forward);
            const dot = (this.forward.x * dx + this.forward.z * dz) /
                (Math.hypot(this.forward.x, this.forward.z) * distance);
            if (dot < Math.cos(Math.max(1, Math.min(360, this.fieldOfView)) * Math.PI / 360))
                return false;
        }
        if (distance < 0.7) return true;
        this.setRayTowardPlayer(this.sightRay, 1.65, 0.65);
        const scene = this.enemy.scene as Laya.Scene3D;
        // 玩家由距离和视锥判断；射线只检查墙体等遮挡，跳过敌人自身(64)和玩家(32)。
        return !scene.physicsSimulation.rayCast(this.sightRay, this.sightHit,
            Math.max(0, distance - 0.75), -1,
            ~(Laya.Physics3DUtils.COLLISIONFILTERGROUP_CHARACTERFILTER
                | Laya.Physics3DUtils.COLLISIONFILTERGROUP_CUSTOMFILTER1));
    }

    private fireAtPlayer(): void {
        if (this.clock?.paused || !this.enabled || !this.isAlive || this._state !== "Combat" || !this.playerHealth?.isAlive) return;
        // 一次实际射击对应一次反馈，射线落空或被墙挡住也仍是一次开火。
        this.owner.event(EnemyAI.FIRED, this);
        this.setRayTowardPlayer(this.shotRay, 1.5, 0.65);
        const scene = this.enemy.scene as Laya.Scene3D;
        if (!scene.physicsSimulation.rayCast(this.shotRay, this.shotHit,
            Math.max(1, this.sightRange + 1), -1,
            ~Laya.Physics3DUtils.COLLISIONFILTERGROUP_CUSTOMFILTER1)) return;
        const hitNode = this.shotHit.collider?.owner as Laya.Sprite3D;
        if (hitNode && (hitNode === this.player || this.player.isAncestorOf(hitNode))) {
            this.playerHealth.applyDamage(8, this.enemy.transform.position);
        }
    }

    private setRayTowardPlayer(ray: Laya.Ray, eyeHeight: number, forwardOffset: number): void {
        const p = this.enemy.transform.position;
        const target = this.player.transform.position;
        const dx = target.x - p.x;
        const dz = target.z - p.z;
        const horizontal = Math.hypot(dx, dz);
        const nx = horizontal > 0.001 ? dx / horizontal : 0;
        const nz = horizontal > 0.001 ? dz / horizontal : 1;
        ray.origin.setValue(p.x + nx * forwardOffset, p.y + eyeHeight, p.z + nz * forwardOffset);
        ray.direction.setValue(target.x - ray.origin.x, target.y - ray.origin.y, target.z - ray.origin.z);
        Laya.Vector3.normalize(ray.direction, ray.direction);
    }
}
