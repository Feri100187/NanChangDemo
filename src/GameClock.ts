/** 由 LevelController 持有；战斗用精确毫秒时间，3D 用同一关卡的可暂停 Timer。 */
export class GameClock {
    readonly timer = new Laya.Timer();
    paused = false;
    private pausedAt = 0;
    private excludedTime = 0;

    now(): number {
        return (this.paused ? this.pausedAt : performance.now()) - this.excludedTime;
    }

    setPaused(value: boolean): void {
        if (this.paused === value) return;
        const now = performance.now();
        if (value) {
            this.pausedAt = now;
            this.timer.pause();
            this.timer.delta = 0;
        } else {
            this.excludedTime += now - this.pausedAt;
            // 3.4.1 Timer.resume 不重置时间戳；先以暂停状态同步，避免窗口隐藏后补步进。
            this.timer._update(now);
            this.timer.resume();
        }
        this.paused = value;
    }

    destroy(): void {
        // Timer.destroy 只清自身回调，自动更新还注册在 systemTimer 上。
        Laya.systemTimer.clearAll(this.timer);
        this.timer.destroy();
    }
}
