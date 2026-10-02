type FlyingCase = {
    node: Laya.Sprite3D;
    velocity: Laya.Vector3;
    spin: Laya.Vector3;
    expires: number;
    resting: boolean;
};

/** Small visual-only ballistic simulation. Sweeps against the level's existing
 * static colliders, without adding targets that could block bullets or actors. */
export class CasingEjection {
    private readonly active: FlyingCase[] = [];
    private readonly ray = new Laya.Ray(new Laya.Vector3(), new Laya.Vector3());
    private readonly hit = new Laya.HitResult();
    private readonly position = new Laya.Vector3();
    private readonly rotation = new Laya.Vector3();

    constructor(private readonly template: Laya.Sprite3D, private readonly scene: Laya.Scene3D) {}

    eject(gun: Laya.Transform3D, now: number, lifetime: number, speed: number, viewScale = 1): void {
        if (this.template.destroyed || this.scene.destroyed) return;
        while (this.active.length >= 8) this.active.shift().node.destroy(true);
        // Ignore RifleBox's legacy nonuniform scale; offsets/velocities are meters.
        this.position.setValue(0.012, 0.18, 0.21);
        Laya.Vector3.scale(this.position, viewScale, this.position);
        Laya.Vector3.transformQuat(this.position, gun.rotation, this.position);
        Laya.Vector3.add(this.position, gun.position, this.position);
        const node = Laya.Sprite3D.instantiate(this.template, this.scene, false, this.position, gun.rotation);
        node.name = "EjectedCase";
        node.transform.localScale = new Laya.Vector3(viewScale, viewScale, viewScale);
        node.active = true;
        const multiplier = Number.isFinite(speed) ? Math.max(0.1, Math.min(3, speed)) : 1;
        const velocity = new Laya.Vector3((0.85 + Math.random() * 0.25) * multiplier,
            (1.35 + Math.random() * 0.3) * multiplier, (0.1 + Math.random() * 0.2) * multiplier);
        Laya.Vector3.transformQuat(velocity, gun.rotation, velocity);
        this.active.push({ node, velocity, spin: new Laya.Vector3(8 + Math.random() * 7,
            4 + Math.random() * 5, -10 - Math.random() * 8),
            expires: now + (Number.isFinite(lifetime) ? Math.max(0.2, Math.min(10, lifetime)) : 4) * 1000,
            resting: false });
    }

    update(dt: number, now: number): void {
        // Fixed-size substeps plus a swept segment prevent this small prop from
        // tunnelling through walls/floors. No async loading or real-time callbacks.
        const steps = Math.max(1, Math.ceil(Math.min(dt, 0.05) / (1 / 120)));
        const step = Math.max(0, Math.min(dt, 0.05)) / steps;
        for (let i = this.active.length - 1; i >= 0; --i) {
            const item = this.active[i];
            if (item.node.destroyed || now >= item.expires) {
                if (!item.node.destroyed) item.node.destroy(true);
                this.active.splice(i, 1);
                continue;
            }
            if (item.resting || step === 0) continue;
            for (let j = 0; j < steps && !item.resting; ++j) this.advance(item, step);
        }
    }

    private advance(item: FlyingCase, dt: number): void {
        const v = item.velocity;
        v.y -= 9.81 * dt;
        const p = item.node.transform.position;
        const length = Math.hypot(v.x, v.y, v.z) * dt;
        if (length < 0.000001) return;
        this.ray.direction.setValue(v.x * dt / length, v.y * dt / length, v.z * dt / length);
        const d = this.ray.direction;
        // Bullet can miss rays starting within a collider's contact margin.
        // Back up the query, but accept only approaching contacts at this step.
        const back = 0.06;
        this.ray.origin.setValue(p.x - d.x * back, p.y - d.y * back, p.z - d.z * back);
        // Group 1 is the existing level geometry; player/enemy groups are excluded.
        const collided = this.scene.physicsSimulation.rayCast(this.ray, this.hit, length + 0.007 + back, -1, 1)
            && Laya.Vector3.dot(d, this.hit.normal) < 0
            && (this.hit.point.x - p.x) * d.x + (this.hit.point.y - p.y) * d.y
                + (this.hit.point.z - p.z) * d.z >= -0.008;
        if (collided) {
            const n = this.hit.normal;
            this.position.setValue(this.hit.point.x + n.x * 0.008,
                this.hit.point.y + n.y * 0.008, this.hit.point.z + n.z * 0.008);
            const inward = v.x * n.x + v.y * n.y + v.z * n.z;
            if (inward < 0) {
                // Retain 55% of tangential speed and 28% of normal speed.
                v.setValue((v.x - n.x * inward) * 0.55 - n.x * inward * 0.28,
                    (v.y - n.y * inward) * 0.55 - n.y * inward * 0.28,
                    (v.z - n.z * inward) * 0.55 - n.z * inward * 0.28);
                Laya.Vector3.scale(item.spin, 0.5, item.spin);
            }
            if (n.y > 0.65 && Math.hypot(v.x, v.y, v.z) < 0.25) {
                item.resting = true;
                // A spent case settles on its side rather than standing upright.
                const angles = item.node.transform.rotationEuler;
                this.rotation.setValue(0, angles.y, 0);
                item.node.transform.rotationEuler = this.rotation;
            }
        } else this.position.setValue(p.x + v.x * dt, p.y + v.y * dt, p.z + v.z * dt);
        item.node.transform.position = this.position;
        if (!item.resting) {
            this.rotation.setValue(item.spin.x * dt, item.spin.y * dt, item.spin.z * dt);
            item.node.transform.rotate(this.rotation, false, true);
        }
    }

    clear(): void {
        for (const item of this.active) if (!item.node.destroyed) item.node.destroy(true);
        this.active.length = 0;
    }
}
