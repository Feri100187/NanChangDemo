/** 第一人称短刀外观：深木握柄、深色护手和亮钢刀身，不依赖外部模型资源。 */
export class KnifeView {
    readonly root = new Laya.Sprite3D("FieldKnife");
    private readonly meshes: Laya.Mesh[] = [];
    private readonly materials: Laya.BlinnPhongMaterial[] = [];

    constructor(parent: Laya.Sprite3D) {
        parent.addChild(this.root);
        this.addPart("WoodGrip", 0.095, 0.11, 0.28, new Laya.Vector3(0, 0, 0.17),
            new Laya.Color(0.23, 0.12, 0.07, 1));
        this.addPart("IronGuard", 0.29, 0.035, 0.07, new Laya.Vector3(0, 0, 0.005),
            new Laya.Color(0.16, 0.19, 0.20, 1));
        this.addPart("SteelBlade", 0.13, 0.022, 0.52, new Laya.Vector3(0, 0, -0.29),
            new Laya.Color(0.78, 0.84, 0.84, 1));
        this.addPart("SteelTip", 0.095, 0.018, 0.12, new Laya.Vector3(0, 0, -0.60),
            new Laya.Color(0.90, 0.94, 0.92, 1));
        this.root.active = false;
    }

    private addPart(name: string, width: number, height: number, depth: number,
        position: Laya.Vector3, color: Laya.Color): void {
        const mesh = Laya.PrimitiveMesh.createBox(width, height, depth);
        const material = new Laya.BlinnPhongMaterial();
        material.albedoColor = color;
        const node = new Laya.MeshSprite3D(mesh, name);
        node.meshRenderer.sharedMaterial = material;
        node.transform.localPosition = position;
        this.root.addChild(node);
        this.meshes.push(mesh);
        this.materials.push(material);
    }

    setPose(progress: number, heavy = false): void {
        const swing = Math.sin(Math.max(0, Math.min(1, progress)) * Math.PI);
        this.root.transform.localPosition = new Laya.Vector3(0.38 - swing * (heavy ? 0.36 : 0.22),
            -0.26 + swing * (heavy ? 0.18 : 0.08), -0.68 - swing * (heavy ? 0.34 : 0.24));
        this.root.transform.localRotationEuler = new Laya.Vector3(-10 + swing * (heavy ? 78 : 35),
            -18 + swing * (heavy ? 35 : 65), -28 + swing * (heavy ? -105 : 75));
    }

    destroy(): void {
        if (!this.root.destroyed) this.root.destroy(true);
        for (const mesh of this.meshes) mesh.destroy();
        for (const material of this.materials) material.destroy();
    }
}
