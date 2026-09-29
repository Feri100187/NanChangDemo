// 原创合成占位音；MIT。无需采样素材或音频库，输出 22.05 kHz / 16-bit / 单声道 WAV。
// 历史占位音，仅输出 .tmp/legacy-audio；当前游戏音效由 prepare-hanyang-audio.py 重建。
// 在工程根目录运行：node tools/generate-combat-audio.cjs
const fs = require('fs');
const path = require('path');
const out = path.join(__dirname, '../.tmp/legacy-audio');
fs.mkdirSync(out, {recursive:true});
const sampleRate = 22050;
function synth(name, seconds, seed, pitch) {
    const samples = Math.floor(sampleRate * seconds), data = Buffer.alloc(44 + samples * 2);
    data.write('RIFF',0);data.writeUInt32LE(data.length-8,4);data.write('WAVEfmt ',8);
    data.writeUInt32LE(16,16);data.writeUInt16LE(1,20);data.writeUInt16LE(1,22);
    data.writeUInt32LE(sampleRate,24);data.writeUInt32LE(sampleRate*2,28);
    data.writeUInt16LE(2,32);data.writeUInt16LE(16,34);data.write('data',36);data.writeUInt32LE(samples*2,40);
    let lowNoise = 0;
    for(let i=0;i<samples;i++) {
        const t=i/sampleRate;
        seed=(Math.imul(seed,1664525)+1013904223)>>>0;
        const noise=seed/4294967296*2-1;
        lowNoise+=0.32*(noise-lowNoise);
        const attack=Math.min(1,t/0.0015),tail=Math.pow(Math.max(0,1-t/seconds),2);
        const crack=(noise-lowNoise)*Math.exp(-t*85);
        const body=Math.sin(2*Math.PI*(pitch*t-180*t*t))*Math.exp(-t*42);
        const value=(crack*0.46+lowNoise*0.38+body*0.3)*attack*tail;
        data.writeInt16LE(Math.round(Math.max(-0.8,Math.min(0.8,value))*32767),44+i*2);
    }
    fs.writeFileSync(path.join(out,name),data);
}
synth('player-shot.wav',0.095,73481,190);
synth('enemy-shot.wav',0.115,21947,145);
console.log('Generated two legacy placeholder shots in .tmp/legacy-audio.');
