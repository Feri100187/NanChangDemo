// 原创旧城样板网格/纹理，MIT。离线运行，不参与游戏循环；仅使用 Node 内置模块。
// 在项目根目录运行：node tools/generate-oldtown-art.cjs
const fs=require('fs'),path=require('path'),zlib=require('zlib');
const root=path.join(__dirname,'..'),out=path.join(root,'assets/resources/oldtown');
const S=512,materials=['Brick','Plaster','Wood','RoofTile','Paving','DarkPanel','OriginalConcrete'];
const periods=[[1.4,.96],[3.2,3.2],[1.4,2.8],[1.6,1.6],[1.6,1.6],[1,1],[1,1]];
const clamp=(v,a=0,b=1)=>Math.max(a,Math.min(b,v));
function hash(x,y,seed=0){let h=Math.imul(x+seed*31,374761393)^Math.imul(y+seed*17,668265263);h=Math.imul(h^(h>>>13),1274126177);return ((h^(h>>>16))>>>0)/4294967295;}
function noise(x,y,cell,seed){const n=S/cell,ix=Math.floor(x/cell),iy=Math.floor(y/cell),fx=x/cell-ix,fy=y/cell-iy,u=fx*fx*(3-2*fx),v=fy*fy*(3-2*fy);const h=(a,b)=>hash((a+n)%n,(b+n)%n,seed);return (h(ix,iy)*(1-u)+h(ix+1,iy)*u)*(1-v)+(h(ix,iy+1)*(1-u)+h(ix+1,iy+1)*u)*v;}
const crcTable=Array.from({length:256},(_,n)=>{for(let k=0;k<8;k++)n=n&1?0xedb88320^(n>>>1):n>>>1;return n>>>0});
function crc(b){let n=0xffffffff;for(const v of b)n=crcTable[(n^v)&255]^(n>>>8);return (n^0xffffffff)>>>0;}
function png(file,pixels){const chunk=(name,data)=>{const t=Buffer.from(name),b=Buffer.alloc(data.length+12);b.writeUInt32BE(data.length);t.copy(b,4);data.copy(b,8);b.writeUInt32BE(crc(Buffer.concat([t,data])),b.length-4);return b};const h=Buffer.alloc(13);h.writeUInt32BE(S);h.writeUInt32BE(S,4);h[8]=8;h[9]=6;const raw=Buffer.alloc(S*(1+S*4));for(let y=0;y<S;y++)pixels.copy(raw,y*(S*4+1)+1,y*S*4,(y+1)*S*4);fs.writeFileSync(file,Buffer.concat([Buffer.from([137,80,78,71,13,10,26,10]),chunk('IHDR',h),chunk('IDAT',zlib.deflateSync(raw,{level:9})),chunk('IEND',Buffer.alloc(0))]));}
fs.mkdirSync(path.join(out,'textures'),{recursive:true});
for(let kind=0;kind<5;kind++){
    const pixels=Buffer.alloc(S*S*4),heights=new Float32Array(S*S);
    for(let y=0;y<S;y++)for(let x=0;x<S;x++){
        const broad=noise(x,y,64,17+kind),fine=noise(x,y,8,51+kind),grain=hash(x,y,91+kind)-.5;
        let color,height;
        if(kind===0){
            const row=Math.floor(y/64),xx=(x+(row%2)*64)%S,col=Math.floor(xx/128),bx=xx%128,by=y%64,edge=Math.min(bx,128-bx,by,64-by),bevel=clamp((edge-2)/5),variation=(hash(col,row,5)-.5)*27;
            const weather=(broad-.5)*13+grain*7+(fine-.5)*8;
            const base=[105,108,101];color=base.map((v,k)=>44*(1-bevel)+(v+variation+weather+(k===2?-2:0))*bevel);
            if(edge>3&&edge<7)color=color.map(v=>v+(by<32?7:-5));height=.22+bevel*.48+(fine-.5)*.06;
        }else if(kind===1){
            const patch=noise(x,y,128,23),wear=clamp((.33-patch)*7),crack=Math.abs(noise(x,y,64,34)-.49)<.004?13:0;
            color=[189,181,158].map((v,k)=>v+(broad-.5)*22+(fine-.5)*9+grain*6-wear*(38-k*3)-crack);
            height=.5+(fine-.5)*.08+grain*.02-wear*.12;
        }else if(kind===2){
            const board=Math.floor(x/128),bx=x%128,join=Math.min(bx,128-bx),wave=Math.sin(x*.48+Math.sin(y*.043)*1.5+noise(x,y,64,8)*7);
            const knot=Math.hypot((bx-64)/20,(y-(96+board*93)%S)/45),ring=knot<2?Math.sin(knot*24)*(2-knot)*4:0;
            const variation=(hash(board,0,7)-.5)*18,light=wave*5+(broad-.5)*13+grain*5+ring;
            color=[100,76,49].map(v=>join<2?v*.4:v+variation+light);height=join<2?.18:.56+wave*.02+ring*.002;
        }else if(kind===3){
            const row=Math.floor(y/64),ridge=Math.sin((x%64)/64*Math.PI),seam=y%64<3,shade=(ridge-.5)*22+(hash(Math.floor(x/64),row,61)-.5)*18;
            color=[72,78,77].map(v=>seam?v*.6:v+shade+(broad-.5)*14+grain*4);height=seam?.25:.48+ridge*.15;
        }else{
            const row=Math.floor(y/128),xx=(x+(row%2)*64)%S,bx=xx%128,by=y%128,edge=Math.min(bx,128-bx,by,128-by),bevel=clamp((edge-2)/6),variation=(hash(Math.floor(xx/128),row,84)-.5)*26;
            color=[124,123,110].map(v=>55*(1-bevel)+(v+variation+(broad-.5)*20+grain*9)*bevel);height=.2+bevel*.45+(fine-.5)*.08;
        }
        const i=(y*S+x)*4;for(let k=0;k<3;k++)pixels[i+k]=Math.round(clamp(color[k],0,255));pixels[i+3]=255;heights[y*S+x]=height;
    }
    png(path.join(out,'textures',materials[kind]+'_albedo.png'),pixels);
    const normals=Buffer.alloc(S*S*4);for(let y=0;y<S;y++)for(let x=0;x<S;x++){const h=(a,b)=>heights[((b+S)%S)*S+(a+S)%S],dx=(h(x+1,y)-h(x-1,y))*2,dy=(h(x,y+1)-h(x,y-1))*2,l=Math.hypot(dx,dy,1),i=(y*S+x)*4;normals[i]=Math.round((-dx/l*.5+.5)*255);normals[i+1]=Math.round((dy/l*.5+.5)*255);normals[i+2]=Math.round((1/l*.5+.5)*255);normals[i+3]=255;}png(path.join(out,'textures',materials[kind]+'_normal.png'),normals);
    for(const suffix of ['albedo','normal']){const metaPath=path.join(out,'textures',materials[kind]+'_'+suffix+'.png.meta');if(fs.existsSync(metaPath)){const meta=JSON.parse(fs.readFileSync(metaPath,'utf8'));meta.importer={...meta.importer,sRGB:suffix==='albedo',generateMipmap:true,wrapMode:0,filterMode:2,anisoLevel:4};fs.writeFileSync(metaPath,JSON.stringify(meta,null,2)+'\n')}}
}

const sub=(a,b)=>a.map((v,i)=>v-b[i]),cross=(a,b)=>[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]],norm=a=>{const l=Math.hypot(...a);return a.map(v=>v/l)},add=(a,b)=>a.map((v,i)=>v+b[i]),mul=(a,s)=>a.map(v=>v*s);
const meshes=[];
class Mesh {
    constructor(name){this.name=name;this.parts=new Map();meshes.push(this);}
    quad(mat,p,uv){if(!this.parts.has(mat))this.parts.set(mat,{p:[],n:[],uv:[],t:[],i:[]});const b=this.parts.get(mat),first=b.p.length/3,n=norm(cross(sub(p[1],p[0]),sub(p[3],p[0]))),t=norm(sub(p[1],p[0]));for(let k=0;k<4;k++){b.p.push(...p[k]);b.n.push(...n);b.uv.push(...uv[k]);b.t.push(...t,1)}b.i.push(first,first+1,first+2,first,first+2,first+3);}
    plane(mat,origin,u,v,x0,x1,y0,y1){const p=(x,y)=>add(origin,add(mul(u,x),mul(v,y))),s=periods[mat];this.quad(mat,[p(x0,y0),p(x1,y0),p(x1,y1),p(x0,y1)],[[x0/s[0],y0/s[1]],[x1/s[0],y0/s[1]],[x1/s[0],y1/s[1]],[x0/s[0],y1/s[1]]]);}
    box(mat,p,size){const [w,h,d]=size,[x,y,z]=p;this.plane(mat,[x,y,z+d/2],[1,0,0],[0,1,0],-w/2,w/2,-h/2,h/2);this.plane(mat,[x,y,z-d/2],[-1,0,0],[0,1,0],-w/2,w/2,-h/2,h/2);this.plane(mat,[x+w/2,y,z],[0,0,-1],[0,1,0],-d/2,d/2,-h/2,h/2);this.plane(mat,[x-w/2,y,z],[0,0,1],[0,1,0],-d/2,d/2,-h/2,h/2);this.plane(mat,[x,y+h/2,z],[1,0,0],[0,0,-1],-w/2,w/2,-d/2,d/2);this.plane(mat,[x,y-h/2,z],[1,0,0],[0,0,1],-w/2,w/2,-d/2,d/2);}
}
const windowMesh=new Mesh('ClosedWindow');
windowMesh.box(5,[0,.775,-.075],[1.35,1.55,.01]);
for(const x of [-.625,.625])windowMesh.box(2,[x,.775,-.04],[.1,1.55,.08]);
for(const y of [.05,1.5,.68])windowMesh.box(2,[0,y,-.035],[1.35,.1,.07]);
for(let i=-2;i<=2;i++)windowMesh.box(2,[i*.2,.81,-.045],[.037,1.32,.04]);
for(const y of [.3,.48,.92,1.13,1.34])windowMesh.box(2,[0,y,-.047],[1.14,.035,.035]);
windowMesh.box(4,[0,.025,-.04],[1.35,.05,.08]);
const doorMesh=new Mesh('ClosedDoor');
doorMesh.box(2,[0,1.325,-.055],[1.45,2.65,.04]);
for(const x of [-.67,.67])doorMesh.box(2,[x,1.325,-.0225],[.11,2.65,.045]);
for(const y of [.075,2.575,1.25])doorMesh.box(2,[0,y,-.02],[1.45,.15,.04]);
doorMesh.box(5,[0,1.33,-.02],[.018,2.37,.035]);
for(const x of [-.12,.12])doorMesh.box(5,[x,1.2,-.0075],[.06,.16,.015]);
const eaveMesh=new Mesh('TileEave');
eaveMesh.box(2,[0,.025,-.025],[4,.05,.05]);
eaveMesh.box(3,[0,.555,-.2675],[4,.07,.025]);
eaveMesh.plane(3,[0,0,-.28],[1,0,0],[0,1,0],-2,2,0,.59);
eaveMesh.plane(3,[0,.59,0],[1,0,0],[0,0,1],-2,2,-.28,0);
eaveMesh.plane(3,[-2,0,0],[0,0,-1],[0,1,0],0,.28,0,.59);
eaveMesh.plane(3,[2,0,0],[0,0,1],[0,1,0],-.28,0,0,.59);
for(let tile=0;tile<20;tile++)for(let slice=0;slice<4;slice++){
    const x0=-2+(tile+slice/4)*.2,x1=x0+.05,curve=x=>.025+Math.sin((x+2-tile*.2)/.2*Math.PI)*.032;
    eaveMesh.quad(3,[[x0,curve(x0),0],[x1,curve(x1),0],[x1,.50+curve(x1),-.28],[x0,.50+curve(x0),-.28]],[[x0/.8,0],[x1/.8,0],[x1/.8,1],[x0/.8,1]]);
    eaveMesh.quad(3,[[x0,0,0],[x1,0,0],[x1,curve(x1),0],[x0,curve(x0),0]],[[x0/.8,0],[x1/.8,0],[x1/.8,.1],[x0/.8,.1]]);
}

const scene=JSON.parse(fs.readFileSync(path.join(root,'assets/Demo01.ls'),'utf8'));
const nodes=[];(function walk(n){nodes.push(n);for(const c of n._$child||[])walk(c)})(scene);
const ids=new Map(nodes.map(n=>[n._$id,n]));const modules=[],skins=[];
function boxData(id){const n=ids.get(id),p=n.transform.localPosition||{},s=n.transform.localScale;return{id,name:n.name,p:[p.x||0,p.y||0,p.z||0],size:[s.x,s.y,s.z]};}
const definitions=[
    {...boxData('d1b0001'),p:[-14,3,-9.5],size:[.6,6,35.6],faces:['+x'],tail:{p:[-14,3,-44.8],size:[.6,6,35]}},
    {...boxData('d1b0002'),p:[14,3,-9.5],size:[.6,6,35.6],faces:['-x'],tail:{p:[14,3,-44.8],size:[.6,6,35]}},
    {...boxData('d1b0003'),faces:['-z'],plain:true},
    {...boxData('d1b0005'),faces:['-x','-z']},
    ...['d1b0007','d1b0008','d1b0009'].map(id=>({...boxData(id),faces:['+z','-z']})),
    {...boxData('d1b0011'),faces:['-x','+z','-z']},
    {...boxData('d1b0012'),faces:['+x','+z','-z']},
    ...['d1b0013','d1b0014','d1b0015'].map(id=>({...boxData(id),faces:[],cover:true})),
    ...['d1b0016','d1b0017','d1b0018'].map(id=>({...boxData(id),faces:['+z']}))
];
for(const d of definitions){
    const m=new Mesh('Skin_'+d.id),[w,h,depth]=d.size,base=d.p[1]-h/2,top=base+h;
    const faces=[{key:'+z',o:[0,0,depth/2],u:[1,0,0],n:[0,0,1],len:w,yaw:0},{key:'-z',o:[0,0,-depth/2],u:[-1,0,0],n:[0,0,-1],len:w,yaw:180},{key:'+x',o:[w/2,0,0],u:[0,0,-1],n:[1,0,0],len:depth,yaw:90},{key:'-x',o:[-w/2,0,0],u:[0,0,1],n:[-1,0,0],len:depth,yaw:-90}];
    for(const f of faces){
        const art=d.faces.includes(f.key),holes=[];const eaveBottom=top-.72;
        const place=(type,x,y,scale=[1,1,1])=>{const position=add(d.p,add(f.o,mul(f.u,x)));position[1]=y;modules.push({type,position,yaw:f.yaw,scale,backing:d.id,face:f.key});};
        if(art&&!d.plain&&f.len>=2.5&&h>=2.5){
            const bays=Math.max(1,Math.floor(f.len/4.2)),span=f.len/bays;
            for(let k=0;k<bays;k++){
                const x=-f.len/2+span*(k+.5);
                if(base<.2){const door=k%3===1,type=door?'ClosedDoor':'ClosedWindow',mw=door?1.45:1.35,mh=door?2.65:1.55,y=door?.04:1.25;if(y+mh<eaveBottom-.1){holes.push([x-mw/2,x+mw/2,y,y+mh]);place(type,x,y)}}
                if(k%2===0&&3.62>base&&4.79<eaveBottom-.08){holes.push([x-1.35*.75/2,x+1.35*.75/2,3.62,3.62+1.55*.75]);place('ClosedWindow',x,3.62,[.75,.75,1])}
            }
            holes.push([-f.len/2,f.len/2,eaveBottom,eaveBottom+.59]);
            const strips=Math.max(1,Math.round(f.len/4)),stripWidth=f.len/strips;
            for(let i=0;i<strips;i++)place('TileEave',-f.len/2+stripWidth*(i+.5),eaveBottom,[stripWidth/4,1,1]);
        }
        const xs=[-f.len/2,f.len/2,...holes.flatMap(q=>q.slice(0,2))],ys=[base,top,...holes.flatMap(q=>q.slice(2)),...([.85,3.15,3.35,top-.2].filter(y=>y>base&&y<top))];
        const xx=[...new Set(xs)].sort((a,b)=>a-b),yy=[...new Set(ys)].sort((a,b)=>a-b);
        for(let ix=1;ix<xx.length;ix++)for(let iy=1;iy<yy.length;iy++){
            const x0=xx[ix-1],x1=xx[ix],y0=yy[iy-1],y1=yy[iy],cx=(x0+x1)/2,cy=(y0+y1)/2;if(holes.some(q=>cx>q[0]&&cx<q[1]&&cy>q[2]&&cy<q[3]))continue;
            let mat=art?(cy<.85?0:(cy>top-.2||cy>3.15&&cy<3.35)?4:1):d.cover?(cy>top-.12?4:0):6;
            if(art&&base>2&&cy<base+.18)mat=2;
            m.plane(mat,[...f.o.slice(0,1),-d.p[1],f.o[2]],f.u,[0,1,0],x0,x1,y0,y1);
        }
    }
    m.plane(d.cover?4:3,[0,h/2,0],[1,0,0],[0,0,-1],-w/2,w/2,-depth/2,depth/2);
    m.plane(6,[0,-h/2,0],[1,0,0],[0,0,1],-w/2,w/2,-depth/2,depth/2);
    skins.push({...d,mesh:meshes.indexOf(m)});
}
const ground=new Mesh('FrontPaving');ground.plane(4,[0,.015,0],[1,0,0],[0,0,-1],-13.7,13.7,-7.7,26.7);

const chunks=[],views=[],accessors=[];let byteLength=0;
function buffer(values,type,integer=false){const data=Buffer.from(integer?new Uint16Array(values).buffer:new Float32Array(values).buffer),view=views.length;views.push({buffer:0,byteOffset:byteLength,byteLength:data.length});chunks.push(data);byteLength+=data.length;const pad=(4-byteLength%4)%4;if(pad){chunks.push(Buffer.alloc(pad));byteLength+=pad}const dims={VEC2:2,VEC3:3,VEC4:4,SCALAR:1}[type],item={bufferView:view,componentType:integer?5123:5126,count:values.length/dims,type};if(type==='VEC3'){item.min=[0,1,2].map(k=>Math.min(...values.filter((_,i)=>i%3===k)));item.max=[0,1,2].map(k=>Math.max(...values.filter((_,i)=>i%3===k)))}accessors.push(item);return accessors.length-1;}
const meshData=meshes.map(m=>({name:m.name,primitives:[...m.parts].sort((a,b)=>a[0]-b[0]).map(([mat,b])=>({attributes:{POSITION:buffer(b.p,'VEC3'),NORMAL:buffer(b.n,'VEC3'),TEXCOORD_0:buffer(b.uv,'VEC2'),TANGENT:buffer(b.t,'VEC4')},indices:buffer(b.i,'SCALAR',true),material:mat}))}));
const bin=Buffer.concat(chunks),gltf={asset:{version:'2.0',generator:'NanChangDemo original procedural oldtown kit (MIT)'},scene:0,scenes:[{nodes:meshes.map((_,i)=>i)}],nodes:meshes.map((m,i)=>({name:m.name,mesh:i})),meshes:meshData,materials:materials.map(name=>({name,pbrMetallicRoughness:{baseColorFactor:[.65,.62,.55,1],metallicFactor:0,roughnessFactor:.9}})),buffers:[{byteLength:bin.length}],bufferViews:views,accessors};
let json=Buffer.from(JSON.stringify(gltf));json=Buffer.concat([json,Buffer.alloc((4-json.length%4)%4,32)]);const glb=Buffer.alloc(12+8+json.length+8+bin.length);glb.writeUInt32LE(0x46546c67);glb.writeUInt32LE(2,4);glb.writeUInt32LE(glb.length,8);glb.writeUInt32LE(json.length,12);glb.writeUInt32LE(0x4e4f534a,16);json.copy(glb,20);const offset=20+json.length;glb.writeUInt32LE(bin.length,offset);glb.writeUInt32LE(0x004e4942,offset+4);bin.copy(glb,offset+8);
fs.writeFileSync(path.join(out,'models/OldtownModules.glb'),glb);
fs.mkdirSync(path.join(root,'.tmp'),{recursive:true});
const manifest={materials,skins,modules,groundMesh:meshes.indexOf(ground),meshes:meshes.map((m,i)=>({name:m.name,index:i,materials:[...m.parts.keys()].sort((a,b)=>a-b),vertices:[...m.parts.values()].reduce((n,b)=>n+b.p.length/3,0),triangles:[...m.parts.values()].reduce((n,b)=>n+b.i.length/3,0)}))};
fs.writeFileSync(path.join(root,'.tmp/oldtown-art-manifest.json'),JSON.stringify(manifest,null,2));
console.log(JSON.stringify({modelBytes:glb.length,meshes:meshes.length,moduleInstances:modules.length,triangles:manifest.meshes.reduce((s,m)=>s+m.triangles,0),textures:10}));
