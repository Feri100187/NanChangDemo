/** Shared visual keyframes. The Blender authoring tool reads these JSON literals too. */
export const KNIFE_MOTION = {
    "light": [
        [0, 0.20, -0.075, -0.68, 35, -18, -28],
        [0.22, 0.27, -0.16, -0.56, 50, -36, -48],
        [0.50, -0.03, -0.035, -0.82, -20, 45, 45],
        [0.56, -0.10, -0.04, -0.85, -27, 53, 53],
        [0.63, -0.10, -0.04, -0.85, -27, 53, 53],
        [0.84, 0.14, -0.11, -0.66, 28, -13, -24],
        [1, 0.20, -0.075, -0.68, 35, -18, -28]
    ],
    "heavy": [
        [0, 0.20, -0.075, -0.68, 35, -18, -28],
        [0.30, 0.28, 0.04, -0.54, 85, -30, -55],
        [0.42, 0.23, -0.03, -0.61, 60, -22, -60],
        [0.50, -0.04, -0.02, -0.96, -50, 17, -125],
        [0.55, -0.10, -0.065, -1.00, -63, 22, -135],
        [0.65, -0.10, -0.065, -1.00, -63, 22, -135],
        [1, 0.20, -0.075, -0.68, 35, -18, -28]
    ]
};

// Each row: phase, handle lift, rearward bolt travel, weapon tilt.
export const BOLT_MOTION = {
    "shot": [[0,0,0,0],[0.12,0,0,0],[0.25,1,0,0.55],[0.48,1,1,1],[0.60,1,1,1],[0.82,1,0,0.6],[0.95,0,0,0],[1,0,0,0]],
    "reload": [[0,0,0,0],[0.10,1,0,0.8],[0.22,1,1,1],[0.72,1,1,1],[0.87,1,0,0.8],[0.96,0,0,0],[1,0,0,0]]
};

export const BOLT_CYCLE_MS = 1050;

/** Bounded Hermite segments: flat duplicate keys create explicit action holds. */
export function motionValue(keys: number[][], phase: number, column: number): number {
    const t = Math.max(0, Math.min(1, phase));
    for (let i = 1; i < keys.length; i++) {
        if (t > keys[i][0]) continue;
        const a = keys[i - 1], b = keys[i];
        let u = (t - a[0]) / (b[0] - a[0]);
        u = u * u * (3 - 2 * u);
        return a[column] + (b[column] - a[column]) * u;
    }
    return keys[keys.length - 1][column];
}
