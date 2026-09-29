# 汉阳造游戏音效：来源与许可

这些文件用于 NanChangDemo 中汉阳造步枪的**游戏拟声**。来源标注为同类栓动步枪与装填声，不是汉阳造或德国 M1888 的实枪原声；没有改变武器射速、弹量、伤害或装填时长。

## 下载来源（2026-09-29）

| 素材 | 作者／署名 | 来源 | 本工程采用的许可 |
| --- | --- | --- | --- |
| `tabasco-mosin.wav`，包内 `sounds/mosin.wav` | 上传者 Tabasco；随包署名 Copyright (c) 2009 Vincent Sevedge | [Gunshot Sounds](https://opengameart.org/content/gunshot-sounds)，[原始 ZIP](https://opengameart.org/sites/default/files/sounds.zip) | [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/) |
| `fennelliott-gun-bolt.mp3`，原题 `gun bolt.wav` | fennelliott | [Freesound 347360](https://freesound.org/people/fennelliott/sounds/347360/)，[公开 HQ MP3](https://cdn.freesound.org/previews/347/347360_6207707-hq.mp3) | [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) |
| `bmaczero-clipload1.wav`、`bmaczero-clipload2.wav` | BMacZero / Brian MacIntosh | [Gun Reload Sound Effects](https://opengameart.org/content/gun-reload-sound-effects) | [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) |

枪声网页当前标注 CC0，但 ZIP 内附有 CC BY 3.0 版权说明。本工程保留原说明并遵循其署名条件，枪声原件及派生文件不改用项目的 MIT 许可。原说明见 `audio-sources/hanyang/tabasco-original-notice.txt`。

枪栓来源是作者公开提供的 MP3 预听文件；没有下载需要登录的原始 WAV。原音标注为 Mosin Nagant 枪栓声，枪声包也将所用片段标注为 Mosin Nagant。上述作者不为本项目或武器还原程度背书。

## 加工与对应关系

- `player-shot.wav`：取 `mosin.wav` 第一发约 0.438 秒处起的 1.15 秒，转单声道、重采样、频谱降噪、高低通、淡入淡出与峰值归一化。
- `enemy-shot.wav`：来自同一发枪声，长度同为 1.15 秒，使用更低的高频截止和峰值，以配合现有敌人音量。它不代表按实际距离计算的空间声学。
- `rifle-reload.wav`：由枪栓原音 0.08～0.68 秒、1.36～1.97 秒片段与两个装填声组合；动作声分别安排在约 0.04、1.05、1.72、2.54 秒，总长 3.2 秒，适配现有 3.3 秒装填流程。

三个运行文件均为 44.1 kHz、16 位 PCM、单声道 WAV。保留旧文件名及 `.meta` UUID，两个场景的引用无需迁移。玩家／敌人基础音量、总音量和装填音量设置仍由现有组件控制。

原始下载文件、下载地址、日期和 SHA-256 位于 `audio-sources/hanyang/`。该目录是离线加工源，不是 Laya 运行资源目录。重建命令：

```text
blender --background --factory-startup --python tools/prepare-hanyang-audio.py
```

处理脚本使用 Blender 自带的 `aud` 与 `numpy`，不自动联网，不增加游戏音频库。脚本校验原始文件哈希；运行素材位于 `assets/resources/combat-feedback/`，其 `.meta` 应继续保留。

原来的合成枪声与合成装填声生成器只把历史占位音写入 `.tmp/legacy-audio/`，不会覆盖这三个运行文件。轻／重挥刀音仍按原流程生成，未替换其素材。
