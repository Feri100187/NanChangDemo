/** Incremental grid search. Every edge is checked with the actor's physics envelope. */
export class BotNavigation {
    private open: { x: number; z: number; g: number; f: number; parent?: any }[] = [];
    private costs = new Map<string, number>();
    private path: Laya.Vector3[] = [];
    private goal: Laya.Vector3;
    private origin: Laya.Vector3;
    private expanded = 0;
    private retryAt = 0;

    step(position: Laya.Vector3, goal: Laya.Vector3, now: number,
        clear: (a: Laya.Vector3, b: Laya.Vector3) => boolean): Laya.Vector3 {
        if (!this.goal || Math.hypot(goal.x - this.goal.x, goal.z - this.goal.z) > 2.5
            || (!this.path.length && !this.open.length && now >= this.retryAt)) {
            this.goal = goal.clone(); this.origin = position.clone();
            this.path = []; this.costs.clear(); this.expanded = 0;
            this.open = [{ x: 0, z: 0, g: 0, f: 0 }]; this.costs.set('0,0', 0);
            this.retryAt = now + 2000;
        }
        if (clear(position, goal)) { this.path = []; this.open = []; return goal; }
        const point = (x: number, z: number) => new Laya.Vector3(
            this.origin.x + x * 1.25, position.y, this.origin.z + z * 1.25);
        for (let budget = 0; this.open.length && budget < 12 && this.expanded < 2400; budget++, this.expanded++) {
            this.open.sort((a, b) => b.f - a.f);
            const n = this.open.pop();
            if (n.g > this.costs.get(`${n.x},${n.z}`)) continue;
            const p = point(n.x, n.z);
            if (Math.hypot(p.x - goal.x, p.z - goal.z) < 2 && clear(p, goal)) {
                this.path = [goal.clone()];
                for (let c = n; c.parent; c = c.parent) this.path.unshift(point(c.x, c.z));
                this.open = []; break;
            }
            for (const [dx, dz] of [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]) {
                const x = n.x + dx, z = n.z + dz;
                if (Math.abs(x) > 70 || Math.abs(z) > 70) continue;
                const g = n.g + Math.hypot(dx, dz) * 1.25, key = `${x},${z}`, q = point(x, z);
                if (g >= (this.costs.get(key) ?? Infinity) || !clear(p, q)) continue;
                this.costs.set(key, g);
                this.open.push({ x, z, g, f: g + Math.hypot(q.x - goal.x, q.z - goal.z), parent: n });
            }
        }
        if (this.expanded >= 2400) this.open = [];
        while (this.path.length && Math.hypot(this.path[0].x - position.x, this.path[0].z - position.z) < .2) this.path.shift();
        return this.path[0] || position;
    }
}
