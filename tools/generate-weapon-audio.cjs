// 原创挥刀音；历史合成装填音输出 .tmp/legacy-audio，不覆盖当前下载素材音效。
// 在工程根目录运行：node tools/generate-weapon-audio.cjs
const fs = require('fs');
const path = require('path');
const out = path.join(__dirname, '../assets/resources/combat-feedback');
const legacyOut = path.join(__dirname, '../.tmp/legacy-audio');
const sampleRate = 22050;

function writeWav(name, seconds, sample, outputDir = out) {
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
    fs.mkdirSync(outputDir, {recursive:true});
    fs.writeFileSync(path.join(outputDir, name), data);
}

let seed = 80629;
function noise() {
    seed = (Math.imul(seed, 1664525) + 1013904223) >>> 0;
    return seed / 4294967296 * 2 - 1;
}

// 拉开枪栓、装填、闭锁依次发生，配合当前 3.3 秒汉阳造装填流程。
// 以非整数倍的共振频率代替单一纯音，避免听起来像提示音。
let lowNoise = 0, midNoise = 0;
const clicks = [
    [0.06, 0.20, 780, 1120],  // 提起枪栓
    [0.34, 0.13, 520, 840],   // 枪栓后拉
    [0.82, 0.12, 450, 930],   // 弹药入位
    [1.42, 0.20, 570, 1240],  // 装填摩擦与碰撞
    [2.24, 0.17, 690, 1050],  // 装填结束
    [3.02, 0.30, 760, 1420],  // 推栓闭锁
];
const strokes = [
    [0.18, 0.54, 0.15],  // 拉开枪栓
    [0.91, 2.33, 0.20],  // 装填
    [2.62, 3.00, 0.16],  // 推回枪栓
];
writeWav('rifle-reload.wav', 3.2, t => {
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
}, legacyOut);

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
// 独立噪声序列使装填声改长时不会连带改变两段挥刀声。
seed = 48173;
writeWhoosh('knife-swing.wav', 0.42, false);
writeWhoosh('knife-heavy-swing.wav', 0.67, true);

console.log('Generated original reload, light knife and heavy knife sounds.');
