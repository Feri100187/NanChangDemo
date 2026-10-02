"""Editable search routes and a finite, initially inactive reinforcement pool."""
import copy
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
file = ROOT/'assets/Demo01.ls'
data = json.loads(file.read_text(encoding='utf-8'))

def walk(node):
    yield node
    for child in node.get('_$child', []):
        yield from walk(child)

def ai(node):
    return next((c for c in node.get('_$comp', []) if c.get('scriptPath','').endswith('/EnemyAI.ts')), None)

level = next(c for c in data['_$comp'] if c.get('scriptPath','').endswith('/LevelController.ts'))
nodes = list(walk(data))
byid = {n.get('_$id'):n for n in nodes}
enemies = [byid[r['_$ref']] for r in level['enemies']]
allies = [byid[r['_$ref']] for r in level['teammates']]
parent = next(n for n in nodes if enemies[0] in n.get('_$child', []))
parent['_$child'] = [n for n in parent['_$child'] if not n.get('_$id','').startswith(('reinforce_', 'search_'))]
# Ground heights and free standing envelopes checked against the native physics map.
far = [(32,0,14),(32,.08,8),(32,.08,2),(32,.08,-4),(32,.08,-10),(28,0,-14),(22,0,-14),(16,0,-14),
       (-38,0,-30),(-34,0,-30),(-38,.05,-20),(-34,.05,-14),(-20,0,-16),(-12,0,-28),(-8,0,-22),(4,0,-26)]
near = [(-28,0,23),(-28,0,15),(-26,0,7),(-22,0,3),(-14,0,-9),(-6,.02,-1),(2,.02,3),(6,.02,7)]
def position(p):
    return dict(zip(['x','y','z'],p), **{'_$type':'Vector3'})

routes = []
for i,p in enumerate(far+near):
    node = {'_$id':f'search_route_{i}','_$type':'Sprite3D','name':f'SearchRoute_{i}',
            'transform':{'localPosition':position(p)}}
    parent['_$child'].append(node); routes.append({'_$ref':node['_$id']})
spawns = []
for i,p in enumerate(far):
    node = {'_$id':f'search_spawn_{i}','_$type':'Sprite3D','name':f'FarReinforcementSpawn_{i}',
            'transform':{'localPosition':position(p)}}
    parent['_$child'].append(node); spawns.append({'_$ref':node['_$id']})
for i,enemy in enumerate(enemies):
    enemy['transform']['localPosition'] = position(far[i])
for actor in enemies+allies:
    ai(actor)['patrolPoints'] = routes if ai(actor).get('friendly') else routes[:len(far)]
    ai(actor).update(sightRange=65, alertTime=.2)
    ai(actor)['patrolWaitSeconds'] = .8

reserves=[]
for i in range(4):
    node=copy.deepcopy(enemies[0])
    mapping={n['_$id']:f'reinforce_{i}_{n["_$id"]}' for n in walk(node) if '_$id' in n}
    def remap(value):
        if isinstance(value,dict):
            for key,item in value.items():
                if key in ['_$id','_$ref'] and isinstance(item,str) and item in mapping:value[key]=mapping[item]
                else:remap(item)
        elif isinstance(value,list):
            for item in value:remap(item)
    remap(node)
    node['name']=f'增援敌人_{i+1}';node['active']=False
    ai(node)['reinforcement']=True
    node['transform']['localPosition']=position(far[8+i])
    parent['_$child'].append(node);reserves.append(node)
level['reinforcementEnemies']=[{'_$ref':n['_$id']} for n in reserves]
level['reinforcementSpawns']=spawns
level.update(reinforcementDistance=35,reinforcementDelay=6,reinforcementCooldown=45)
for ally in allies:ai(ally)['opponents']=[{'_$ref':n['_$id']} for n in enemies+reserves]
feedback=next(c for c in data['_$comp'] if c.get('scriptPath','').endswith('/CombatFeedback.ts'))
feedback['enemies']=[{'_$ref':n['_$id']} for n in enemies+allies+reserves]
feedback['enemyFlashes']=[{'_$ref':next(c['_$id'] for c in walk(n) if c.get('name')=='EnemyMuzzleFlash')} for n in enemies+allies+reserves]
file.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print('Configured 8 distant enemies, 24 random-search waypoints, 16 spawn candidates and 4 inactive reserves')
