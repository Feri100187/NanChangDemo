"""从保留骨骼的源 FBX 生成角色姿态网格，原始资源保持不变。

运行：blender --background --factory-startup --python tools/prepare-provided-characters.py
运行贴图为源贴图缩小后的 2048 JPEG；缺少时由脚本生成。模型、贴图权利归原提供方。
源文件没有动画；这里用已有骨骼摆出持枪、站立和下蹲姿态并烘焙网格。
"""
import bpy
import bmesh
import json
import math
from pathlib import Path
from mathutils import Matrix, Vector, Quaternion

if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('请使用独立的 --background --factory-startup 进程。')

ROOT = Path(__file__).resolve().parents[1]


def aim(rig, name, child_name, target):
    bone = rig.pose.bones[name]
    head = bone.head.copy()
    tip = rig.pose.bones[child_name].head.copy() if child_name else bone.tail.copy()
    rotation = (tip - head).rotation_difference(target - head).to_matrix().to_4x4()
    bone.matrix = Matrix.Translation(head) @ rotation @ Matrix.Translation(-head) @ bone.matrix
    bpy.context.view_layer.update()


def bend_limb(rig, upper, lower, end, target, pole):
    shoulder = rig.pose.bones[upper].head.copy()
    elbow = rig.pose.bones[lower].head.copy()
    hand = rig.pose.bones[end].head.copy()
    a, b = (elbow - shoulder).length, (hand - elbow).length
    direction = (target - shoulder).normalized()
    distance = max(abs(a - b) + 0.001, min(a + b - 0.001, (target - shoulder).length))
    along = (a*a - b*b + distance*distance) / (2*distance)
    normal = pole - shoulder
    normal = (normal - direction * normal.dot(direction)).normalized()
    joint = shoulder + direction * along + normal * math.sqrt(max(0, a*a - along*along))
    aim(rig, upper, lower, joint)
    aim(rig, lower, end, shoulder + direction * distance)


def split_mesh(mesh, face_ids, keep):
    result = mesh.copy()
    bm = bmesh.new()
    bm.from_mesh(result)
    bm.faces.ensure_lookup_table()
    bmesh.ops.delete(bm, geom=[f for f in bm.faces if (f.index in face_ids) != keep], context='FACES_ONLY')
    bmesh.ops.delete(bm, geom=[v for v in bm.verts if not v.link_faces], context='VERTS')
    bm.to_mesh(result)
    bm.free()
    return result


reports = []
for role, height in [('Enemy', 2.55), ('Player', 1.8)]:
    for obj in list(bpy.data.objects):
        bpy.data.objects.remove(obj, do_unlink=True)
    source = next((ROOT / 'source-assets/characters' / role.lower()).glob('*.fbx'))
    folder = ROOT / 'assets/resources/characters' / role
    folder.mkdir(parents=True, exist_ok=True)
    texture = folder / f'{role}Albedo.jpg'
    if not texture.exists():
        original = next((source.parent / (source.stem + '.fbm')).glob('*.jpg'))
        image = bpy.data.images.load(str(original))
        image.scale(2048, 2048)
        formats = [item.identifier for item in image.bl_rna.properties['file_format'].enum_items]
        assert 'JPEG' in formats
        image.file_format = 'JPEG'
        image.filepath_raw = str(texture)
        image.save()
    bpy.ops.import_scene.fbx(filepath=str(source))
    rig = next(obj for obj in bpy.context.scene.objects if obj.type == 'ARMATURE')
    mesh = next(obj for obj in bpy.context.scene.objects if obj.type == 'MESH')
    points = [mesh.matrix_world @ v.co for v in mesh.data.vertices]
    floor = min(v.z for v in points)
    factor = height / (max(v.z for v in points) - floor)
    # FBX 正面朝 +X；glTF/Laya 正面统一朝 +Z，脚底落在原点。
    normalization = Matrix.Scale(factor, 4) @ Matrix.Rotation(-math.pi/2, 4, 'Z') @ Matrix.Translation((0, 0, -floor))
    for mat in mesh.data.materials:
        for node in mat.node_tree.nodes:
            if node.type == 'TEX_IMAGE':
                node.image = bpy.data.images.load(str(folder / f'{role}Albedo.jpg'), check_existing=True)
        shader = next(node for node in mat.node_tree.nodes if node.type == 'BSDF_PRINCIPLED')
        shader.inputs['Metallic'].default_value = 0
        shader.inputs['Roughness'].default_value = 0.85
    # 按原始面索引分离头颈；两种姿态共享同一分界，第一人称可仅关闭头部。
    head_groups = {g.index for g in mesh.vertex_groups if g.name in ['Head', 'NeckTwist01', 'NeckTwist02']}
    head_weights = {v.index:sum(g.weight for g in v.groups if g.group in head_groups) for v in mesh.data.vertices}
    head_faces = {p.index for p in mesh.data.polygons if
        sum(head_weights[v] for v in p.vertices) / len(p.vertices) > 0.5}
    outputs = []
    hitboxes = {}

    def position(x, y, z):
        return Vector((z/factor, x/factor, y/factor + floor))

    for pose in (['Ready'] if role == 'Enemy' else ['Standing', 'Crouching']):
        for bone in rig.pose.bones:
            bone.matrix_basis = Matrix.Identity(4)
        bpy.context.view_layer.update()
        if pose == 'Crouching':
            hip = rig.pose.bones['Hip']
            matrix = hip.matrix.copy()
            matrix.translation = position(0, 0.45, -0.2)
            hip.matrix = matrix
            bpy.context.view_layer.update()
            for bone_name in ['Spine01', 'Spine02']:
                bone = rig.pose.bones[bone_name]
                pivot = bone.head.copy()
                rotation = Quaternion(Vector((0, 1, 0)), math.radians(16)).to_matrix().to_4x4()
                bone.matrix = Matrix.Translation(pivot) @ rotation @ Matrix.Translation(-pivot) @ bone.matrix
                bpy.context.view_layer.update()
            for side, sign in [('L', 1), ('R', -1)]:
                bend_limb(rig, f'{side}_Thigh', f'{side}_Calf', f'{side}_Foot',
                    position(sign*0.16, 0.028, 0), position(sign*0.25, 0.45, 0.8))
                # 膝盖弯曲后保持鞋底水平，避免继承小腿旋转而陷入地面。
                foot = rig.pose.bones[f'{side}_Foot']
                matrix = foot.bone.matrix_local.copy()
                matrix.translation = foot.head.copy()
                foot.matrix = matrix
                bpy.context.view_layer.update()
        for side, sign in [('L', 1), ('R', -1)]:
            if role == 'Enemy':
                target = position(0.12 if side == 'L' else 0.03, 1.72 if side == 'L' else 1.65,
                    0.38 if side == 'L' else 0.08)
                pole = position(sign*0.5, 1.5, 0.03)
                hand_direction = Vector((1, 0, 0))
            elif pose == 'Standing':
                target = position(sign*0.24, 0.94, 0.05)
                pole = position(sign*0.4, 1.12, 0.03)
                hand_direction = Vector((0, 0, -1))
            else:
                target = position(sign*0.21, 0.54, 0.23)
                pole = position(sign*0.44, 0.63, 0.12)
                hand_direction = Vector((0.3, 0, -1)).normalized()
            bend_limb(rig, f'{side}_Upperarm', f'{side}_Forearm', f'{side}_Hand', target, pole)
            hand = rig.pose.bones[f'{side}_Hand']
            aim(rig, f'{side}_Hand', None, hand.head + hand_direction*0.1)
        bpy.context.view_layer.update()
        evaluated = mesh.evaluated_get(bpy.context.evaluated_depsgraph_get())
        baked = bpy.data.meshes.new_from_object(evaluated, preserve_all_data_layers=True,
            depsgraph=bpy.context.evaluated_depsgraph_get())
        baked.transform(normalization @ mesh.matrix_world)
        # 姿态改变后重新校准脚底，消除鞋子蒙皮带来的小幅高度偏差。
        baked.transform(Matrix.Translation((0, 0, -min(v.co.z for v in baked.vertices))))
        if role == 'Enemy':
            categories = {}
            for vertex in mesh.data.vertices:
                dominant = max(vertex.groups, key=lambda g:g.weight)
                name = mesh.vertex_groups[dominant.group].name
                category = 'Head' if name in ['Head', 'NeckTwist01', 'NeckTwist02'] else (
                    'Legs' if any(word in name for word in ['Thigh', 'Calf', 'Foot', 'Toe']) else (
                    'LeftArm' if name.startswith('L_') else 'RightArm' if name.startswith('R_') else 'Torso'))
                point = baked.vertices[vertex.index].co
                categories.setdefault(category, []).append(Vector((point.x, point.z, -point.y)))
            for category, points in categories.items():
                low = Vector(tuple(min(p[i] for p in points) - .015 for i in range(3)))
                high = Vector(tuple(max(p[i] for p in points) + .015 for i in range(3)))
                # 腰带/挎包可能带有大腿权重，不能把这些附件上方也判为腿部。
                hip_height = rig.pose.bones['Hip'].head.z * factor
                if category == 'Legs':
                    low.y = 0
                    high.y = hip_height
                elif category == 'Torso':
                    low.y = hip_height
                hitboxes[category] = {'center':list((low+high)/2), 'size':list(high-low)}
        for part in (['Body'] if role == 'Enemy' else ['Body', 'Head']):
            data = baked if role == 'Enemy' else split_mesh(baked, head_faces, part == 'Head')
            obj = bpy.data.objects.new(f'{role}{pose}{part}', data)
            bpy.context.scene.collection.objects.link(obj)
            outputs.append(obj)
    bpy.ops.object.select_all(action='DESELECT')
    for obj in outputs:
        obj.select_set(True)
    bpy.context.view_layer.objects.active = outputs[0]
    from io_scene_gltf2 import get_format_items
    assert 'GLB' in [item[0] for item in get_format_items(None, bpy.context)]
    bpy.ops.export_scene.gltf(filepath=str(folder / f'Provided{role}.glb'), export_format='GLB',
        use_selection=True, export_yup=True, export_animations=False)
    reports.append({'role':role,'source':str(source.relative_to(ROOT)), 'source_bones':len(rig.data.bones), 'hitboxes':hitboxes,
        'meshes':[{'name':o.name, 'vertices':len(o.data.vertices),'polygons':len(o.data.polygons),
            'bounds':[[min(v.co[i] for v in o.data.vertices) for i in range(3)],
                [max(v.co[i] for v in o.data.vertices) for i in range(3)]]} for o in outputs]})
    # 供本地目视复核；只写忽略目录，不把 Blender 工作文件加入运行资源。
    (ROOT / '.tmp').mkdir(exist_ok=True)
    for obj in list(bpy.data.objects):
        if obj not in outputs:
            bpy.data.objects.remove(obj, do_unlink=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(ROOT / '.tmp' / f'prepared-{role}.blend'))
(ROOT / '.tmp/character-export-report.json').write_text(json.dumps(reports,indent=2),encoding='utf8')
print(json.dumps(reports))
