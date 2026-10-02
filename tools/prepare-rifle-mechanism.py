"""Correct the supplied rifle's left-handed bolt in Blender, preserving its mesh/UVs.

Only the moving bolt/handle is reflected; stock, receiver and sights stay intact.
"""
import bpy
import bmesh
import json
import re
from pathlib import Path
from mathutils import Vector

if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('Use --background --factory-startup')
root=Path(__file__).resolve().parents[1]
folder=root/'assets/resources/weapons/ProvidedGun'
motion=(root/'src/WeaponMotion.ts').read_text(encoding='utf8')
mechanism=json.loads(re.search(r'export const BOLT_MECHANISM = (\{.*?\n\});',motion,re.S).group(1))
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)
bpy.ops.import_scene.gltf(filepath=str(folder/'ProvidedRifle.glb'))
source=next(o for o in bpy.context.scene.objects if o.type=='MESH')
selected=set()
for face in source.data.polygons:
    center=source.matrix_world@face.center
    x,y,z=center.x,center.z,-center.y
    handle=x<-.013 and .105<y<.165 and .10<z<.19
    shaft=abs(x)<.014 and y>.142 and .075<z<.224
    if handle or shaft:selected.add(face.index)
assert 20<len(selected)<len(source.data.polygons)//2, 'Unexpected bolt selection'
parts=[]
for name,keep in [('Static',False),('Bolt',True)]:
    obj=source.copy();obj.data=source.data.copy();obj.name=name
    bpy.context.collection.objects.link(obj)
    bm=bmesh.new();bm.from_mesh(obj.data);bm.faces.ensure_lookup_table()
    bmesh.ops.delete(bm,geom=[f for f in bm.faces if (f.index in selected)!=keep],context='FACES_ONLY')
    bmesh.ops.delete(bm,geom=[v for v in bm.verts if not v.link_faces],context='VERTS')
    bm.to_mesh(obj.data);bm.free()
    if keep:
        # Reflect this part's geometry and winding, not the whole rifle or its
        # node scale. The corrected exported node retains a positive scale.
        for v in obj.data.vertices:v.co.x=-v.co.x
        bm=bmesh.new();bm.from_mesh(obj.data)
        bmesh.ops.reverse_faces(bm,faces=list(bm.faces))
        bmesh.ops.recalc_face_normals(bm,faces=list(bm.faces))
        bm.to_mesh(obj.data);bm.free()
        x,y,z=mechanism['pivot'];pivot=Vector((x,-z,y))
        for v in obj.data.vertices:v.co-=pivot
        obj.location=pivot
    parts.append(obj)
assert sum(len(o.data.polygons) for o in parts)==len(source.data.polygons)
bpy.ops.object.select_all(action='DESELECT')
for o in parts:o.select_set(True)
bpy.context.view_layer.objects.active=parts[0]
bpy.ops.export_scene.gltf(filepath=str(folder/'RifleMechanism.glb'),export_format='GLB',use_selection=True,export_animations=False)
source.hide_set(True);source.hide_render=True
source.name='OriginalLeftBolt_ReferenceOnly'
for image in bpy.data.images:
    if not image.packed_file and image.source=='FILE':image.pack()
authoring=root/'source-assets/weapons/HanyangRifleMechanism.blend'
authoring.parent.mkdir(parents=True,exist_ok=True)
bpy.ops.wm.save_as_mainfile(filepath=str(authoring),compress=True)
print('Preserved faces:',len(source.data.polygons),'Bolt faces:',len(selected))
