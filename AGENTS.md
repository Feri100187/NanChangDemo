# NanChangDemo 开发约定

## 目标与入口

持续改进 LayaAir 3.4.1 第一人称旧城街巷玩法原型，每轮只完成一个可验收的小任务。先阅读 `README.md`、`SUPERVISOR.md` 和 `.agent/STATUS.md`；README 描述玩法及资源维护方法，STATUS 描述当前基线和未完成验证。场景为虚构布局，不宣称复原真实历史地点。

- `assets/Demo01.ls`：默认关卡；街口、院落各两敌，取文件后到终点。
- `assets/Scene.ls`：共用控制器的旧测试场，保留直接试玩及清敌后到终点规则。
- `src/LevelController.ts`：会话、分阶段任务、交互、暂停、胜负和重开。
- `src/PlayerController.ts` / `RifleController.ts` / `EnemyAI.ts`：输入移动、武器和敌军行为。
- `src/GameClock.ts` / `GameSettings.ts` / `SettingsController.ts`：暂停时间与设置。
- `CharacterAnimation.ts`、`FirstPersonArmIK.ts`、`WeaponPresentation.ts`、`WeaponMotion.ts`：人物与持械表现；`CombatFeedback.ts` 管理反馈。
- `assets/resources/`：场景引用的共享资源；`engine/types/`：本机引擎 API 声明；`tools/`：已有定点回归与离线资源生成器。

## 工作边界

1. 开始时检查 `git status --short --branch`、remote、HEAD、worktree、暂存区及相关文件变化。原工作区可能有其他任务；不把“当前干净”当成无并行开发的保证。
2. 默认在 `agent-dev` 或明确的任务分支开发，不长期在 master 上工作。当前监督工作使用独立 worktree，路径见 STATUS。切换基线前说明需要纳入的提交及原因；不擅自合并其他开发分支。
3. 不 reset、clean、覆盖或暂存他人的改动。不用 `git add .`；仅暂存本轮明确文件，检查暂存 diff 后提交。原目录和 worktree 共用 Git 元数据，提交时再次核对路径和分支。
4. 普通阅读、定点修改、必要测试、创建开发分支、commit 和推送对应 GitHub 开发分支已获授权。GitHub remote 名为 `github`；`origin` 有 Gitee 与 GitHub 两个 push URL，不使用 `git push origin`。推送前核实 remote，只显式推送本轮分支并用 `ls-remote` 核对 SHA。
5. 不读取、打印或提交 API Key、Token、密码、`.env`、凭据或会话目录。只读 memory 摘要仅在确有需要且不涉及秘密时使用。
6. 大量资源删除、大规模重构、核心玩法方向改变、合并 master、登录/验证码/付款/密钥/重要授权操作暂停并报告。禁止 force push、删除主分支或仓库、修改凭据或其他项目。
7. 保留 `.meta` UUID、场景显式引用、共享预制体的兼容性及资源许可。不要顺手运行全量模型/音频生成器；先评估其覆盖范围。不要提交 `library`、`local`、`release`、`output`、`.tmp` 或大量构建产物。
8. 每轮先写明目标、完成标准和必要测试，再修改、验证、审阅 diff、commit、push、核实远程 SHA。父线程检查 diff 后再分派下一轮，不自行连续铺开多个功能。相同问题最多两轮修复，仍失败记为 `BLOCKED`。

## 验证

优先级：TypeScript → 编译 → 正常启动 → Console → 本轮涉及玩法 → 旧玩法必要回归。优先使用现有检查，不为文档变更加大量测试代码。以当前目录为工程根；此机器的 TypeScript 来自已安装 IDE：

```powershell
node D:\a\LayaAirIDE\resources\node_modules\typescript\bin\tsc --noEmit --pretty false -p tsconfig.json
node tools\check-mission-flow.cjs D:\a\LayaAirIDE\resources\node_modules\typescript
node tools\check-weapon-states.cjs D:\a\LayaAirIDE\resources\node_modules\typescript
git diff --check
```

定点脚本用真实控制器配合替身，不证明真实渲染、物理、声音或手感通过。TypeScript 编译成功也不等于完整 LayaAir Web 构建成功。需要实际导入、构建、启动时，在对应 worktree 中用 3.4.1 编辑器执行并记录准确基线；不借用另一个分支的缓存或旧测试结果作为本轮证据。

IDE 热重载可能保留旧任务引用：停止预览，关闭并重开 Demo01，再启动预览；随后可执行任务检查追加 `--preview-cache`。不要只重编译脚本后宣称引用已刷新。不能可靠判断的视觉、听感和完整实战标记“需要人工验证”。
