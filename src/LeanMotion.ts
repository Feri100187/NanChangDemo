/** Shared, collision-limited upper-body lean. Positive = actor's right. */
export class LeanMotion {
    static readonly distance = .12;
    static readonly angle = 8;
    static readonly bodyShift = .02;
    value = 0;
    private shape = new Laya.SphereColliderShape(.18);
    private hits: Laya.HitResult[] = [];
    private end = new Laya.Vector3();

    update(request: number, dt: number, owner: Laya.Sprite3D, eye: Laya.Vector3, right: Laya.Vector3): void {
        const next = this.value + Math.max(-dt * 5, Math.min(dt * 5, request - this.value));
        this.end.setValue(eye.x + right.x * next * LeanMotion.distance, eye.y,
            eye.z + right.z * next * LeanMotion.distance);
        this.value = next * this.limit(owner, eye, this.end);
    }

    limit(owner: Laya.Sprite3D, from: Laya.Vector3, to: Laya.Vector3): number {
        this.hits.length = 0;
        (owner.scene as Laya.Scene3D).physicsSimulation.shapeCastAll(this.shape.shape,
            from, to, this.hits, null, null, -1, -1);
        let fraction = 1;
        for (const hit of this.hits) {
            const node = hit.collider?.owner;
            if (!node || node === owner || owner.isAncestorOf(node)) continue;
            fraction = Math.min(fraction, Math.max(0, hit.hitFraction - .05));
        }
        return fraction;
    }

    destroy(): void { this.shape.destroy(); this.hits.length = 0; }
}

/** Applied after Animator; restored before its next evaluation, so poses never accumulate. */
export class UpperBodyLean {
    private basePosition = new Laya.Vector3();
    private baseRotation = new Laya.Quaternion();
    private forward = new Laya.Vector3();
    private right = new Laya.Vector3();
    private rotation = new Laya.Quaternion();
    private result = new Laya.Quaternion();
    private position = new Laya.Vector3();
    private applied = false;
    constructor(private spine: Laya.Sprite3D) {}
    restore(): void {
        if (!this.applied || !this.spine || this.spine.destroyed) return;
        this.spine.transform.localPosition = this.basePosition;
        this.spine.transform.localRotation = this.baseRotation;
        this.applied = false;
    }
    apply(reference: Laya.Sprite3D, amount: number): void {
        if (!this.spine || !reference || Math.abs(amount) < .001) return;
        const transform = this.spine.transform;
        transform.localPosition.cloneTo(this.basePosition);
        transform.localRotation.cloneTo(this.baseRotation);
        Laya.Vector3.transformQuat(new Laya.Vector3(0,0,1), reference.transform.rotation, this.forward);
        Laya.Vector3.transformQuat(new Laya.Vector3(-1,0,0), reference.transform.rotation, this.right);
        Laya.Quaternion.createFromAxisAngle(this.forward, amount * LeanMotion.angle * Math.PI / 180, this.rotation);
        Laya.Quaternion.multiply(this.rotation, transform.rotation, this.result);
        transform.rotation = this.result;
        const p = transform.position;
        // A small shoulder tilt, rather than stretching the waist sideways.
        this.position.setValue(p.x + this.right.x * amount * LeanMotion.bodyShift, p.y,
            p.z + this.right.z * amount * LeanMotion.bodyShift);
        transform.position = this.position;
        this.applied = true;
    }
}
