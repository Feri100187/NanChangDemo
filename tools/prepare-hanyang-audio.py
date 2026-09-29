"""从已下载的授权素材重建汉阳造游戏拟声音效。

运行：blender --background --factory-startup --python tools/prepare-hanyang-audio.py
使用 Blender 自带的 aud 解码器和 numpy；不增加游戏运行时依赖，不自动联网。
来源、许可与原始哈希见 audio-sources/hanyang/sources.json 和 docs/audio-credits.md。
"""
import aud
import hashlib
import json
import wave
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "audio-sources/hanyang"
OUTPUT = ROOT / "assets/resources/combat-feedback"
RATE = 44100


def read(name):
    sound = aud.Sound(str(SOURCE / name))
    rate, _ = sound.specs
    mono = np.asarray(sound.data(), dtype=np.float64).mean(axis=1)
    if int(rate) != RATE:
        mono = np.interp(np.arange(round(len(mono) * RATE / rate)) / RATE,
                         np.arange(len(mono)) / rate, mono)
    return mono


def cut(samples, start, end):
    return samples[round(start * RATE):round(end * RATE)].copy()


def fade(samples, attack=.003, release=.03):
    samples = samples.copy()
    a, r = min(round(attack * RATE), len(samples)), min(round(release * RATE), len(samples))
    if a:
        samples[:a] *= np.linspace(0, 1, a)
    if r:
        samples[-r:] *= np.linspace(1, 0, r)
    return samples


def filter_noise(samples, noise, highpass=80, lowpass=11000):
    # 短时频谱降噪，保留枪声瞬态；只处理素材，不合成替代枪声。
    size, hop = 1024, 256
    window = np.hanning(size)
    profile = [np.abs(np.fft.rfft(noise[i:i+size] * window))
               for i in range(0, len(noise)-size+1, hop)]
    floor = np.median(profile, axis=0) if profile else np.zeros(size//2+1)
    padded = np.pad(samples, (size, size))
    result, weights = np.zeros_like(padded), np.zeros_like(padded)
    frequency = np.fft.rfftfreq(size, 1 / RATE)
    band = (1 - np.exp(-(frequency / highpass)**4)) / (1 + (frequency / lowpass)**8)
    for i in range(0, len(padded)-size+1, hop):
        spectrum = np.fft.rfft(padded[i:i+size] * window)
        gain = np.clip(1 - floor * 1.4 / (np.abs(spectrum) + 1e-9), .06, 1)
        result[i:i+size] += np.fft.irfft(spectrum * gain * band) * window
        weights[i:i+size] += window**2
    return (result / np.maximum(weights, 1e-8))[size:size+len(samples)]


def peak(samples, target):
    return samples * (target / max(float(np.max(np.abs(samples))), 1e-9))


def write(name, samples):
    samples = np.clip(samples, -.98, .98)
    pcm = np.rint(samples * 32767).astype('<i2')
    file = OUTPUT / name
    with wave.open(str(file), 'wb') as output:
        output.setnchannels(1)
        output.setsampwidth(2)
        output.setframerate(RATE)
        output.writeframes(pcm.tobytes())
    return {'file': name, 'seconds': len(samples)/RATE, 'sampleRate': RATE,
            'peak': float(np.max(np.abs(pcm.astype(float))))/32767,
            'rms': float(np.sqrt(np.mean(samples**2))),
            'sha256': hashlib.sha256(file.read_bytes()).hexdigest()}


manifest = json.loads((SOURCE / 'sources.json').read_text(encoding='utf8'))
for item in manifest['sources']:
    if hashlib.sha256((SOURCE/item['file']).read_bytes()).hexdigest() != item['sha256']:
        raise RuntimeError('原始素材哈希不匹配：' + item['file'])

shot = read('tabasco-mosin.wav')
# 首发瞬态附近，向前保留 2ms；取 1.15s，避开后续射击及其它环境事件。
onset = int(np.flatnonzero(np.abs(shot[:RATE]) > .28)[0])
start = max(0, onset-88)
dry = shot[start:start+round(RATE*1.15)]
ambient = shot[:round(RATE*.25)]
player = fade(filter_noise(dry, ambient), .001, .22)
enemy = fade(filter_noise(dry, ambient, lowpass=5200), .001, .24)

bolt = read('fennelliott-gun-bolt.mp3')
noise = cut(bolt, .85, 1.15)
opening = peak(fade(filter_noise(cut(bolt, .08, .68), noise, highpass=130)), .55)
closing = peak(fade(filter_noise(cut(bolt, 1.36, 1.97), noise, highpass=130)), .62)
clip1 = peak(fade(read('bmaczero-clipload1.wav')), .43)
clip2 = peak(fade(read('bmaczero-clipload2.wav')), .34)
reload = np.zeros(round(RATE*3.2))
for at, samples in [(.04, opening), (1.05, clip1), (1.72, clip2), (2.54, closing)]:
    i = round(at * RATE)
    count = min(len(samples), len(reload)-i)
    reload[i:i+count] += samples[:count]

OUTPUT.mkdir(parents=True, exist_ok=True)
report = [write('player-shot.wav', peak(player, .78)),
          write('enemy-shot.wav', peak(enemy, .66)),
          write('rifle-reload.wav', fade(reload, .003, .045))]
print(json.dumps({'shotSourceStartSeconds': start/RATE, 'outputs': report}, indent=2))
