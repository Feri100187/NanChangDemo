"""Split the supplied rifle's existing bolt faces. No replacement/overlaid bolt geometry."""
import bpy
import bmesh
from pathlib import Path
from mathutils import Vector

if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('Use --background --factory-startup')
root=Path(__file__).resolve().parents[1]
folder=root/'assets/resources/weapons/ProvidedGun'
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
        pivot=Vector((0,-.15,.14))
        for v in obj.data.vertices:v.co-=pivot
        obj.location=pivot
    parts.append(obj)
assert sum(len(o.data.polygons) for o in parts)==len(source.data.polygons)
bpy.ops.object.select_all(action='DESELECT')
for o in parts:o.select_set(True)
bpy.context.view_layer.objects.active=parts[0]
bpy.ops.export_scene.gltf(filepath=str(folder/'RifleMechanism.glb'),export_format='GLB',use_selection=True,export_animations=False)
print('Preserved faces:',len(source.data.polygons),'Bolt faces:',len(selected))
