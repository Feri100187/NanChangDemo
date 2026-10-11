import { GameClock } from "./GameClock";

const { regClass, property } = Laya;

/** Hinged door/window. Doors target their moving leaf; windows retain aperture interaction. */
@regClass()
export class Openable extends Laya.Script {
    static readonly instances = new Set<Openable>();
    @property({ type: Laya.Sprite3D, caption: "铰链节点" })
    hinge: Laya.Sprite3D;
    @property({ type: Boolean, caption: "透明玻璃窗" })
    isWindow = false;
    @property({ type: Number, caption: "开口宽度" })
    width = 2;
    @property({ type: Number, caption: "开口高度" })
    height = 2.7;
    @property({ type: Number, caption: "打开角度" })
    openAngle = 95;
    clock: GameClock;
    isBlocked: (angle: number) => boolean;
    private targetOpen = false;
    private angle = 0;
    private readonly rotation = new Laya.Vector3();
    private readonly leafInverse = new Laya.Matrix4x4();
    private readonly leafRay = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3());
    private readonly leafBounds = new Laya.BoundBox(new Laya.Vector3(), new Laya.Vector3());

    get isOpen(): boolean { return this.targetOpen; }
    get currentAngle(): number { return this.angle; }
    get hint(): string { return `F ${this.targetOpen ? "关闭" : "打开"}${this.isWindow ? "窗户" : "房门"}`; }

    onEnable(): void { Openable.instances.add(this); }
    onDisable(): void { Openable.instances.delete(this); }
    onDestroy(): void { Openable.instances.delete(this); this.isBlocked = null; }
    toggle(): void {
        if (!this.enabled || this.clock?.paused) return;
        this.targetOpen = !this.targetOpen;
    }
    onUpdate(): void {
        if (!this.hinge || this.clock?.paused) return;
        const target = this.targetOpen ? this.openAngle : 0;
        const step = Math.min((this.clock?.timer.delta ?? Laya.timer.delta) / 1000, .05) * 160;
        const next = this.angle + Math.max(-step, Math.min(step, target - this.angle));
        if (next === this.angle || this.isBlocked?.(next)) return;
        this.angle = next;
        this.rotation.setValue(0, this.angle, 0);
        this.hinge.transform.localRotationEuler = this.rotation;
    }

    /** Ray intersection with the door leaf or window aperture, in metres from the camera. */
    interactionDistance(ray: Laya.Ray): number {
        if (!this.isWindow) return this.doorInteractionDistance(ray);
        const root = this.owner as Laya.Sprite3D, p = root.transform.position;
        const yaw = root.transform.rotationEuler.y * Math.PI / 180, s = Math.sin(yaw), c = Math.cos(yaw);
        const dx = ray.origin.x - p.x, dz = ray.origin.z - p.z;
        const localZ = dx * s + dz * c;
        const directionZ = ray.direction.x * s + ray.direction.z * c;
        if (Math.abs(directionZ) < .0001) return Infinity;
        const t = -localZ / directionZ;
        if (t < 0 || t > 2.8) return Infinity;
        const x = (dx + ray.direction.x * t) * c - (dz + ray.direction.z * t) * s;
        const y = ray.origin.y + ray.direction.y * t - p.y;
        return Math.abs(x) <= this.width / 2 && y >= 0 && y <= this.height ? t : Infinity;
    }

    private doorInteractionDistance(ray: Laya.Ray): number {
        const leaf = this.hinge?.getChildByName("DoorCollider") as Laya.Sprite3D;
        const collider = leaf?.getComponent(Laya.PhysicsCollider);
        const shape = collider?.colliderShape;
        if (!leaf?.activeInHierarchy || !collider?.enabled || !(shape instanceof Laya.BoxColliderShape)) return Infinity;
        leaf.transform.worldMatrix.invert(this.leafInverse);
        Laya.Vector3.transformCoordinate(ray.origin, this.leafInverse, this.leafRay.origin);
        // Keep the transformed direction unnormalized so t remains a world-space distance,
        // including the leaf's nonuniform scale. The box also makes its thin edge targetable.
        Laya.Vector3.TransformNormal(ray.direction, this.leafInverse, this.leafRay.direction);
        const p = shape.localOffset;
        this.leafBounds.min.setValue(p.x - shape.sizeX / 2, p.y - shape.sizeY / 2, p.z - shape.sizeZ / 2);
        this.leafBounds.max.setValue(p.x + shape.sizeX / 2, p.y + shape.sizeY / 2, p.z + shape.sizeZ / 2);
        const t = Laya.CollisionUtils.intersectsRayAndBoxRD(this.leafRay, this.leafBounds);
        return t >= 0 && t <= 2.8 ? t : Infinity;
    }

    /** Keep the moving leaf out of a vertical character capsule. */
    overlapsActor(position: Laya.Vector3, footOffset: number, actorHeight: number, angle: number): boolean {
        const root = this.owner as Laya.Sprite3D, p = root.transform.position;
        const bottom = position.y - footOffset;
        if (bottom >= p.y + this.height || bottom + actorHeight <= p.y) return false;
        const yaw = root.transform.rotationEuler.y * Math.PI / 180, s = Math.sin(yaw), c = Math.cos(yaw);
        const dx = position.x - p.x, dz = position.z - p.z;
        const x = dx * c - dz * s, z = dx * s + dz * c;
        const hingeX = -this.width / 2 + .04, hingeZ = -.15;
        const a = angle * Math.PI / 180, ex = Math.cos(a) * (this.width - .08), ez = -Math.sin(a) * (this.width - .08);
        const t = Math.max(0, Math.min(1, ((x - hingeX) * ex + (z - hingeZ) * ez) / (ex * ex + ez * ez)));
        return Math.hypot(x - hingeX - t * ex, z - hingeZ - t * ez) < .56;
    }

    static fromNode(node: Laya.Node): Openable {
        for (let n = node; n; n = n.parent) {
            const opening = n.getComponent(Openable);
            if (opening) return opening;
        }
        return null;
    }
}
