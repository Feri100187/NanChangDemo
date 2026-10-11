"""Build the annotated winding-lane level and prepare a precise Laya IDE patch.

Uses original procedural meshes and existing project textures. Apply the emitted
output/lane-mission/scene-patch.json through Laya_EditAsset; never writes the scene.
"""
import copy
import json
import math
import struct
import uuid
from pathlib import Path
from openable_panels import build_panels

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'output/lane-mission'
ASSET = ROOT / 'assets/resources/environment/lane-mission'
OUT.mkdir(parents=True, exist_ok=True)
ASSET.mkdir(parents=True, exist_ok=True)
SCENE = json.loads((ROOT / 'assets/Demo01.ls').read_text(encoding='utf-8'))
WORLD = SCENE['_$child'][0]
NAMESPACE = uuid.UUID('e0498044-0bac-4932-ad0d-ef872d095a59')
def uid(name): return str(uuid.uuid5(NAMESPACE, name))
build_panels(ASSET, uid)
def vec(x, y, z): return {'_$type': 'Vector3', 'x': x, 'y': y, 'z': z}
def ref(node): return {'_$ref': node['_$id']}
def node(id, name, p=None):
    n = {'_$id': id, '_$type': 'Sprite3D', 'name': name}
    if p is not None: n['transform'] = {'localPosition': vec(*p)}
    return n
def walk(n):
    yield n
    for c in n.get('_$child', []): yield from walk(c)
def component(n, name):
    return next(c for c in n.get('_$comp', []) if c.get('scriptPath', '').endswith('/'+name+'.ts'))

# Clockwise order follows the annotated red route, with a short mid-lane dogleg
# ensuring the two encounters on the second street cannot see each other's spawn.
corners = [(-6,5),(-6,2),(-8,2),(-8,0),(-6,0),(-6,-5),(-3,-5),
           (-3,-1),(-2,-1),(-2,1),(-3,1),(-3,5),(0,5),(0,-5),
           (3,-5),(3,5),(6,5),(6,-1),(13,-1)]
cells = [corners[0]]
for a,b in zip(corners,corners[1:]):
    dx = (b[0]>a[0])-(b[0]<a[0]); dz = (b[1]>a[1])-(b[1]<a[1])
    p = a
    while p != b:
        p = (p[0]+dx,p[1]+dz); cells.append(p)
road = set(cells)
points = [(x*8,z*8) for x,z in corners]
def progress(p):
    total=0; best=(float('inf'),0)
    for a,b in zip(points,points[1:]):
        dx,dz=b[0]-a[0],b[1]-a[1]; length=math.hypot(dx,dz)
        t=max(0,min(1,((p[0]-a[0])*dx+(p[1]-a[1])*dz)/(length*length)))
        candidate=(math.hypot(p[0]-a[0]-t*dx,p[1]-a[1]-t*dz),total+t*length)
        if candidate[0]<best[0]:best=candidate
        total+=length
    return best[1]
encounters = [((-48,-24),(-64,8)),((-24,-24),(-40,-40)),((-24,24),(-24,-8)),
              ((0,16),(-8,40)),((24,-8),(8,-40)),((48,16),(40,40)),((88,-8),(48,0))]

# Build GLB parts with metre-based UVs. One mesh per house/material keeps draw
# calls bounded while the separately editable collision boxes preserve openings.
materials=['Brick','Plaster','Wood','RoofTile','Paving','DarkPanel','ExitWhite']
parts={}; collider_nodes=[]; boxes=[]; surface_planes={}; removed_overlap_area=0
def quad(group,mat,vertices):
    global removed_overlap_area
    a,b,c,d=vertices;u=[b[i]-a[i] for i in range(3)];v=[d[i]-a[i] for i in range(3)]
    n=[u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]
    length=math.sqrt(sum(t*t for t in n)); n=[t/length for t in n]
    ul=math.sqrt(sum(t*t for t in u));vl=math.sqrt(sum(t*t for t in v))
    axis=max(range(3),key=lambda j:abs(n[j]));axes=[j for j in range(3) if j!=axis]
    aa,bb=axes;xs=sorted(set(round(p[aa],7)for p in vertices));ys=sorted(set(round(p[bb],7)for p in vertices))
    if len(xs)==2 and len(ys)==2 and len(set(tuple(p)for p in vertices))==4:
        # All box faces and pitched-roof rectangles remain rectangles after
        # dropping the dominant normal axis. Subtract surfaces already emitted
        # on this oriented plane, including partial overlaps between buildings.
        offset=sum(n[j]*a[j]for j in range(3));key=tuple(round(t,6)for t in n)+(round(offset,6),)
        rect=(xs[0],xs[1],ys[0],ys[1]);pieces=[rect]
        for old in surface_planes.get(key,[]):
            remaining=[]
            for x0,x1,y0,y1 in pieces:
                ix0,ix1=max(x0,old[0]),min(x1,old[1]);iy0,iy1=max(y0,old[2]),min(y1,old[3])
                if ix1-ix0<=1e-6 or iy1-iy0<=1e-6:remaining.append((x0,x1,y0,y1));continue
                removed_overlap_area+=(ix1-ix0)*(iy1-iy0)/abs(n[axis])
                for piece in [(x0,ix0,y0,y1),(ix1,x1,y0,y1),(ix0,ix1,y0,iy0),(ix0,ix1,iy1,y1)]:
                    if piece[1]-piece[0]>1e-6 and piece[3]-piece[2]>1e-6:remaining.append(piece)
            pieces=remaining
            if not pieces:break
        surface_planes.setdefault(key,[]).append(rect)
        for x0,x1,y0,y1 in pieces:
            cut=[]
            for x,y in [(x0,y0),(x1,y0),(x1,y1),(x0,y1)]:
                p=[0,0,0];p[aa]=x;p[bb]=y;p[axis]=(offset-n[aa]*x-n[bb]*y)/n[axis];cut.append(p)
            edge1=[cut[1][j]-cut[0][j]for j in range(3)];edge2=[cut[3][j]-cut[0][j]for j in range(3)]
            cross=[edge1[1]*edge2[2]-edge1[2]*edge2[1],edge1[2]*edge2[0]-edge1[0]*edge2[2],edge1[0]*edge2[1]-edge1[1]*edge2[0]]
            if sum(cross[j]*n[j]for j in range(3))<0:cut.reverse()
            uv=[(sum((p[j]-a[j])*u[j]for j in range(3))/ul/2,sum((p[j]-a[j])*v[j]for j in range(3))/vl/2)for p in cut]
            emit_quad(group,mat,cut,n,uv)
    else:emit_quad(group,mat,vertices,n,[(0,0),(ul/2,0),(ul/2,vl/2),(0,vl/2)])
def emit_quad(group,mat,vertices,n,uvs):
    p=parts.setdefault((group,mat),{'p':[],'n':[],'uv':[],'i':[]})
    start=len(p['p'])//3
    for vertex,uv in zip(vertices,uvs):p['p']+=vertex;p['n']+=n;p['uv']+=uv
    p['i'] += [start,start+1,start+2,start,start+2,start+3]
def box(group,mat,p,size,solid=True):
    x,y,z=p;w,h,d=[s/2 for s in size]
    quad(group,mat,[(x-w,y-h,z+d),(x+w,y-h,z+d),(x+w,y+h,z+d),(x-w,y+h,z+d)])
    quad(group,mat,[(x+w,y-h,z-d),(x-w,y-h,z-d),(x-w,y+h,z-d),(x+w,y+h,z-d)])
    quad(group,mat,[(x+w,y-h,z+d),(x+w,y-h,z-d),(x+w,y+h,z-d),(x+w,y+h,z+d)])
    quad(group,mat,[(x-w,y-h,z-d),(x-w,y-h,z+d),(x-w,y+h,z+d),(x-w,y+h,z-d)])
    quad(group,mat,[(x-w,y+h,z+d),(x+w,y+h,z+d),(x+w,y+h,z-d),(x-w,y+h,z-d)])
    quad(group,mat,[(x-w,y-h,z-d),(x+w,y-h,z-d),(x+w,y-h,z+d),(x-w,y-h,z+d)])
    if solid:
        n=node(f'lane_col_{len(collider_nodes)}',group,p)
        n['transform']['localScale']=vec(*size)
        n['_$comp']=[{'_$type':'PhysicsCollider','colliderShape':{'_$type':'BoxColliderShape'},'collisionGroup':1,'canCollideWith':-1}]
        collider_nodes.append(n);boxes.append({'group':group,'p':p,'size':size})

for x,z in cells: box('巷道路面','Paving',(x*8,-.1,z*8),(8,.2,8))
neighbors={}
for x,z in sorted(road):
    for dx,dz in [(1,0),(-1,0),(0,1),(0,-1)]:
        c=(x+dx,z+dz)
        if c not in road:neighbors.setdefault(c,(-dx,-dz))
# Reserve a larger one-door mission hall alongside the final eastbound lane.
hall_cells={(x,z) for x in (10,11,12) for z in (-2,-3)}
claimed=set(hall_cells)
houses=[]
for c,f in sorted(neighbors.items()):
    if c in claimed: continue
    claimed.add(c);u=(f[1],-f[0]);other=(c[0]+u[0],c[1]+u[1]);width=8;center=c
    if other in neighbors and neighbors[other]==f and other not in claimed:
        claimed.add(other);width=16;center=((c[0]+other[0])/2,(c[1]+other[1])/2)
    houses.append((center[0]*8,center[1]*8,width,8,f,False))
houses.append((88,-20,24,16,(0,1),True))

room_manifest=[]
for index,(cx,cz,width,depth,f,hall) in enumerate(houses):
    name='任务屋' if hall else f'单门民居_{index+1:02}'
    height=5.5 if hall else 3.9+(index%3)*.18
    u=(f[1],-f[0]); front=depth/2
    def local(a,y,b):return (cx+u[0]*a+f[0]*b,y,cz+u[1]*a+f[1]*b)
    def wall(a,y,b,w,h,d,mat='Plaster',solid=True):
        size=(abs(u[0])*w+abs(f[0])*d,h,abs(u[1])*w+abs(f[1])*d)
        box(name,mat,local(a,y,b),size,solid)
    wall(0,-.08,0,width,.16,depth,'Paving')
    wall(0,height/2,-front+.14,width,height,.28,'Brick')
    wall(-width/2+.14,height/2,0,.28,height,depth,'Brick')
    wall(width/2-.14,height/2,0,.28,height,depth,'Brick')
    door=2.4 if hall else 2
    openings=[(-door/2,door/2,0,2.7)]
    for side in (-1,1):
        mid=side*width*.30;openings.append((mid-.75,mid+.75,1.12,1.97))
    xs=sorted(set([-width/2,width/2]+[a for o in openings for a in o[:2]]))
    ys=sorted(set([0,.85,height]+[a for o in openings for a in o[2:]]))
    for lo,hi in zip(ys,ys[1:]):
        spans=[];y=(lo+hi)/2
        for a,b in zip(xs,xs[1:]):
            x=(a+b)/2
            if any(q[0]<x<q[1] and q[2]<=y<q[3] for q in openings):continue
            if spans and spans[-1][1]==a:spans[-1][1]=b
            else:spans.append([a,b])
        for a,b in spans:wall((a+b)/2,y,front-.14,b-a,hi-lo,.28,'Brick' if y<.85 else 'Plaster')
    for lo,hi,bottom,top in openings:
        for a in (lo-.055,hi+.055):wall(a,(bottom+top)/2,front,.11,top-bottom+.16,.18,'Wood',False)
        wall((lo+hi)/2,top+.055,front,hi-lo,.11,.18,'Wood',False)
        if bottom>0:wall((lo+hi)/2,bottom-.055,front,hi-lo+.2,.11,.28,'Wood',False)
    # Closed ceiling plus pitched tiled surfaces. Each dwelling keeps its own
    # roof silhouette even where the back walls meet the next row of houses.
    wall(0,height+.10,0,width+.5,.20,depth+.5,'RoofTile')
    half=depth/2+.35;base=height+.23;rise=2.1 if hall else 1.25;wide=width/2+.3
    quad(name,'RoofTile',[local(-wide,base,half),local(wide,base,half),local(wide,base+rise,0),local(-wide,base+rise,0)])
    quad(name,'RoofTile',[local(wide,base,-half),local(-wide,base,-half),local(-wide,base+rise,0),local(wide,base+rise,0)])
    for side in (-1,1):
        tri=[local(side*width/2,base,-depth/2),local(side*width/2,base,depth/2),local(side*width/2,base+rise,0)]
        if side>0:tri.reverse()
        quad(name,'Plaster',tri+[tri[-1]])
    wall(0,base+rise+.05,0,width+.7,.12,.16,'RoofTile',False)
    for i in range(int(depth/.8)+1):
        b=-depth/2+i*.8;wall(0,base+rise*(1-abs(b)/half)+.09,b,width+.6,.08,.07,'RoofTile',False)
    wall(0,height-.08,front+.14,width+.6,.22,.20,'Wood',False)
    wall(0,height-.08,-front-.14,width+.6,.22,.20,'Wood',False)
    # All layouts reserve the central 2.4m aisle and the front door/window bays.
    # The side zones vary by purpose, with small per-house placement differences.
    furniture_start=len(collider_nodes)
    side=-1 if index%2==0 else 1
    left=side*width*.30;right=-side*width*.30
    back=-depth/2+.9
    def table(a,b,w=1.8,d=1):
        wall(a,.82,b,w,.14,d,'Wood')
        for da in (-w/2+.12,w/2-.12):
            for db in (-d/2+.12,d/2-.12):wall(a+da,.37,b+db,.14,.74,.14,'Wood')
    def stool(a,b):
        wall(a,.44,b,.52,.12,.52,'Wood')
        wall(a,.19,b,.33,.38,.33,'Wood')
    def shelf(a,b):
        wall(a,.95,b,1.65,1.9,.16,'Wood')
        for da in (-.76,.76):wall(a+da,.95,b+.27,.13,1.9,.6,'Wood')
        for y in (.16,.78,1.4,1.9):wall(a,y,b+.27,1.65,.10,.6,'Wood')
        for j in range(5):wall(a-.55+j*.24,1.1,b+.30,.12,.48-(j%2)*.10,.26,'Plaster' if j%2 else 'DarkPanel',False)
    style=['卧室','餐室','储物间','工作间','书房','会客间'][index%6]
    if hall:
        style='档案室'
        wall(0,.88,-2,2.6,.16,1.1,'Wood')
        for a in (-1,1):wall(a,.4,-2,.15,.8,.8,'Wood')
        shelf(-width*.32,back);shelf(width*.32,back)
        table(-width*.30,0,2.2,1.1);stool(-width*.30,1)
    elif style=='卧室':
        wall(left,.28,-depth*.20,1.45,.56,2.35,'Wood')
        wall(left,.62,-depth*.20,1.40,.14,2.28,'Plaster')
        wall(left,.73,-depth*.20-.75,.95,.12,.45,'Plaster',False)
        wall(left,.68,-depth*.20-1.15,1.5,.75,.12,'Wood')
        wall(right,.43,back,.8,.86,.65,'Wood');stool(right,back+1)
    elif style=='餐室':
        table(left,-depth*.23,2,1.15);stool(left,0);stool(left,back)
        wall(left,.93,-depth*.23,.38,.05,.38,'Plaster',False)
        wall(right,.70,back,1.2,1.4,.65,'Wood')
    elif style=='储物间':
        for j in range(3):
            wall(left,.40,back+j*1.15,1.1,.8,.95,'Wood')
        wall(left,1.17,back,1.02,.74,.88,'Wood')
        shelf(right,back)
    elif style=='工作间':
        table(left,back+.35,2.2,1.1);stool(left,back+1.45)
        for j in range(3):wall(left-.6+j*.5,.95,back+.35,.30,.12,.18,'DarkPanel',False)
        wall(right,.22,-depth*.12,.75,.44,1.8,'Wood')
        wall(right,1.20,back,.8,2.4,.16,'Wood')
    elif style=='书房':
        table(left,-depth*.15,1.7,.9);stool(left,-depth*.15+1)
        wall(left,.92,-depth*.15,.7,.06,.45,'Plaster',False)
        shelf(right,back)
    else:
        for a in (left,right):
            wall(a,.42,-depth*.18,.72,.20,2.0,'Wood')
            wall(a,.21,-depth*.18,.5,.42,1.7,'Wood')
            wall(a+(.28 if a>0 else -.28),.85,-depth*.18,.12,.8,2.0,'Wood')
        wall(left,.40,back,.75,.8,.65,'Wood')
    # A few ceiling beams distinguish interiors without narrowing the floor path.
    if index%3==0:
        for b in (-depth*.25,depth*.18):wall(0,height-.15,b,width-.6,.22,.15,'Wood',False)
    room_manifest.append({'name':name,'style':style,'furnitureColliders':len(collider_nodes)-furniture_start,
        'center':[cx,cz],'width':width,'depth':depth,'front':f,'door':list(local(0,0,front)),
        'windows':[list(local(side*width*.30,1.55,front)) for side in(-1,1)]})

# Small cover along encounters, leaving more than 4m of road clear.
for i,((x,z),_) in enumerate(encounters):
    box(f'第{i+1}区掩体','Brick',(x+2.8,.45,z+4 if i<6 else z+2.7),(.8,.9,1.4))
# Thin annulus: a white floor ring at the final exit, not a blocking volume.
for i in range(48):
    a=i*math.tau/48;b=(i+1)*math.tau/48
    quad('白色撤离圈','ExitWhite',[(104+math.cos(a)*r,.015,-8+math.sin(a)*r) for r,a in [(1.8,a),(2.1,a),(2.1,b),(1.8,b)]][::-1])

chunks=[];views=[];access=[];offset=0
def buf(values,kind):
    global offset
    integer=kind=='SCALAR';dims={'SCALAR':1,'VEC2':2,'VEC3':3}[kind]
    data=struct.pack('<'+('I' if integer else 'f')*len(values),*values)
    views.append({'buffer':0,'byteOffset':offset,'byteLength':len(data)})
    chunks.append(data);offset+=len(data)
    a={'bufferView':len(views)-1,'componentType':5125 if integer else 5126,'count':len(values)//dims,'type':kind}
    if kind=='VEC3':a.update(min=[min(values[k::3]) for k in range(3)],max=[max(values[k::3]) for k in range(3)])
    access.append(a);return len(access)-1
meshes=[];gltf_nodes=[]
for (name,mat),p in parts.items():
    primitive={'attributes':{'POSITION':buf(p['p'],'VEC3'),'NORMAL':buf(p['n'],'VEC3'),'TEXCOORD_0':buf(p['uv'],'VEC2')},'indices':buf(p['i'],'SCALAR'),'material':materials.index(mat)}
    meshes.append({'name':name+'_'+mat,'primitives':[primitive]});gltf_nodes.append({'name':name+'_'+mat,'mesh':len(meshes)-1})
gm=[];images=[];textures=[]
for name in materials:
    m={'name':name,'pbrMetallicRoughness':{'metallicFactor':0,'roughnessFactor':.9}}
    if name not in ('DarkPanel','ExitWhite'):
        images.append({'uri':'../../oldtown/textures/'+name+'_albedo.png'});textures.append({'sampler':0,'source':len(images)-1})
        m['pbrMetallicRoughness']['baseColorTexture']={'index':len(textures)-1}
    else:m['pbrMetallicRoughness']['baseColorFactor']=[.9,.93,.88,1] if name=='ExitWhite' else [.12,.14,.14,1]
    gm.append(m)
binary=b''.join(chunks)
gltf={'asset':{'version':'2.0','generator':'NanChangDemo winding-lane builder'},'scene':0,'scenes':[{'nodes':list(range(len(gltf_nodes)))}],
      'nodes':gltf_nodes,'meshes':meshes,'materials':gm,'images':images,'textures':textures,
      'samplers':[{'magFilter':9729,'minFilter':9987,'wrapS':10497,'wrapT':10497}],
      'buffers':[{'byteLength':len(binary)}],'bufferViews':views,'accessors':access}
j=json.dumps(gltf,ensure_ascii=False,separators=(',',':')).encode();j+=b' '*(-len(j)%4)
glb=struct.pack('<III',0x46546c67,2,28+len(j)+len(binary))+struct.pack('<II',len(j),0x4e4f534a)+j+struct.pack('<II',len(binary),0x004e4942)+binary
model_file=ASSET/'WindingLanes.glb'
if not model_file.exists() or model_file.read_bytes()!=glb:model_file.write_bytes(glb)
if not (ASSET/'WindingLanes.glb.meta').exists():
    (ASSET/'WindingLanes.glb.meta').write_text(json.dumps({'uuid':uid('WindingLanes.glb')},indent=2)+'\n',encoding='utf8')

template=json.loads((ROOT/'source-assets/level-kits/lane-enemy-template.json').read_text(encoding='utf8'))
allies=[copy.deepcopy(n) for n in WORLD['_$child'] if n.get('_$id','').startswith('squad_')]
assert len(allies)==5
keep={'6jx8h8bvc6','6ni3p096l5','player01','weapon01','exitzone1','d1spawn','mission_document'}
children=[copy.deepcopy(n) for n in WORLD['_$child'] if n.get('_$id') in keep]
byid={n['_$id']:n for n in children}
route_nodes=[node(f'lane_route_{i}',f'主巷路线_{i}',(x,0,z)) for i,(x,z) in enumerate(points)]
children.append({'_$id':'lane_visual','_$prefab':uid('WindingLanes.glb'),'name':'曲折小巷_房屋与道路'})
children.append(dict(node('lane_collisions','小巷实体碰撞'),**{'_$child':collider_nodes}))
children.append(dict(node('lane_route','主巷路线'),**{'_$child':route_nodes}))
openings=[]
for i,room in enumerate(room_manifest):
    fx,fz=room['front'];yaw=math.degrees(math.atan2(fx,fz))
    for k,position in enumerate([room['door']]+room['windows']):
        window=k>0;width=1.5 if window else 2.4 if room['name']=='任务屋' else 2
        height=.85 if window else 2.7;bottom=1.12 if window else 0
        ident=f'lane_opening_{i}_{k}'
        opening=node(ident,room['name']+('房门'if not window else f'窗户{k}'),(position[0],bottom,position[2]))
        opening['transform']['localRotationEuler']=vec(0,yaw,0)
        hinge=node(ident+'_hinge','Hinge',(-width/2+.04,.03,-.15))
        leaf=node(ident+'_leaf','WindowCollider' if window else 'DoorCollider',((width-.08)/2,(height-.06)/2,0))
        leaf['transform']['localScale']=vec(width-.08,height-.06,.09)
        leaf['_$comp']=[{'_$type':'PhysicsCollider','colliderShape':{'_$type':'BoxColliderShape'},'collisionGroup':1,'canCollideWith':-1}]
        visual={'_$id':ident+'_visual','_$prefab':uid('WindowPanel.glb' if window else 'DoorPanel.glb'),'name':'LeafVisual',
                'transform':{'localScale':vec(width-.08,height-.06,1)}}
        hinge['_$child']=[leaf,visual];opening['_$child']=[hinge]
        opening['_$comp']=[{'_$type':'fbe9a9ea-e2aa-452d-b580-76324b4d02fd','scriptPath':'../src/Openable.ts',
                            'hinge':ref(hinge),'isWindow':window,'width':width,'height':height,'openAngle':95}]
        openings.append(opening)
opening_group=dict(node('lane_openables','可交互门窗'),**{'_$child':openings})
enemies=[];wave_nodes=[];triggers=[]
def clone_actor(source,idprefix):
    actor=copy.deepcopy(source);mapping={n['_$id']:idprefix+'_'+n['_$id'] for n in walk(actor) if '_$id' in n}
    def remap(v):
        if isinstance(v,dict):
            for k,item in v.items():
                if k in ('_$id','_$ref') and isinstance(item,str) and item in mapping:v[k]=mapping[item]
                else:remap(item)
        elif isinstance(v,list):
            for item in v:remap(item)
    remap(actor);return actor
for i,((x,z),(tx,tz)) in enumerate(encounters):
    wave=node(f'lane_wave_{i}',f'第{i+1}交战区',(x,0,z))
    trigger=node(f'lane_trigger_{i}',f'进入第{i+1}区',(tx,0,tz));triggers.append(trigger)
    patrol=[node(f'lane_patrol_{i}_{k}',f'第{i+1}区巡逻{k}',(x+(k-1)*2 if i==6 else x,0,z if i==6 else z+(k-1)*3)) for k in range(3)]
    children.extend(patrol);group=[]
    for k,(dx,dz) in enumerate([(-1.8,0),(1.8,-2),(0,2)]):
        e=clone_actor(template,f'wave{i}_{k}')
        if i==0 and k==0:
            old=e['_$id'];e['_$id']='target001'
        e['name']=f'第{i+1}波_敌人{k+1}';e['active']=False
        e['transform']['localPosition']=vec(x+dx,0,z+dz)
        ai=component(e,'EnemyAI');ai.update(friendly=False,reinforcement=False,opponents=[ref(n) for n in allies],patrolPoints=[ref(n) for n in patrol],
            patrolRadius=6,patrolSpeed=1.4,sprintSpeed=4.5,combatSpeed=2,sightRange=35,fieldOfView=120,territoryCenter=ref(wave),territoryRadius=10)
        ai.pop('followTarget',None)
        group.append(e);enemies.append(e)
    start=0 if i==0 else progress((tx,tz))
    end=progress(encounters[i+1][1]) if i+1<len(encounters) else progress(points[-1])+100
    wave['_$comp']=[{'_$type':'40a0e7a2-4b78-4fa0-8915-e9b80424eab0','scriptPath':'../src/EncounterWave.ts','enemies':[ref(n) for n in group],
                    'triggerPoint':ref(trigger),'triggerRadius':4,'regionStart':start,'regionEnd':end}]
    wave_nodes.append(wave)
children.extend(triggers+wave_nodes+enemies)
for i,a in enumerate(allies):
    a['transform']['localPosition']=vec(-48+(-1.4 if i%2==0 else 1.4),.02,40+math.floor(i/2)*1.6)
    follow=node(f'lane_follow_{i}',f'队友{i+1}跟随点',(-48,0,40))
    component(a,'EnemyAI').update(opponents=[ref(n) for n in enemies],patrolPoints=[],patrolRadius=0,followTarget=ref(follow),sightRange=35,patrolSpeed=2.5,sprintSpeed=6)
    component(a,'EnemyAI').pop('territoryCenter',None)
    children.extend([follow,a])
children.append(opening_group)
for id in ('player01','d1spawn'):byid[id]['transform']['localPosition']=vec(-48,1.1,40)
component(byid['player01'],'PlayerController')['sprintSpeed']=6.5
byid['d1spawn']['transform']['localRotationEuler']=vec(0,0,0)
byid['mission_document']['transform']['localPosition']=vec(88,1.04,-22)
byid['mission_document']['name']='任务文件_尽头任务屋内'
byid['exitzone1']['transform']['localPosition']=vec(104,1,-8)
byid['exitzone1']['name']='白色撤离区'
# The original orange gate was only decoration; the GLB supplies the white ring.
byid['exitzone1']['_$child']=[]
level=copy.deepcopy(component(SCENE,'LevelController'))
level.update(enemies=[ref(n) for n in enemies],streetEnemies=[],courtyardEnemies=[],reinforcementEnemies=[],reinforcementSpawns=[],
             encounterWaves=[ref(n) for n in wave_nodes],missionRoutePoints=[ref(n) for n in route_nodes],routePoints=[ref(n) for n in triggers],
             teammates=[ref(n) for n in allies],exitHalfSize=vec(2.2,2,2.2),combatObjective='沿曲折小巷逐区推进，取得任务文件后撤离')
feedback=copy.deepcopy(component(SCENE,'CombatFeedback'))
feedback['enemies']=[ref(n) for n in enemies+allies]
feedback['enemyFlashes']=[ref(next(c for c in walk(n) if c.get('name')=='EnemyMuzzleFlash')) for n in enemies+allies]
ops=[{'op':'replace','path':'/_$child/0/_$child','value':json.dumps(children,ensure_ascii=False)}]
for i,c in enumerate(SCENE['_$comp']):
    if c.get('scriptPath','').endswith('/LevelController.ts'):ops.append({'op':'replace','path':f'/_$comp/{i}','value':json.dumps(level,ensure_ascii=False)})
    if c.get('scriptPath','').endswith('/CombatFeedback.ts'):ops.append({'op':'replace','path':f'/_$comp/{i}','value':json.dumps(feedback,ensure_ascii=False)})
for i,n in enumerate(SCENE['_$child']):
    if n.get('_$id')=='d1prototypehud':
        ops.append({'op':'add','path':f'/_$child/{i}/text','value':json.dumps('曲折小巷 · 分区推进 / 虚构任务布局',ensure_ascii=False)})
(OUT/'scene-patch.json').write_text(json.dumps(ops,ensure_ascii=False),encoding='utf8')
(OUT/'layout.json').write_text(json.dumps({'points':points,'cells':cells,'encounters':encounters,'rooms':room_manifest,'boxes':boxes},ensure_ascii=False,indent=2),encoding='utf8')
# A source-derived plan makes the X zones, task house and exit easy to review.
def sx(x):return 40+(x+80)*5.3
def sy(z):return 70+(z+56)*5.3
svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="740" viewBox="0 0 1200 740">',
     '<rect width="1200" height="740" fill="#14202b"/>',
     '<g font-family="Microsoft YaHei, sans-serif" fill="#eef3f3">',
     '<text x="40" y="35" font-size="23">曲折小巷 · 七区顺序推进</text>']
for r in room_manifest:
    w,d=(r['depth'],r['width']) if r['front'][0] else (r['width'],r['depth'])
    cx,cz=r['center'];fill='#7a7254' if r['name']=='任务屋' else '#394a55'
    svg.append(f'<rect x="{sx(cx-w/2):.1f}" y="{sy(cz-d/2):.1f}" width="{w*5.3:.1f}" height="{d*5.3:.1f}" fill="{fill}" stroke="#60717b"/>')
poly=' '.join(f'{sx(x):.1f},{sy(z):.1f}' for x,z in points)
svg.append(f'<polyline points="{poly}" fill="none" stroke="#8c9288" stroke-width="39" stroke-linejoin="miter"/>')
svg.append(f'<polyline points="{poly}" fill="none" stroke="#ff685d" stroke-width="3"/>')
for i,((x,z),_) in enumerate(encounters):
    x,z=sx(x),sy(z)
    svg.append(f'<path d="M{x-8},{z-8}L{x+8},{z+8}M{x+8},{z-8}L{x-8},{z+8}" stroke="#ff574e" stroke-width="5"/>')
    svg.append(f'<text x="{x+13}" y="{z+6}" font-size="19" font-weight="bold">{i+1}</text>')
svg.append(f'<circle cx="{sx(-48)}" cy="{sy(40)}" r="7" fill="#67dfaa"/><text x="{sx(-48)-20}" y="{sy(40)+33}" font-size="17">入口</text>')
x,z=sx(88),sy(-20)
svg.append(f'<path d="M{x},{z-12}L{x-13},{z+11}L{x+13},{z+11}Z" fill="none" stroke="#ffd47a" stroke-width="3"/><text x="{x-34}" y="{z+34}" font-size="16">任务屋</text>')
svg.append(f'<circle cx="{sx(104)}" cy="{sy(-8)}" r="12" fill="none" stroke="white" stroke-width="3"/><text x="{sx(104)-15}" y="{sy(-8)+36}" font-size="16">撤离</text>')
svg.append('<text x="40" y="702" font-size="17">红线：主路线　X 1–7：每区三人　△：任务文件　○：终点　｜　房屋仅单门进出</text></g></svg>')
(ROOT/'docs/lane-mission-layout.svg').write_text('\n'.join(svg),encoding='utf8')
print(json.dumps({'houses':len(houses),'collisionBoxes':len(boxes),'meshes':len(meshes),'glbBytes':len(glb),'routeLength':progress(points[-1]),'waves':7,'enemies':len(enemies),'allies':len(allies),'removedOverlapArea':round(removed_overlap_area,2)}))
