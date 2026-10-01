"""Bake editable, in-place prototype animations onto the supplied 71-bone characters.

Run with Blender --background --factory-startup --python tools/prepare-rigged-characters.py.
The supplied GLBs under source-assets/characters/rigged are never modified.
"""
import bpy
import bmesh
import math
import sys
import json
import re
from pathlib import Path
from mathutils import Matrix, Vector, Quaternion

ROOT = Path(__file__).resolve().parents[1]
motion_source = (ROOT/'src/WeaponMotion.ts').read_text(encoding='utf8')
KNIFE_MOTION = json.loads(re.search(r'export const KNIFE_MOTION = (\{.*?\n\});',motion_source,re.S).group(1))
BOLT_MOTION = json.loads(re.search(r'export const BOLT_MOTION = (\{.*?\n\});',motion_source,re.S).group(1))
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


def hand_frame(rig, rest, side, wrist, forward, palm):
    """Place the palm, not just the wrist: the local bend direction faces the grip."""
    hand = rig.pose.bones[f'{side}_Hand']
    rest_forward = (rest[f'{side}_Middle_01'].translation-rest[hand.name].translation).normalized()
    finger = rest[f'{side}_Middle_01'].to_3x3()
    rest_palm = finger.col[0].cross(finger.col[1]).normalized()
    def frame(f, p):
        f=f.normalized();p=(p-f*p.dot(f)).normalized()
        return Matrix((f,p,f.cross(p))).transposed()
    rotation=frame(forward,palm) @ frame(rest_forward,rest_palm).transposed()
    matrix=(rotation @ rest[hand.name].to_3x3().normalized()).to_4x4()
    matrix.translation=wrist
    hand.matrix=matrix
    bpy.context.view_layer.update()


def motion_value(keys, phase, column):
    t=max(0,min(1,phase))
    for a,b in zip(keys,keys[1:]):
        if t<=b[0]:
            u=(t-a[0])/(b[0]-a[0]);u=u*u*(3-2*u)
            return a[column]+(b[column]-a[column])*u
    return keys[-1][column]


def knife_pose(phase, heavy=False):
    """Same visual motion as KnifeView.setPose; all values are camera-local metres/degrees."""
    keys=KNIFE_MOTION['heavy' if heavy else 'light']
    p=Vector(tuple(motion_value(keys,phase,c) for c in [1,2,3]))
    x,y,z=[math.radians(motion_value(keys,phase,c)) for c in [4,5,6]]
    rotation=Matrix.Rotation(y,3,'Y') @ Matrix.Rotation(x,3,'X') @ Matrix.Rotation(z,3,'Z')
    return p,rotation


CLIPS = {'Idle':2.0, 'Walk':1.0, 'Run':.64, 'CrouchIdle':2.0,
         'CrouchWalk':1.2, 'Aim':2.0, 'Fire':.4, 'Reload':3.3,
         'Jump':.7, 'Melee':.32, 'HeavyMelee':.62,
         'CrouchFire':.4, 'CrouchReload':3.3, 'CrouchMelee':.32,
         'CrouchHeavyMelee':.62, 'StrafeLeft':1.0, 'StrafeRight':1.0}
PLAYER_CLIPS = {'Hold':2.0, 'HoldWalk':1.0, 'HoldRun':.64, 'CrouchHold':2.0,
                'CrouchHoldWalk':1.2, 'AimWalk':1.0, 'CrouchAim':2.0,
                'CrouchAimWalk':1.2, 'ViewHold':2.0, 'ViewAim':2.0, 'ViewReload':3.3,
                'ViewBolt':1.05, 'KnifeHold':2.0, 'KnifeWalk':1.0, 'KnifeRun':.64, 'CrouchKnifeHold':2.0,
                'CrouchKnifeWalk':1.2, 'ViewKnifeHold':2.0, 'ViewKnifeLight':.32, 'ViewKnifeHeavy':.62}

for role in (['Player'] if '--player-only' in sys.argv else ['Player','Enemy']):
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
        arm_groups = {g.index for g in mesh.vertex_groups if any(s in g.name for s in
            ['Upperarm','Forearm','Hand','Index_','Middle_','Ring_','Little_','Thumb_'])}
        arm_weights = {v.index:sum(g.weight for g in v.groups if g.group in arm_groups) for v in mesh.data.vertices}
        arm_faces = {p.index for p in mesh.data.polygons if p.index not in faces
            and sum(arm_weights[i] for i in p.vertices)/len(p.vertices) > .5}
        for name, selected in [('FirstPersonHiddenHead',faces),('Arms',arm_faces)]:
            part = mesh.copy()
            part.data = mesh.data.copy()
            part.name = name
            bpy.context.collection.objects.link(part)
            meshes.append(part)
        for obj, selected in [(mesh,faces|arm_faces),(meshes[1],faces),(meshes[2],arm_faces)]:
            bm = bmesh.new()
            bm.from_mesh(obj.data)
            bm.faces.ensure_lookup_table()
            keep = obj != mesh
            bmesh.ops.delete(bm, geom=[f for f in bm.faces if (f.index in selected) != keep], context='FACES_ONLY')
            bmesh.ops.delete(bm, geom=[v for v in bm.verts if not v.link_faces], context='VERTS')
            bm.to_mesh(obj.data)
            bm.free()
        # The full-body shoulder blends into the clavicle/chest. The FPS copy is an
        # open sleeve cut: remove those chest influences so moving its shoulder into
        # camera space cannot stretch triangles back towards the torso's rest pose.
        view_mesh = meshes[2].copy()
        view_mesh.data = meshes[2].data.copy()
        view_mesh.name = 'ViewArms'
        bpy.context.collection.objects.link(view_mesh)
        meshes.append(view_mesh)
        for vertex in view_mesh.data.vertices:
            weights = [(g.group,g.weight) for g in vertex.groups if g.group in arm_groups]
            if not weights:
                side = 'L' if vertex.co.x > 0 else 'R'
                weights = [(view_mesh.vertex_groups[f'{side}_Upperarm'].index,1)]
            total = sum(w for _,w in weights)
            for index in [g.group for g in vertex.groups]: view_mesh.vertex_groups[index].remove([vertex.index])
            for index,weight in weights: view_mesh.vertex_groups[index].add([vertex.index],weight/total,'REPLACE')
        # The body/arm split leaves an open shoulder edge. Extend only the FPS
        # sleeve back past the view boundary; don't expose a jagged floating cut
        # when the camera slides sideways into ADS. Hands/forearms stay unchanged.
        to_rig = rig.matrix_world.inverted() @ view_mesh.matrix_world
        from_rig = to_rig.inverted()
        for side in ['L','R']:
            head = rig.data.bones[f'{side}_Upperarm'].head_local
            axis = (rig.data.bones[f'{side}_Forearm'].head_local-head).normalized()
            sleeve_groups = {g.index for g in view_mesh.vertex_groups if g.name.startswith(f'{side}_Upperarm')}
            for vertex in view_mesh.data.vertices:
                weight = sum(g.weight for g in vertex.groups if g.group in sleeve_groups)
                if weight <= 0: continue
                p = to_rig @ vertex.co
                taper = max(0,min(1,1-(p-head).dot(axis)/.18))
                vertex.co = from_rig @ (p-axis*(.24*taper*weight))
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
        walking = name.endswith('Walk') or name.endswith('Run') or name.startswith('Strafe')
        cycle = phase*math.tau
        hip = rig.pose.bones['Hip']
        mat = hip.matrix.copy()
        mat.translation += pos(.016*math.sin(cycle) if walking else 0,
            (-.43 if crouch else 0)+(-.035+.013*math.cos(cycle*2) if walking else .004*math.sin(cycle)),0)
        hip.matrix = mat
        bpy.context.view_layer.update()
        if walking:
            spine=rig.pose.bones['Spine01'];pivot=spine.head.copy()
            twist=Matrix.Rotation(math.radians(2.5)*math.sin(cycle),4,'Z')
            spine.matrix=Matrix.Translation(pivot)@twist@Matrix.Translation(-pivot)@spine.matrix
            bpy.context.view_layer.update()
        if crouch:
            spine = rig.pose.bones['Spine01']
            p = spine.head.copy()
            spine.matrix = Matrix.Translation(p) @ Matrix.Rotation(math.radians(12),4,'X') @ Matrix.Translation(-p) @ spine.matrix
            bpy.context.view_layer.update()
        for side, sign in [('L',1),('R',-1)]:
            foot = feet[side].copy()
            u=(phase+(0 if side=='L' else .5))%1
            if u<.6:
                stride=1-2*u/.6;lift=0
            else:
                swing=(u-.6)/.4;smooth=swing*swing*(3-2*swing)
                stride=-1+2*smooth;lift=math.sin(math.pi*swing)
            if not walking:stride=lift=0
            amplitude=.159 if role=='Enemy' else .25 if name.endswith('Run') else .18
            foot += pos(0,lift*(.12 if name.endswith('Run') else .07),stride*amplitude)
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
            # World-space body poses. First-person grip uses the same mesh/rig in a
            # second, arms-only instance attached to the existing rifle transform.
            y = (1.72 if side=='L' else 1.65)/scale if role=='Enemy' else .94
            x = (.12 if side=='L' else .03)/scale if role=='Enemy' else sign*.23
            z = (.38 if side=='L' else .08)/scale if role=='Enemy' else .05
            y -= .40 if crouch else 0
            holding = role=='Player' and ('Hold' in name or 'Aim' in name)
            if holding:
                x = -.09 if side=='L' else -.20
                y = (1.34 if 'Aim' in name else 1.18) - (.40 if crouch else 0)
                z = .32 if side=='L' else .10
            if name.endswith('Fire'): z -= .045*math.sin(math.pi*phase)
            if name.endswith('Reload') and side=='R':
                y += .08*math.sin(phase*math.tau*2)
                z += .12*math.sin(math.pi*phase)
            if name.endswith('Melee') and side=='R':
                y += .16*math.sin(math.pi*phase)
                z += .23*math.sin(math.pi*phase)
            view = name.startswith('View')
            knife = 'Knife' in name
            hand_forward = hand_palm = None
            operating = 0
            loading = 0
            release = 0
            if view:
                # Coordinates below are metres relative to the unscaled rifle mesh.
                # Put the sleeve cut behind/below the view; keep both grip points fixed
                # while tucking the elbows for ADS. The gun/camera still own ADS motion.
                ads = name=='ViewAim'
                shoulder = pos(-.33 if side=='L' else .25, -.52 if ads else -.47, .24 if side=='L' else .63)
                if knife: shoulder=pos(-.25 if side=='L' else .26,-.56,.04)
                shoulder += pos(.002*math.sin(cycle),.003*math.sin(cycle),0)
                upper = rig.pose.bones[f'{side}_Upperarm']
                matrix = upper.matrix.copy()
                matrix.translation = shoulder
                upper.matrix = matrix
                bpy.context.view_layer.update()
                target = pos(-.062,.089,-.17) if side=='L' else pos(.034,.130,.325)
                hand_forward = pos(.97,.10,-.20) if side=='L' else pos(0,-.62,-.78)
                hand_palm = pos(0,1,0) if side=='L' else pos(-1,0,0)
                if knife:
                    p,rotation=knife_pose(phase if name!='ViewKnifeHold' else 0,name=='ViewKnifeHeavy')
                    if side=='R':
                        target=pos(*(p+rotation@Vector((.035,.050,.23))))
                        hand_forward=pos(*(rotation@Vector((0,-.80,-.60))))
                        hand_palm=pos(*(rotation@Vector((-1,0,0))))
                    else:
                        target=pos(-.19,-.20,-.38-.018*math.sin(phase*math.pi) if name!='ViewKnifeHold' else -.38)
                        hand_forward=pos(.15,.1,-.98)
                        hand_palm=pos(0,-1,0)
                if name in ['ViewReload','ViewBolt'] and side=='R':
                    keys=BOLT_MOTION['reload' if name=='ViewReload' else 'shot']
                    lift=motion_value(keys,phase,1);pull=motion_value(keys,phase,2)
                    angle=math.radians(-60*lift)
                    knob=pos(-.042*math.cos(angle)+.01*math.sin(angle),
                        .14-.042*math.sin(angle)-.01*math.cos(angle),.14+.10*pull)
                    grip=target.copy()
                    operate=knob+pos(.08,.064+.046*(1-lift),.012)
                    outside=pos(.13,.32,.30)
                    # Clear the receiver before crossing over to the handle; use the
                    # same raised route on return instead of cutting through the stock.
                    if phase<.055:
                        target=grip.lerp(outside,motion_value([[0,0],[.055,1]],phase,1))
                    elif phase<.12:
                        target=outside.lerp(operate,motion_value([[.055,0],[.12,1]],phase,1))
                    elif phase<.90:
                        target=operate
                    elif phase<.96:
                        target=operate.lerp(outside,motion_value([[.90,0],[.96,1]],phase,1))
                    else:
                        target=outside.lerp(grip,motion_value([[.96,0],[1,1]],phase,1))
                    operating=motion_value([[0,0],[.055,0],[.12,1],[.90,1],[.96,0],[1,0]],phase,1)
                    release=motion_value([[0,0],[.015,1],[.065,1],[.12,0],[.90,0],[.96,1],[.985,1],[1,0]],phase,1)
                    hand_forward=hand_forward.lerp(pos(-1,-.15,0),operating)
                    hand_palm=hand_palm.lerp(pos(0,-1,0),operating)
                    if name=='ViewReload':
                        loading=motion_value([[0,0],[.24,0],[.31,1],[.65,1],[.74,0],[1,0]],phase,1)
                        press=motion_value([[0,0],[.34,0],[.42,1],[.48,0],[.59,1],[.65,0],[1,0]],phase,1)
                        target=target.lerp(pos(.04,.345-.025*press,.13),loading)
                        hand_forward=hand_forward.lerp(pos(0,-1,0),loading)
                        hand_palm=hand_palm.lerp(pos(-1,0,0),loading)
                # Keep anatomical length/thickness. Bring the sleeve origin closer
                # when necessary instead of inflating the whole arm to reach the grip.
                reach=(target-upper.head).length
                chain=(rig.pose.bones[f'{side}_Forearm'].head-upper.head).length + (rig.pose.bones[f'{side}_Hand'].head-rig.pose.bones[f'{side}_Forearm'].head).length
                matrix=upper.matrix.copy()
                if reach>chain*.92:
                    matrix.translation += (target-upper.head).normalized()*(reach-chain*.92)
                upper.matrix=matrix
                bpy.context.view_layer.update()
                pole=pos(-.42 if side=='L' else .36,-.32 if ads else -.28,.36 if side=='L' else .48)
                if knife: pole=pos(-.42 if side=='L' else .52,-.55,-.14)
                limb(rig,f'{side}_Upperarm',f'{side}_Forearm',f'{side}_Hand',target,
                    pole)
            else:
                limb(rig,f'{side}_Upperarm',f'{side}_Forearm',f'{side}_Hand',pos(x,y,z),pos(sign*.42,y-.15,.02))
            hand=rig.pose.bones[f'{side}_Hand']
            aim(rig,hand.name,None,hand.head+(pos(0,0,-.1) if view else pos(0,0,.1) if role=='Enemy' or holding else pos(0,-.1,0)))
            if view:
                hand_frame(rig,rest,side,target,hand_forward,hand_palm)
            for finger in ['Index','Middle','Ring','Little','Thumb']:
                for segment in ['01','02','03']:
                    bone=rig.pose.bones.get(f'{side}_{finger}_{segment}')
                    angle=20 if finger=='Index' else 38
                    if view:
                        angles= [50,60,45] if side=='R' else [45,55,40]
                        if finger=='Thumb': angles=[25,35,25]
                        if side=='R' and finger=='Index' and not knife: angles=[8,32,25]
                        if side=='R' and name in ['ViewBolt','ViewReload']:
                            action_angles=[45,65,45] if finger!='Thumb' else [30,40,30]
                            action_angles=[a*(1-loading)+b*loading for a,b in zip(action_angles,[15,25,15])]
                            angles=[a*(1-operating)+b*operating for a,b in zip(angles,action_angles)]
                            angles=[a*(1-release)+b*release for a,b in zip(angles,[5,10,5])]
                        if side=='L' and knife: angles=[25,35,25]
                        angle=angles[int(segment)-1]
                    if bone: bone.rotation_quaternion=Quaternion((1,0,0),math.radians(angle))
            if view and side=='L' and not knife:
                bpy.context.view_layer.update()
                limb(rig,'L_Thumb_01','L_Thumb_02','L_Thumb_03',pos(0,.14,-.18),pos(-.04,.155,-.16))
                thumb=rig.pose.bones['L_Thumb_03']
                aim(rig,thumb.name,None,thumb.head+pos(.02,0,0))
        bpy.context.view_layer.update()

    if ('--preview-grip' in sys.argv or '--preview-knife' in sys.argv) and role=='Player':
        pose('ViewKnifeHold' if '--preview-knife' in sys.argv else 'ViewHold',0)
        bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'.tmp/GripPreview.blend'))
        continue
    bpy.context.scene.render.fps=30
    clips = {**CLIPS, **(PLAYER_CLIPS if role=='Player' else {})}
    for name,duration in clips.items():
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
    print('EXPORTED',role,len(rig.data.bones),'bones',list(clips))
