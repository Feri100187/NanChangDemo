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
retired={'ground01','gridroot','bld00000','oldtownart','otrearart','songbaix_root','songbaix_collisions','sb_roomlight','enemy005','enemy006','enemy007','enemy008'}
c[:]=[n for n in c if n['_$id'] not in retired and not n['_$id'].startswith('sb_roomfill_')]
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
byid['enemy_patrol_routes']['_$child']=[n for n in byid['enemy_patrol_routes']['_$child'] if not n['_$id'].startswith('sb_extra_route_')]
for k,(id,p) in enumerate(zip(['target001','enemy002','enemy003','enemy004'],enemypos)):
    byid[id]['transform']['localPosition']=vec(p)
    route=byid['enemy_patrol_routes']['_$child'][k]
    route['transform']['localPosition']=vec(p)
# Clone the existing enemy with a complete ID/reference remap, including muzzle/eye nodes.
def ids_in(n):
    result=[n['_$id']] if '_$id' in n else []
    for child in n.get('_$child',[]):result+=ids_in(child)
    return result
def remap(v,ids):
    if isinstance(v,dict):return {k:remap(x,ids) for k,x in v.items()}
    if isinstance(v,list):return [remap(x,ids) for x in v]
    return ids.get(v,v) if isinstance(v,str) else v
for i,pos in [(5,[-18,.05,0]),(6,[-35,.05,5]),(7,[20,.08,0]),(8,[-3,.05,-29])]:
    template=byid['target001'];patrol=byid['enemy_patrol_routes']['_$child'][0]
    mapping={id:'sb_e%d_'%i+id for id in ids_in(template)+ids_in(patrol)}
    mapping[template['_$id']]='enemy%03d'%i;mapping[patrol['_$id']]='sb_extra_route_%d'%i
    enemy=remap(copy.deepcopy(template),mapping);enemy['name']='Interior_Enemy%02d_Fictional'%i;enemy['transform']['localPosition']=vec(pos)
    pr=remap(copy.deepcopy(patrol),mapping);pr['transform']['localPosition']=vec(pos);pr['name']='InteriorPatrol_%d'%i
    c.append(enemy);byid['enemy_patrol_routes']['_$child'].append(pr)
    # No instant fire on entering a room: retain original sight/alert/damage parameters.
controller=s['_$comp'][0]
controller['enemies']=[{'_$ref':v} for v in ['target001','enemy002','enemy003','enemy004','enemy005','enemy006','enemy007','enemy008']]
controller['streetEnemies']=[{'_$ref':v} for v in ['target001','enemy002','enemy005','enemy006']]
controller['courtyardEnemies']=[{'_$ref':v} for v in ['enemy003','enemy004','enemy007','enemy008']]
byid['mission_document']['transform']['localPosition']=vec([-22.7,1.025,-25.7])
byid['exitzone1']['name']='ExitZone_Songbaix_NorthLane'
byid['exitzone1']['transform']['localPosition']=vec([-32,1,-36])
points=[(-28,-14,'沿巷前行，房屋门洞均可进入'),(-20,-14,'街区共四名敌人：注意西侧及转角屋内'),(-11,-2,'搜索转角房屋后，沿院墙进院'),(-4,10,'院区共四名敌人：搜索教堂与北侧小屋'),(-18.8,20,'清敌后进入任务建筑，文件在西侧木桌'),(-18.8,31,'取得文件后穿过后门'),(-32,36,'抵达撤离区')]
for n,(x,y,txt) in zip(byid['d1waypoints']['_$child'],points):
    n['transform']['localPosition']=vec([x,0,-y]);n['name']=txt
# Neutral inspection lighting is retained until a separate night-lighting pass.
s['_$child'][0]['ambientColor']={'_$type':'Color','r':.6,'g':.62,'b':.65}
lamp=node('sb_roomlight','Songbaix_InteriorFill',[-23,3,-25.5])
lamp['_$comp']=[{'_$type':'PointLightCom','color':{'_$type':'Color','r':1,'g':.86,'b':.7},'intensity':1.1,'range':10}]
c.append(lamp)
for i,(x,y,z,ran) in enumerate([(-35,3,23,10),(-18,3,24,9),(-35,3,5,10),(-18,3,0,9),(-35,3,-17,10),(-4,3,24,9),(-3,3,-29,8),(22,6,0,22),(44,6,0,22)]):
    light=node('sb_roomfill_'+str(i),'RoomFill_'+str(i),[x,y,z]);light['_$comp']=[{'_$type':'PointLightCom','color':{'_$type':'Color','r':1,'g':.91,'b':.8},'intensity':.9,'range':ran}];c.append(light)
byid['6jx8h8bvc6']['farPlane']=180
for n in s['_$child']:
    if n.get('_$id')=='d1prototypehud':n['text']='松柏巷街区 · 历史地标参考 / 虚构任务布局'
# Whole child-list patch preserves every unchanged child object byte-for-byte semantically.
ops=[{'op':'replace','path':'/_$child/0/_$child','value':json.dumps(c,ensure_ascii=False)},
     {'op':'replace','path':'/_$comp/0','value':json.dumps(controller,ensure_ascii=False)},
     {'op':'replace','path':'/_$child/0/ambientColor','value':json.dumps(s['_$child'][0]['ambientColor'])}]
for i,n in enumerate(s['_$child']):
    if n.get('_$id')=='d1prototypehud':ops.append({'op':'add','path':f'/_$child/{i}/text','value':json.dumps(n['text'],ensure_ascii=False)})
(R/'.tmp').mkdir(exist_ok=True)
(R/'.tmp/songbaix-scene-patch.json').write_text(json.dumps(ops,ensure_ascii=False),encoding='utf8')
print(json.dumps({'colliders':len(cr['_$child']),'map_modules':5,'ops':len(ops)}))
