import { EnemyAI } from "./EnemyAI";
import { PlayerController } from "./PlayerController";
import { PlayerHealth } from "./PlayerHealth";
import { RifleController } from "./RifleController";
import { CombatFeedback } from "./CombatFeedback";
import { GameClock } from "./GameClock";

const { regClass, property } = Laya;
type LevelState = "Ready" | "Playing" | "Paused" | "Won" | "Lost" | "Restarting";

/** 单关卡：指定敌人清零后进入终点，结算后重载完整场景。 */
@regClass()
export class LevelController extends Laya.Script {
    // 3.4.1 的公开物理更新开关为全局属性。重载期间可能同时存在两个场景，
    // 只有最后一个暂停持有者释放时才恢复它，旧场景销毁不会解冻新开始界面。
    private static readonly physicsHolders = new Set<LevelController>();
    private static savedPhysicsUpdate = true;
    @property({ type: Laya.Sprite3D })
    player: Laya.Sprite3D;
    @property({ type: [Laya.Sprite3D], caption: "本关指定敌人" })
    enemies: Laya.Sprite3D[] = [];
    @property({ type: Laya.Sprite3D, caption: "终点区域中心" })
    exitZone: Laya.Sprite3D;
    @property({ type: Laya.Vector3, caption: "终点区域半尺寸" })
    exitHalfSize = new Laya.Vector3(2.5, 2, 2.5);
    @property({ type: String, caption: "战斗目标提示" })
    combatObjective = "目标：清除全部敌人，再进入通道尽头的橙色终点区";
    @property({ type: String, caption: "重开场景（无 URL 时）" })
    restartScene = "Scene.ls";
    @property({ type: [Laya.Sprite3D], caption: "路线提示点（节点名为提示）" })
    routePoints: Laya.Sprite3D[] = [];
    @property({ type: Laya.GTextField })
    routeText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    remainingText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    objectiveText: Laya.GTextField;
    @property({ type: Laya.GBox })
    resultPanel: Laya.GBox;
    @property({ type: Laya.GTextField })
    resultTitle: Laya.GTextField;
    @property({ type: Laya.GTextField })
    resultDetail: Laya.GTextField;
    @property({ type: Laya.GButton })
    restartButton: Laya.GButton;
    @property({ type: Laya.GButton, caption: "开始/继续按钮（可选）" })
    continueButton: Laya.GButton;
    @property({ type: Laya.GButton, caption: "设置按钮（可选）" })
    settingsButton: Laya.GButton;

    private state: LevelState = "Playing";
    private readonly remaining = new Set<EnemyAI>();
    private targets: EnemyAI[] = [];
    private health: PlayerHealth;
    private playerControl: PlayerController;
    private rifle: RifleController;
    private wasInsideExit = false;
    private routeIndex = 0;
    private clock: GameClock;
    private world: Laya.Scene3D;
    private previousTimer: Laya.Timer;
    private awaitingControls = false;

    onAwake(): void {
        this.health = this.player.getComponent(PlayerHealth);
        this.playerControl = this.player.getComponent(PlayerController);
        this.rifle = this.player.getComponent(RifleController);
        this.clock = new GameClock();
        this.world = this.player.scene as Laya.Scene3D;
        this.previousTimer = this.world.timer;
        this.world.timer = this.clock.timer;
        this.targets = Array.from(new Set(this.enemies.map(node => node.getComponent(EnemyAI))));
        this.playerControl.clock = this.rifle.clock = this.health.clock = this.clock;
        for (const enemy of this.targets) if (enemy) enemy.clock = this.clock;
        (this.owner as Laya.Scene).autoDestroyAtClosed = true;
        this.resultPanel.visible = false;
        if (this.continueButton) {
            this.playerControl.useMenuFocus();
            this.state = "Ready";
            this.setGameplayPaused(true);
            this.showSessionMenu();
        }
    }

    onEnable(): void {
        this.restartButton.on(Laya.Event.CLICK, this, this.restart);
        if (this.continueButton) {
            this.continueButton.on(Laya.Event.CLICK, this, this.beginContinue);
            this.player.on(PlayerController.CONTROL_ACQUIRED, this, this.onControlsAcquired);
            this.player.on(PlayerController.CONTROL_LOST, this, this.onControlsLost);
            window.addEventListener("blur", this.onControlsLost);
            document.addEventListener("visibilitychange", this.onVisibilityChanged);
            window.addEventListener("keydown", this.onEscape, true);
            Laya.Browser.mainCanvas.source.addEventListener("blur", this.onControlsLost);
        }
        Laya.stage.on(Laya.Event.RESIZE, this, this.layoutResult);
        this.layoutResult();
    }

    onStart(): void {
        // 显式场景引用定义任务目标；Set 同时防止重复配置和重复死亡通知。
        if (!this.targets.length || this.targets.some(enemy => !enemy)) {
            throw new Error("LevelController 的指定敌人必须挂有 EnemyAI，且不能留空。");
        }
        for (const enemy of this.targets) {
            if (enemy.isAlive) this.remaining.add(enemy);
            enemy.owner.on(EnemyAI.DIED, this, this.onEnemyDied);
        }
        this.player.on(PlayerHealth.DIED, this, this.onPlayerDied);
        this.player.on(PlayerController.RESPAWNED, this, this.onPlayerRespawned);
        this.wasInsideExit = this.isInsideExit();
        this.updateObjective();
        this.updateRouteHint();
    }

    onUpdate(): void {
        if (this.state !== "Playing") return;
        // 失败优先，也覆盖组件启动前生命就已归零的情况。
        if (!this.health.isAlive) {
            this.finish(false);
            return;
        }
        const inside = this.isInsideExit();
        if (this.remaining.size === 0 && inside && !this.wasInsideExit) {
            this.finish(true);
            return;
        }
        this.wasInsideExit = inside;
        this.updateObjective();
        this.updateRouteHint();
    }

    private setGameplayPaused(paused: boolean): void {
        this.clock.setPaused(paused);
        const holders = LevelController.physicsHolders;
        if (paused && !holders.has(this)) {
            if (holders.size === 0) LevelController.savedPhysicsUpdate = Laya.Stat.enablePhysicsUpdate;
            holders.add(this);
            Laya.Stat.enablePhysicsUpdate = false;
        } else if (!paused && holders.delete(this) && holders.size === 0) {
            Laya.Stat.enablePhysicsUpdate = LevelController.savedPhysicsUpdate;
        }
        this.owner.getComponent(CombatFeedback)?.setPaused(paused);
        if (paused) {
            this.rifle.clearGameplayInput();
            this.playerControl.releaseGameplayFocus();
        }
    }

    private showSessionMenu(): void {
        if (!this.continueButton) return;
        const ready = this.state === "Ready";
        this.resultTitle.text = ready ? "旧城街巷 · DEMO 01" : "游戏已暂停";
        this.resultTitle.color = "#ffcf80";
        this.resultDetail.text = ready
            ? "虚构布局的玩法原型，不复原真实历史地点。\n清除 4 名敌人，穿过目标建筑，抵达橙色终点。\n\nWASD 移动 · 左键单发 / 轻击 · 右键开镜 / 重击\n1 汉阳造 · 3 短刀 · R 装填 · Space 跳跃\nShift 疾跑 · C 下蹲 · Esc 暂停"
            : "战斗与换弹已冻结。\n点击继续，取得鼠标控制后恢复游戏。\n\n鼠标锁定受限时，仍可在画面内移动鼠标转向。";
        this.continueButton.title = ready ? "开始游戏" : "继续游戏";
        this.continueButton.enabled = true;
        this.continueButton.visible = true;
        if (this.settingsButton) {
            this.settingsButton.visible = true;
            this.settingsButton.enabled = true;
        }
        this.restartButton.visible = !ready;
        this.restartButton.enabled = true;
        this.restartButton.title = "重新开始";
        this.resultPanel.visible = true;
        this.layoutResult();
    }

    private beginContinue(): void {
        if (this.awaitingControls || (this.state !== "Ready" && this.state !== "Paused")
            || document.hidden || !document.hasFocus()) return;
        this.awaitingControls = true;
        if (this.settingsButton) this.settingsButton.enabled = false;
        this.continueButton.enabled = false;
        this.continueButton.title = "正在取得鼠标控制…";
        this.owner.getComponent(CombatFeedback)?.requestAudioUnlock();
        this.playerControl.requestGameplayFocus();
    }

    private onControlsAcquired(): void {
        if (!this.awaitingControls || (this.state !== "Ready" && this.state !== "Paused")) return;
        this.awaitingControls = false;
        this.state = "Playing";
        this.setGameplayPaused(false);
        this.resultPanel.visible = false;
    }

    private readonly onControlsLost = () => {
        if (this.state === "Playing") {
            this.state = "Paused"; // 先转状态，再释放鼠标，避免失焦回调重入。
            this.awaitingControls = false;
            this.setGameplayPaused(true);
            this.showSessionMenu();
        } else if (this.awaitingControls && (this.state === "Ready" || this.state === "Paused")) {
            this.awaitingControls = false;
            this.setGameplayPaused(true);
            this.showSessionMenu();
        }
    };

    private readonly onVisibilityChanged = () => { if (document.hidden) this.onControlsLost(); };
    private readonly onEscape = (event: KeyboardEvent) => {
        if (event.key === "Escape") this.onControlsLost();
    };

    private onEnemyDied(enemy: EnemyAI): void {
        if (this.state !== "Playing" || enemy.isAlive || !this.remaining.delete(enemy)) return;
        // 在终点内击杀最后一个目标，仍须离开后再进入，不能原地直接获胜。
        if (this.remaining.size === 0) this.wasInsideExit = this.isInsideExit();
        this.updateObjective();
    }

    private onPlayerDied(): void {
        this.finish(false);
    }

    private onPlayerRespawned(): void {
        this.routeIndex = 0;
        this.wasInsideExit = this.isInsideExit();
        this.updateRouteHint();
    }

    private updateRouteHint(): void {
        if (!this.routeText || !this.routePoints.length) return;
        const p = this.player.transform.position;
        // 提示点只引导路线，不另设通关条件；跳过前面的点也能接上后续提示。
        for (let i = this.routeIndex; i < this.routePoints.length; i++) {
            const point = this.routePoints[i].transform.position;
            if (Math.abs(p.y - point.y) < 3 && Math.hypot(p.x - point.x, p.z - point.z) <= 2.5) {
                this.routeIndex = Math.min(i + 1, this.routePoints.length - 1);
            }
        }
        this.routeText.text = `路线：${this.routePoints[this.routeIndex].name}`;
    }

    private isInsideExit(): boolean {
        const p = this.player.transform.position;
        const exit = this.exitZone.transform.position;
        return Math.abs(p.x - exit.x) <= this.exitHalfSize.x
            && Math.abs(p.y - exit.y) <= this.exitHalfSize.y
            && Math.abs(p.z - exit.z) <= this.exitHalfSize.z;
    }

    private updateObjective(): void {
        this.remainingText.text = `剩余敌人  ${this.remaining.size} / ${this.targets.length}`;
        const inside = this.isInsideExit();
        if (this.remaining.size > 0) {
            this.objectiveText.text = inside
                ? "终点尚未解锁：先清除本关全部敌人"
                : this.combatObjective;
            this.objectiveText.color = "#ffcf80";
        } else {
            const p = this.player.transform.position;
            const exit = this.exitZone.transform.position;
            const distance = Math.hypot(p.x - exit.x, p.z - exit.z);
            this.objectiveText.text = inside
                ? "敌人已清除：请先离开终点区，再进入完成任务"
                : `敌人已清除：前往橙色终点区 · 距离 ${distance.toFixed(0)} 米`;
            this.objectiveText.color = "#8fffb0";
        }
    }

    private finish(won: boolean): void {
        if (this.state !== "Playing") return;
        this.state = won ? "Won" : "Lost";
        this.awaitingControls = false;
        this.setGameplayPaused(true);
        if (this.continueButton) this.continueButton.visible = false;
        if (this.settingsButton) this.settingsButton.visible = false;
        this.restartButton.visible = true;
        this.owner.getComponent(CombatFeedback)?.stop();
        // 同步关停：同一帧里其他敌人和残留射击都不能再造成伤害。
        this.health.enabled = false;
        for (const enemy of this.targets) enemy.enabled = false;
        this.rifle.stopCombat();
        this.playerControl.stopGameplay();
        this.resultTitle.text = won ? "任务完成" : "任务失败";
        this.resultTitle.color = won ? "#8fffb0" : "#ff7777";
        this.resultDetail.text = (won
            ? `已清除全部 ${this.targets.length} 名敌人，并抵达终点。`
            : `玩家已阵亡，本关还剩 ${this.remaining.size} 名敌人。`)
            + (this.continueButton ? "\n重新开始后返回开始界面。" : "\n重新开始后，点击画面取得鼠标控制。");
        this.restartButton.title = "重新开始";
        this.resultPanel.visible = true;
        this.layoutResult();
    }

    private async restart(): Promise<void> {
        if (this.state !== "Won" && this.state !== "Lost" && this.state !== "Paused") return;
        const endedState = this.state;
        this.state = "Restarting";
        this.awaitingControls = false;
        this.setGameplayPaused(true);
        if (this.settingsButton) this.settingsButton.enabled = false;
        if (this.continueButton) this.continueButton.enabled = false;
        this.restartButton.enabled = false;
        this.restartButton.title = "正在重新开始…";
        const currentScene = this.owner as Laya.Scene;
        let nextScene: Laya.Scene;
        try {
            // 先加载成功再销毁旧关卡；加载失败时保留结算界面供重试。
            // 优先重载当前关卡；无运行时 URL 的实例使用本关配置的资源路径。
            nextScene = await Laya.Scene.load(currentScene.url || this.restartScene, null);
            if (this.destroyed || currentScene.destroyed) {
                nextScene.destroy(true);
                return;
            }
            // close 会销毁 2D、3D 及全部脚本；先解绑旧输入，再激活新实例。
            currentScene.close();
            nextScene.open(false);
        } catch (error) {
            if (nextScene && !nextScene.destroyed) nextScene.destroy(true);
            console.error("重新加载关卡失败", error);
            if (this.destroyed || currentScene.destroyed) return;
            this.state = endedState;
            if (endedState === "Paused") this.showSessionMenu();
            this.restartButton.enabled = true;
            this.restartButton.title = "重试重新开始";
            this.resultDetail.text = "关卡加载失败，请点击按钮重试。";
        }
    }

    private layoutResult(): void {
        const width = Laya.stage.width;
        const height = Laya.stage.height;
        // 先按设计宽度排版，再统一缩放内容，避免窄窗口换行挤掉按钮。
        const textWidth = 720;
        this.resultPanel.size(width, height);
        this.resultTitle.width = this.resultDetail.width = textWidth;
        const sessionMenu = this.state === "Ready" || this.state === "Paused" ||
            (this.state === "Restarting" && this.continueButton?.visible);
        if (sessionMenu && this.continueButton) {
            this.resultTitle.pos(-textWidth / 2, -205);
            this.resultDetail.height = 210;
            this.resultDetail.pos(-textWidth / 2, -125);
            this.continueButton.pos(-this.continueButton.width / 2, 120);
            this.restartButton.pos(-this.restartButton.width / 2, 194);
            if (this.settingsButton) {
                const ready = this.state === "Ready";
                this.settingsButton.pos(ready ? -this.settingsButton.width / 2 : 8, 194);
                if (!ready) this.restartButton.x = -this.restartButton.width - 8;
            }
        } else {
            this.resultDetail.height = 72;
            this.resultTitle.pos(-textWidth / 2, -130);
            this.resultDetail.pos(-textWidth / 2, -52);
            this.restartButton.pos(-this.restartButton.width / 2, 38);
        }

        // 背景始终铺满舞台；标题、说明与所有可见按钮作为一个内容组适配。
        const widgets = [this.resultTitle, this.resultDetail, this.continueButton,
            this.restartButton, this.settingsButton].filter(widget => widget?.visible);
        const left = Math.min(...widgets.map(widget => widget.x));
        const top = Math.min(...widgets.map(widget => widget.y));
        const contentWidth = Math.max(...widgets.map(widget => widget.x + widget.width)) - left;
        const contentHeight = Math.max(...widgets.map(widget => widget.y + widget.height)) - top;
        const scale = Math.min(1, Math.max(1, width - 32) / contentWidth,
            Math.max(1, height - 32) / contentHeight);
        const x = (width - contentWidth * scale) / 2;
        const y = (height - contentHeight * scale) / 2;
        for (const widget of widgets) {
            widget.scale(scale, scale);
            widget.pos(x + (widget.x - left) * scale, y + (widget.y - top) * scale);
        }
    }

    onDisable(): void {
        this.awaitingControls = false;
        this.player.off(PlayerController.CONTROL_ACQUIRED, this, this.onControlsAcquired);
        this.player.off(PlayerController.CONTROL_LOST, this, this.onControlsLost);
        window.removeEventListener("blur", this.onControlsLost);
        document.removeEventListener("visibilitychange", this.onVisibilityChanged);
        window.removeEventListener("keydown", this.onEscape, true);
        Laya.Browser.mainCanvas.source.removeEventListener("blur", this.onControlsLost);
        this.continueButton?.offAllCaller(this);
        this.player.off(PlayerHealth.DIED, this, this.onPlayerDied);
        this.player.off(PlayerController.RESPAWNED, this, this.onPlayerRespawned);
        for (const enemy of this.targets) {
            enemy.owner?.off(EnemyAI.DIED, this, this.onEnemyDied);
        }
        this.restartButton.offAllCaller(this);
        Laya.stage.offAllCaller(this);
        if (LevelController.physicsHolders.delete(this) && LevelController.physicsHolders.size === 0)
            Laya.Stat.enablePhysicsUpdate = LevelController.savedPhysicsUpdate;
        if (this.world && !this.world.destroyed) this.world.timer = this.previousTimer;
        this.clock?.destroy();
    }
}
