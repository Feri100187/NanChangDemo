const { regClass, property } = Laya;

export interface PlayerDamage {
    damage: number;
    sourcePosition?: Laya.Vector3;
}

/** 玩家生命值；归零时通知关卡结算。 */
@regClass()
export class PlayerHealth extends Laya.Script {
    static readonly DIED = "player-died";
    static readonly DAMAGED = "player-damaged";

    @property({ type: Number, caption: "最大生命值" })
    maxHealth = 100;

    @property({ type: Laya.GTextField })
    healthText: Laya.GTextField;

    private _health = 100;
    private hitFlashUntil = 0;

    get health(): number {
        return this._health;
    }

    get isAlive(): boolean {
        return this._health > 0;
    }

    onAwake(): void {
        this.maxHealth = Math.max(1, this.maxHealth);
        this._health = this.maxHealth;
        this.updateDisplay();
    }

    /** 返回实际扣除的血量。 */
    applyDamage(amount: number, sourcePosition?: Laya.Vector3): number {
        if (!this.enabled || !this.isAlive || !Number.isFinite(amount) || amount <= 0) return 0;
        const damage = Math.min(this._health, amount);
        this._health -= damage;
        this.hitFlashUntil = performance.now() + 450;
        this.updateDisplay();
        // 只传受击时的位置快照，不把敌人引用交给 HUD 持续追踪。
        this.owner.event(PlayerHealth.DAMAGED, {
            damage, sourcePosition: sourcePosition?.clone()
        } as PlayerDamage);
        if (!this.isAlive) this.owner.event(PlayerHealth.DIED);
        return damage;
    }

    onUpdate(): void {
        if (this.healthText && performance.now() > this.hitFlashUntil
            && this.healthText.color !== "#ffffff") this.updateDisplay();
    }

    private updateDisplay(): void {
        if (!this.healthText) return;
        this.healthText.text = this.isAlive
            ? `生命  ${this._health.toFixed(0)} / ${this.maxHealth.toFixed(0)} HP`
            : "生命  0 HP  ·  已阵亡";
        this.healthText.color = performance.now() < this.hitFlashUntil ? "#ff5959" : "#ffffff";
    }
}
