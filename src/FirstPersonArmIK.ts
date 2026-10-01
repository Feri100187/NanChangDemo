import { ARM_BIND_POSE } from "./ArmBindPose";

type Joint = { node: Laya.Sprite3D; p: Laya.Vector3; q: Laya.Quaternion };
type Arm = {
    side: "L" | "R";
    joints: Record<string, Joint>;
    target: Laya.Sprite3D;
    anchor: Laya.Vector3;
    fingers: [Laya.Sprite3D, Laya.Sprite3D][];
    upperLength: number;
    lowerLength: number;
    previousElbow: Laya.Vector3;
    hasPrevious: boolean;
    roll: number;
};

/** Drives the original body's arms from its clavicles to the animated grip targets.
 * The second Animator supplies hand/finger actions only; it is never rendered. */
export class FirstPersonArmIK {
    private readonly arms: Arm[] = [];
    private readonly probe = new Laya.SphereColliderShape(0.05);
    private readonly hit = new Laya.HitResult();
    private readonly matrix = new Laya.Matrix4x4();
    private readonly inverseBody = new Laya.Matrix4x4();
    private readonly shoulder = new Laya.Vector3();
    private readonly wrist = new Laya.Vector3();
    private readonly elbow = new Laya.Vector3();
    private readonly direction = new Laya.Vector3();
    private readonly pole = new Laya.Vector3();
    private readonly normal = new Laya.Vector3();
    private readonly center = new Laya.Vector3();
    private readonly candidate = new Laya.Vector3();
    private readonly local = new Laya.Vector3();
    private readonly temp = new Laya.Vector3();
    private readonly lowerAxis = new Laya.Vector3();
    private readonly handForward = new Laya.Vector3();
    private readonly scale = new Laya.Vector3();
    private readonly handRotation = new Laya.Quaternion();
    private readonly upperRotation = new Laya.Quaternion();
    private readonly lowerRotation = new Laya.Quaternion();
    private readonly partialTwist = new Laya.Quaternion();
    private readonly identity = new Laya.Quaternion();
    private readonly q0 = new Laya.Quaternion();
    private readonly q1 = new Laya.Quaternion();
    private readonly q2 = new Laya.Quaternion();

    constructor(private readonly body: Laya.Sprite3D, targets: Laya.Sprite3D,
        private readonly scene: Laya.Scene3D) {
        const bodyNodes = new Map<string, Laya.Sprite3D>(), targetNodes = new Map<string, Laya.Sprite3D>();
        const visit = (node: Laya.Sprite3D, map: Map<string, Laya.Sprite3D>) => {
            map.set(node.name, node);
            for (let i = 0; i < node.numChildren; i++) visit(node.getChildAt(i) as Laya.Sprite3D, map);
        };
        visit(body, bodyNodes); visit(targets, targetNodes);
        for (const side of ["L", "R"] as const) {
            const joints: Record<string, Joint> = {};
            const definition: Record<string, {p: number[]; q: number[]}> = ARM_BIND_POSE[side];
            for (const part of Object.keys(definition)) {
                const bind = definition[part];
                joints[part] = { node: bodyNodes.get(`${side}_${part}`),
                    p: new Laya.Vector3(...bind.p), q: new Laya.Quaternion(...bind.q) };
            }
            if (Object.keys(joints).some(part => !joints[part].node) || !targetNodes.has(`${side}_Hand`)) continue;
            const fingers: [Laya.Sprite3D, Laya.Sprite3D][] = [];
            for (const [name, node] of bodyNodes) {
                if (name.startsWith(side + "_") && /_(Thumb|Index|Middle|Ring|Little)_/.test(name)
                    && targetNodes.has(name)) fingers.push([node, targetNodes.get(name)]);
            }
            this.arms.push({ side, joints, target: targetNodes.get(`${side}_Hand`), fingers,
                anchor: joints.Upperarm.node.transform.localPosition.clone(),
                upperLength: Laya.Vector3.distance(joints.Upperarm.p, joints.Forearm.p),
                lowerLength: Laya.Vector3.distance(joints.Forearm.p, joints.Hand.p),
                previousElbow: new Laya.Vector3(), hasPrevious: false, roll: 0 });
        }
    }

    update(handScale: number, dt: number): void {
        this.body.transform.worldMatrix.invert(this.inverseBody);
        for (const arm of this.arms) {
            const j = arm.joints;
            // The shoulder is evaluated from the body's animated clavicle, not a
            // camera/gun offset. Do not move it to make an unreachable grip fit.
            Laya.Vector3.transformCoordinate(arm.anchor, (j.Upperarm.node.parent as Laya.Sprite3D).transform.worldMatrix, this.shoulder);
            arm.target.transform.position.cloneTo(this.wrist);
            arm.target.transform.rotation.cloneTo(this.handRotation);
            Laya.Vector3.subtract(this.wrist, this.shoulder, this.direction);
            const distance = Math.max(0.001, this.direction.length());
            Laya.Vector3.scale(this.direction, 1 / distance, this.direction);
            // Keep the original total length when the grip is near the body;
            // longer view poses extend along the limb, never across its width.
            let upper = arm.upperLength, lower = arm.lowerLength;
            this.pole.setValue(arm.side === "L" ? 0.30 : -0.30, -0.35, arm.side === "L" ? 0.08 : -0.12);
            Laya.Vector3.transformQuat(this.pole, this.body.transform.rotation, this.pole);
            const dot = Laya.Vector3.dot(this.pole, this.direction);
            this.pole.setValue(this.pole.x - dot * this.direction.x, this.pole.y - dot * this.direction.y,
                this.pole.z - dot * this.direction.z);
            if (this.pole.lengthSquared() < 0.000001) {
                this.temp.setValue(Math.abs(this.direction.y) < 0.9 ? 0 : 1,
                    Math.abs(this.direction.y) < 0.9 ? 1 : 0, 0);
                Laya.Vector3.cross(this.direction, this.temp, this.pole);
            }
            Laya.Vector3.normalize(this.pole, this.pole);
            Laya.Vector3.cross(this.direction, this.pole, this.normal);
            this.handForward.setValue(0, 1, 0);
            Laya.Vector3.transformQuat(this.handForward, this.handRotation, this.handForward);
            Laya.Vector3.transformCoordinate(this.shoulder, this.inverseBody, this.local);
            const shoulderY = this.local.y;
            let best = Infinity;
            for (const reach of [0.96, 0.82, 0.70]) {
                const length = Math.max(arm.upperLength + arm.lowerLength, distance / reach);
                const a = length * 0.52, b = length * 0.48;
                const along = (a * a - b * b + distance * distance) / (2 * distance);
                const radius = Math.sqrt(Math.max(0, a * a - along * along));
                this.center.setValue(this.shoulder.x + this.direction.x * along,
                    this.shoulder.y + this.direction.y * along, this.shoulder.z + this.direction.z * along);
                let clear = false;
                for (const degrees of [0, -30, 30, -60, 60, -90, 90, -120, 120, -150, 150, 180]) {
                    const angle = degrees * Math.PI / 180;
                    const c = Math.cos(angle) * radius, s = Math.sin(angle) * radius;
                    this.candidate.setValue(this.center.x + this.pole.x * c + this.normal.x * s,
                        this.center.y + this.pole.y * c + this.normal.y * s,
                        this.center.z + this.pole.z * c + this.normal.z * s);
                    Laya.Vector3.subtract(this.wrist, this.candidate, this.temp);
                    Laya.Vector3.normalize(this.temp, this.temp);
                    const preference = Math.abs(angle) * 0.12 + (1 - Laya.Vector3.dot(this.temp, this.handForward));
                    let penalty = Math.max(0, this.candidate.y - Math.max(this.shoulder.y, this.wrist.y - 0.06)) * 100;
                    Laya.Vector3.transformCoordinate(this.candidate, this.inverseBody, this.local);
                    penalty += Math.max(0, 0.02 - (arm.side === "L" ? this.local.x : -this.local.x)) * 1000;
                    penalty += this.torsoCost(this.candidate, shoulderY);
                    for (const t of [0.2, 0.4, 0.6, 0.8]) {
                        Laya.Vector3.lerp(this.candidate, this.wrist, t, this.temp);
                        penalty += this.torsoCost(this.temp, shoulderY);
                    }
                    if (this.scene.physicsSimulation.shapeCast(this.probe.shape, this.shoulder, this.candidate,
                        this.hit, null, null, -1, 1)) penalty += 100;
                    if (this.scene.physicsSimulation.shapeCast(this.probe.shape, this.candidate, this.wrist,
                        this.hit, null, null, -1, 1)) penalty += 100;
                    const cost = (penalty < 0.00001 ? 0 : 1000 + penalty * 1000) + preference;
                    if (penalty < 0.00001) clear = true;
                    if (cost < best) { best = cost; upper = a; lower = b; this.candidate.cloneTo(this.elbow); }
                }
                if (clear) break; // Only add bend room when the shorter pose is obstructed.
            }
            if (arm.hasPrevious) {
                Laya.Vector3.transformCoordinate(arm.previousElbow, this.body.transform.worldMatrix, this.candidate);
                Laya.Vector3.lerp(this.candidate, this.elbow, 1 - Math.exp(-30 * dt), this.candidate);
                Laya.Vector3.transformCoordinate(this.candidate, this.inverseBody, this.local);
                let clear = (arm.side === "L" ? this.local.x : -this.local.x) >= 0.02
                    && this.candidate.y <= Math.max(this.shoulder.y, this.wrist.y - 0.06) + 0.005
                    && this.torsoCost(this.candidate, shoulderY) === 0;
                for (const t of [0.2, 0.4, 0.6, 0.8]) {
                    Laya.Vector3.lerp(this.candidate, this.wrist, t, this.temp);
                    if (this.torsoCost(this.temp, shoulderY)) clear = false;
                }
                if (clear && !this.scene.physicsSimulation.shapeCast(this.probe.shape, this.shoulder,
                    this.candidate, this.hit, null, null, -1, 1)
                    && !this.scene.physicsSimulation.shapeCast(this.probe.shape, this.candidate,
                        this.wrist, this.hit, null, null, -1, 1)) this.candidate.cloneTo(this.elbow);
            }
            Laya.Vector3.transformCoordinate(this.elbow, this.inverseBody, arm.previousElbow);
            arm.hasPrevious = true;
            upper = Laya.Vector3.distance(this.shoulder, this.elbow);
            lower = Laya.Vector3.distance(this.elbow, this.wrist);
            this.aimBind(j.Upperarm, j.Forearm.p, this.shoulder, this.elbow, this.upperRotation);
            this.aimBind(j.Forearm, j.Hand.p, this.elbow, this.wrist, this.lowerRotation);
            Laya.Vector3.subtract(this.wrist, this.elbow, this.lowerAxis);
            Laya.Vector3.normalize(this.lowerAxis, this.lowerAxis);
            // Extract pronation around the forearm, then distribute it over the
            // existing twist joints. The wrist no longer absorbs the whole roll.
            Laya.Quaternion.invert(j.Hand.q, this.q0);
            Laya.Quaternion.multiply(this.handRotation, this.q0, this.q1);
            Laya.Quaternion.multiply(this.q1, j.Forearm.q, this.q0);
            Laya.Quaternion.invert(this.lowerRotation, this.q1);
            Laya.Quaternion.multiply(this.q0, this.q1, this.q2);
            const roll = this.q2.x * this.lowerAxis.x + this.q2.y * this.lowerAxis.y + this.q2.z * this.lowerAxis.z;
            let angle = 2 * Math.atan2(roll, this.q2.w);
            angle += Math.round((arm.roll - angle) / (Math.PI * 2)) * Math.PI * 2;
            arm.roll = angle; // Keep the twist continuous when crossing +/-180 degrees.
            this.pose(j.Upperarm.node, this.shoulder, this.upperRotation, 1, upper / arm.upperLength);
            this.pose(j.Forearm.node, this.elbow, this.lowerRotation, handScale, lower / arm.lowerLength);
            for (const [part, t, rollPart] of [["UpperarmTwist01", 0, 0], ["UpperarmTwist02", 0.5, 0],
                ["ForearmTwist01", 0, 1 / 3], ["ForearmTwist02", 0.5, 2 / 3]] as const) {
                const isUpper = part.startsWith("Upper");
                const base = isUpper ? j.Upperarm : j.Forearm;
                const rotation = isUpper ? this.upperRotation : this.lowerRotation;
                Laya.Quaternion.invert(base.q, this.q0);
                Laya.Quaternion.multiply(rotation, this.q0, this.q1);
                Laya.Quaternion.multiply(this.q1, j[part].q, this.q0);
                Laya.Quaternion.createFromAxisAngle(this.lowerAxis, arm.roll * rollPart, this.partialTwist);
                Laya.Quaternion.multiply(this.partialTwist, this.q0, this.q1);
                Laya.Vector3.lerp(isUpper ? this.shoulder : this.elbow, isUpper ? this.elbow : this.wrist, t, this.temp);
                this.pose(j[part].node, this.temp, this.q1, isUpper && t === 0 ? 1 : handScale,
                    isUpper ? upper / arm.upperLength : lower / arm.lowerLength);
            }
            this.pose(j.Hand.node, this.wrist, this.handRotation, handScale, handScale);
            for (const [bone, target] of arm.fingers) {
                bone.transform.localPosition = target.transform.localPosition;
                bone.transform.localRotation = target.transform.localRotation;
                bone.transform.localScale = target.transform.localScale;
            }
        }
    }

    private torsoCost(point: Laya.Vector3, shoulderY: number): number {
        Laya.Vector3.transformCoordinate(point, this.inverseBody, this.local);
        return Math.abs(this.local.x) < 0.255 && this.local.z > -0.18 && this.local.z < 0.24
            && this.local.y > shoulderY - 0.52 && this.local.y < shoulderY + 0.03 ? 10 : 0;
    }

    private aimBind(joint: Joint, end: Laya.Vector3, from: Laya.Vector3, to: Laya.Vector3, out: Laya.Quaternion): void {
        Laya.Vector3.subtract(end, joint.p, this.local);
        Laya.Vector3.transformQuat(this.local, this.body.transform.rotation, this.local);
        Laya.Vector3.normalize(this.local, this.local);
        Laya.Vector3.subtract(to, from, this.temp); Laya.Vector3.normalize(this.temp, this.temp);
        this.identity.cloneTo(this.q0);
        joint.node.transform.rotationTo(this.q0, this.local, this.temp);
        Laya.Quaternion.multiply(this.body.transform.rotation, joint.q, this.q1);
        Laya.Quaternion.multiply(this.q0, this.q1, out);
    }

    private pose(node: Laya.Sprite3D, position: Laya.Vector3, rotation: Laya.Quaternion, width: number, length: number): void {
        this.scale.setValue(width, length, width);
        Laya.Matrix4x4.createAffineTransformation(position, rotation, this.scale, this.matrix);
        node.transform.worldMatrix = this.matrix;
    }

    destroy(): void { this.probe.destroy(); }
}
