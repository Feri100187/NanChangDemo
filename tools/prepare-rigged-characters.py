"""Bake editable, in-place prototype animations onto the supplied 71-bone characters.

Run with Blender --background --factory-startup --python tools/prepare-rigged-characters.py.
The supplied GLBs under source-assets/characters/rigged are never modified.
"""
import bpy
import bmesh
import math
from pathlib import Path
from mathutils import Matrix, Vector, Quaternion

ROOT = Path(__file__).resolve().parents[1]
if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('Use a separate background factory-startup Blender process.')


def aim(rig, name, child, target):
    bone = rig.pose.bones[name]
    head = bone.head.copy()
    tip = rig.pose.bones[child].head.copy() if child else bone.tail.copy()
    rotation = (tip - head).rotation_difference(target - head).to_matrix().to_4x4()
    bone.matrix = Matrix.Translation(head) @ rotation @ Matrix.Translation(-head) @ bone.matrix
    bpy.context.view_layer.update()


def limb(rig, upper, lower, end, target, pole):
    shoulder = rig.pose.bones[upper].head.copy()
    elbow = rig.pose.bones[lower].head.copy()
    hand = rig.pose.bones[end].head.copy()
    a, b = (elbow - shoulder).length, (hand - elbow).length
    direction = (target - shoulder).normalized()
    distance = max(abs(a-b)+.001, min(a+b-.001, (target-shoulder).length))
    along = (a*a-b*b+distance*distance)/(2*distance)
    normal = pole - shoulder
    normal = (normal-direction*normal.dot(direction)).normalized()
    joint = shoulder + direction*along + normal*math.sqrt(max(0, a*a-along*along))
    aim(rig, upper, lower, joint)
    aim(rig, lower, end, shoulder+direction*distance)


CLIPS = {'Idle':2.0, 'Walk':1.0, 'Run':.64, 'CrouchIdle':2.0,
         'CrouchWalk':1.2, 'Aim':2.0, 'Fire':.4, 'Reload':3.3,
         'Jump':.7, 'Melee':.32, 'HeavyMelee':.62,
         'CrouchFire':.4, 'CrouchReload':3.3, 'CrouchMelee':.32,
         'CrouchHeavyMelee':.62, 'StrafeLeft':1.0, 'StrafeRight':1.0}

for role in ['Player', 'Enemy']:
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for action in list(bpy.data.actions):
        bpy.data.actions.remove(action)
    bpy.ops.import_scene.gltf(filepath=str(ROOT / 'source-assets/characters/rigged' / f'{role}.glb'))
    rig = next(o for o in bpy.context.scene.objects if o.type == 'ARMATURE')
    mesh = next(o for o in bpy.context.scene.objects if o.type == 'MESH')
    rig.name = f'{role}Rig'
    mesh.name = 'Body'
    meshes = [mesh]
    if role == 'Player':
        groups = {g.index for g in mesh.vertex_groups if g.name in ['Head','NeckTwist01','NeckTwist02']}
        weights = {v.index:sum(g.weight for g in v.groups if g.group in groups) for v in mesh.data.vertices}
        faces = {p.index for p in mesh.data.polygons if sum(weights[i] for i in p.vertices)/len(p.vertices) > .5}
        head = mesh.copy()
        head.data = mesh.data.copy()
        head.name = 'FirstPersonHiddenHead'
        bpy.context.collection.objects.link(head)
        meshes.append(head)
        for obj, keep in [(mesh, False), (head, True)]:
            bm = bmesh.new()
            bm.from_mesh(obj.data)
            bm.faces.ensure_lookup_table()
            bmesh.ops.delete(bm, geom=[f for f in bm.faces if (f.index in faces) != keep], context='FACES_ONLY')
            bmesh.ops.delete(bm, geom=[v for v in bm.verts if not v.link_faces], context='VERTS')
            bm.to_mesh(obj.data)
            bm.free()
    scale = 1 if role == 'Player' else 2.55/1.8
    def pos(x,y,z):
        return Vector((x*scale,-z*scale,y*scale))
    rest = {b.name:b.matrix_local.copy() for b in rig.data.bones}
    feet = {s:rest[f'{s}_Foot'].translation.copy() for s in ['L','R']}

    def pose(name, phase):
        for bone in rig.pose.bones:
            bone.matrix_basis = Matrix.Identity(4)
            bone.rotation_mode = 'QUATERNION'
        bpy.context.view_layer.update()
        crouch = name.startswith('Crouch')
        walking = name in ['Walk','Run','CrouchWalk','StrafeLeft','StrafeRight']
        cycle = phase*math.tau
        hip = rig.pose.bones['Hip']
        mat = hip.matrix.copy()
        mat.translation += pos(0,(-.43 if crouch else 0)+(.008*math.sin(cycle*2) if walking else .003*math.sin(cycle)),0)
        hip.matrix = mat
        bpy.context.view_layer.update()
        if crouch:
            spine = rig.pose.bones['Spine01']
            p = spine.head.copy()
            spine.matrix = Matrix.Translation(p) @ Matrix.Rotation(math.radians(12),4,'X') @ Matrix.Translation(-p) @ spine.matrix
            bpy.context.view_layer.update()
        for side, sign in [('L',1),('R',-1)]:
            foot = feet[side].copy()
            stride = math.sin(cycle+(0 if side=='L' else math.pi)) if walking else 0
            foot += pos(0,max(0,stride)*(.10 if name=='Run' else .055),stride*(.16 if name=='Run' else .10))
            if name.startswith('Strafe'):
                foot = feet[side] + pos(stride*.09*(1 if name=='StrafeLeft' else -1),max(0,stride)*.045,0)
            if name=='Jump':
                foot += pos(0,.10*math.sin(math.pi*phase),-.08*math.sin(math.pi*phase))
            limb(rig,f'{side}_Thigh',f'{side}_Calf',f'{side}_Foot',foot,pos(sign*.2,.5,.6))
            pb=rig.pose.bones[f'{side}_Foot']
            mat=rest[pb.name].copy()
            mat.translation=pb.head.copy()
            pb.matrix=mat
            bpy.context.view_layer.update()
            # Enemy grip matches the existing world-space rifle mount. Player arms remain
            # below the first-person camera; the existing weapon view handles aiming/recoil.
            y = (1.72 if side=='L' else 1.65)/scale if role=='Enemy' else .94
            x = (.12 if side=='L' else .03)/scale if role=='Enemy' else sign*.23
            z = (.38 if side=='L' else .08)/scale if role=='Enemy' else .05
            y -= .40 if crouch else 0
            if name.endswith('Fire'): z -= .045*math.sin(math.pi*phase)
            if name.endswith('Reload') and side=='R':
                y += .08*math.sin(phase*math.tau*2)
                z += .12*math.sin(math.pi*phase)
            if name.endswith('Melee') and side=='R':
                y += .16*math.sin(math.pi*phase)
                z += .23*math.sin(math.pi*phase)
            limb(rig,f'{side}_Upperarm',f'{side}_Forearm',f'{side}_Hand',pos(x,y,z),pos(sign*.42,y-.15,.02))
            hand=rig.pose.bones[f'{side}_Hand']
            aim(rig,hand.name,None,hand.head+(pos(0,0,.1) if role=='Enemy' else pos(0,-.1,0)))
            for finger in ['Index','Middle','Ring','Little','Thumb']:
                for segment in ['01','02','03']:
                    bone=rig.pose.bones.get(f'{side}_{finger}_{segment}')
                    if bone: bone.rotation_quaternion=Quaternion((1,0,0),math.radians(20 if finger=='Index' else 38))
        bpy.context.view_layer.update()

    bpy.context.scene.render.fps=30
    for name,duration in CLIPS.items():
        action=bpy.data.actions.new(name)
        action.use_fake_user=True
        rig.animation_data_create()
        rig.animation_data.action=action
        end=round(duration*30)
        for frame in range(end+1):
            pose(name,frame/end)
            for bone in rig.pose.bones:
                bone.keyframe_insert('location',frame=frame,group=bone.name)
                bone.keyframe_insert('rotation_quaternion',frame=frame,group=bone.name)
                bone.keyframe_insert('scale',frame=frame,group=bone.name)
    rig.animation_data.action=bpy.data.actions['Idle']
    bpy.context.scene.frame_set(0)
    bpy.ops.object.select_all(action='DESELECT')
    for obj in [rig]+meshes: obj.select_set(True)
    bpy.context.view_layer.objects.active=rig
    folder=ROOT/'assets/resources/characters'/role
    bpy.ops.export_scene.gltf(filepath=str(folder/f'Animated{role}.glb'),export_format='GLB',
        use_selection=True,export_animations=True,export_animation_mode='ACTIONS',
        export_force_sampling=True,export_optimize_animation_size=False,export_yup=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'.tmp'/f'Animated{role}.blend'))
    print('EXPORTED',role,len(rig.data.bones),'bones',list(CLIPS))
