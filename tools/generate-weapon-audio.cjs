// 原创合成占位音；只生成新增装填和挥刀音，不覆盖现有枪声。
// 在工程根目录运行：node tools/generate-weapon-audio.cjs
const fs = require('fs');
const path = require('path');
const out = path.join(__dirname, '../assets/resources/combat-feedback');
const sampleRate = 22050;

function writeWav(name, seconds, sample) {
    const count = Math.floor(sampleRate * seconds);
    const data = Buffer.alloc(44 + count * 2);
    data.write('RIFF', 0); data.writeUInt32LE(data.length - 8, 4);
    data.write('WAVEfmt ', 8); data.writeUInt32LE(16, 16);
    data.writeUInt16LE(1, 20); data.writeUInt16LE(1, 22);
    data.writeUInt32LE(sampleRate, 24); data.writeUInt32LE(sampleRate * 2, 28);
    data.writeUInt16LE(2, 32); data.writeUInt16LE(16, 34);
    data.write('data', 36); data.writeUInt32LE(count * 2, 40);
    for (let i = 0; i < count; i++) {
        const value = Math.max(-0.85, Math.min(0.85, sample(i / sampleRate)));
        data.writeInt16LE(Math.round(value * 32767), 44 + i * 2);
    }
    fs.writeFileSync(path.join(out, name), data);
}

let seed = 80629;
function noise() {
    seed = (Math.imul(seed, 1664525) + 1013904223) >>> 0;
    return seed / 4294967296 * 2 - 1;
}

// 弹匣释放、抽出、插入、拍紧和拉机柄依次发生；短促金属碰撞叠加摩擦噪声。
// 以非整数倍的共振频率代替单一纯音，避免听起来像提示音。
let lowNoise = 0, midNoise = 0;
const clicks = [
    [0.06, 0.20, 780, 1120],  // 弹匣卡笋
    [0.34, 0.13, 520, 840],   // 旧弹匣离开
    [0.82, 0.12, 450, 930],   // 新弹匣对准
    [1.34, 0.31, 570, 1240],  // 弹匣入位
    [1.68, 0.17, 690, 1050],  // 拉机柄到底
    [1.94, 0.30, 760, 1420],  // 机柄回位
];
const strokes = [
    [0.18, 0.54, 0.15],  // 抽出弹匣
    [0.91, 1.33, 0.20],  // 插入弹匣
    [1.55, 1.90, 0.16],  // 拉动机柄
];
writeWav('rifle-reload.wav', 2.12, t => {
    const white = noise();
    lowNoise += 0.035 * (white - lowNoise);
    midNoise += 0.24 * (white - midNoise);
    const grit = white - midNoise;
    let sound = 0;
    for (const [start, end, gain] of strokes) {
        if (t < start || t > end) continue;
        const travel = (t - start) / (end - start);
        const envelope = Math.sin(Math.PI * travel);
        const ratchet = 0.76 + 0.24 * Math.sin(2 * Math.PI * 31 * (t - start));
        sound += gain * envelope * ratchet * (0.5 * grit + 1.2 * midNoise + 0.8 * lowNoise);
    }
    for (const [at, gain, pitchA, pitchB] of clicks) {
        const dt = t - at;
        if (dt < 0 || dt > 0.14) continue;
        const impact = Math.min(1, dt / 0.0015) * Math.exp(-dt * 48);
        const ring = Math.sin(2 * Math.PI * pitchA * dt) * 0.25
            + Math.sin(2 * Math.PI * pitchB * dt) * 0.18;
        const thud = Math.sin(2 * Math.PI * 170 * dt) * Math.exp(-dt * 85);
        sound += gain * impact * (grit * 0.75 + ring + thud * 0.42);
    }
    return sound;
});

// 扫频带通噪声模拟刀刃掠过空气；掠过镜头时气流增强，音高随远离而下降。
function writeWhoosh(name, duration, heavy) {
    let low = 0, mid = 0;
    writeWav(name, duration, t => {
        const progress = t / duration;
        const motion = Math.pow(Math.sin(Math.PI * progress), heavy ? 1.2 : 1.7);
        const pass = Math.exp(-Math.pow((progress - 0.56) / (heavy ? 0.23 : 0.18), 2));
        const white = noise();
        low += 0.025 * (white - low);
        mid += (0.07 + 0.38 * pass) * (white - mid);
        const air = mid - low;
        const hiss = white - mid;
        const bladePitch = heavy ? 920 : 1500;
        const drop = heavy ? 560 : 880;
        const whistle = Math.sin(2 * Math.PI * (bladePitch * t
            - drop * t * t / (2 * duration)));
        const flutter = 0.86 + 0.14 * Math.sin(2 * Math.PI * (heavy ? 11 : 17) * t);
        return motion * flutter * ((heavy ? 0.82 : 0.65) * air
            + (heavy ? 0.09 : 0.12) * hiss + (heavy ? 0.28 : 0.12) * low)
            + whistle * pass * motion * (heavy ? 0.065 : 0.05);
    });
}
writeWhoosh('knife-swing.wav', 0.42, false);
writeWhoosh('knife-heavy-swing.wav', 0.67, true);

console.log('Generated original reload, light knife and heavy knife sounds.');
