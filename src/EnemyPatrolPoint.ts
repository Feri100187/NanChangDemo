const { regClass, property } = Laya;

/** Editable route data only. Position and arrival yaw come from its scene node. */
@regClass()
export class EnemyPatrolPoint extends Laya.Script {
    @property({ type: Number, caption: "到点停留（秒）" })
    waitSeconds = 1.2;
    @property({ type: Boolean, caption: "到点采用节点朝向" })
    useFacing = true;
}
