// 原创后半关卡外观，MIT。仅离线生成网格，不执行运行时场景搭建。
// node tools/generate-oldtown-rear-art.cjs
// 原版 OldtownModules.glb、材质、纹理和三个预制体保持不变。
const fs = require('fs');
const path = require('path');
const root = path.join(__dirname, '..');
const materials = ['Brick', 'Plaster', 'Wood', 'RoofTile', 'Paving', 'DarkPanel'];
const periods = [[1.4, .96], [3.2, 3.2], [1.4, 2.8], [1.6, 1.6], [1.6, 1.6], [1, 1]];
const add = (a, b) => a.map((v, i) => v + b[i]);
const sub = (a, b) => a.map((v, i) => v - b[i]);
const mul = (a, s) => a.map(v => v * s);
const cross = (a, b) => [a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]];
const norm = a => mul(a, 1 / Math.hypot(...a));
const meshes = [], skins = [], modules = [];
class Mesh {
    constructor(name) { this.name = name; this.parts = new Map(); meshes.push(this); }
    quad(mat, p, uv) {
        if (!this.parts.has(mat)) this.parts.set(mat, {p:[], n:[], uv:[], t:[], i:[]});
        const b = this.parts.get(mat), first = b.p.length / 3;
        const n = norm(cross(sub(p[1], p[0]), sub(p[3], p[0]))), t = norm(sub(p[1], p[0]));
        for (let k=0; k<4; k++) { b.p.push(...p[k]); b.n.push(...n); b.uv.push(...uv[k]); b.t.push(...t, 1); }
        b.i.push(first, first+1, first+2, first, first+2, first+3);
    }
    plane(mat, origin, u, v, x0, x1, y0, y1) {
        const p = (x,y) => add(origin, add(mul(u,x),mul(v,y))), s = periods[mat];
        this.quad(mat, [p(x0,y0),p(x1,y0),p(x1,y1),p(x0,y1)],
            [[x0/s[0],y0/s[1]],[x1/s[0],y0/s[1]],[x1/s[0],y1/s[1]],[x0/s[0],y1/s[1]]]);
    }
    box(mat, p, size) {
        const [w,h,d]=size, [x,y,z]=p;
        this.plane(mat,[x,y,z+d/2],[1,0,0],[0,1,0],-w/2,w/2,-h/2,h/2);
        this.plane(mat,[x,y,z-d/2],[-1,0,0],[0,1,0],-w/2,w/2,-h/2,h/2);
        this.plane(mat,[x+w/2,y,z],[0,0,-1],[0,1,0],-d/2,d/2,-h/2,h/2);
        this.plane(mat,[x-w/2,y,z],[0,0,1],[0,1,0],-d/2,d/2,-h/2,h/2);
        this.plane(mat,[x,y+h/2,z],[1,0,0],[0,0,-1],-w/2,w/2,-d/2,d/2);
        this.plane(mat,[x,y-h/2,z],[1,0,0],[0,0,1],-w/2,w/2,-d/2,d/2);
    }
}

// 2.4 x 2.8 米净空门套：所有实体均在洞口外侧，深度向原墙内收。
const portal = new Mesh('OpenPortal_240x280');
for (const sign of [-1,1]) {
    portal.box(4,[sign*1.425,.2,-.06],[.45,.4,.12]);
    portal.box(2,[sign*1.425,2.02,-.075],[.45,3.24,.09]);
    portal.box(2,[sign*1.425,1.6,-.02],[.19,2.4,.04]);
}
portal.box(2,[0,3.00,-.065],[2.4,.4,.11]);
portal.box(2,[0,3.24,-.04],[2.4,.08,.08]);
portal.box(5,[0,3.46,-.09],[2.4,.36,.04]);
for (const x of [-1.1,-.55,0,.55,1.1]) portal.box(2,[x,3.46,-.035],[.07,.36,.07]);
portal.box(2,[0,3.6,-.03],[2.4,.08,.06]);

const scene = JSON.parse(fs.readFileSync(path.join(root,'assets/Demo01.ls'),'utf8'));
const nodes = new Map();
(function walk(n) { nodes.set(n._$id,n); (n._$child||[]).forEach(walk); })(scene);
function boxData(id) {
    const n=nodes.get(id), p=n.transform.localPosition||{}, s=n.transform.localScale;
    return {id,name:n.name,p:[p.x||0,p.y||0,p.z||0],size:[s.x,s.y,s.z]};
}
const definitions = [
    {...boxData('d1b0001'),p:[-14,3,-44.8],size:[.6,6,35],faces:['+x'],tail:true},
    {...boxData('d1b0002'),p:[14,3,-44.8],size:[.6,6,35],faces:['-x'],tail:true},
    {...boxData('d1b0004'),faces:['+z'],quiet:true},
    ...Array.from({length:6},(_,i)=>({...boxData('d1b00'+(19+i)),faces:['+z','-z']})),
    ...Array.from({length:5},(_,i)=>({...boxData('d1b00'+(25+i)),faces:[],cover:true})),
    ...['d1b0030','d1b0031'].map(id=>({...boxData(id),faces:['+z','-z']})),
    ...Array.from({length:6},(_,i)=>({...boxData('d1b00'+(32+i)),faces:['+z','-z'],target:true})),
    {...boxData('d1b0038'),faces:['+x','-x'],target:true,interior:'+x'},
    {...boxData('d1b0039'),faces:['+x','-x'],target:true,interior:'-x'},
    {...boxData('d1b0040'),faces:[],ceiling:true},
    {...boxData('d1b0041'),faces:[],storage:true}
];

for (const d of definitions) {
    const m=new Mesh('RearSkin_'+d.id), [w,h,depth]=d.size, base=d.p[1]-h/2, top=base+h;
    const faces=[
        {key:'+z',o:[0,0,depth/2],u:[1,0,0],n:[0,0,1],len:w,yaw:0},
        {key:'-z',o:[0,0,-depth/2],u:[-1,0,0],n:[0,0,-1],len:w,yaw:180},
        {key:'+x',o:[w/2,0,0],u:[0,0,-1],n:[1,0,0],len:depth,yaw:90},
        {key:'-x',o:[-w/2,0,0],u:[0,0,1],n:[-1,0,0],len:depth,yaw:-90}
    ];
    for (const f of faces) {
        const decorated=d.faces.includes(f.key), holes=[];
        const interior=d.interior===f.key || d.target && d.id<'d1b0038' && (d.p[2]===-50?f.key==='-z':f.key==='+z');
        const eaveBottom=top-.72;
        const place=(type,x,y,scale=[1,1,1])=>{
            const position=add(d.p,add(f.o,mul(f.u,x))); position[1]=y;
            modules.push({type,position,yaw:f.yaw,scale,backing:d.id,face:f.key});
        };
        const windowAt=(x,y,sx=1,sy=1)=>{
            holes.push([x-1.35*sx/2,x+1.35*sx/2,y,y+1.55*sy]);
            place('ClosedWindow',x,y,[sx,sy,1]);
        };
        if (decorated) {
            if (d.target && d.id<'d1b0038') {
                // 门套跨三个原实体，切槽仅发生在原有左右墙和门楣内。
                const globalToLocal=x=>(x-d.p[0])*f.u[0];
                const x0=Math.max(-f.len/2,Math.min(globalToLocal(-1.65),globalToLocal(1.65)));
                const x1=Math.min(f.len/2,Math.max(globalToLocal(-1.65),globalToLocal(1.65)));
                if (x1>x0) holes.push([x0,x1,base,3.64]);
                if (base>2) { const p=add(d.p,f.o);p[0]=0;p[1]=0;modules.push({type:'OpenPortal',position:p,yaw:f.yaw,scale:[1,1,1],backing:d.id,face:f.key}); }
                else windowAt((d.p[0]<0?-.33:.33)*f.u[0],1.2,.9,.95);
            } else if (!d.quiet && f.len>=2.5) {
                const bays=Math.max(1,Math.floor(f.len/4.5)), span=f.len/bays;
                for (let k=0;k<bays;k++) {
                    const x=-f.len/2+span*(k+.5);
                    if (base<.2) windowAt(x,d.target?1.45:1.25);
                    if (!d.target && k%2===0 && 3.62>base && 4.79<eaveBottom-.08) windowAt(x,3.62,.75,.75);
                }
            }
            // 0.28m 内收檐口仅放外侧；内墙以木腰线/护墙对应原表面。
            if (!interior && f.len>=2) {
                holes.push([-f.len/2,f.len/2,eaveBottom,eaveBottom+.59]);
                const count=Math.max(1,Math.round(f.len/4)), width=f.len/count;
                for(let k=0;k<count;k++) place('TileEave',-f.len/2+width*(k+.5),eaveBottom,[width/4,1,1]);
            }
        }
        // 门洞侧壁是完整木包边；装饰不侵入开口。
        const jamb=d.target && d.id<'d1b0038' && !['+z','-z'].includes(f.key);
        const xs=[-f.len/2,f.len/2,...holes.flatMap(q=>q.slice(0,2))];
        const ys=[base,top,...holes.flatMap(q=>q.slice(2)),...[.85,1.1,1.18,3.15,3.35,top-.2,top-.12].filter(y=>y>base&&y<top)];
        if(d.storage) { xs.push(-f.len/2+.12,f.len/2-.12);ys.push(.12,top-.12); }
        const xx=[...new Set(xs)].sort((a,b)=>a-b), yy=[...new Set(ys)].sort((a,b)=>a-b);
        for(let ix=1;ix<xx.length;ix++) for(let iy=1;iy<yy.length;iy++) {
            const x0=xx[ix-1],x1=xx[ix],y0=yy[iy-1],y1=yy[iy],cx=(x0+x1)/2,cy=(y0+y1)/2;
            if(holes.some(q=>cx>q[0]&&cx<q[1]&&cy>q[2]&&cy<q[3])) continue;
            let mat=cy<.85?0:cy>top-.2||cy>3.15&&cy<3.35?4:1;
            if(d.cover) mat=cy>top-.12?4:0;
            if(interior) mat=cy<1.18||cy>top-.2?2:1;
            if(jamb || d.ceiling) mat=2;
            if(d.storage) mat=2;
            const inset=d.storage && Math.abs(cx)<f.len/2-.12&&cy>.12&&cy<top-.12?.018:0;
            const o=add(f.o,mul(f.n,-inset));o[1]=-d.p[1];
            m.plane(mat,o,f.u,[0,1,0],x0,x1,y0,y1);
        }
    }
    m.plane(d.cover?4:d.storage?2:3,[0,h/2,0],[1,0,0],[0,0,-1],-w/2,w/2,-depth/2,depth/2);
    if(d.ceiling) {
        // 屋顶底面木梁与内收木板共用原屋顶 0.3m 厚度，不降低 4.4m 净高。
        const count=4, span=depth/count;
        for(let k=0;k<count;k++) {
            const z0=-depth/2+k*span,z1=z0+span;
            m.plane(2,[0,-h/2,0],[1,0,0],[0,0,1],-w/2,w/2,z0,z0+.16);
            m.plane(2,[0,-h/2+.045,0],[1,0,0],[0,0,1],-w/2,w/2,z0+.16,z1);
            m.plane(2,[0,-h/2,z0+.16],[1,0,0],[0,1,0],-w/2,w/2,0,.045);
            m.plane(2,[0,-h/2,z1],[-1,0,0],[0,1,0],-w/2,w/2,0,.045);
        }
    } else m.plane(d.target?2:4,[0,-h/2,0],[1,0,0],[0,0,1],-w/2,w/2,-depth/2,depth/2);
    skins.push({...d,mesh:meshes.indexOf(m)});
}
const paving=new Mesh('RearPaving');
paving.plane(4,[0,.015,0],[1,0,0],[0,0,-1],-13.7,13.7,26.7,61.7);

// glTF 2.0 独立网格。IDE 导入 @lmN 子资源，场景引用现有标准材质。
const chunks=[], views=[], accessors=[];let byteLength=0;
function buffer(values,type,integer=false) {
    const data=Buffer.from(integer?new Uint16Array(values).buffer:new Float32Array(values).buffer),view=views.length;
    views.push({buffer:0,byteOffset:byteLength,byteLength:data.length});chunks.push(data);byteLength+=data.length;
    const pad=(4-byteLength%4)%4;if(pad){chunks.push(Buffer.alloc(pad));byteLength+=pad;}
    const dims={VEC2:2,VEC3:3,VEC4:4,SCALAR:1}[type],item={bufferView:view,componentType:integer?5123:5126,count:values.length/dims,type};
    if(type==='VEC3'){item.min=[0,1,2].map(k=>Math.min(...values.filter((_,i)=>i%3===k)));item.max=[0,1,2].map(k=>Math.max(...values.filter((_,i)=>i%3===k)));}
    accessors.push(item);return accessors.length-1;
}
const meshData=meshes.map(m=>({name:m.name,primitives:[...m.parts].sort((a,b)=>a[0]-b[0]).map(([mat,b])=>({
    attributes:{POSITION:buffer(b.p,'VEC3'),NORMAL:buffer(b.n,'VEC3'),TEXCOORD_0:buffer(b.uv,'VEC2'),TANGENT:buffer(b.t,'VEC4')},
    indices:buffer(b.i,'SCALAR',true),material:mat
}))}));
const bin=Buffer.concat(chunks),gltf={asset:{version:'2.0',generator:'NanChangDemo original rear oldtown kit (MIT)'},scene:0,
    scenes:[{nodes:meshes.map((_,i)=>i)}],nodes:meshes.map((m,i)=>({name:m.name,mesh:i})),meshes:meshData,
    materials:materials.map(name=>({name,pbrMetallicRoughness:{baseColorFactor:[.65,.62,.55,1],metallicFactor:0,roughnessFactor:.9}})),
    buffers:[{byteLength:bin.length}],bufferViews:views,accessors};
let json=Buffer.from(JSON.stringify(gltf));json=Buffer.concat([json,Buffer.alloc((4-json.length%4)%4,32)]);
const glb=Buffer.alloc(12+8+json.length+8+bin.length);
glb.writeUInt32LE(0x46546c67);glb.writeUInt32LE(2,4);glb.writeUInt32LE(glb.length,8);glb.writeUInt32LE(json.length,12);glb.writeUInt32LE(0x4e4f534a,16);json.copy(glb,20);
const offset=20+json.length;glb.writeUInt32LE(bin.length,offset);glb.writeUInt32LE(0x004e4942,offset+4);bin.copy(glb,offset+8);
fs.writeFileSync(path.join(root,'assets/resources/oldtown/models/OldtownRearModules.glb'),glb);
const manifest={materials,skins,modules,portalMesh:0,groundMesh:meshes.indexOf(paving),meshes:meshes.map((m,index)=>({name:m.name,index,
    materials:[...m.parts.keys()].sort((a,b)=>a-b),vertices:[...m.parts.values()].reduce((n,b)=>n+b.p.length/3,0),triangles:[...m.parts.values()].reduce((n,b)=>n+b.i.length/3,0)}))};
fs.mkdirSync(path.join(root,'.tmp'),{recursive:true});fs.writeFileSync(path.join(root,'.tmp/oldtown-rear-manifest.json'),JSON.stringify(manifest,null,2));
console.log(JSON.stringify({modelBytes:glb.length,meshes:meshes.length,moduleInstances:modules.length,triangles:manifest.meshes.reduce((s,m)=>s+m.triangles,0)}));
