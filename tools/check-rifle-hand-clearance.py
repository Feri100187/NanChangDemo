"""Read-only left-hand / rifle surface check, in a separate Blender process.

blender --background --factory-startup --python tools/check-rifle-hand-clearance.py
Append -- --runtime-report output/playwright/hands-runtime-report.txt to inspect
the actual body IK matrices captured by check-rifle-hands-runtime.js as well.
This samples surface crossings, not closed-volume penetration or visual quality.
Only faces whose EVERY vertex has >0.8 combined L_Hand/finger weight are tested;
shoulders, elbows and forearms are deliberately outside this hand-only check.
"""
import argparse
import json
import math
import sys
from pathlib import Path

import bpy
from mathutils import Matrix, Vector
from mathutils.bvhtree import BVHTree


ROOT = Path(__file__).resolve().parents[1]
TO_BLENDER = Matrix.Rotation(math.pi / 2, 4, 'X')
TO_GUN = TO_BLENDER.inverted()
CLIPS = ('ViewHold', 'ViewAim', 'ViewBolt', 'ViewReload')


def read_report(path):
    text = Path(path).read_text(encoding='utf-8-sig').strip()
    if text.startswith('### Result'):
        text = text[len('### Result'):].lstrip()
    if text.startswith('```json'):
        text = text[len('```json'):].lstrip()
    try:
        result, _ = json.JSONDecoder().raw_decode(text)
    except (json.JSONDecodeError, ValueError) as exc:
        raise ValueError(f'Runtime report has no valid JSON result: {path}') from exc
    if isinstance(result, str):
        result = json.loads(result)
    if not isinstance(result, dict) or not isinstance(result.get('poses'), list):
        raise ValueError('Runtime report must contain a poses array')
    return result


def hand_faces(obj):
    names = {'L_Hand'} | {f'L_{finger}_{segment:02}'
                         for finger in ('Thumb', 'Index', 'Middle', 'Ring', 'Little')
                         for segment in (1, 2, 3)}
    groups = {group.index for group in obj.vertex_groups if group.name in names}
    weights = {vertex.index: sum(group.weight for group in vertex.groups if group.group in groups)
               for vertex in obj.data.vertices}
    faces = [(polygon.index, tuple(polygon.vertices)) for polygon in obj.data.polygons
             if all(weights[index] > 0.8 for index in polygon.vertices)]
    if not faces:
        raise ValueError(f'No isolated left-hand faces found in {obj.name}')
    return faces


def action_for(name):
    matches = [action for action in bpy.data.actions
               if action.name == name or action.name.startswith(name + '_')]
    if len(matches) != 1:
        raise ValueError(f'Expected one imported action for {name}; got {[a.name for a in matches]}')
    return matches[0]


def set_action(rig, name, phase=0):
    action = action_for(name)
    rig.animation_data.action = action
    if action.slots:
        rig.animation_data.action_slot = action.slots[0]
    low, high = action.frame_range
    frame = low + (high - low) * phase
    bpy.context.scene.frame_set(math.floor(frame), subframe=frame - math.floor(frame))
    bpy.context.view_layer.update()


def converted_matrix(elements):
    if not isinstance(elements, list) or len(elements) != 16 or not all(
            isinstance(value, (int, float)) and math.isfinite(value) for value in elements):
        raise ValueError('Expected 16 finite column-major Laya Matrix4x4 elements')
    matrix = Matrix([elements[i:i + 4] for i in range(0, 16, 4)]).transposed()
    if any(abs(matrix[3][i] - (1 if i == 3 else 0)) > 1e-4 for i in range(4)):
        raise ValueError('Runtime bone matrix is not an affine transform')
    return TO_BLENDER @ matrix


def calibration(rig, poses):
    # Neutral, non-ADS left hand should coincide with the baked hand target. Its
    # actual body's upper-arm/forearm poses need not match the hidden view rig.
    neutral = next((pose for pose in poses if pose.get('pitch') == 0 and not pose.get('aim')), None)
    if neutral is None:
        raise ValueError('Runtime calibration requires a pitch=0, aim=false sample')
    set_action(rig, 'ViewHold', 0)
    comparisons = []
    for name in ('L_Hand', 'L_Thumb_03', 'L_Index_03'):
        baked = rig.matrix_world @ rig.pose.bones[name].matrix
        actual = converted_matrix(neutral['bones'][name])
        position_mm = (baked.translation - actual.translation).length * 1000
        rotation_degrees = math.degrees(baked.to_quaternion().rotation_difference(actual.to_quaternion()).angle)
        rotation_degrees = min(rotation_degrees, abs(360 - rotation_degrees))
        scale_error = max(abs(a - b) for a, b in zip(baked.to_scale(), actual.to_scale()))
        comparisons.append({'bone': name, 'positionMm': round(position_mm, 5),
                            'rotationDegrees': round(rotation_degrees, 5), 'scaleError': round(scale_error, 6)})
    # 10 mm accommodates the existing IK reach tolerance; a wrong axis/transpose
    # would fail this plus the independent orientation and scale checks.
    passed = all(item['positionMm'] <= 10 and item['rotationDegrees'] <= 1
                 and item['scaleError'] <= 0.02 for item in comparisons)
    print('RUNTIME_CALIBRATION ' + json.dumps({'passed': passed, 'comparisons': comparisons}))
    if not passed:
        raise ValueError('Runtime matrix conversion/target calibration failed; no runtime overlap verdict issued')
    return comparisons


def apply_runtime(rig, bones):
    missing = [bone.name for bone in rig.pose.bones if bone.name not in bones]
    if missing:
        raise ValueError(f'Runtime pose is missing body bones: {missing}')
    rig.animation_data.action = None
    # Runtime IK writes independent world TRS matrices, including nonuniform arm
    # scales. Blender's default inherited parent scale can force shear into the
    # child basis and decompose it away. Disable scale inheritance only in this
    # disposable verification scene; every world bone matrix is supplied below.
    for bone in rig.data.bones:
        bone.inherit_scale = 'NONE'
    bpy.context.view_layer.update()
    inverse_rig = rig.matrix_world.inverted()
    # Every matrix is an absolute gun-local transform, so apply parents before
    # children and update dependencies before the child matrix setter resolves it.
    for bone in sorted(rig.pose.bones, key=lambda value: len(value.parent_recursive)):
        bone.matrix = inverse_rig @ converted_matrix(bones[bone.name])
        bpy.context.view_layer.update()
    # Detect any loss caused by matrix conversion or parent/child application.
    max_error = 0
    for name in rig.pose.bones.keys():
        expected = converted_matrix(bones[name])
        actual = rig.matrix_world @ rig.pose.bones[name].matrix
        error = max(abs(actual[row][column] - expected[row][column]) for row in range(4) for column in range(4))
        max_error = max(max_error, error)
        if error > 1e-4:
            raise ValueError(f'Applied runtime matrix differs for {name}: {error}; no overlap verdict issued')
    return max_error


def sample_overlap(obj, faces, rifle):
    evaluated = obj.evaluated_get(bpy.context.evaluated_depsgraph_get())
    mesh = evaluated.to_mesh()
    try:
        vertices = [evaluated.matrix_world @ vertex.co for vertex in mesh.vertices]
        hand = BVHTree.FromPolygons(vertices, [face for _, face in faces], epsilon=0)
        overlap = rifle.overlap(hand)
        locations = []
        for gun_index, hand_index in overlap[:6]:
            original_index, face = faces[hand_index]
            point = sum((vertices[i] for i in face), Vector()) / len(face)
            point = TO_GUN @ point
            locations.append({'handPolygon': original_index, 'gunPolygon': gun_index,
                              'handFaceCenterGunLocal': [round(value, 6) for value in point]})
        return {'surfacePairs': len(overlap), 'locations': locations}
    finally:
        evaluated.to_mesh_clear()


def main():
    if not bpy.app.background or bpy.data.filepath:
        raise RuntimeError('Use a separate --background --factory-startup Blender process')
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--runtime-report', type=Path)
    args = parser.parse_args(sys.argv[sys.argv.index('--') + 1:] if '--' in sys.argv else [])
    bpy.ops.wm.read_factory_settings(use_empty=True)
    bpy.context.scene.render.fps = 30
    bpy.ops.import_scene.gltf(filepath=str(ROOT / 'assets/resources/characters/Player/AnimatedPlayer.glb'))
    rig = next(obj for obj in bpy.context.scene.objects if obj.type == 'ARMATURE')
    view_arms, body_arms = bpy.data.objects['ViewArms'], bpy.data.objects['Arms']
    for track in rig.animation_data.nla_tracks:
        track.mute = True
    view_faces, body_faces = hand_faces(view_arms), hand_faces(body_arms)
    bpy.ops.import_scene.gltf(filepath=str(ROOT / 'assets/resources/weapons/ProvidedGun/RifleMechanism.glb'))
    static = bpy.data.objects['Static']
    rifle_vertices = [static.matrix_world @ vertex.co for vertex in static.data.vertices]
    rifle_faces = [tuple(polygon.vertices) for polygon in static.data.polygons]
    rifle = BVHTree.FromPolygons(rifle_vertices, rifle_faces, epsilon=0)
    baked_failures, runtime_failures = [], []
    for name in CLIPS:
        for percent in range(101):
            set_action(rig, name, percent / 100)
            result = sample_overlap(view_arms, view_faces, rifle)
            if result['surfacePairs']:
                baked_failures.append({'clip': name, 'percent': percent, **result})
    print('BAKED_LEFT_HAND ' + json.dumps({'samples': 404, 'selectedFaces': len(view_faces),
                                          'failedSamples': len(baked_failures), 'failures': baked_failures[:12]}))
    runtime_samples = 0
    runtime_matrix_error = 0
    if args.runtime_report:
        report_path = args.runtime_report if args.runtime_report.is_absolute() else ROOT / args.runtime_report
        report = read_report(report_path)
        poses = [pose for pose in report['poses'] if isinstance(pose.get('bones'), dict)]
        if not poses:
            raise ValueError('Runtime report contains no complete bone snapshots')
        calibration(rig, poses)
        for index, pose in enumerate(poses):
            runtime_matrix_error = max(runtime_matrix_error, apply_runtime(rig, pose['bones']))
            result = sample_overlap(body_arms, body_faces, rifle)
            runtime_samples += 1
            if result['surfacePairs']:
                runtime_failures.append({'sample': index, 'pitch': pose.get('pitch'), 'aim': pose.get('aim'),
                                         'cycle': pose.get('cycle'), **result})
        print('RUNTIME_LEFT_HAND ' + json.dumps({'samples': runtime_samples, 'selectedFaces': len(body_faces),
                                                'maxBoneMatrixError': runtime_matrix_error,
                                                'failedSamples': len(runtime_failures), 'failures': runtime_failures}))
    if baked_failures or runtime_failures:
        raise AssertionError(f'Left-hand/static-rifle surface crossings: baked {len(baked_failures)}/404, '
                             f'runtime {len(runtime_failures)}/{runtime_samples}')
    print(f'PASS: 404 baked samples and {runtime_samples} calibrated runtime samples have no selected left-hand/static-rifle surface crossings')


if __name__ == '__main__':
    main()
