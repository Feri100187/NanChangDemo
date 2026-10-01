/** Fits weapons and hand targets into the free space around the camera.
 * Visible arms are anchored separately; world depth and lighting remain enabled. */
export class WeaponPresentation {
    scale = 0.90;
    private maximumScale = 0.90;
    private obstruction = 0;
    private readonly probe = new Laya.SphereColliderShape(0.045);
    private readonly hit = new Laya.HitResult();
    private readonly local = new Laya.Vector3();
    private readonly end = new Laya.Vector3();
    private readonly position = new Laya.Vector3();
    private readonly rotation = new Laya.Vector3();
    private readonly size = new Laya.Vector3(1, 1, 1);

    constructor(private readonly pivot: Laya.Sprite3D, private readonly scene: Laya.Scene3D) {}

    setMaximumScale(value: number): void {
        this.maximumScale = value;
        this.scale = Math.min(this.scale, value);
    }

    apply(eye: Laya.Vector3, camera: Laya.Camera, angles: Laya.Vector3, aim: number): void {
        // When looking at the feet, the eyes turn farther down than the held rifle.
        // ADS still follows the camera exactly so the sight/ray alignment is unchanged.
        const freeLook = Math.max(0, -angles.x - 45) * 0.55 * (1 - aim);
        this.rotation.setValue(angles.x + freeLook - 9 * this.obstruction * (1 - aim), angles.y, 0);
        this.pivot.transform.rotationEuler = this.rotation;
        const c = camera.transform.position;
        this.position.setValue(c.x + (eye.x - c.x) * this.scale,
            c.y + (eye.y - c.y) * this.scale, c.z + (eye.z - c.z) * this.scale);
        this.pivot.transform.position = this.position;
        this.size.setValue(this.scale, this.scale, this.scale);
        this.pivot.transform.localScale = this.size;
    }

    update(eye: Laya.Vector3, camera: Laya.Camera, angles: Laya.Vector3, aim: number, dt: number): void {
        this.apply(eye, camera, angles, aim);
        let safeScale = this.maximumScale;
        const start = camera.transform.position;
        // A padded envelope covers the muzzle, sleeves, reload hand and knife swing.
        // Sweeps have volume, including at door edges and oblique wall approaches.
        for (const x of [-0.52, 0.18, 0.82]) for (const y of [-0.98, -0.25, 0.50]) {
            for (const z of [-1.72, -0.60, 0.08]) {
                this.local.setValue(x, y, z);
                Laya.Vector3.transformQuat(this.local, this.pivot.transform.rotation, this.end);
                Laya.Vector3.add(this.end, eye, this.end);
                if (this.scene.physicsSimulation.shapeCast(this.probe.shape, start, this.end,
                    this.hit, null, null, -1, 1)) {
                    safeScale = Math.min(safeScale, Math.max(0.025, this.hit.hitFraction - 0.015));
                }
            }
        }
        // Move inward immediately for safety; ease out to avoid a pop on leaving a wall.
        this.scale = safeScale < this.scale ? safeScale
            : this.scale + (safeScale - this.scale) * (1 - Math.exp(-12 * dt));
        this.obstruction += ((1 - safeScale / this.maximumScale) - this.obstruction) * (1 - Math.exp(-12 * dt));
        this.apply(eye, camera, angles, aim);
    }

    destroy(): void {
        this.probe.destroy();
        if (!this.pivot.destroyed) {
            this.size.setValue(1, 1, 1);
            this.pivot.transform.localScale = this.size;
        }
    }
}
