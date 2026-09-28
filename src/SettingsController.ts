import { GameSettings } from "./GameSettings";
import { PlayerController } from "./PlayerController";

const { regClass, property } = Laya;

/** 开始/暂停菜单上的可选设置页；返回时不自动恢复战斗。 */
@regClass()
export class SettingsController extends Laya.Script {
    @property({ type: Laya.Sprite3D })
    player: Laya.Sprite3D;
    @property({ type: Laya.GButton })
    settingsButton: Laya.GButton;
    @property({ type: Laya.GBox })
    settingsPanel: Laya.GBox;
    @property({ type: Laya.GBox })
    settingsCard: Laya.GBox;
    @property({ type: Laya.GSlider })
    volumeSlider: Laya.GSlider;
    @property({ type: Laya.GSlider })
    sensitivitySlider: Laya.GSlider;
    @property({ type: Laya.GSlider })
    reloadVolumeSlider: Laya.GSlider;
    @property({ type: Laya.GSlider })
    meleeVolumeSlider: Laya.GSlider;
    @property({ type: Laya.GTextField })
    volumeText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    sensitivityText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    reloadVolumeText: Laya.GTextField;
    @property({ type: Laya.GTextField })
    meleeVolumeText: Laya.GTextField;
    @property({ type: Laya.GButton })
    backButton: Laya.GButton;
    @property({ type: Laya.GButton })
    resetButton: Laya.GButton;

    private playerControl: PlayerController;

    onAwake(): void {
        this.playerControl = this.player.getComponent(PlayerController);
        this.close();
        this.volumeSlider.min = 0;
        this.volumeSlider.max = 100;
        this.volumeSlider.wholeNumbers = true;
        for (const slider of [this.reloadVolumeSlider, this.meleeVolumeSlider]) {
            slider.min = 0;
            slider.max = 100;
            slider.wholeNumbers = true;
        }
        this.sensitivitySlider.min = 25;
        this.sensitivitySlider.max = 300;
        this.sensitivitySlider.wholeNumbers = true;
        this.refresh();
    }

    onEnable(): void {
        this.settingsButton.on(Laya.Event.CLICK, this, this.open);
        this.backButton.on(Laya.Event.CLICK, this, this.close);
        this.resetButton.on(Laya.Event.CLICK, this, this.reset);
        this.volumeSlider.on(Laya.Event.CHANGED, this, this.changeVolume);
        this.reloadVolumeSlider.on(Laya.Event.CHANGED, this, this.changeReloadVolume);
        this.meleeVolumeSlider.on(Laya.Event.CHANGED, this, this.changeMeleeVolume);
        this.sensitivitySlider.on(Laya.Event.CHANGED, this, this.changeSensitivity);
        Laya.stage.on(Laya.Event.RESIZE, this, this.layout);
        window.addEventListener("keydown", this.onEscape);
        this.layout();
    }

    private open(): void {
        if (!this.settingsButton.visible || !this.settingsButton.enabled || !this.playerControl.clock?.paused) return;
        this.refresh();
        this.settingsPanel.visible = true;
        for (const slider of [this.volumeSlider, this.reloadVolumeSlider,
            this.meleeVolumeSlider, this.sensitivitySlider]) slider.canDrag = true;
        this.layout();
    }

    private close(): void {
        // 隐藏父面板不会取消引擎已捕获的握把拖动。
        for (const slider of [this.volumeSlider, this.reloadVolumeSlider,
            this.meleeVolumeSlider, this.sensitivitySlider]) slider.canDrag = false;
        this.settingsPanel.visible = false;
    }

    private readonly onEscape = (event: KeyboardEvent) => {
        if (event.key === "Escape" && this.settingsPanel.visible) this.close();
    };

    private changeVolume(): void {
        if (!this.settingsPanel.visible) return;
        GameSettings.setVolume(this.volumeSlider.value / 100);
        this.updateLabels();
    }

    private changeSensitivity(): void {
        if (!this.settingsPanel.visible) return;
        GameSettings.setSensitivity(this.sensitivitySlider.value / 100 * GameSettings.defaultSensitivity);
        this.playerControl.mouseSensitivity = GameSettings.sensitivity;
        this.updateLabels();
    }

    private changeReloadVolume(): void {
        if (!this.settingsPanel.visible) return;
        GameSettings.setReloadVolume(this.reloadVolumeSlider.value / 100);
        this.updateLabels();
    }

    private changeMeleeVolume(): void {
        if (!this.settingsPanel.visible) return;
        GameSettings.setMeleeVolume(this.meleeVolumeSlider.value / 100);
        this.updateLabels();
    }

    private reset(): void {
        GameSettings.reset();
        this.refresh();
    }

    private refresh(): void {
        this.volumeSlider.value = Math.round(GameSettings.volume * 100);
        this.reloadVolumeSlider.value = Math.round(GameSettings.reloadVolume * 100);
        this.meleeVolumeSlider.value = Math.round(GameSettings.meleeVolume * 100);
        this.sensitivitySlider.value = Math.round(GameSettings.sensitivity / GameSettings.defaultSensitivity * 100);
        this.playerControl.mouseSensitivity = GameSettings.sensitivity;
        this.updateLabels();
    }

    private updateLabels(): void {
        this.volumeText.text = `音量  ${Math.round(GameSettings.volume * 100)}%`;
        this.reloadVolumeText.text = `装填音量  ${Math.round(GameSettings.reloadVolume * 100)}%`;
        this.meleeVolumeText.text = `挥刀音量  ${Math.round(GameSettings.meleeVolume * 100)}%`;
        this.sensitivityText.text = `鼠标灵敏度  ${(GameSettings.sensitivity / GameSettings.defaultSensitivity).toFixed(2)} 倍`;
        // GSlider 更新填充条；本页的握把位置按同一数值同步，不依赖额外资源。
        for (const slider of [this.volumeSlider, this.reloadVolumeSlider,
            this.meleeVolumeSlider, this.sensitivitySlider]) {
            slider.gripButton.x = (slider.value - slider.min) / (slider.max - slider.min)
                * slider.width - slider.gripButton.width / 2;
        }
    }

    private layout(): void {
        const width = Laya.stage.width, height = Laya.stage.height;
        this.settingsPanel.size(width, height);
        const scale = Math.max(0.1, Math.min(1, (width - 32) / 640, (height - 32) / 620));
        this.settingsCard.scale(scale, scale);
        this.settingsCard.pos((width - 640 * scale) / 2, (height - 620 * scale) / 2);
    }

    onDisable(): void {
        this.close();
        for (const widget of [this.settingsButton, this.backButton, this.resetButton,
            this.volumeSlider, this.reloadVolumeSlider, this.meleeVolumeSlider,
            this.sensitivitySlider]) widget.offAllCaller(this);
        Laya.stage.offAllCaller(this);
        window.removeEventListener("keydown", this.onEscape);
    }
}
