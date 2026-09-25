/**
 * LayaAir IDE 3.4.1 的场景热重载可能在重建旧节点后，仍按旧组件下标
 * 读取 owner.components[i]._extra。只把仍属于当前场景的组件交给原方法，
 * 避免对已销毁节点执行热替换。此文件仅编入 IDE 场景环境。
 */
@IEditorEnv.regClass()
export class EditorHotReloadGuard {
    @IEditorEnv.onLoad
    static install(): void {
        const manager = EditorEnv.extensionManager as any;
        const original = Object.getPrototypeOf(manager)?.reloadComponents;
        // 只适配已核对源码的 3.4.1 实现；升级后若实现变化就不接管。
        if (typeof original !== "function"
            || !Function.prototype.toString.call(original).includes("components[i]._extra")) return;

        manager.reloadComponents = function (scene: any, targets: any[], pairs: any[]): any {
            if (!Array.isArray(targets) || !Array.isArray(pairs)
                || pairs.length !== targets.length * 2
                || typeof scene?.getNodeById !== "function") {
                return original.call(this, scene, targets, pairs);
            }

            const currentTargets: any[] = [];
            const currentPairs: any[] = [];
            for (let k = 0; k < targets.length; k++) {
                const old = targets[k];
                const index = pairs[k * 2 + 1];
                const owner = old?.owner;
                if (owner && !owner.destroyed && Number.isInteger(index)
                    && index >= 0 && owner.components?.[index] === old
                    && owner._extra?.id != null
                    && scene.getNodeById(owner._extra.id) === owner) {
                    currentTargets.push(old);
                    currentPairs.push(pairs[k * 2], index);
                }
            }

            if (currentTargets.length !== targets.length) {
                console.warn(`[HotReloadGuard] 跳过 ${targets.length - currentTargets.length} 个过期组件；当前场景节点需重新加载时请重开场景。`);
            }
            return original.call(this, scene, currentTargets, currentPairs);
        };
    }
}
