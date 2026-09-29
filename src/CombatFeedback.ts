import { EnemyAI } from "./EnemyAI";
import { PlayerDamage, PlayerHealth } from "./PlayerHealth";
import { RifleController } from "./RifleController";
import { GameSettings } from "./GameSettings";

const { regClass, property } = Laya;

/** 可选的关卡反馈；枪声与闪光订阅开火，装填与轻重挥刀订阅对应动作。 */
@regClass()
export class CombatFeedback extends Laya.Script {
    @property({ type: Laya.Sprite3D })
    player: Laya.Sprite3D;
    @property({ type: Laya.Camera })
    viewCamera: Laya.Camera;
    @property({ type: Laya.Sprite3D })
    playerFlash: Laya.Sprite3D;
    @property({ type: [Laya.Sprite3D] })
    enemies: Laya.Sprite3D[] = [];
    @property({ type: [Laya.Sprite3D], caption: "与敌人顺序对应的枪口闪光" })
    enemyFlashes: Laya.Sprite3D[] = [];
    @property({ type: String, isAsset: true, assetTypeFilter: "Audio" })
    playerShotSound = "";
    @property({ type: String, isAsset: true, assetTypeFilter: "Audio" })
    enemyShotSound = "";
    @property({ type: String, isAsset: true, assetTypeFilter: "Audio" })
    reloadSound = "";
    @property({ type: String, isAsset: true, assetTypeFilter: "Audio" })
    meleeSound = "";
    @property({ type: String, isAsset: true, assetTypeFilter: "Audio" })
    heavyMeleeSound = "";
    @property({ type: Number, caption: "玩家枪声音量（0～1）" })
    playerVolume = 0.3;
    @property({ type: Number, caption: "敌人枪声音量（0～1）" })
    enemyVolume = 0.22;
    @property({ type: Number, caption: "装填音基础音量（0～1）" })
    reloadVolume = 0.42;
    @property({ type: Number, caption: "挥刀音基础音量（0～1）" })
    meleeVolume = 0.45;
    @property({ type: Number, caption: "枪口闪光时长（秒）" })
    flashSeconds = 0.045;
    @property({ type: Laya.GBox })
    damageEdges: Laya.GBox;
    @property({ type: Laya.GTextField })
    damageDirection: Laya.GTextField;
    @property({ type: Number, caption: "受击边缘强度（0～1）" })
    damageEdgeOpacity = 0.2;
    @property({ type: Number, caption: "受击边缘时长（秒）" })
    damageSeconds = 0.35;
    @property({ type: Number, caption: "方向提示时长（秒）" })
    directionSeconds = 0.7;

    private running = false;
    private paused = false;
    private generation = 0;
    private audioReady = false;
    private audioGesture = 0;
    private canvas: HTMLCanvasElement;
    private readonly soundUrls = new Map<string, string>();
    private readonly soundDurationsMs = new Map<string, number>();
    private readonly channels = new Map<Laya.SoundChannel, number>();
    private reloadChannel: Laya.SoundChannel;
    private readonly flashes = new Map<Laya.Sprite3D, number>();
    private readonly forward = new Laya.Vector3();
    private damageUntil = 0;
    private directionUntil = 0;
    private damageAngle = 0;

    onAwake(): void {
        this.canvas = Laya.Browser.mainCanvas.source;
        this.clearTransient();
        this.layoutFeedback();
    }

    onEnable(): void {
        this.running = true;
        const generation = ++this.generation;
        this.player?.on(RifleController.FIRED, this, this.onPlayerShot);
        this.player?.on(RifleController.RELOAD_STARTED, this, this.onReload);
        this.player?.on(RifleController.RELOAD_ENDED, this, this.onReloadEnded);
        this.player?.on(RifleController.MELEE_SWUNG, this, this.onMelee);
        this.player?.on(RifleController.MELEE_HEAVY_SWUNG, this, this.onHeavyMelee);
        this.player?.on(PlayerHealth.DAMAGED, this, this.onPlayerDamaged);
        for (const enemy of new Set(this.enemies)) {
            enemy?.on(EnemyAI.FIRED, this, this.onEnemyShot);
            enemy?.on(EnemyAI.DIED, this, this.onEnemyDied);
        }
        Laya.stage.on(Laya.Event.RESIZE, this, this.layoutFeedback);
        this.canvas.addEventListener("pointerup", this.unlockAudio, true);
        window.addEventListener("blur", this.suspend);
        document.addEventListener("visibilitychange", this.onVisibilityChange);
        void this.prepareSound(this.playerShotSound, generation);
        void this.prepareSound(this.enemyShotSound, generation);
        void this.prepareSound(this.reloadSound, generation);
        void this.prepareSound(this.meleeSound, generation);
        void this.prepareSound(this.heavyMeleeSound, generation);
    }

    private isCurrent(generation: number): boolean {
        return !this.destroyed && this.running && this.generation === generation;
    }

    private async prepareSound(source: string, generation: number): Promise<void> {
        if (!source) return;
        try {
            const url = await Laya.AssetDb.inst.resolveURL(source);
            if (!url || !this.isCurrent(generation)) return;
            if (Laya.PAL.media.audioCtx) {
                const buffer = await Laya.loader.load(url, Laya.Loader.SOUND) as AudioBuffer;
                if (!buffer || !this.isCurrent(generation)) return;
                if (Number.isFinite(buffer.duration) && buffer.duration > 0)
                    this.soundDurationsMs.set(source, buffer.duration * 1000);
                // 3.4.1 SoundManager 使用同一个引擎音频缓存，预热后开火无需等待解码。
                Laya.PAL.media.audioDataCache.add(url, buffer, buffer.length * buffer.numberOfChannels * 4);
            }
            if (this.isCurrent(generation)) this.soundUrls.set(source, url);
            // 加载完成仅登记资源，绝不补播加载期间的音效。
        } catch (_) {
            // 声音缺失或解码失败不能影响射击、伤害与关卡流程。
        }
    }

    private readonly unlockAudio = () => {
        if (!this.running || document.hidden) return;
        const generation = this.generation;
        const gesture = ++this.audioGesture;
        const context = Laya.PAL.media.audioCtx;
        if (!context || context.state === "running") {
            this.audioReady = true;
        } else if (context.state !== "closed") {
            context.resume().then(() => {
                if (this.isCurrent(generation) && this.audioGesture === gesture)
                    this.audioReady = context.state === "running";
            }).catch(() => {});
        }
    };

    private playShot(source: string, volume: number, fallbackDurationMs = 1800): Laya.SoundChannel {
        // 设置音量作为倍率，保留玩家与敌人各自配置的相对音量。
        volume *= GameSettings.volume;
        const url = this.soundUrls.get(source);
        if (this.paused || !this.running || !this.audioReady || document.hidden || !url || volume <= 0) return;
        let channel: Laya.SoundChannel;
        try {
            channel = Laya.SoundManager.playSound(url, 1, () => {
                this.channels.delete(channel);
                if (this.reloadChannel === channel) this.reloadChannel = null;
            });
            if (!channel || channel.isStopped) return;
            channel.volume = Math.max(0, Math.min(1, volume));
            // 实录枪声有完整尾音，不能再按旧占位音的 250ms 截断。
            // 解码长度用于兜底清理；正常结束由引擎回调处理，暂停/取消仍立即停止。
            const duration = this.soundDurationsMs.get(source) ?? fallbackDurationMs;
            this.channels.set(channel, performance.now() + duration + 150);
            return channel;
        } catch (_) {
            if (channel) this.stopChannel(channel);
        }
    }

    private stopChannel(channel: Laya.SoundChannel): void {
        this.channels.delete(channel);
        if (this.reloadChannel === channel) this.reloadChannel = null;
        channel.completeHandler = null;
        // stop 同步撤销 3.4.1 声道的 started 状态，晚到的加载/恢复回调不能再播放。
        try { channel.stop(); } catch (_) {}
    }

    private flash(node: Laya.Sprite3D): void {
        if (this.paused || !this.running || !node || node.destroyed || document.hidden || this.flashSeconds <= 0) return;
        node.active = true;
        this.flashes.set(node, performance.now() + Math.max(0.01, this.flashSeconds) * 1000);
    }

    private onPlayerShot(): void {
        this.flash(this.playerFlash);
        this.playShot(this.playerShotSound, this.playerVolume);
    }

    private onReload(): void {
        this.onReloadEnded();
        this.reloadChannel = this.playShot(this.reloadSound, this.reloadVolume * GameSettings.reloadVolume, 3400);
    }

    private onReloadEnded(): void {
        if (this.reloadChannel) this.stopChannel(this.reloadChannel);
    }

    private onMelee(): void {
        this.playShot(this.meleeSound, this.meleeVolume * GameSettings.meleeVolume, 550);
    }

    private onHeavyMelee(): void {
        this.playShot(this.heavyMeleeSound, this.meleeVolume * GameSettings.meleeVolume, 800);
    }

    private onEnemyShot(enemy: EnemyAI): void {
        const index = this.enemies.indexOf(enemy.owner as Laya.Sprite3D);
        if (index < 0) return;
        this.flash(this.enemyFlashes[index]);
        this.playShot(this.enemyShotSound, this.enemyVolume);
    }

    private onEnemyDied(enemy: EnemyAI): void {
        const flash = this.enemyFlashes[this.enemies.indexOf(enemy.owner as Laya.Sprite3D)];
        if (flash && !flash.destroyed) flash.active = false;
        this.flashes.delete(flash);
    }

    private onPlayerDamaged(hit: PlayerDamage): void {
        if (this.paused || !this.running || document.hidden || !(hit.damage > 0)) return;
        const now = performance.now();
        this.damageUntil = now + Math.max(0, this.damageSeconds) * 1000;
        this.directionUntil = 0;
        const source = hit.sourcePosition;
        if (source && this.viewCamera) {
            const camera = this.viewCamera.transform.position;
            const dx = source.x - camera.x, dz = source.z - camera.z;
            this.viewCamera.transform.getForward(this.forward);
            const length = Math.hypot(this.forward.x, this.forward.z);
            if (Math.hypot(dx, dz) > 0.001 && length > 0.001 && Number.isFinite(dx + dz)) {
                const front = (dx * this.forward.x + dz * this.forward.z) / length;
                const right = (-dx * this.forward.z + dz * this.forward.x) / length;
                this.damageAngle = Math.atan2(right, front);
                this.directionUntil = now + Math.max(0, this.directionSeconds) * 1000;
                this.placeDirection();
            }
        }
        this.updateDamage(now);
    }

    private updateDamage(now: number): void {
        if (this.damageEdges && !this.damageEdges.destroyed) {
            this.damageEdges.visible = now < this.damageUntil;
            this.damageEdges.alpha = Math.max(0, Math.min(1, this.damageEdgeOpacity))
                * Math.max(0, (this.damageUntil - now) / Math.max(1, this.damageSeconds * 1000));
        }
        if (this.damageDirection && !this.damageDirection.destroyed) {
            this.damageDirection.visible = now < this.directionUntil;
            this.damageDirection.alpha = Math.max(0,
                Math.min(1, (this.directionUntil - now) / Math.max(1, this.directionSeconds * 600)));
        }
    }

    private placeDirection(): void {
        if (!this.damageDirection || this.damageDirection.destroyed) return;
        const radius = Math.min(96, Laya.stage.width * 0.2, Laya.stage.height * 0.2);
        this.damageDirection.pivotX = this.damageDirection.width / 2;
        this.damageDirection.pivotY = this.damageDirection.height / 2;
        this.damageDirection.pos(Laya.stage.width / 2 + Math.sin(this.damageAngle) * radius,
            Laya.stage.height / 2 - Math.cos(this.damageAngle) * radius);
        this.damageDirection.rotation = this.damageAngle * 180 / Math.PI;
        // 只使用受击瞬间的相机方向快照；这里不保存、查询或跟随攻击者。
    }

    private layoutFeedback(): void {
        if (this.damageEdges && !this.damageEdges.destroyed) {
            const width = Laya.stage.width, height = Laya.stage.height;
            this.damageEdges.size(width, height);
            const g = this.damageEdges.graphics;
            g.clear();
            const band = Math.min(6, height * 0.012);
            for (let i = 0; i < 4; i++) {
                const inset = i * band;
                const color = `rgba(235,55,55,${1 - i * 0.23})`;
                g.drawRect(inset, inset, width - inset * 2, band, color);
                g.drawRect(inset, height - inset - band, width - inset * 2, band, color);
                g.drawRect(inset, inset + band, band, height - (inset + band) * 2, color);
                g.drawRect(width - inset - band, inset + band, band, height - (inset + band) * 2, color);
            }
        }
        this.placeDirection();
    }

    onUpdate(): void {
        if (this.paused || !this.running) return;
        const now = performance.now();
        for (const [node, until] of this.flashes) {
            if (now >= until || node.destroyed) {
                if (!node.destroyed) node.active = false;
                this.flashes.delete(node);
            }
        }
        for (const [channel, until] of this.channels) {
            if (channel.isStopped || now >= until) this.stopChannel(channel);
        }
        this.updateDamage(now);
    }

    private clearTransient(): void {
        this.audioReady = false;
        ++this.audioGesture;
        for (const channel of this.channels.keys()) this.stopChannel(channel);
        for (const node of [this.playerFlash, ...this.enemyFlashes]) {
            if (node && !node.destroyed) node.active = false;
        }
        this.flashes.clear();
        this.damageUntil = this.directionUntil = 0;
        this.updateDamage(performance.now());
    }

    private readonly suspend = () => { this.clearTransient(); };
    private readonly onVisibilityChange = () => { if (document.hidden) this.suspend(); };

    /** 暂停不解绑订阅或取消资源预热；加载完成始终只登记，不补播。 */
    setPaused(value: boolean): void {
        this.paused = value;
        if (value) this.clearTransient();
    }

    requestAudioUnlock(): void { this.unlockAudio(); }

    stop(): void {
        this.enabled = false;
    }

    onDisable(): void {
        this.running = false;
        ++this.generation;
        this.player?.offAllCaller(this);
        for (const enemy of this.enemies) enemy?.offAllCaller(this);
        Laya.stage.offAllCaller(this);
        this.canvas.removeEventListener("pointerup", this.unlockAudio, true);
        window.removeEventListener("blur", this.suspend);
        document.removeEventListener("visibilitychange", this.onVisibilityChange);
        this.clearTransient();
        this.soundUrls.clear();
        this.soundDurationsMs.clear();
    }
}
