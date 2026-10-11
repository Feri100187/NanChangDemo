# 元数据与缓存维护记录

2026-10-11，检查合并后剩余 `.meta` 改动与工程内临时文件；仅回收已证明没有继续保留必要的副本，保留原始素材、交付物、验证历史及活动任务资料。

## 元数据结论

- Git 状态中的 286 份 `.meta` 均保持原 UUID。其中 281 份与 HEAD 逐字节一致，是 IDE 写回 LF 后的 Git 索引统计差异；刷新明确白名单的索引后，没有产生提交内容。
- 另外五份为 `assets/resources/oldtown/textures/` 下 Brick、Paving、Plaster、RoofTile、Wood 的 albedo 元数据。GLB 导入器将 `anisoLevel` 从 4 改成 1，并补入 `platformDefault.format=0`、`hdrEncodeFormat=0`。
- `tools/generate-oldtown-art.cjs` 和对应旧材质明确采用 4 倍各向异性过滤。本轮恢复这五份元数据的仓库原内容，避免把自动降低采样质量当作必要配置提交。
- 本机 LayaAir IDE 3.4.1 的 glTF 导入器会将带 sampler 的纹理默认参数写回共享纹理元数据。重新导入相关 GLB 仍可能再次出现该差异；本轮未修改引擎或宣称永久消除该行为。
- `.gitignore` 新增 Python `__pycache__`、`.pyc`、`.pyo` 规则，源 `.py` 文件继续跟踪。没有忽略 `.meta` 或改动全仓换行策略。

## 已核验回收范围

以下 8 个目录共 537 个文件、54,673,711 字节（约 52.14 MiB），已移入 Windows 回收站。操作前检查路径、完整文件清单与 SHA-256；操作后核对原路径消失、回收站元数据及全部文件哈希一致。

| 路径 | 不再需要的依据 |
| --- | --- |
| `.tmp/web-before-final-c96de2e` | 256 个文件与保留的 `release/web` 逐字节相同 |
| `.tmp/web-before-final-fresh` | 同上，另一份重复发布备份 |
| `.tmp/minified-before-final` | 8 份已保留的压缩文件，以及一份已被武器变换修复替代的旧生成 bundle |
| `.codex-backup/2026-09-29T01-29-03-982Z-before-rifle-audio` | 3 份元数据可从 `336c938` 精确恢复 |
| `.codex-backup/characters-cf8bab5` | 4 份文本可从 `cf8bab5` 恢复，LF 转 CRLF 后逐字节一致 |
| `.codex-backup/hotreload-guard` | 2 份源文件可从 `9468131` 精确恢复 |
| `.codex-backup/multi-enemy-20260926-103248` | 5 份文件可从 `9468131` 恢复，README 可从 `92e7ad7` 恢复 |
| `tools/__pycache__` | 仅包含可由已跟踪源脚本重新生成的 Python 字节码 |

## 保留范围与验证

`.codex-backup` 其余 9 组含 Git 历史中未找到的独有内容，暂留：rear-art、buildings、combat-feedback、demo01、enemy-ai、initial-player、oldtown-art、save-audit、sight-and-recoil 对应目录。

人物／武器 `.blend`、`.blend1`、手部及动画探针、截图视频和历史检查记录保留；另一个持枪与换弹任务仍在进行。音频原件、研究素材、`output` 验证证据和一份完整历史 `release/web` 发布产物也保留，不按缓存盲目清除。

`library`、`local` 和当前编辑器会话目录继续保留。当前 IDE 预览曾出现 `_nodeType` 初始化错误，本轮未通过清空正在使用的缓存或关闭编辑器来处理。另将当前受跟踪文件复制到独立临时目录，使用 LayaAir IDE 3.4.1 完整 Web 构建并重新启动浏览器验证：构建 PASS；Ready、100 HP、7 波／21 敌／5 友／285 门窗正确，751 次资源响应无失败或运行时错误。TypeScript noEmit 也通过。

详细白名单、操作前后哈希、回收站定位、构建和预览日志保存在本机 `output/metadata-cache-audit-2026-10-11/`。这些审计记录不提交为运行资源。
