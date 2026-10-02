"""Prepare precise IDE JSON patches for the Songbaix environment integration.
Run at repository root; apply .tmp/songbaix-scene-patch.json with Laya_EditAsset.
Keeps gameplay scripts and source map untouched. GLB positions already use Y-up.
"""
import json, struct, pathlib, copy, uuid
R=pathlib.Path(__file__).resolve().parents[1]
D=R/'assets/resources/environment/songbaix'
def read_glb(name):
    b=(D/name).read_bytes(); n=struct.unpack_from('<I',b,12)[0]
    return json.loads(b[20:20+n]), b[20+n:]
def vec(v):return dict(zip(('x','y','z'),v),**{'_$type':'Vector3'})
def node(id,name,pos=None):
    n={'_$id':id,'_$type':'Sprite3D','name':name}
    if pos is not None:n['transform']={'localPosition':vec(pos)}
    return n
def collider(id,name,p,size):
    n=node(id,name,p);n['transform']['localScale']=vec(size)
    n['_$comp']=[{'_$type':'PhysicsCollider','colliderShape':{'_$type':'BoxColliderShape'},'collisionGroup':1,'canCollideWith':-1}]
    return n
def aabb(g,n):
    assert not n.get('rotation') and not n.get('matrix'),n['name']
    a=g['accessors'][g['meshes'][n['mesh']]['primitives'][0]['attributes']['POSITION']]
    t=n.get('translation',[0,0,0]);s=n.get('scale',[1,1,1])
    lo=[a['min'][i]*s[i]+t[i] for i in range(3)];hi=[a['max'][i]*s[i]+t[i] for i in range(3)]
    return [(lo[i]+hi[i])/2 for i in range(3)],[hi[i]-lo[i] for i in range(3)]
# Remove the non-interactive blank-paper display from a dedicated gameplay variant.
g,tail=read_glb('mission-building.glb')
omit={i for i,n in enumerate(g['nodes']) if n.get('name','').startswith('Mission_BlankDocument')}
for s in g['scenes']:s['nodes']=[i for i in s['nodes'] if i not in omit]
for n in g['nodes']:
    if 'children' in n:n['children']=[i for i in n['children'] if i not in omit]
j=json.dumps(g,separators=(',',':')).encode();j+=b' '*((-len(j))%4)
(D/'mission-building-game.glb').write_bytes(struct.pack('<4sII',b'glTF',2,20+len(j)+len(tail))+struct.pack('<II',len(j),0x4e4f534a)+j+tail)
meta=D/'mission-building-game.glb.meta'
if not meta.exists():meta.write_text(json.dumps({'uuid':str(uuid.uuid5(uuid.NAMESPACE_URL,'NanChangDemo/mission-building-game.glb'))},indent=2)+'\n')
s=json.loads((R/'assets/Demo01.ls').read_text(encoding='utf8'))
old=copy.deepcopy(s)
c=s['_$child'][0]['_$child'];byid={n['_$id']:n for n in c}
retired={'ground01','gridroot','bld00000','oldtownart','otrearart','songbaix_root','songbaix_collisions','sb_roomlight'}
c[:]=[n for n in c if n['_$id'] not in retired]
maproot=node('songbaix_root','Songbaix_Environment')
maproot['_$child']=[]
for stem in ['ground','landmark','street-buildings','mission-building-game','props']:
    uid=json.loads((D/(stem+'-unpacked')/(stem+'.lh.meta')).read_text())['uuid']
    maproot['_$child'].append({'_$id':'sb_'+stem,'_$prefab':uid,'name':'Songbaix_'+stem})
cr=node('songbaix_collisions','Songbaix_StaticCollisions');cr['_$child']=[]
g,_=read_glb('collision-proxies.glb')
for i,n in enumerate(g['nodes']):
    if 'mesh' in n:
        p,z=aabb(g,n);cr['_$child'].append(collider('sb_col_'+str(i),n['name'],p,z))
for stem,starts in [('props.glb',('MovableCrate_Fictional_',)),('mission-building.glb',('Mission_TableTop','Mission_TableLeg','Mission_Bench','Mission_Shelf')),('street-buildings.glb',('CourtyardGatePier','CourtyardGateLintel'))]:
    g,_=read_glb(stem)
    for i,n in enumerate(g['nodes']):
        name=n.get('name','')
        if any(name.startswith(k) for k in starts) and '_Band' not in name:
            p,z=aabb(g,n);cr['_$child'].append(collider('sb_extra_'+stem[:2]+str(i),'COL_'+name,p,z))
cr['_$child'].append(collider('sb_ceiling','COL_MissionCeiling',[-20,3.9,-27.5],[14,.18,11]))
c.extend([maproot,cr])
for id,h in [('player01',1.1),('d1spawn',1.1),('6jx8h8bvc6',1.65),('weapon01',1.65)]:
    byid[id].setdefault('transform',{})['localPosition']=vec([-28,h,27])
byid['d1spawn']['name']='SpawnPoint_Songbaix_Entry'
enemypos=[[-19,0,12],[-16,0,9],[-3,.02,-10],[2,.02,-7]]
for k,(id,p) in enumerate(zip(['target001','enemy002','enemy003','enemy004'],enemypos)):
    byid[id]['transform']['localPosition']=vec(p)
    route=byid['enemy_patrol_routes']['_$child'][k]
    route['transform']['localPosition']=vec(p)
byid['mission_document']['transform']['localPosition']=vec([-22.7,1.025,-25.7])
byid['exitzone1']['name']='ExitZone_Songbaix_NorthLane'
byid['exitzone1']['transform']['localPosition']=vec([-32,1,-36])
points=[(-28,-14,'沿巷前行，到街口右转'),(-20,-14,'清理街口两名敌人，沿前方转角通行'),(-11,-2,'沿院墙走，到尽头右转进院'),(-4,10,'清理院落两名敌人'),(-18.8,20,'进入北侧普通建筑，文件在西侧桌上'),(-18.8,31,'取得文件后穿过后门'),(-32,36,'抵达撤离区')]
for n,(x,y,txt) in zip(byid['d1waypoints']['_$child'],points):
    n['transform']['localPosition']=vec([x,0,-y]);n['name']=txt
# Neutral inspection lighting is retained until a separate night-lighting pass.
s['_$child'][0]['ambientColor']={'_$type':'Color','r':.6,'g':.62,'b':.65}
lamp=node('sb_roomlight','Songbaix_InteriorFill',[-23,3,-25.5])
lamp['_$comp']=[{'_$type':'PointLightCom','color':{'_$type':'Color','r':1,'g':.86,'b':.7},'intensity':1.1,'range':10}]
c.append(lamp)
for n in s['_$child']:
    if n.get('_$id')=='d1prototypehud':n['text']='松柏巷街区 · 历史地标参考 / 虚构任务布局'
# Whole child-list patch preserves every unchanged child object byte-for-byte semantically.
ops=[{'op':'replace','path':'/_$child/0/_$child','value':json.dumps(c,ensure_ascii=False)},
     {'op':'replace','path':'/_$child/0/ambientColor','value':json.dumps(s['_$child'][0]['ambientColor'])}]
for i,n in enumerate(s['_$child']):
    if n.get('_$id')=='d1prototypehud':ops.append({'op':'add','path':f'/_$child/{i}/text','value':json.dumps(n['text'],ensure_ascii=False)})
(R/'.tmp').mkdir(exist_ok=True)
(R/'.tmp/songbaix-scene-patch.json').write_text(json.dumps(ops,ensure_ascii=False),encoding='utf8')
print(json.dumps({'colliders':len(cr['_$child']),'map_modules':5,'ops':len(ops)}))
