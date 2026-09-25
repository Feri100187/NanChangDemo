const { regClass, property } = Laya;

export interface TargetHitResult {
    damage: number;
    remainingHealth: number;
    killed: boolean;
}

/** 射击靶。碰撞节点使用 Head、Torso、Legs 命名。 */
@regClass()
export class TargetDummy extends Laya.Script {
    @property({ type: Number, caption: "最大血量" })
    maxHealth = 100;

    @property({ type: Number, caption: "复活延迟（秒）" })
    respawnDelaySeconds = 3;

    private _health = 100;
    private hiddenComponents: Array<{ component: Laya.Component; enabled: boolean }> = [];

    get health(): number {
        return this._health;
    }

    get isAlive(): boolean {
        return this._health > 0;
    }

    onAwake(): void {
        this.maxHealth = Number.isFinite(this.maxHealth) ? Math.max(1, this.maxHealth) : 100;
        this._health = this.maxHealth;
    }

    /** 传入射线命中的节点，返回实际扣血量及击杀结果。 */
    applyHit(hitNode: Laya.Sprite3D, baseDamage: number): TargetHitResult {
        if (!this.isAlive || !hitNode || !Number.isFinite(baseDamage) || baseDamage <= 0
            || (hitNode !== this.owner && !this.owner.isAncestorOf(hitNode))) {
            return { damage: 0, remainingHealth: this._health, killed: false };
        }

        const multiplier = this.damageMultiplier(hitNode);
        const damage = Math.min(this._health, baseDamage * multiplier);
        this._health -= damage;
        const killed = this._health <= 0;
        if (killed) {
            this._health = 0;
            this.hideBodyAndColliders();
            this.scheduleRespawn();
        }

        return { damage, remainingHealth: this._health, killed };
    }

    private damageMultiplier(hitNode: Laya.Node): number {
        // 射线可能命中部位的子节点，因此沿层级向上寻找部位名称。
        for (let node: Laya.Node = hitNode; node && node !== this.owner; node = node.parent) {
            const name = node.name.toLowerCase();
            if (name.includes("head")) return 2.5;
            if (name.includes("legs") || name.includes("leg")) return 0.65;
            if (name.includes("torso")) return 1;
        }
        return 1;
    }

    private hideBodyAndColliders(): void {
        this.hiddenComponents = [];
        this.visitTargetNodes(this.owner, node => {
            for (const component of node.components) {
                if (component instanceof Laya.MeshRenderer || component instanceof Laya.PhysicsCollider) {
                    this.hiddenComponents.push({ component, enabled: component.enabled });
                    component.enabled = false;
                }
            }
        });
    }

    private visitTargetNodes(node: Laya.Node, action: (node: Laya.Node) => void): void {
        action(node);
        for (let i = 0; i < node.numChildren; i++) {
            this.visitTargetNodes(node.getChildAt(i), action);
        }
    }

    private scheduleRespawn(): void {
        Laya.timer.clear(this, this.respawn);
        Laya.timer.once(Math.max(0, this.respawnDelaySeconds) * 1000, this, this.respawn);
    }

    private respawn(): void {
        this._health = this.maxHealth;
        for (const { component, enabled } of this.hiddenComponents) component.enabled = enabled;
        this.hiddenComponents = [];
    }

    onEnable(): void {
        if (!this.isAlive) this.scheduleRespawn();
    }

    onDisable(): void {
        Laya.timer.clear(this, this.respawn);
    }

    onDestroy(): void {
        Laya.timer.clear(this, this.respawn);
        this.hiddenComponents = [];
    }
}
