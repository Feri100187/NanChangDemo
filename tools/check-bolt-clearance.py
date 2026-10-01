"""Check exported right-arm surfaces against the static rifle during bolt manipulation.

Run in Blender with --background --factory-startup --python tools/check-bolt-clearance.py.
The first/last 4% retain the original resting grip/contact and are not tested here.
The moving bolt is excluded because the fingers intentionally grip it.
"""
import bpy
from pathlib import Path
from mathutils.bvhtree import BVHTree

if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('Use a separate background factory-startup Blender process.')
root = Path(__file__).resolve().parents[1]
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.context.scene.render.fps = 30
bpy.ops.import_scene.gltf(filepath=str(root/'assets/resources/characters/Player/AnimatedPlayer.glb'))
rig = next(o for o in bpy.context.scene.objects if o.type == 'ARMATURE')
arms = bpy.data.objects['ViewArms']
for track in rig.animation_data.nla_tracks:
    track.mute = True
right = {g.index for g in arms.vertex_groups if g.name.startswith('R_')}
weights = {v.index: sum(g.weight for g in v.groups if g.group in right) for v in arms.data.vertices}
faces = [p.vertices[:] for p in arms.data.polygons if all(weights[i] > .8 for i in p.vertices)]
bpy.ops.import_scene.gltf(filepath=str(root/'assets/resources/weapons/ProvidedGun/RifleMechanism.glb'))
body = bpy.data.objects['Static']
rifle = BVHTree.FromPolygons([body.matrix_world @ v.co for v in body.data.vertices],
    [p.vertices[:] for p in body.data.polygons])
failures = []
for name in ['ViewBolt', 'ViewReload']:
    action = next(a for a in bpy.data.actions if a.name == name or a.name.startswith(name+'_'))
    rig.animation_data.action = action
    if action.slots:
        rig.animation_data.action_slot = action.slots[0]
    low, high = action.frame_range
    for percent in range(4, 97):
        frame = low + (high-low)*percent/100
        bpy.context.scene.frame_set(int(frame), subframe=frame-int(frame))
        evaluated = arms.evaluated_get(bpy.context.evaluated_depsgraph_get())
        mesh = evaluated.to_mesh()
        hand = BVHTree.FromPolygons([arms.matrix_world @ v.co for v in mesh.vertices], faces)
        overlap = rifle.overlap(hand)
        evaluated.to_mesh_clear()
        if overlap:
            failures.append((name, percent, len(overlap)))
if failures:
    raise AssertionError(f'Right-arm / receiver surface intersections: {failures}')
print('PASS: exported ViewBolt and ViewReload, 186 samples without static-rifle surface intersections')
