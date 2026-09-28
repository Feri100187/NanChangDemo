"""将用户提供的 FBX 导出为带完整 PBR 贴图的可移植游戏模型。

在项目根目录运行：blender --background --factory-startup --python tools/prepare-provided-rifle.py
只用于离线资源处理；原始 FBX/FBM 不修改。模型与贴图权利归原提供方。
"""
import bpy
import math
from pathlib import Path
from mathutils import Matrix, Vector

if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError("请在独立的 --background --factory-startup 进程运行，避免改动工作中的场景。")

root = Path(__file__).resolve().parents[1]
folder = root / "assets/resources/weapons/ProvidedGun"
source = folder / "tripo_convert_156acf08-9d73-46ec-b784-96cecce32001.fbx"
for obj in list(bpy.data.objects):
    bpy.data.objects.remove(obj, do_unlink=True)
bpy.ops.import_scene.fbx(filepath=str(source))
meshes = [obj for obj in bpy.context.scene.objects if obj.type == 'MESH']
points = [obj.matrix_world @ vertex.co for obj in meshes for vertex in obj.data.vertices]
# 以枪口横向中心对轴；枪栓向侧面突出，不能使用整个包围盒的横向中点。
front = min(p.x for p in points)
muzzle = [p for p in points if p.x < front + .015]
width_center = (min(p.y for p in muzzle) + max(p.y for p in muzzle)) / 2
top = max(p.z for p in points)
# 源文件枪口朝 -X，Blender 中改为 +Y，导出 glTF 后朝 -Z。
# 铁瞄最高点对齐既有枪械控制节点上方 0.18m 的瞄准线。
normalization = Matrix.Translation((-width_center, 0, .18 - top)) @ Matrix.Rotation(-math.pi / 2, 4, 'Z')
for obj in meshes:
    obj.matrix_world = normalization @ obj.matrix_world
    obj.name = "ProvidedRifleMesh"

for image in bpy.data.images:
    if image.source == 'FILE' and image.filepath:
        candidate = folder / (source.stem + '.fbm') / Path(image.filepath).name
        if candidate.exists():
            image.filepath = str(candidate)
            image.reload()

bpy.ops.object.select_all(action='DESELECT')
for obj in meshes:
    obj.select_set(True)
bpy.context.view_layer.objects.active = meshes[0]
bpy.ops.object.transform_apply(location=True, rotation=True, scale=True)
# 5.2 的格式枚举是回调，RNA enum_items 为空；从同一导出器查询有效项。
bpy.ops.export_scene.gltf.get_rna_type()
from io_scene_gltf2 import get_format_items
assert 'GLB' in [item[0] for item in get_format_items(None, bpy.context)]
bpy.ops.export_scene.gltf(filepath=str(folder / 'ProvidedRifle.glb'), export_format='GLB',
                          use_selection=True, export_yup=True)
print('Exported ProvidedRifle.glb:', len(meshes), 'mesh,',
      sum(len(obj.data.polygons) for obj in meshes), 'polygons')
