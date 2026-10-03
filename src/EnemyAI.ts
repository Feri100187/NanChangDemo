import { LeanMotion } from "./LeanMotion";
import { PlayerController } from "./PlayerController";
import { BotNavigation } from "./BotNavigation";
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

/** 敌我共用：视线感知、巡逻寻路、掩体机动与非锁定射击。 */
@regClass()
export class EnemyAI extends Laya.Script {
    static readonly DIED = "enemy-died";
    static readonly FIRED = "enemy-fired";
    clock: GameClock;
    @property({ type: Boolean, caption: "玩家阵营队友" })
    friendly = false;
    @property({ type: [Laya.Sprite3D], caption: "敌对角色" })
    opponents: Laya.Sprite3D[] = [];
    @property({ type: Number, caption: "战斗移动速度" })
    combatSpeed = 2.2;
    @property({ type: Number, caption: "基础散布半角（度）" })
    spreadDegrees = 3;
    @property({ type: Number, caption: "疾跑速度" })
    sprintSpeed = 9;
    private readonly leaning = new LeanMotion();
    private readonly leanRight = new Laya.Vector3();
    private leanRequest = 0;
    private coverLean = 0;
    private sprinting = false;
    get leanAmount(): number { return this.leaning.value; }
    get isSprinting(): boolean { return this.sprinting; }
    @property({ type: Boolean, caption: "增援预备角色" })
    reinforcement = false;
    private heardUntil = 0;
    private readonly heardPosition = new Laya.Vector3();
    private searchGoal: Laya.Vector3;
    private nextSearchDecision = 0;
    private patrolRunning = false;
    get hasHeardGunfire(): boolean { return (this.clock?.now() ?? performance.now()) < this.heardUntil; }
    /** Only retain the event's position snapshot, never the shooter's live transform. */
    hearGunshot(position: Laya.Vector3): void {
        if (!this.isAlive || !this.enabled) return;
        position.cloneTo(this.heardPosition);
        this.heardUntil = (this.clock?.now() ?? performance.now()) + 20000;
        this.searchGoal = null;
        if (this._state === "Idle" || this._state === "Patrol") this._state = "Alert";
    }
    private aimAtHead = false;
    private target: Laya.Sprite3D;
    private crouching = false;
    private crouchBlend = 0;
    private nextDecision = 0;
    private nextScan = 0;
    private cover: Laya.Vector3;
    private combatGoal: Laya.Vector3;
    private coverPeek: Laya.Vector3;
    private readonly navigation = new BotNavigation();
    private readonly aimPoint = new Laya.Vector3();
    private readonly postureNodes: {node: Laya.Sprite3D; position: Laya.Vector3; scale: Laya.Vector3}[] = [];
    get isCrouching(): boolean { return this.crouching; }


    @property({ type: Laya.Sprite3D, caption: "玩家" })
    player: Laya.Sprite3D;

    @property({ type: Number, caption: "最大血量" })
    maxHealth = 100;
    @property({ type: Number, caption: "视野距离" })
    sightRange = 65;
    @property({ type: Number, caption: "视野角度" })
    fieldOfView = 120;
    @property({ type: Number, caption: "进入战斗所需警戒时间（秒）" })
    alertTime = .2;
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
    private stepProbe: Laya.BoxColliderShape;
    private readonly stepHeight = .25;
    private readonly maxWalkDrop = .5;
    private verticalSpeed = 0;
    private readonly groundRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3(0, -1, 0));
    private readonly groundHits: Laya.HitResult[] = [];
    private readonly walkFrom = new Laya.Vector3();
    private readonly walkTo = new Laya.Vector3();
    private readonly standingEye = new Laya.Vector3();
    private readonly standingBreech = new Laya.Vector3();
    private readonly standingMuzzle = new Laya.Vector3();
    private readonly standingRifle = new Laya.Vector3();
    private actorScale = 1;
    private readonly crouchDrop = .65;

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
        this.choosePatrolPoint();
        for (let i = 0; i < this.enemy.numChildren; i++) {
            const node = this.enemy.getChildAt(i) as Laya.Sprite3D;
            if (["Head", "Torso", "Legs", "LeftArm", "RightArm", "EnemyRifle", "ObservationPoint"].indexOf(node.name) >= 0)
                this.postureNodes.push({node, position: node.transform.localPosition.clone(), scale: node.transform.localScale.clone()});
        }
        // Query-only envelope: no new collider/rigidbody is added to the scene.
        this.actorScale = this.enemy.transform.getWorldLossyScale().y;
        this.patrolProbe = new Laya.BoxColliderShape(.84 * this.actorScale, 2.55 * this.actorScale, .84 * this.actorScale);
        this.stepProbe = new Laya.BoxColliderShape(.84 * this.actorScale,
            2.55 * this.actorScale - this.stepHeight, .84 * this.actorScale);
        // Capture the configured standing geometry, including nested rifle nodes.
        this.cacheStandingPoint(this.observationPoint, this.observationOffset, this.standingEye);
        this.cacheStandingPoint(this.shotBase, this.shotBaseOffset, this.standingBreech);
        this.cacheStandingPoint(this.shotPoint, this.shotOffset, this.standingMuzzle);
        const rifle = this.enemy.getChildByName("EnemyRifle") as Laya.Sprite3D;
        if (rifle) this.cacheStandingPoint(rifle, new Laya.Vector3(), this.standingRifle);
    }

    onUpdate(): void {
        this._horizontalSpeed = 0;
        this.sprinting = false;
        this.leanRequest = 0;
        if (this.clock?.paused || !this.isAlive) return;
        const dt = Math.min(Math.max((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, 0), 0.05);
        const now = this.clock?.now() ?? performance.now();
        this.updateGround(dt);
        this.updatePosture(dt);
        this.updateLean(0);
        if (this.target && !this.targetAlive(this.target)) {
            this.target = null; this.clearPerception(); this.cover = null; this.nextDecision = 0;
        }
        if (now >= this.nextScan) {
            this.selectTarget(); this.nextScan = now + 250;
        }
        if (!this.targetAlive(this.target)) {
            this.crouching = false;
            this.clearPerception();
            this.updateSearch(dt, now);
            this.updateLean(dt);
            return;
        }

        const checkFieldOfView = this._state === "Idle" || this._state === "Patrol";
        let visible = this.canSeePlayer(checkFieldOfView);
        // Movement can use a fresh observation, but suspicion is updated only
        // once, after moving, turning and applying the final lean pose.
        if (visible) {
            this.rememberVisiblePlayer(now);
            if (checkFieldOfView) this._state = "Alert";
        }
        let facing = false;
        if (this._state === "Idle") {
            this.idleElapsed += dt;
            if (this.idleElapsed >= 1.2) this._state = "Patrol";
        } else if (this._state === "Patrol") {
            this.updatePatrol(dt);
        } else {
            this.updateCombatMovement(dt, now, visible);
            facing = this.hasLastKnown && this.facePosition(this.lastKnownPosition, dt);
        }
        this.updateLean(dt);
        visible = this.canSeePlayer(checkFieldOfView);
        if (visible) {
            this.rememberVisiblePlayer(now);
            this.suspicion = Math.min(1, this.suspicion + dt / Math.max(0.1, this.alertTime));
            if (this.suspicion >= 1) {
                this._state = "Combat";
            } else this._state = "Alert";
        } else {
            this.suspicion = Math.max(0, this.suspicion - dt / Math.max(0.1, this.loseTargetTime));
            // Being hit can renew vigilance, but never renew a hidden target's
            // position or extend the lifetime of the last visual observation.
            if (now >= this.lastSeenAt + Math.max(this.cover ? 6 : .1, this.loseTargetTime) * 1000)
                this.hasLastKnown = false;
            if (this.hasLastKnown || now < this.alertUntil) this._state = "Alert";
            else if (this._state !== "Idle") {
                this.clearPerception();
                this._state = this.hasHeardGunfire ? "Alert" : "Patrol";
            }
        }

        if (this._state === "Combat" && visible && facing && now >= this.nextAttackAt) {
            if (this.fireAtPlayer()) this.nextAttackAt = now + Math.max(0.1, this.attackInterval) * 1000;
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
        } else {
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

    private choosePatrolPoint(): void {
        const p = this.enemy?.transform.position;
        const nearby: number[] = [], all: number[] = [];
        this.patrolPoints.forEach((point, index) => {
            if (!point || point.destroyed || index === this.patrolIndex) return;
            all.push(index);
            if (p && Math.hypot(point.transform.position.x-p.x, point.transform.position.z-p.z) <= 20) nearby.push(index);
        });
        const candidates = nearby.length ? nearby : all;
        this.patrolIndex = candidates.length ? candidates[Math.floor(Math.random()*candidates.length)]
            : (this.patrolIndex + 1) % this.patrolOffsets.length;
        this.patrolRunning = Math.random() < .35;
    }

    private updateSearch(dt: number, now: number): void {
        if (!this.hasHeardGunfire) {
            this._state = "Patrol"; this.updatePatrol(dt); return;
        }
        this._state = "Alert";
        const p = this.enemy.transform.position;
        if (!this.searchGoal || now >= this.nextSearchDecision) {
            const near = Math.hypot(p.x-this.heardPosition.x,p.z-this.heardPosition.z) < 4;
            const angle = Math.random()*Math.PI*2, radius = near ? 2 + Math.random()*4 : 1 + Math.random()*2;
            this.searchGoal = new Laya.Vector3(this.heardPosition.x+Math.cos(angle)*radius,p.y,
                this.heardPosition.z+Math.sin(angle)*radius);
            this.nextSearchDecision = now + 4000;
        }
        const far = Math.hypot(p.x-this.searchGoal.x,p.z-this.searchGoal.z) > 8;
        this.moveTowards(this.searchGoal,dt,far ? this.sprintSpeed : this.patrolSpeed,true);
    }

    private updatePatrol(dt: number): void {
        this.crouching = false;
        const position = this.enemy.transform.position;
        const points = this.patrolPoints.filter(node => node && !node.destroyed);
        this.patrolIndex %= points.length || this.patrolOffsets.length;
        const point = points[this.patrolIndex % Math.max(1, points.length)];
        const config = point?.getComponent(EnemyPatrolPoint);
        if (point) point.transform.position.cloneTo(this.patrolTarget);
        else this.patrolTarget.setValue(this.spawnPosition.x + this.patrolOffsets[this.patrolIndex],
            this.spawnPosition.y, this.spawnPosition.z);
        // Patrol radius is configurable: guards stay local; allies use the map-wide route.
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
        if (remaining < 0.2) {
            if (!this.atPatrolPoint) {
                this.atPatrolPoint = true;
                this.waitRemaining = Math.max(0, config?.waitSeconds ?? this.patrolWaitSeconds);
            }
            if (point && (config?.useFacing ?? true) && !this.turnToward(point.transform.rotationEuler.y, dt)) return;
            this.waitRemaining = Math.max(0, this.waitRemaining - dt);
            if (this.waitRemaining === 0) {
                this.choosePatrolPoint();
                this.atPatrolPoint = false;
                this.blockedElapsed = 0;
            }
            return;
        }
        this.atPatrolPoint = false;
        this.moveTowards(this.patrolTarget, dt, this.patrolRunning && remaining > 4 ? this.sprintSpeed : this.patrolSpeed, true);
        this.blockedElapsed = this._horizontalSpeed > .01 ? 0 : this.blockedElapsed + dt;
        if (this.blockedElapsed > 6) {
            this.choosePatrolPoint();
            this.blockedElapsed = 0;
        }
    }

    private targetAlive(node: Laya.Sprite3D): boolean {
        if (!node || node.destroyed || !node.activeInHierarchy) return false;
        return node.getComponent(EnemyAI)?.isAlive ?? node.getComponent(PlayerHealth)?.isAlive ?? false;
    }

    private targetPosition(): Laya.Vector3 {
        if (!this.target) return this.lastKnownPosition;
        this.target.transform.position.cloneTo(this.aimPoint);
        const bot = this.target.getComponent(EnemyAI);
        if (this.aimAtHead) {
            const head = bot ? this.target.getChildByName("Head") as Laya.Sprite3D
                : this.target.getComponent(PlayerController)?.followCamera;
            if (head) { head.transform.position.cloneTo(this.aimPoint); return this.aimPoint; }
        }
        if (bot) {
            if (Math.abs(bot.leanAmount) > .05 && bot.observationPoint) bot.observationPoint.transform.position.cloneTo(this.aimPoint);
            else this.aimPoint.y += 1.65 * bot.actorScale - bot.crouchBlend * bot.crouchDrop;
        } else {
            const player = this.target.getComponent(PlayerController);
            if (player && Math.abs(player.leanAmount) > .05) player.followCamera.transform.position.cloneTo(this.aimPoint);
        }
        return this.aimPoint;
    }

    private selectTarget(): void {
        const old = this.target;
        let best = this.targetAlive(old) ? old : null, score = Infinity;
        const candidates = this.friendly ? this.opponents : [this.player, ...this.opponents];
        for (const candidate of candidates) {
            if (!this.targetAlive(candidate)) continue;
            const bot = candidate.getComponent(EnemyAI);
            if (bot && bot.friendly === this.friendly) continue;
            this.target = candidate;
            if (!this.canSeePlayer(this._state === "Idle" || this._state === "Patrol")) continue;
            const a = this.enemy.transform.position, b = candidate.transform.position;
            const distance = Math.hypot(a.x - b.x, a.z - b.z) * (candidate === old ? .75 : 1);
            if (distance < score) { score = distance; best = candidate; }
        }
        this.target = best;
        if (old !== best) { this.clearPerception(); this.cover = null; this.nextDecision = 0; }
    }

    private moveTowards(goal: Laya.Vector3, dt: number, speed: number, face: boolean): void {
        const p = this.enemy.transform.position;
        const next = this.navigation.step(p, goal, this.clock?.now() ?? performance.now(),
            (a, b) => this.walkSegmentClear(a, b, true));
        const dx = next.x - p.x, dz = next.z - p.z, distance = Math.hypot(dx, dz);
        if (distance < .001) return;
        if (face && !this.turnToward(Math.atan2(dx, dz) * 180 / Math.PI, dt)) return;
        const step = Math.min(distance, Math.max(0, speed) * dt);
        this.moveTo.setValue(p.x + dx / distance * step, p.y, p.z + dz / distance * step);
        if (!this.walkSegmentClear(p, this.moveTo)) {
            // Rebuild stale geometry routes, but keep routes blocked only by actors.
            if (!this.walkSegmentClear(p, this.moveTo, true)) this.navigation.invalidate();
            // Yield around a team-mate instead of permanently queuing on the same route edge.
            const side = this.patrolIndex % 2 ? 1 : -1;
            this.moveTo.setValue(p.x - dz / distance * step * side, p.y, p.z + dx / distance * step * side);
            if (!this.walkSegmentClear(p, this.moveTo)) return;
        }
        const ground = this.groundHeight(this.moveTo, this.maxWalkDrop);
        if (ground !== null) this.moveTo.y = ground;
        this.enemy.transform.position = this.moveTo;
        this._horizontalSpeed = dt > 0 ? step / dt : 0;
        this.sprinting = this._horizontalSpeed > this.combatSpeed + .1;
    }

    private updateCombatMovement(dt: number, now: number, visible: boolean): void {
        if (!this.hasLastKnown) { this.crouching = false; this.updateSearch(dt, now); return; }
        const p = this.enemy.transform.position;
        if (now >= this.nextDecision) {
            this.nextDecision = now + 3500 + Math.random() * 1500;
            this.cover = null; this.coverPeek = null; this.coverLean = 0;
            // Look for reachable locations whose low torso is occluded from the last observed threat.
            for (let i = 0; i < 24; i++) {
                const angle = Math.random() * Math.PI * 2, radius = 1 + Math.random() * 2.5;
                const q = new Laya.Vector3(p.x + Math.cos(angle) * radius, p.y, p.z + Math.sin(angle) * radius);
                if (!this.walkSegmentClear(p, q, true)) continue;
                const ground = this.groundHeight(q, this.maxWalkDrop);
                if (ground === null) continue;
                q.y = ground;
                const low = new Laya.Vector3(q.x, q.y + .9, q.z);
                const obstacle = this.trace(low, this.lastKnownPosition, this.sightRay);
                if (!obstacle || this.actorNode(obstacle)) continue;
                for (const side of (Math.random() < .5 ? [-1, 1, 0] : [1, -1, 0])) {
                    const dx = this.lastKnownPosition.x - q.x, dz = this.lastKnownPosition.z - q.z;
                    const d = Math.max(.01, Math.hypot(dx, dz));
                    const peek = new Laya.Vector3(q.x + dz / d * side * LeanMotion.distance, q.y, q.z - dx / d * side * LeanMotion.distance);
                    const yaw = Math.atan2(dx, dz);
                    if (!this.coverCanFire(q, yaw, -side, this.lastKnownPosition)) continue;
                    this.cover = q; this.coverPeek = peek; this.coverLean = -side; break;
                }
                if (this.cover) break;
            }
            const dx = this.lastKnownPosition.x - p.x, dz = this.lastKnownPosition.z - p.z;
            const distance = Math.max(.01, Math.hypot(dx, dz)), side = Math.random() < .5 ? -1 : 1;
            this.combatGoal = this.cover || new Laya.Vector3(
                p.x + (distance > 15 ? dx / distance * 3 : 0) + dz / distance * side * 2,
                p.y, p.z + (distance > 15 ? dz / distance * 3 : 0) - dx / distance * side * 2);
        }
        const inCover = this.cover && Math.hypot(p.x - this.cover.x, p.z - this.cover.z) < .3;
        // Alternate crouched protection and standing exposure; no perpetual crouching behind an opaque wall.
        this.crouching = !!inCover && this.nextDecision - now > 2200;
        if (!visible && !this.cover) this.combatGoal = new Laya.Vector3(this.lastKnownPosition.x, p.y, this.lastKnownPosition.z);
        if (this.cover) {
            this.combatGoal = this.cover;
            if (inCover && !this.crouching) this.leanRequest = this.coverLean;
        }
        if (this.combatGoal) {
            const distance = Math.hypot(this.combatGoal.x-p.x,this.combatGoal.z-p.z);
            const rush = !visible && !this.crouching && (this.cover ? distance > 2.5 : distance > 8);
            this.moveTowards(this.combatGoal, dt, rush ? this.sprintSpeed : this.combatSpeed * (this.crouching ? .55 : 1), false);
        }
    }

    private actorNode(node: Laya.Node): boolean {
        for (let n = node; n; n = n.parent)
            if (n.getComponent(EnemyAI) || n.getComponent(PlayerHealth)) return true;
        return false;
    }

    private updateLean(dt: number): void {
        // Always limit and apply from the unleaned posture; calls in the same
        // frame must never accumulate offsets on the eye or rifle.
        this.updatePosture(0);
        this.readPoint(this.observationPoint, this.observationOffset, this.eye, false);
        Laya.Vector3.transformQuat(new Laya.Vector3(-1,0,0), this.enemy.transform.rotation, this.leanRight);
        this.leaning.update(this.sprinting ? 0 : this.leanRequest, dt, this.enemy, this.eye, this.leanRight);
        for (const item of this.postureNodes) {
            if (item.node.name === "Legs") continue;
            const p = item.node.transform.localPosition.clone();
            p.x -= this.leanAmount * LeanMotion.distance / this.actorScale * (item.node.name === "Torso" ? .5 : 1);
            item.node.transform.localPosition = p;
            if (item.node.name === "EnemyRifle") item.node.transform.localRotationEuler = new Laya.Vector3(0,0,this.leanAmount * LeanMotion.angle);
        }
    }

    private cacheStandingPoint(node: Laya.Sprite3D, offset: Laya.Vector3, out: Laya.Vector3): void {
        this.readPoint(node, offset, out, false);
        Laya.Vector3.subtract(out, this.enemy.transform.position, out);
        const inverse = new Laya.Quaternion();
        Laya.Quaternion.invert(this.enemy.transform.rotation, inverse);
        Laya.Vector3.transformQuat(out, inverse, out);
    }

    private coverPoint(offset: Laya.Vector3, position: Laya.Vector3, yaw: number, lean: number, rifle = false): Laya.Vector3 {
        let x = offset.x, y = offset.y;
        if (rifle) {
            const roll = lean * LeanMotion.angle * Math.PI / 180;
            const rx = x - this.standingRifle.x, ry = y - this.standingRifle.y;
            x = this.standingRifle.x + rx * Math.cos(roll) - ry * Math.sin(roll);
            y = this.standingRifle.y + rx * Math.sin(roll) + ry * Math.cos(roll);
        }
        x -= lean * LeanMotion.distance;
        return new Laya.Vector3(position.x + x * Math.cos(yaw) + offset.z * Math.sin(yaw),
            position.y + y, position.z - x * Math.sin(yaw) + offset.z * Math.cos(yaw));
    }

    private coverCanFire(position: Laya.Vector3, yaw: number, lean: number, target: Laya.Vector3): boolean {
        const baseEye = this.coverPoint(this.standingEye, position, yaw, 0);
        const eye = this.coverPoint(this.standingEye, position, yaw, lean);
        // A theoretical peek is useful only if the actual head sweep permits it.
        if (this.leaning.limit(this.enemy, baseEye, eye) < .999) return false;
        const breech = this.coverPoint(this.standingBreech, position, yaw, lean, !!this.shotBase);
        const muzzle = this.coverPoint(this.standingMuzzle, position, yaw, lean, !!this.shotPoint);
        for (const [from, to] of [[eye, target], [eye, breech], [breech, muzzle], [muzzle, target]]) {
            const hit = this.trace(from, to, this.shotRay);
            if (hit && !this.isPlayerNode(hit)) return false;
        }
        return true;
    }

    private updatePosture(dt: number): void {
        this.crouchBlend += Math.max(-dt * 4, Math.min(dt * 4, (this.crouching ? 1 : 0) - this.crouchBlend));
        for (const item of this.postureNodes) {
            const p = item.position.clone(), scale = item.scale.clone();
            if (item.node.name === "Legs") { p.y *= 1 - this.crouchBlend * .5; scale.y *= 1 - this.crouchBlend * .5; }
            else p.y -= this.crouchBlend * this.crouchDrop / this.actorScale;
            item.node.transform.localPosition = p; item.node.transform.localScale = scale;
        }
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
        if (!this.targetAlive(this.target)) return false;
        const p = this.enemy.transform.position;
        this.aimAtHead = false;
        const target = this.targetPosition();
        const dx = target.x - p.x;
        const dz = target.z - p.z;
        const distance = Math.hypot(dx, dz);
        if (distance > Math.max(0, this.sightRange)) return false;
        if (checkFieldOfView && distance > 6) {
            Laya.Vector3.transformQuat(new Laya.Vector3(0, 0, 1), this.enemy.transform.rotation, this.forward);
            const dot = (this.forward.x * dx + this.forward.z * dz) /
                (Math.hypot(this.forward.x, this.forward.z) * distance);
            if (dot < Math.cos(Math.max(1, Math.min(360, this.fieldOfView)) * Math.PI / 360))
                return false;
        }
        this.readPoint(this.observationPoint, this.observationOffset, this.eye);
        const hit = this.trace(this.eye, target, this.sightRay);
        if (!hit || this.isPlayerNode(hit)) return true;
        // A visible head over low cover is enough to engage; aim at the exposed part.
        this.aimAtHead = true;
        const headHit = this.trace(this.eye, this.targetPosition(), this.sightRay);
        return !headHit || this.isPlayerNode(headHit);
    }

    private fireAtPlayer(): boolean {
        if (this.clock?.paused || this.sprinting || !this.enabled || !this.isAlive || this._state !== "Combat" || !this.targetAlive(this.target)) return false;
        this.readPoint(this.observationPoint, this.observationOffset, this.eye);
        this.readPoint(this.shotBase, this.shotBaseOffset, this.breech);
        this.readPoint(this.shotPoint, this.shotOffset, this.muzzle);
        // Do not start beyond a wall or fire through a blocked barrel. A nearby
        // player intercepted along the barrel is hit without casting backwards
        // from a muzzle already inside/beyond the player's capsule.
        const rootHit = this.trace(this.eye, this.breech, this.shotRay);
        if (rootHit && !this.isPlayerNode(rootHit)) return false;
        const barrelHit = this.trace(this.breech, this.muzzle, this.shotRay);
        if (barrelHit && !this.isPlayerNode(barrelHit)) return false;
        const aim = this.targetPosition().clone();
        const distance = Math.max(1, Math.hypot(aim.x - this.muzzle.x, aim.y - this.muzzle.y, aim.z - this.muzzle.z));
        // Uniform disk in the plane perpendicular to the shot; never snap the hit to the target.
        const yaw = Math.atan2(aim.x - this.muzzle.x, aim.z - this.muzzle.z);
        const pitch = Math.atan2(aim.y - this.muzzle.y, Math.hypot(aim.x - this.muzzle.x, aim.z - this.muzzle.z));
        const spread = Math.max(.1, this.spreadDegrees) * (this._horizontalSpeed > .1 ? 1.7 : 1) * (this.crouching ? .65 : 1);
        const radius = Math.sqrt(Math.random()) * Math.tan(spread * Math.PI / 180) * distance;
        const angle = Math.random() * Math.PI * 2, h = Math.cos(angle) * radius, v = Math.sin(angle) * radius;
        aim.x += Math.cos(yaw) * h - Math.sin(yaw) * Math.sin(pitch) * v;
        aim.z += -Math.sin(yaw) * h - Math.cos(yaw) * Math.sin(pitch) * v;
        aim.y += Math.cos(pitch) * v;
        // Continue beyond the aim plane so misses can strike scenery or other hostile actors.
        Laya.Vector3.subtract(aim, this.muzzle, this.shotRay.direction);
        Laya.Vector3.normalize(this.shotRay.direction, this.shotRay.direction);
        Laya.Vector3.scale(this.shotRay.direction, Math.max(60, this.sightRange), aim);
        Laya.Vector3.add(this.muzzle, aim, aim);
        const targetHit = rootHit || barrelHit || this.trace(this.muzzle, aim, this.shotRay);
        this.owner.event(EnemyAI.FIRED, this);
        if (!targetHit) return true;
        for (let node = targetHit; node; node = node.parent) {
            const bot = node.getComponent(EnemyAI);
            if (bot) {
                if (bot.friendly !== this.friendly) bot.applyHit(targetHit as Laya.Sprite3D, this.shotDamage);
                return true;
            }
            const health = node.getComponent(PlayerHealth);
            if (health) {
                if (!this.friendly) health.applyDamage(this.shotDamage, this.enemy.transform.position);
                return true;
            }
        }
        return true;
    }

    private rememberVisiblePlayer(now: number): void {
        this.targetPosition().cloneTo(this.lastKnownPosition);
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

    private readPoint(node: Laya.Sprite3D, offset: Laya.Vector3, out: Laya.Vector3, leaned = true): void {
        if (node && !node.destroyed) node.transform.position.cloneTo(out);
        else {
            Laya.Vector3.transformCoordinate(offset, this.enemy.transform.worldMatrix, out);
            const yaw = this.enemy.transform.rotationEuler.y * Math.PI / 180;
            if (leaned) {
                out.x -= Math.cos(yaw) * this.leanAmount * LeanMotion.distance;
                out.z += Math.sin(yaw) * this.leanAmount * LeanMotion.distance;
            }
            out.y -= this.crouchBlend * this.crouchDrop;
        }
    }

    private isSelf(node: Laya.Node): boolean {
        return !!node && (node === this.owner || this.owner.isAncestorOf(node));
    }

    private isPlayerNode(node: Laya.Node): boolean {
        return !!node && !!this.target && (node === this.target || this.target.isAncestorOf(node));
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

    private groundHeight(position: Laya.Vector3, maxDrop: number): number {
        this.groundRay.origin.setValue(position.x, position.y + this.stepHeight + .02, position.z);
        this.groundHits.length = 0;
        (this.enemy.scene as Laya.Scene3D).physicsSimulation.rayCastAll(this.groundRay, this.groundHits,
            this.stepHeight + .02 + maxDrop, -1, -1);
        let nearest: Laya.HitResult = null;
        for (const hit of this.groundHits) {
            const node = hit.collider?.owner;
            if (!node || node.getComponent(Laya.PhysicsCollider)?.isTrigger
                || this.isSelf(node) || this.actorNode(node) || hit.normal.y < .6) continue;
            if (!nearest || hit.hitFraction < nearest.hitFraction) nearest = hit;
        }
        return nearest ? nearest.point.y : null;
    }

    private updateGround(dt: number): void {
        const p = this.enemy.transform.position;
        const fall = Math.min(20, this.verticalSpeed + 9.8 * dt);
        const distance = fall * dt;
        const ground = this.groundHeight(p, Math.max(.1, distance));
        if (ground !== null) {
            this.moveTo.setValue(p.x, ground, p.z);
            // A low floor is walkable; a ceiling still blocks an upward correction.
            if (ground > p.y && !this.walkSegmentClear(p, this.moveTo, true)) return;
            this.enemy.transform.position = this.moveTo;
            this.verticalSpeed = 0;
        } else {
            this.verticalSpeed = fall;
            this.moveTo.setValue(p.x, p.y - distance, p.z);
            if (this.patrolSegmentClear(p, this.moveTo)) this.enemy.transform.position = this.moveTo;
            else this.verticalSpeed = 0;
        }
    }

    /** Sample support heights along each route edge, allowing only small steps.
     * The upper-body envelope keeps the original head clearance; the bottom
     * stepHeight is handled by support rays rather than treating a riser as a wall. */
    private walkSegmentClear(from: Laya.Vector3, to: Laya.Vector3, ignoreActors = false): boolean {
        const count = Math.max(1, Math.ceil(Math.hypot(to.x - from.x, to.z - from.z) / .5));
        from.cloneTo(this.walkFrom);
        for (let i = 1; i <= count; i++) {
            this.walkTo.setValue(from.x + (to.x - from.x) * i / count, this.walkFrom.y,
                from.z + (to.z - from.z) * i / count);
            const ground = this.groundHeight(this.walkTo, this.maxWalkDrop);
            if (ground === null) return false;
            this.walkTo.y = ground;
            const center = 1.28 * this.actorScale + this.stepHeight / 2;
            this.sweepFrom.setValue(this.walkFrom.x, this.walkFrom.y + center, this.walkFrom.z);
            this.sweepTo.setValue(this.walkTo.x, this.walkTo.y + center, this.walkTo.z);
            this.hits.length = 0;
            (this.enemy.scene as Laya.Scene3D).physicsSimulation.shapeCastAll(this.stepProbe.shape,
                this.sweepFrom, this.sweepTo, this.hits, null, null, -1, -1);
            for (const hit of this.hits) {
                if (!hit.collider || this.isSelf(hit.collider.owner)) continue;
                if (ignoreActors && this.actorNode(hit.collider.owner)) continue;
                if (hit.normal.y > .95 && hit.point.y <= Math.max(this.walkFrom.y, this.walkTo.y) + .02) continue;
                return false;
            }
            this.walkTo.cloneTo(this.walkFrom);
        }
        return true;
    }

    private patrolSegmentClear(from: Laya.Vector3, to: Laya.Vector3, ignoreActors = false): boolean {
        this.sweepFrom.setValue(from.x, from.y + 1.28 * this.actorScale, from.z);
        this.sweepTo.setValue(to.x, to.y + 1.28 * this.actorScale, to.z);
        this.hits.length = 0;
        (this.enemy.scene as Laya.Scene3D).physicsSimulation.shapeCastAll(this.patrolProbe.shape,
            this.sweepFrom, this.sweepTo, this.hits, null, null, -1, -1);
        for (const hit of this.hits) {
            if (!hit.collider || this.isSelf(hit.collider.owner)) continue;
            if (ignoreActors && this.actorNode(hit.collider.owner)) continue;
            // Bullet's sweep already excludes contacts we are moving away from.
            // Laya 3.4.1 negates the returned normal.x but not the sweep positions;
            // a second direction/normal test therefore let X-facing walls through.
            // Only discard a horizontal support face at foot level. Every other
            // swept contact blocks the entire step, including the avoidance step.
            if (hit.normal.y > .95 && hit.point.y <= Math.min(from.y, to.y) + .08) continue;
            return false;
        }
        return true;
    }

    onDisable(): void { this.heardUntil = 0; this._horizontalSpeed = 0; this.clearPerception(); }
    onDestroy(): void {
        this.leaning.destroy(); this.patrolProbe?.destroy(); this.stepProbe?.destroy();
        this.hits.length = 0; this.groundHits.length = 0;
    }
}
