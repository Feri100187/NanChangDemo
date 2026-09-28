/** 本地玩法设置；存储不可用时仍保留本次运行的设置。 */
export class GameSettings {
    static readonly defaultVolume = 1;
    static readonly defaultSensitivity = 0.18;
    static readonly defaultReloadVolume = 1;
    static readonly defaultMeleeVolume = 1;
    static readonly minSensitivity = 0.045;
    static readonly maxSensitivity = 0.54;
    private static readonly storageKey = "NanChangDemo.settings.v1";
    private static loaded = false;
    private static _volume = GameSettings.defaultVolume;
    private static _sensitivity = GameSettings.defaultSensitivity;
    private static _reloadVolume = GameSettings.defaultReloadVolume;
    private static _meleeVolume = GameSettings.defaultMeleeVolume;

    static get volume(): number {
        this.load();
        return this._volume;
    }

    static get sensitivity(): number {
        this.load();
        return this._sensitivity;
    }

    static get reloadVolume(): number {
        this.load();
        return this._reloadVolume;
    }

    static get meleeVolume(): number {
        this.load();
        return this._meleeVolume;
    }

    static setVolume(value: number): void {
        this.load();
        this._volume = this.clamp(value, 0, 1, this.defaultVolume);
        this.save();
    }

    static setSensitivity(value: number): void {
        this.load();
        this._sensitivity = this.clamp(value, this.minSensitivity, this.maxSensitivity,
            this.defaultSensitivity);
        this.save();
    }

    static setReloadVolume(value: number): void {
        this.load();
        this._reloadVolume = this.clamp(value, 0, 1, this.defaultReloadVolume);
        this.save();
    }

    static setMeleeVolume(value: number): void {
        this.load();
        this._meleeVolume = this.clamp(value, 0, 1, this.defaultMeleeVolume);
        this.save();
    }

    static reset(): void {
        this.loaded = true;
        this._volume = this.defaultVolume;
        this._sensitivity = this.defaultSensitivity;
        this._reloadVolume = this.defaultReloadVolume;
        this._meleeVolume = this.defaultMeleeVolume;
        this.save();
    }

    private static clamp(value: unknown, min: number, max: number, fallback: number): number {
        return typeof value === "number" && Number.isFinite(value)
            ? Math.max(min, Math.min(max, value)) : fallback;
    }

    private static load(): void {
        if (this.loaded) return;
        this.loaded = true;
        try {
            const saved = JSON.parse(localStorage.getItem(this.storageKey) || "null");
            if (!saved || typeof saved !== "object") return;
            this._volume = this.clamp(saved.volume, 0, 1, this.defaultVolume);
            this._sensitivity = this.clamp(saved.sensitivity, this.minSensitivity,
                this.maxSensitivity, this.defaultSensitivity);
            this._reloadVolume = this.clamp(saved.reloadVolume, 0, 1, this.defaultReloadVolume);
            this._meleeVolume = this.clamp(saved.meleeVolume, 0, 1, this.defaultMeleeVolume);
        } catch (_) {
            // 浏览器禁用存储或数据损坏不能阻止进入游戏。
        }
    }

    private static save(): void {
        try {
            localStorage.setItem(this.storageKey, JSON.stringify({
                volume: this._volume, sensitivity: this._sensitivity,
                reloadVolume: this._reloadVolume, meleeVolume: this._meleeVolume
            }));
        } catch (_) {}
    }
}
