"""Blender background checks: reopen source, validate geometry, reimport actual GLBs.
This is an asset check, not a gameplay or historical-accuracy test.
"""
import bpy, bmesh, json, math, struct, hashlib
from pathlib import Path
from mathutils import Vector
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
OUT=ROOT/'assets/resources/environment/songbaix'
bpy.ops.wm.open_mainfile(filepath=str(HERE/'Songbaix_Block.blend'))
bpy.data.collections['90_CollisionProxies'].hide_viewport=False
bpy.context.view_layer.update()
report={'blender_version':bpy.app.version_string,'source_open':'PASS','source_sha256':hashlib.sha256((HERE/'Songbaix_Block.blend').read_bytes()).hexdigest(),'modules':{},'limitations':['This report checks Blender and GLB; engine checks are recorded in docs/songbaix-interiors-checks.json.','No historical survey: all dimensions estimated.']}
modules={'ground':'01_Ground','landmark':'02_Landmark','street-buildings':'03_StreetBuildings','mission-building':'04_MissionBuilding_Fictional','props':'05_Props','collision-proxies':'90_CollisionProxies'}
def bounds(obs):
    pts=[o.matrix_world@Vector(v) for o in obs for v in o.bound_box]
    return [[min(p[i] for p in pts) for i in range(3)],[max(p[i] for p in pts) for i in range(3)]]
def validate(obs):
    errors=[]
    for me in set(o.data for o in obs):
        if not me.uv_layers:errors.append('missing UV '+me.name)
        if not me.materials:errors.append('missing material '+me.name)
        if any(p.area<1e-10 for p in me.polygons):errors.append('zero area '+me.name)
        if any(not math.isfinite(v) for vert in me.vertices for v in vert.co):errors.append('nonfinite vertex '+me.name)
        bm=bmesh.new();bm.from_mesh(me)
        if any(not e.is_manifold for e in bm.edges):errors.append('nonmanifold '+me.name)
        if bm.calc_volume(signed=True)<-1e-6:errors.append('negative volume '+me.name)
        bm.free()
    return errors
source_bounds={}
for stem,group in modules.items():
    obs=[o for o in bpy.data.collections[group].objects if o.type=='MESH']
    source_bounds[stem]=bounds(obs)
    report['modules'][stem]={'source_bounds':source_bounds[stem],'source_errors':validate(obs),'file_bytes':(OUT/(stem+'.glb')).stat().st_size}
report['packed_texture_count']=sum(bool(i.packed_file) for i in bpy.data.images if i.source=='FILE')
assert report['packed_texture_count']==7,report['packed_texture_count']
layout=json.loads((HERE/'layout.json').read_text())
proxies=list(bpy.data.collections['90_CollisionProxies'].objects)
hits=[]
for seg,(a,b) in enumerate(zip(layout['route_xy'],layout['route_xy'][1:])):
    length=math.dist(a,b)
    for k in range(math.ceil(length/.15)+1):
        t=k/max(1,math.ceil(length/.15));x=a[0]+(b[0]-a[0])*t;y=a[1]+(b[1]-a[1])*t
        for o in proxies:
            lo,hi=bounds([o])
            if hi[2]<=.06 or lo[2]>=2.05:continue
            dx=max(lo[0]-x,0,x-hi[0]);dy=max(lo[1]-y,0,y-hi[1])
            if dx*dx+dy*dy < .45**2:
                hits.append({'segment':seg,'object':o.name});break
        if hits and hits[-1]['segment']==seg:break
report['route_static_proxy_clearance']={'sample_step_m':.15,'radius_m':.45,'height_m':2,'collisions':hits,'scope':'XY samples against static proxy boxes; not physics/navmesh/combat test'}

for stem in modules:
    # GLB binary header + schema surface checks, followed by real Blender import.
    raw=(OUT/(stem+'.glb')).read_bytes()
    magic,version,total=struct.unpack_from('<4sII',raw)
    assert magic==b'glTF' and version==2 and total==len(raw)
    size,typ=struct.unpack_from('<II',raw,12);assert typ==0x4e4f534a
    gltf=json.loads(raw[20:20+size])
    primitives=[p for m in gltf['meshes'] for p in m['primitives']]
    attrs_ok=all('NORMAL' in p['attributes'] and 'TEXCOORD_0' in p['attributes'] for p in primitives)
    assert attrs_ok
    report['modules'][stem]['glb_attributes']='NORMAL + TEXCOORD_0'
    report['modules'][stem]['required_extensions']=gltf.get('extensionsRequired',[])
    report['modules'][stem]['sha256']=hashlib.sha256(raw).hexdigest()
    assert all('bufferView' in i and 'uri' not in i for i in gltf.get('images',[]))
    assert not gltf.get('extensionsRequired')
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.ops.import_scene.gltf(filepath=str(OUT/(stem+'.glb')))
    bpy.context.view_layer.update()
    obs=[o for o in bpy.context.scene.objects if o.type=='MESH']
    bb=bounds(obs);src=source_bounds[stem]
    delta=max(abs(bb[i][j]-src[i][j]) for i in range(2) for j in range(3))
    # GLTF splits vertices at UV/normal seams; topology manifold check applies to source meshes.
    missing=[m.name for o in obs for m in o.data.materials if not m]
    report['modules'][stem].update(reimport='PASS',bounds_max_error_m=delta,reimport_mesh_objects=len(obs),image_count=len([i for i in bpy.data.images if i.source=='FILE']))
    print('REIMPORT_BOUNDS',stem,'error',delta,'source',src,'actual',bb,flush=True)
    (HERE/'validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf8')
    assert delta<.001 and not missing
report['source_geometry']='PASS' if not any(v['source_errors'] for v in report['modules'].values()) else 'FAIL'
report['route_static_proxy_clearance']['result']='FAIL' if hits else 'PASS'
(HERE/'validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf8')
assert report['source_geometry']=='PASS',report
assert not hits,hits
print('SONGBAIX_ASSET_CHECKS_PASS')
