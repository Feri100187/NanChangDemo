"""Original low-poly cartridge prop for the game; visual proportions, not engineering data.
Blender --background --factory-startup --python tools/create-cartridge-model.py
"""
import bpy
import math
import sys
from pathlib import Path

if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('Use a separate background factory-startup process.')
root = Path(__file__).resolve().parents[1]
bpy.context.preferences.filepaths.save_version = 0
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)

def material(name, color, metallic, roughness):
    mat = bpy.data.materials.new(name)
    mat.diffuse_color = (*color, 1)
    mat.use_nodes = True
    shader = mat.node_tree.nodes.get('Principled BSDF')
    shader.inputs['Base Color'].default_value = (*color, 1)
    shader.inputs['Metallic'].default_value = metallic
    shader.inputs['Roughness'].default_value = roughness
    return mat

brass = material('Cartridge_Brass', (.52,.31,.075), .72, .32)
copper = material('Cartridge_Copper', (.48,.18,.07), .66, .30)
primer = material('Cartridge_Primer', (.34,.30,.21), .65, .42)

def lathe(name, profile, mat):
    sides = 24
    verts = [(radius*math.cos(i*math.tau/sides), axial, radius*math.sin(i*math.tau/sides))
             for axial,radius in profile for i in range(sides)]
    faces = []
    for ring in range(len(profile)-1):
        for i in range(sides):
            a=ring*sides+i; b=ring*sides+(i+1)%sides
            faces.append((a,a+sides,b+sides,b))
    faces += [tuple(range(sides)), tuple((len(profile)-1)*sides+i for i in reversed(range(sides)))]
    mesh=bpy.data.meshes.new(name);mesh.from_pydata(verts,[],faces);mesh.update()
    obj=bpy.data.objects.new(name,mesh);bpy.context.collection.objects.link(obj)
    obj.data.materials.append(mat)
    for polygon in mesh.polygons:polygon.use_smooth=len(polygon.vertices)==4
    return obj

case_only = '--case-only' in sys.argv
parts = [
    lathe('CaseBrass',[(-.040,.0058),(-.039,.0060),(-.0378,.0060),(-.037,.00525),
        (-.0355,.00525),(-.0348,.0058),(.009,.0054),(.015,.0043),(.018,.00425),(.023,.00425)],brass),
    lathe('ProjectileCopper',[(.0225,.00405),(.029,.00405),(.033,.00375),(.036,.0030),
        (.038,.0021),(.0393,.0011),(.040,.00015)],copper),
    lathe('Primer',[(-.04025,.0022),(-.04015,.0022)],primer)
]
if case_only:
    for obj in parts:
        bpy.data.objects.remove(obj, do_unlink=True)
    # Open mouth and inner wall: an empty visual shell, never a flying live round.
    profile = [(-.040,.0058),(-.039,.0060),(-.0378,.0060),(-.037,.00525),
        (-.0355,.00525),(-.0348,.0058),(.009,.0054),(.015,.0043),(.018,.00425),
        (.023,.00425),(.023,.00365),(.018,.00365),(.014,.0037),(.008,.0048),(-.0375,.0048)]
    parts = [lathe('EmptyBrassCase',[(axial+.0085,radius) for axial,radius in profile],brass),
        lathe('SpentPrimer',[(-.03175,.0022),(-.03165,.0022)],primer)]
name = 'EjectedCase792' if case_only else 'Cartridge792'
bpy.ops.object.select_all(action='DESELECT')
for obj in parts:obj.select_set(True)
bpy.context.view_layer.objects.active=parts[0]
source=root/'source-assets/ammunition';source.mkdir(parents=True,exist_ok=True)
bpy.ops.wm.save_as_mainfile(filepath=str(source/(name+'.blend')))
destination=root/'assets/resources/weapons/Ammunition';destination.mkdir(parents=True,exist_ok=True)
bpy.ops.export_scene.gltf(filepath=str(destination/(name+'.glb')),export_format='GLB',
    use_selection=True,export_animations=False,export_yup=True)
print(name+' exported; original visual prop, opening/nose along Laya local -Z; no textures.')
