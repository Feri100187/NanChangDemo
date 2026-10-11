/** Route distances distinguish adjacent streets separated by buildings. */
export class MissionRoute {
    private lengths: number[] = [0];
    constructor(private points: { x: number; z: number }[]) {
        for (let i = 1; i < points.length; i++)
            this.lengths.push(this.lengths[i - 1] + Math.hypot(points[i].x - points[i - 1].x, points[i].z - points[i - 1].z));
    }
    progress(p: { x: number; z: number }): number {
        let best = Infinity, progress = 0;
        for (let i = 1; i < this.points.length; i++) {
            const a = this.points[i - 1], b = this.points[i], dx = b.x - a.x, dz = b.z - a.z;
            const t = Math.max(0, Math.min(1, ((p.x - a.x) * dx + (p.z - a.z) * dz) / (dx * dx + dz * dz || 1)));
            const distance = Math.hypot(p.x - a.x - dx * t, p.z - a.z - dz * t);
            if (distance < best) { best = distance; progress = this.lengths[i - 1] + t * (this.lengths[i] - this.lengths[i - 1]); }
        }
        return progress;
    }
    sample(progress: number, lateral = 0): { x: number; z: number } {
        if (progress < 0 && this.points.length > 1) {
            const a = this.points[0], b = this.points[1], length = this.lengths[1] || 1;
            const dx = (b.x - a.x) / length, dz = (b.z - a.z) / length;
            return {x: a.x + dx * progress - dz * lateral, z: a.z + dz * progress + dx * lateral};
        }
        const d = Math.max(0, Math.min(this.lengths[this.lengths.length - 1], progress));
        for (let i = 1; i < this.points.length; i++) {
            if (d > this.lengths[i]) continue;
            const a = this.points[i - 1], b = this.points[i], length = this.lengths[i] - this.lengths[i - 1];
            const dx = (b.x - a.x) / (length || 1), dz = (b.z - a.z) / (length || 1), t = d - this.lengths[i - 1];
            return { x: a.x + dx * t - dz * lateral, z: a.z + dz * t + dx * lateral };
        }
        return this.points[0];
    }
}
