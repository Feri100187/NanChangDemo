// Package an actual LayaAir 3.4.1 Web export. Never copies assets/library/src.
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const {execFileSync} = require('node:child_process');
const repo = path.resolve(__dirname, '..');
const git = (...args) => execFileSync('git',args,{cwd:repo,encoding:'utf8'}).trim();
const input = path.resolve(process.argv[2] || path.join(repo,'release/web'));
const output = process.argv[3] && path.resolve(process.argv[3]);
const draft = process.argv.includes('--draft');
if (!output || fs.existsSync(output)) throw Error('Supply a NEW output directory. Existing directories are never overwritten.');
if (output === repo || output.startsWith(input + path.sep)) throw Error('Output must be independent of the Web export.');
if (!draft && git('status','--porcelain')) throw Error('Commit changes and rebuild before final packaging; --draft is test-only.');
if (JSON.parse(fs.readFileSync(path.join(repo,'NanChangDemo.laya'))).version !== '3.4.1') throw Error('Expected LayaAir 3.4.1');
const sha = git('rev-parse','HEAD');
const scene = JSON.parse(fs.readFileSync(path.join(input,'Demo01.ls')));
const source = JSON.parse(fs.readFileSync(path.join(repo,'assets/Demo01.ls')));
const mission = scene._$comp.find(c=>c.missionDocument);
const original = source._$comp.find(c=>c.missionDocument);
for (const key of ['enemies','streetEnemies','courtyardEnemies','missionDocument','documentRange','documentAimRadius']) {
  if (!mission || JSON.stringify(mission[key]) !== JSON.stringify(original[key])) throw Error('Stale exported mission binding: '+key);
}
if (!fs.readFileSync(path.join(input,'js/index.js'),'utf8').includes('"startupScene":"Demo01.ls"')) throw Error('Wrong startup scene');
if (!draft && fs.statSync(path.join(input,'js/bundle.js')).mtimeMs < Number(git('show','-s','--format=%ct'))*1000) throw Error('Export predates source commit; rebuild.');
const all = [];
function walk(dir, prefix='') { for(const e of fs.readdirSync(dir,{withFileTypes:true})) {
  if(e.isSymbolicLink()) throw Error('Symlink not allowed: '+e.name);
  const p = prefix + e.name;
  if(e.isDirectory()) walk(path.join(dir,e.name),p+'/'); else all.push(p);
}}
walk(input);
const available = new Set(all), selected = new Set();
const queue = [];
function include(file) { if(available.has(file) && !selected.has(file)) {selected.add(file);queue.push(file);} }
// Engine/default UI support and bootstrap are runtime files. Resource files below
// resources/ are included only through exported scene/prefab/material dependencies.
for(const file of all) if(/^(libs|js|internal)\//.test(file) && !/\.map$/.test(file)) include(file);
for(const file of ['index.html','splash.png','Demo01.ls','fileconfig.json','resources/combat-feedback/AUDIO_LICENSES.txt']) include(file);
while(queue.length) {
  const file=queue.shift();
  // fileconfig is an export-wide texture index, not a dependency root.
  if(file==='fileconfig.json' || !/\.(ls|lh|lmat|controller|atlas|shader|glsl|html|js)$/.test(file)) continue;
  const text=fs.readFileSync(path.join(input,file),'utf8');
  for(const match of text.matchAll(/["']([^"'\r\n]+)["']/g)) {
    // Laya's model loader resolves model.glb to the exported model@0.lh.
    const ref=match[1].replace(/\.(glb|gltf|fbx)$/i,'@0.lh');
    if(ref.includes('://') || ref.includes('\\')) continue;
    include(path.posix.normalize(path.posix.join(path.posix.dirname(file),ref)));
    include(ref);
  }
}
const forbidden=/\.(fbx|blend|glb|gltf|ts|map|meta|psd|py|bat)$/i;
for(const file of selected) if(forbidden.test(file) || /(^|\/)(library|source-assets|audio-sources|node_modules)(\/|$)/.test(file)) throw Error('Non-runtime file: '+file);
fs.mkdirSync(output,{recursive:true});
for(const file of [...selected].sort()) {const dest=path.join(output,file);fs.mkdirSync(path.dirname(dest),{recursive:true});fs.copyFileSync(path.join(input,file),dest);}
for(const [from,to] of [['tools/playtest/serve.cjs','serve.cjs'],['tools/playtest/start.cmd','start.cmd'],['docs/playtest.md','README.md'],['docs/playtest-verification.md','VALIDATION.md'],['docs/audio-credits.md','audio-credits.md'],['LICENSE','LICENSE'],['tools/playtest/CREDITS.txt','CREDITS.txt'],['tools/playtest/LICENSE-LayaAir.txt','LICENSE-LayaAir.txt'],['tools/playtest/LICENSE-Bullet.txt','LICENSE-Bullet.txt']]) fs.copyFileSync(path.join(repo,from),path.join(output,to));
const files=[];
function manifest(dir,prefix='') {for(const e of fs.readdirSync(dir,{withFileTypes:true})) {const name=prefix+e.name;if(e.isDirectory())manifest(path.join(dir,e.name),name+'/');else{const data=fs.readFileSync(path.join(dir,e.name));files.push({path:name,bytes:data.length,sha256:crypto.createHash('sha256').update(data).digest('hex')});}}}
manifest(output);
const report={sourceCommit:sha,sourceBranch:git('branch','--show-current'),draft,engine:'LayaAir 3.4.1',builtAt:new Date(fs.statSync(path.join(input,'js/bundle.js')).mtimeMs).toISOString(),packagedAt:new Date().toISOString(),runtimeFiles:selected.size,excludedExportFiles:all.filter(f=>!selected.has(f)),files};
fs.writeFileSync(path.join(output,'BUILD.json'),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify({output,sourceCommit:sha,draft,runtimeFiles:selected.size,excluded:report.excludedExportFiles,bytes:files.reduce((n,f)=>n+f.bytes,0)},null,2));
