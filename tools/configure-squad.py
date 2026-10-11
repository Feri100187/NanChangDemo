"""Idempotent scene wiring for five allies; preserves the enemy mission roster."""
import copy
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
NPC_SCALE = 1.65 / 2.295872211456299

def walk(node):
    yield node
    for child in node.get('_$child', []):
        yield from walk(child)

def component(node, name):
    return next((c for c in node.get('_$comp', []) if c.get('scriptPath', '').endswith('/' + name + '.ts')), None)

for scene in ['Demo01', 'Scene']:
    file = ROOT / 'assets' / (scene + '.ls')
    data = json.loads(file.read_text(encoding='utf-8'))
    nodes = list(walk(data))
    level = component(data, 'LevelController')
    if not level:
        continue
    enemies = [n for n in nodes if component(n, 'EnemyAI') and not component(n, 'EnemyAI').get('friendly') and not component(n, 'EnemyAI').get('reinforcement')]
    parent = next(n for n in nodes if enemies[0] in n.get('_$child', []))
    parent['_$child'] = [n for n in parent['_$child'] if not n.get('_$id', '').startswith('squad_')]
    player = next(n for n in nodes if n.get('_$id') == level['player']['_$ref'])
    spawn = player['transform']['localPosition']
    points = [n for n in nodes if component(n, 'EnemyPatrolPoint')]
    routes = [{ '_$ref': n['_$id']} for n in points]
    for point in points:
        component(point, 'EnemyPatrolPoint').update(waitSeconds=.25, useFacing=False)
    for i, enemy in enumerate(enemies):
        enemy['transform']['localScale'] = {'_$type': 'Vector3', 'x': NPC_SCALE, 'y': NPC_SCALE, 'z': NPC_SCALE}
        ai = component(enemy, 'EnemyAI')
        start = ((i + 1) * 3) % len(routes)
        ai.update(patrolRadius=150, patrolSpeed=2, patrolWaitSeconds=.25, fieldOfView=180,
                  alertTime=.2, sightRange=65, loseTargetTime=4, turnSpeed=240, combatSpeed=2.2,
                  patrolPoints=routes[start:] + routes[:start])
    if scene == 'Scene':
        file.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
        print(scene, 'normalized', len(enemies), 'enemies; kept the test-scene roster')
        continue
    allies = []
    for i, (dx, dz) in enumerate([(-1.2, -1.8), (1.2, -1.8), (0, -3.6), (-1.2, -5.4), (1.2, -5.4)]):
        bot = copy.deepcopy(enemies[0])
        mapping = {n['_$id']: f'squad_{i}_{n["_$id"]}' for n in walk(bot) if '_$id' in n}
        def remap(value):
            if isinstance(value, dict):
                for k, v in value.items():
                    if k in ['_$id', '_$ref'] and isinstance(v, str) and v in mapping:
                        value[k] = mapping[v]
                    else:
                        remap(v)
            elif isinstance(value, list):
                for v in value:
                    remap(v)
        remap(bot)
        bot['name'] = f'队友_{i + 1}'
        bot['transform']['localPosition'] = {'_$type': 'Vector3', 'x': spawn.get('x', 0) + dx, 'y': 0.05, 'z': spawn.get('z', 0) + dz}
        ai = component(bot, 'EnemyAI')
        ai.update(friendly=True, opponents=[{'_$ref': e['_$id']} for e in enemies], patrolRadius=150,
                  patrolSpeed=2, patrolWaitSeconds=.25, fieldOfView=180, alertTime=.2, sightRange=65,
                  patrolPoints=routes[i:] + routes[:i])
        visual = next(n for n in bot['_$child'] if n.get('name') == 'EnemyVisual')
        visual['_$prefab'] = json.loads((ROOT/'assets/resources/characters/Ally/ProvidedAlly.lh.meta').read_text(encoding='utf-8'))['uuid']
        visual['name'] = 'AllyVisual'
        visual['transform'] = {'localScale': {'_$type':'Vector3', 'x':1/NPC_SCALE, 'y':1/NPC_SCALE, 'z':1/NPC_SCALE}}
        # A cyan shoulder marker distinguishes allies without changing shared enemy materials.
        marker = copy.deepcopy(next(n for n in bot['_$child'] if n['name'] == 'Head'))
        marker['_$id'] = f'squad_{i}_marker'
        marker['name'] = 'AllyMarker'
        marker['transform'] = {'localPosition': {'_$type': 'Vector3', 'x': 0, 'y': .48, 'z': 0},
                               'localScale': {'_$type': 'Vector3', 'x': .7, 'y': .2, 'z': .7}}
        marker['_$comp'] = [c for c in marker['_$comp'] if c['_$type'] != 'PhysicsCollider']
        renderer = next(c for c in marker['_$comp'] if c['_$type'] == 'MeshRenderer')
        renderer['enabled'] = True
        renderer['sharedMaterials'] = [{'_$uuid': 'a286a154-9045-4858-b27a-802386815eed', '_$type': 'Material'}]
        next(n for n in bot['_$child'] if n['name'] == 'Head').setdefault('_$child', []).append(marker)
        parent['_$child'].append(bot)
        allies.append(bot)
    refs = [{ '_$ref': n['_$id']} for n in allies]
    level['teammates'] = refs
    for enemy in enemies:
        component(enemy, 'EnemyAI')['opponents'] = refs
    feedback = component(data, 'CombatFeedback')
    if feedback:
        feedback['enemies'] = [{ '_$ref': n['_$id']} for n in enemies + allies]
        feedback['enemyFlashes'] = [{ '_$ref': next(n['_$id'] for n in walk(e) if n.get('name') == 'EnemyMuzzleFlash')} for e in enemies + allies]
    file.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(scene, 'wired', len(allies), 'allies and', len(enemies), 'enemies')
