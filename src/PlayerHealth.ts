const { regClass, property } = Laya;

/** 第一版玩家生命值。归零后留在场景中，重新运行场景可重试。 */
@regClass()
export class PlayerHealth extends Laya.Script {
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
    applyDamage(amount: number): number {
        if (!this.isAlive || !Number.isFinite(amount) || amount <= 0) return 0;
        const damage = Math.min(this._health, amount);
        this._health -= damage;
        this.hitFlashUntil = performance.now() + 450;
        this.updateDisplay();
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
            : "生命  0 HP  ·  已阵亡，重新运行场景可重试";
        this.healthText.color = performance.now() < this.hitFlashUntil ? "#ff5959" : "#ffffff";
    }
}
