const { regClass, property } = Laya;

/** 一段小巷的敌人、接近触发点和沿主路线的警戒范围。 */
@regClass()
export class EncounterWave extends Laya.Script {
    @property({ type: [Laya.Sprite3D], caption: "本波敌人" })
    enemies: Laya.Sprite3D[] = [];
    @property({ type: Laya.Sprite3D, caption: "玩家接近触发点" })
    triggerPoint: Laya.Sprite3D;
    @property({ type: Number, caption: "触发半径" })
    triggerRadius = 5;
    @property({ type: Number, caption: "警戒区路线起点（米）" })
    regionStart = 0;
    @property({ type: Number, caption: "警戒区路线终点（米）" })
    regionEnd = 100;
}
