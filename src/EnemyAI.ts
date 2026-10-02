import { PlayerHealth } from "./PlayerHealth";
import { GameClock } from "./GameClock";
import { EnemyPatrolPoint } from "./EnemyPatrolPoint";

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
    attackInterval = 1.8;
    @property({ type: Number, caption: "步枪单发伤害" })
    shotDamage = 18;
    @property({ type: Number, caption: "巡逻速度" })
    patrolSpeed = 0.75;
    @property({ type: Laya.Sprite3D, caption: "观察点（眼位）" })
    observationPoint: Laya.Sprite3D;
    @property({ type: Laya.Sprite3D, caption: "射击起点（枪口）" })
    shotPoint: Laya.Sprite3D;
    @property({ type: Laya.Sprite3D, caption: "枪口遮挡检查起点（枪膛）" })
    shotBase: Laya.Sprite3D;
    @property({ type: Laya.Vector3, caption: "无观察点时本地眼位" })
    observationOffset = new Laya.Vector3(0, 2.30, 0);
    @property({ type: Laya.Vector3, caption: "无枪口节点时本地枪口" })
    shotOffset = new Laya.Vector3(0.10, 1.84, 0.80);
    @property({ type: Laya.Vector3, caption: "无枪膛节点时本地检查起点" })
    shotBaseOffset = new Laya.Vector3(0.10, 1.84, 0.26);
    @property({ type: [Laya.Sprite3D], caption: "巡逻点（世界坐标）" })
    patrolPoints: Laya.Sprite3D[] = [];
    @property({ type: Number, caption: "巡逻活动半径（出生点周围）" })
    patrolRadius = 1.6;
    @property({ type: Number, caption: "默认巡逻停留（秒）" })
    patrolWaitSeconds = 1.2;
    @property({ type: Number, caption: "转向速度（度/秒）" })
    turnSpeed = 180;

    private _health = 100;
    private _state: EnemyState = "Idle";
    private suspicion = 0;
    private idleElapsed = 0;
    private nextAttackAt = 0;
    private patrolIndex = 0;
    private waitRemaining = 0;
    private blockedElapsed = 0;
    private atPatrolPoint = false;
    private _horizontalSpeed = 0;
    private hasLastKnown = false;
    private lastSeenAt = -Infinity;
    private alertUntil = 0;
    private readonly lastKnownPosition = new Laya.Vector3();
    private enemy: Laya.Sprite3D;
    private playerHealth: PlayerHealth;
    private spawnPosition: Laya.Vector3;
    private readonly patrolOffsets = [0, 1.6, -1.6];
    private readonly forward = new Laya.Vector3();
    private readonly sightRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 0, 1));
    private readonly shotRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, 0, 1));
    private readonly lookEuler = new Laya.Vector3();
    private readonly eye = new Laya.Vector3();
    private readonly muzzle = new Laya.Vector3();
    private readonly breech = new Laya.Vector3();
    private readonly patrolTarget = new Laya.Vector3();
    private readonly moveTo = new Laya.Vector3();
    private readonly sweepFrom = new Laya.Vector3();
    private readonly sweepTo = new Laya.Vector3();
    private readonly hits: Laya.HitResult[] = [];
    private patrolProbe: Laya.BoxColliderShape;

    get health(): number { return this._health; }
    get isAlive(): boolean { return this._health > 0; }
    get state(): EnemyState { return this._state; }
    get horizontalSpeed(): number { return this._horizontalSpeed; }

    onAwake(): void {
        this.enemy = this.owner as Laya.Sprite3D;
        this.spawnPosition = this.enemy.transform.position.clone();
        this.playerHealth = this.player?.getComponent(PlayerHealth);
        this.maxHealth = Number.isFinite(this.maxHealth) ? Math.max(1, this.maxHealth) : 100;
        this._health = this.maxHealth;
        // Query-only envelope: no new collider/rigidbody is added to the scene.
        this.patrolProbe = new Laya.BoxColliderShape(0.84, 2.55, 0.84);
    }

    onUpdate(): void {
        this._horizontalSpeed = 0;
        if (this.clock?.paused || !this.isAlive) return;
        const dt = Math.min(Math.max((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0), 0.05);
        const now = this.clock?.now() ?? performance.now();
        if (!this.player || !this.playerHealth?.isAlive) {
            this.clearPerception();
            if (this._state !== "Idle") this._state = "Patrol";
            this.updatePatrol(dt);
            return;
        }

        const visible = this.canSeePlayer(this._state === "Idle" || this._state === "Patrol");
        if (visible) {
            this.rememberVisiblePlayer(now);
            this.suspicion = Math.min(1, this.suspicion + dt / Math.max(0.1, this.alertTime));
            if (this.suspicion >= 1) {
                if (this._state !== "Combat") this.nextAttackAt = now + 200;
                this._state = "Combat";
            } else this._state = "Alert";
        } else {
            this.suspicion = Math.max(0, this.suspicion - dt / Math.max(0.1, this.loseTargetTime));
            // Being hit can renew vigilance, but never renew a hidden target's
            // position or extend the lifetime of the last visual observation.
            if (now >= this.lastSeenAt + Math.max(0.1, this.loseTargetTime) * 1000)
                this.hasLastKnown = false;
            if (now < this.alertUntil) this._state = "Alert";
            else if (this._state !== "Idle") {
                this.clearPerception();
                this._state = "Patrol";
            }
        }

        if (this._state === "Idle") {
            this.idleElapsed += dt;
            if (this.idleElapsed >= 1.2) this._state = "Patrol";
        } else if (this._state === "Patrol") {
            this.updatePatrol(dt);
        } else {
            const facing = this.hasLastKnown && this.facePosition(this.lastKnownPosition, dt);
            if (this._state === "Combat" && visible && facing && now >= this.nextAttackAt) {
                this.fireAtPlayer();
                this.nextAttackAt = now + Math.max(0.1, this.attackInterval) * 1000;
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
            this.clearPerception();
            this._horizontalSpeed = 0;
            this.disableColliders(this.owner);
            // 先置为 Dead，再通知关卡；后续命中不会再次发出死亡事件。
            this.owner.event(EnemyAI.DIED, this);
        } else if (this.playerHealth?.isAlive) {
            // 中弹即可发现威胁，避免玩家在背后持续射击而敌人仍站岗。
            this.suspicion = Math.max(this.suspicion, 0.25);
            const now = this.clock?.now() ?? performance.now();
            if (this.canSeePlayer(false)) this.rememberVisiblePlayer(now);
            else this.alertUntil = now + Math.max(0.1, this.loseTargetTime) * 1000;
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

    private disableColliders(node: Laya.Node): void {
        for (const component of node.components) {
            if (component instanceof Laya.PhysicsCollider)
                component.enabled = false;
        }
        for (let i = 0; i < node.numChildren; i++) this.disableColliders(node.getChildAt(i));
    }

    private updatePatrol(dt: number): void {
        const position = this.enemy.transform.position;
        const points = this.patrolPoints.filter(node => node && !node.destroyed);
        this.patrolIndex %= points.length || this.patrolOffsets.length;
        const point = points[this.patrolIndex % Math.max(1, points.length)];
        const config = point?.getComponent(EnemyPatrolPoint);
        if (point) point.transform.position.cloneTo(this.patrolTarget);
        else this.patrolTarget.setValue(this.spawnPosition.x + this.patrolOffsets[this.patrolIndex],
            this.spawnPosition.y, this.spawnPosition.z);
        // All routes remain local to the original spawn area, including edited
        // waypoints. No target pursuit and no cross-zone pathfinding.
        let dx = this.patrolTarget.x - this.spawnPosition.x, dz = this.patrolTarget.z - this.spawnPosition.z;
        const radius = Number.isFinite(this.patrolRadius) ? Math.max(0, this.patrolRadius) : 1.6;
        const offset = Math.hypot(dx, dz);
        if (offset > radius) {
            this.patrolTarget.x = this.spawnPosition.x + dx * radius / offset;
            this.patrolTarget.z = this.spawnPosition.z + dz * radius / offset;
        }
        this.patrolTarget.y = this.spawnPosition.y;
        dx = this.patrolTarget.x - position.x; dz = this.patrolTarget.z - position.z;
        const remaining = Math.hypot(dx, dz);
        if (remaining < 0.03) {
            if (!this.atPatrolPoint) {
                this.atPatrolPoint = true;
                this.waitRemaining = Math.max(0, config?.waitSeconds ?? this.patrolWaitSeconds);
            }
            if (point && (config?.useFacing ?? true) && !this.turnToward(point.transform.rotationEuler.y, dt)) return;
            this.waitRemaining = Math.max(0, this.waitRemaining - dt);
            if (this.waitRemaining === 0) {
                this.patrolIndex = (this.patrolIndex + 1) % (points.length || this.patrolOffsets.length);
                this.atPatrolPoint = false;
                this.blockedElapsed = 0;
            }
            return;
        }
        this.atPatrolPoint = false;
        if (!this.turnToward(Math.atan2(dx, dz) * 180 / Math.PI, dt)) return;
        const step = Math.min(remaining, Math.max(0, this.patrolSpeed) * dt);
        if (step <= 0) return;
        this.moveTo.setValue(position.x + dx / remaining * step, this.spawnPosition.y,
            position.z + dz / remaining * step);
        if (!this.patrolSegmentClear(position, this.moveTo)) {
            this.blockedElapsed += dt;
            if (this.blockedElapsed >= 0.6) {
                this.patrolIndex = (this.patrolIndex + 1) % (points.length || this.patrolOffsets.length);
                this.blockedElapsed = 0;
            }
            return;
        }
        this.blockedElapsed = 0;
        this.enemy.transform.position = this.moveTo;
        this._horizontalSpeed = dt > 0 ? step / dt : 0;
    }

    private turnToward(targetYaw: number, dt: number): boolean {
        const yaw = this.enemy.transform.rotationEuler.y;
        const delta = ((targetYaw - yaw + 540) % 360) - 180;
        const turn = Math.max(0, this.turnSpeed) * dt;
        this.lookEuler.setValue(0, yaw + Math.max(-turn, Math.min(turn, delta)), 0);
        this.enemy.transform.rotationEuler = this.lookEuler;
        return Math.abs(delta) <= turn + 0.001;
    }

    private facePosition(target: Laya.Vector3, dt: number): boolean {
        const p = this.enemy.transform.position;
        if (Math.hypot(target.x - p.x, target.z - p.z) > 0.001)
            return this.turnToward(Math.atan2(target.x - p.x, target.z - p.z) * 180 / Math.PI, dt);
        return true;
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
        this.readPoint(this.observationPoint, this.observationOffset, this.eye);
        const hit = this.trace(this.eye, target, this.sightRay);
        return !hit || this.isPlayerNode(hit);
    }

    private fireAtPlayer(): void {
        if (this.clock?.paused || !this.enabled || !this.isAlive || this._state !== "Combat" || !this.playerHealth?.isAlive) return;
        this.readPoint(this.observationPoint, this.observationOffset, this.eye);
        this.readPoint(this.shotBase, this.shotBaseOffset, this.breech);
        this.readPoint(this.shotPoint, this.shotOffset, this.muzzle);
        // Do not start beyond a wall or fire through a blocked barrel. A nearby
        // player intercepted along the barrel is hit without casting backwards
        // from a muzzle already inside/beyond the player's capsule.
        const rootHit = this.trace(this.eye, this.breech, this.shotRay);
        if (rootHit && !this.isPlayerNode(rootHit)) return;
        const barrelHit = this.trace(this.breech, this.muzzle, this.shotRay);
        if (barrelHit && !this.isPlayerNode(barrelHit)) return;
        const targetHit = rootHit || barrelHit || this.trace(this.muzzle, this.player.transform.position, this.shotRay);
        this.owner.event(EnemyAI.FIRED, this);
        if (targetHit && this.isPlayerNode(targetHit)) {
            this.playerHealth.applyDamage(this.shotDamage, this.enemy.transform.position);
        }
    }

    private rememberVisiblePlayer(now: number): void {
        this.player.transform.position.cloneTo(this.lastKnownPosition);
        this.hasLastKnown = true;
        this.lastSeenAt = now;
        this.alertUntil = now + Math.max(0.1, this.loseTargetTime) * 1000;
    }

    private clearPerception(): void {
        this.hasLastKnown = false;
        this.lastSeenAt = -Infinity;
        this.alertUntil = 0;
        this.suspicion = 0;
    }

    private readPoint(node: Laya.Sprite3D, offset: Laya.Vector3, out: Laya.Vector3): void {
        if (node && !node.destroyed) node.transform.position.cloneTo(out);
        else Laya.Vector3.transformCoordinate(offset, this.enemy.transform.worldMatrix, out);
    }

    private isSelf(node: Laya.Node): boolean {
        return !!node && (node === this.owner || this.owner.isAncestorOf(node));
    }

    private isPlayerNode(node: Laya.Node): boolean {
        return !!node && (node === this.player || this.player.isAncestorOf(node));
    }

    /** All-hit queries exclude only this enemy, never the entire enemy group.
     * Laya's result order is unspecified; choose the nearest non-self result. */
    private trace(from: Laya.Vector3, to: Laya.Vector3, ray: Laya.Ray): Laya.Node {
        from.cloneTo(ray.origin);
        Laya.Vector3.subtract(to, from, ray.direction);
        const distance = ray.direction.length();
        if (distance < 0.00001) return null;
        Laya.Vector3.scale(ray.direction, 1 / distance, ray.direction);
        this.hits.length = 0;
        (this.enemy.scene as Laya.Scene3D).physicsSimulation.rayCastAll(ray, this.hits, distance, -1, -1);
        let nearest: Laya.HitResult = null;
        for (const hit of this.hits) {
            if (!hit.collider || this.isSelf(hit.collider.owner)) continue;
            if (!nearest || hit.hitFraction < nearest.hitFraction) nearest = hit;
        }
        // HitResult objects are pooled by the engine. Keep only the node across
        // the consecutive eye/breech/muzzle queries, not a mutable pooled result.
        return nearest?.collider.owner || null;
    }

    private patrolSegmentClear(from: Laya.Vector3, to: Laya.Vector3): boolean {
        this.sweepFrom.setValue(from.x, from.y + 1.28, from.z);
        this.sweepTo.setValue(to.x, to.y + 1.28, to.z);
        this.hits.length = 0;
        (this.enemy.scene as Laya.Scene3D).physicsSimulation.shapeCastAll(this.patrolProbe.shape,
            this.sweepFrom, this.sweepTo, this.hits, null, null, -1, -1);
        const dx = to.x - from.x, dz = to.z - from.z;
        for (const hit of this.hits) {
            if (!hit.collider || this.isSelf(hit.collider.owner)) continue;
            // Ignore the supporting floor and contacts we are leaving, not walls
            // or other actors we are approaching. Stop before entering geometry.
            if (dx * hit.normal.x + dz * hit.normal.z < -0.000001) return false;
        }
        return true;
    }

    onDisable(): void { this._horizontalSpeed = 0; this.clearPerception(); }
    onDestroy(): void { this.patrolProbe?.destroy(); this.hits.length = 0; }
}
