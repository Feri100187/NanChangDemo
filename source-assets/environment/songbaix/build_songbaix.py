"""Original editable environment. Blender 5.2 --background --factory-startup --python <this>.
Metres; X east, Y north, Z up. Historic evidence/limits: docs/map-songbaix-references.md.
No downloaded meshes/textures. Run only in an isolated factory-startup process.
"""
import bpy, bmesh, math, json, random, sys, uuid
import numpy as np
from pathlib import Path
from mathutils import Vector

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
OUT = ROOT / 'assets/resources/environment/songbaix'
TEX = OUT / 'textures'
REVIEW = HERE / 'review'
for p in (OUT, TEX, REVIEW): p.mkdir(parents=True, exist_ok=True)
if not bpy.app.background or bpy.data.filepath:
    raise RuntimeError('Use a separate Blender background factory-startup process.')
bpy.context.preferences.filepaths.save_version = 0
bpy.ops.object.select_all(action='SELECT'); bpy.ops.object.delete(use_global=False)
for mat in list(bpy.data.materials): bpy.data.materials.remove(mat)
scene=bpy.context.scene
scene.unit_settings.system='METRIC'; scene.unit_settings.scale_length=1
random.seed(1927)

def collection(name):
    c=bpy.data.collections.new(name); scene.collection.children.link(c); return c
groups={n:collection(n) for n in ['01_Ground','02_Landmark','03_StreetBuildings','04_MissionBuilding_Fictional','05_Props','90_CollisionProxies','91_LayoutAndScale','99_ReviewLighting']}
active=groups['01_Ground']
def move(o):
    for c in list(o.users_collection): c.objects.unlink(o)
    active.objects.link(o); return o

def texture(name, kind, base):
    n=512; y,x=np.mgrid[0:n,0:n]; rng=np.random.default_rng(1927)
    noise=rng.normal(0,.014,(n,n)); value=np.ones((n,n))
    if kind=='brick':
        row=y//32; xx=(x+(row%2)*64)%128
        value+=.11*np.sin((x//128)*7+row*3)
        value[(y%32<3)|(xx<3)]=.64
    elif kind=='stone':
        row=y//128; xx=(x+(row%2)*64)%128
        value+=.07*np.sin((xx//64)*4+row*2)
        value[(y%128<3)|(xx<3)]=.66
    elif kind=='tile':
        value=.75+.25*np.cos(x*math.tau/32)
        value[y%64<4]*=.67
    elif kind=='wood':
        value+=.12*np.sin(x*.20+np.sin(y*.014))+.035*np.sin(x*.75)
        value[x%128<3]*=.5
    else:
        value+=.035*np.sin(x*.021)*np.cos(y*.03)
    arr=np.ones((n,n,4),dtype=np.float32)
    for i,v in enumerate(base): arr[:,:,i]=np.clip(v*value+noise,0,1)
    im=bpy.data.images.new(name,width=n,height=n)
    im.pixels.foreach_set(arr.ravel()); im.filepath_raw=str(TEX/(name+'.png')); im.file_format='PNG'; im.save()
    return im

def material(name, color, rough=.8, kind=None):
    m=bpy.data.materials.new(name); m.diffuse_color=(*color,1); m.use_nodes=True
    bs=m.node_tree.nodes.get('Principled BSDF'); bs.inputs['Base Color'].default_value=(*color,1); bs.inputs['Roughness'].default_value=rough
    if kind:
        node=m.node_tree.nodes.new('ShaderNodeTexImage'); node.image=texture(name,kind,color)
        m.node_tree.links.new(node.outputs['Color'],bs.inputs['Base Color'])
    return m
brick=material('GreyKilnBrick',(.40,.42,.40),kind='brick')
plaster=material('LimePlaster',(.73,.69,.58),kind='lime')
church=material('LandmarkMutedBrick',(.53,.47,.40),kind='brick')
stone=material('CutStone',(.47,.48,.43),kind='stone')
paving=material('LaneStone',(.38,.40,.38),kind='stone')
tile=material('GreyClayRoof',(.24,.28,.28),kind='tile')
wood=material('OiledTimber',(.27,.18,.105),kind='wood')
trim=material('PaleStoneTrim',(.69,.66,.56))
dark=material('RecessShadow',(.07,.085,.08))
glass=material('MutedGlass',(.15,.27,.27),.35)
metal=material('DarkIron',(.12,.14,.14),.45)
paper=material('BlankPaper_Fictional',(.77,.70,.52))
proxyMat=material('ProxyOnly',(.20,.60,.80))

def uv_mesh(mesh):
    uv=mesh.uv_layers.new(name='UV0') if not mesh.uv_layers else mesh.uv_layers[0]
    for poly in mesh.polygons:
        n=poly.normal; axis=max(range(3),key=lambda i:abs(n[i])); axes=[i for i in range(3) if i!=axis]
        for li in poly.loop_indices:
            co=mesh.vertices[mesh.loops[li].vertex_index].co
            uv.data[li].uv=(co[axes[0]]/2,co[axes[1]]/2)
def mesh_obj(name,vs,fs,mat):
    me=bpy.data.meshes.new(name); me.from_pydata(vs,[],fs); me.update()
    bm=bmesh.new(); bm.from_mesh(me); bmesh.ops.recalc_face_normals(bm,faces=bm.faces); bm.to_mesh(me); bm.free()
    uv_mesh(me); me.materials.append(mat)
    o=bpy.data.objects.new(name,me); active.objects.link(o); return o
cube_cache={}
def box(name,loc,size,mat,bevel=.025):
    key=(tuple(size),mat.name,bevel)
    if key not in cube_cache:
        bpy.ops.mesh.primitive_cube_add(size=1)
        o=move(bpy.context.object); o.name=name; o.dimensions=size
        bpy.ops.object.transform_apply(location=False,rotation=False,scale=True)
        o.data.materials.append(mat)
        if bevel:
            m=o.modifiers.new('Small edge bevel','BEVEL');m.width=bevel;m.segments=1
            bpy.ops.object.modifier_apply(modifier=m.name)
        uv_mesh(o.data); cube_cache[key]=o.data
    else:
        o=bpy.data.objects.new(name,cube_cache[key]); active.objects.link(o)
    o.location=loc; return o

def rod(name,a,b,r,mat,vertices=12):
    a,b=Vector(a),Vector(b)
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices,radius=r,depth=(b-a).length,location=(a+b)/2)
    o=move(bpy.context.object);o.name=name;o.rotation_euler=(b-a).to_track_quat('Z','Y').to_euler();o.data.materials.append(mat);return o

def roof(name,cx,cy,w,d,eave,rise):
    # Ridge parallel to world X; two closed roof slabs, batched tile-ridge detail.
    x0,x1=cx-d/2-.35,cx+d/2+.35
    for sign in (-1,1):
        ya,yb=cy,cy+sign*(w/2+.4)
        v=[(x0,ya,eave+rise),(x1,ya,eave+rise),(x1,yb,eave),(x0,yb,eave)]
        v+= [(x,y,z-.16) for x,y,z in v]
        mesh_obj(name+('_N' if sign>0 else '_S'),v,[(0,1,2,3),(4,7,6,5),(0,4,5,1),(1,5,6,2),(2,6,7,3),(3,7,4,0)],tile)
    rod(name+'_Ridge',(x0,cy,eave+rise+.06),(x1,cy,eave+rise+.06),.12,tile)
    for sign in (-1,1):box(name+'_EaveFascia',(cx,cy+sign*(w/2+.37),eave-.12),(d+.8,.16,.25),wood)

def front_polygon(name,x,points,depth,mat):
    vs=[(xx,y,z) for xx in (x,x+depth) for y,z in points];n=len(points)
    fs=[tuple(reversed(range(n))),tuple(range(n,2*n))]
    fs += [(i,(i+1)%n,(i+1)%n+n,i+n) for i in range(n)]
    return mesh_obj(name,vs,fs,mat)

def arch(name,x,y,z,w,h,mat,depth=.18,fill=False):
    r=w/2; spring=z+h-r; steps=20
    if fill:
        pts=[(y-r,z),(y+r,z)]+[(y+r*math.cos(i*math.pi/steps),spring+r*math.sin(i*math.pi/steps)) for i in range(steps+1)]
        return front_polygon(name,x,pts,depth,mat)
    vs=[]; band=.18
    for xx in (x,x+depth):
        for rr in (r,r+band):vs +=[(xx,y+rr*math.cos(i*math.pi/steps),spring+rr*math.sin(i*math.pi/steps)) for i in range(steps+1)]
    n=steps+1;fs=[]
    for i in range(steps):
        fs +=[(i,i+1,n+i+1,n+i),(2*n+i,3*n+i,3*n+i+1,2*n+i+1),(i,2*n+i,2*n+i+1,i+1),(n+i,n+i+1,3*n+i+1,3*n+i)]
    fs +=[(0,n,3*n,2*n),(steps,2*n+steps,3*n+steps,n+steps)]
    o=mesh_obj(name,vs,fs,mat)
    for s in (-1,1): box(name+'_Jamb',(x+depth/2,y+s*(r+band/2),(z+spring)/2),(depth,band,spring-z),mat)
    return o

def round_window(name,x,y,z,r):
    rod(name+'_Glass',(x,y,z),(x+.09,y,z),r,glass,48)
    bpy.ops.mesh.primitive_torus_add(major_radius=r+.08,minor_radius=.10,major_segments=48,minor_segments=8,location=(x-.03,y,z),rotation=(0,math.pi/2,0))
    o=move(bpy.context.object);o.name=name+'_StoneRing';o.data.materials.append(trim)
    for a in range(0,180,45):
        dy=math.cos(math.radians(a))*r; dz=math.sin(math.radians(a))*r
        rod(name+'_SimpleRadial',(x-.10,y-dy,z-dz),(x-.10,y+dy,z+dz),.032,metal,8)

# Ground slabs all have their upper surface at Z=0.
active=groups['01_Ground']
box('Block_Substrate_West',(-16,4,-.40),(48,74,.55),brick)
box('Block_Substrate_East',(33,0,-.40),(50,34,.55),brick)
box('StreetPaving',(-16,4,-.10),(48,74,.20),paving)
box('ChurchSidePaving',(33,0,-.10),(50,34,.20),paving)
box('ForecourtPaving',(-.2,2,-.08),(20,33,.20),stone)
box('LandmarkFooting',(32,0,-.06),(48.5,26.5,.20),stone)
for x in (-30,-24,-10,6):
    box('DrainChannel',(x,-4,.015),(.22,45,.03),dark,0)
    for y in (-22,-10,2,14):box('DrainCover',(x,y,.04),(.34,.7,.06),stone)

# Landmark: WEST-facing elevation. Dimensions are estimates, not a survey.
active=groups['02_Landmark']
box('Landmark_Base',(32,0,.20),(48,26,.4),stone)
box('Landmark_LongHall_ExteriorOnly',(32,0,5.25),(48,26,10.1),church)
box('Landmark_Clerestory',(32,0,13.1),(48,10,5.6),church)
roof('Landmark_NaveRoof',32,0,10,48,16,3.4)
for sy in (-1,1):
    # Lower aisle lean-to, independent closed mesh.
    ya,yb=sy*5,sy*13.4
    v=[(7.7,ya,14.8),(56.3,ya,14.8),(56.3,yb,10.4),(7.7,yb,10.4)]
    v += [(x,y,z-.17) for x,y,z in v]
    mesh_obj('Landmark_AisleRoof',v,[(0,1,2,3),(4,7,6,5),(0,4,5,1),(1,5,6,2),(2,6,7,3),(3,7,4,0)],tile)
    box('Landmark_AisleCornice',(32,sy*13.1,10.25),(48,.45,.32),trim)
    for x in (11,18,25,32,39,46,53):
        box('Landmark_SidePier',(x,sy*13.15,5.25),(.52,.38,10.1),trim)
        if x==53:continue
        # Simple non-enterable side window reveal, no speculative stained iconography.
        o=arch('Landmark_SideWindow_Recess',0,0,0,2.2,5.1,dark,.10,True)
        o.rotation_euler[2]=sy*math.pi/2;o.location=(x+2.8,sy*13.22,2.6)
        # Repeat mullions on exterior plane.
        box('Landmark_SideWindow_Mullion',(x+2.8,sy*13.31,5),( .07,.09,4.4),trim)
front_polygon('Landmark_WestFacade',7.62,[(-13,0),(-13,11.4),(-5.1,15.7),(-5.1,20.0),(-2.8,20.0),(0,21.0),(2.8,20),(5.1,20),(5.1,15.7),(13,11.4),(13,0)],.48,church)
for y in (-12.8,-5.1,5.1,12.8):
    h=20 if abs(y)<6 else 11.4
    box('Landmark_FacadePilaster',(7.46,y,h/2),(.32,.40,h),trim)
box('Landmark_LowerBelt',(7.38,0,5.7),(.36,25.7,.24),trim)
for a,b in [((-13,11.5),(-5.1,15.8)),((5.1,15.8),(13,11.5)),((-5.1,20.1),(-2.8,20.1)),((-2.8,20.1),(0,21.1)),((0,21.1),(2.8,20.1)),((2.8,20.1),(5.1,20.1))]:
    rod('Landmark_Coping',(7.40,*a),(7.40,*b),.14,trim)
for y,w,h in [(0,3.4,4.9),(-4,2.2,4.2),(4,2.2,4.2),(-9.6,1.8,4.0),(9.6,1.8,4.0)]:
    arch('Landmark_ClosedDoor',7.30,y,.28,w,h,wood,.12,True)
    arch('Landmark_DoorSurround',7.12,y,.28,w,h,trim,.20)
    box('Landmark_DoorMeetingStile',(7.06,y,1.8),(.08,.05,3),metal,0)
    for zz in (1.1,2.5):box('Landmark_DoorRail',(7.05,y,zz),(.06,w-.2,.06),metal,0)
for y,r,z in [(0,1.7,12.4),(-9.6,.95,8.8),(9.6,.95,8.8)]: round_window('Landmark_CircularWindow',7.05,y,z,r)
for y in (-.83,.83):
    arch('Landmark_PairedUpperWindow',7.20,y,16.15,1.1,2.85,dark,.12,True)
    arch('Landmark_PairedUpperTrim',7.0,y,16.15,1.1,2.85,trim,.18)
arch('Landmark_Niche_Uncarved',7.18,0,7.25,1.0,2.6,dark,.1,True)
arch('Landmark_NicheTrim',7.0,0,7.25,1.0,2.6,trim)
box('Landmark_Cross_Vertical',(7.65,0,21.8),(.18,.20,1.7),trim)
box('Landmark_Cross_Horizontal',(7.65,0,22.1),(.18,1.05,.20),trim)
box('Landmark_Threshold',(6.65,0,.09),(1.8,6,.18),stone)

# Fictional ordinary Nanchang-lane fabric: sober lime/grey brick, tiled gables.
active=groups['03_StreetBuildings']
def shutter(name,x,y,z):
    box(name+'_Frame',(x,y,z),(1.35,.16,1.65),wood)
    box(name+'_DarkInset',(x,y-.10,z),(1.13,.08,1.43),dark)
    for dx in (-.37,0,.37):box(name+'_Stile',(x+dx,y-.17,z),(.09,.09,1.45),wood)
    for zz in (-.45,0,.45):box(name+'_Rail',(x,y-.17,z+zz),(1.15,.09,.06),wood)
    box(name+'_Sill',(x,y-.12,z-.85),(1.55,.36,.12),stone)
def house(name,x,y,w,d,h):
    box(name+'_Plinth',(x,y,.3),(w,d,.6),brick)
    box(name+'_Walls',(x,y,(h+.6)/2),(w,d,h-.6),plaster)
    roof(name+'_Roof',x,y,d,w,h,2.05)
    # Solid gable closures at ends of ridge.
    for sx in (-1,1):front_polygon(name+'_Gable',x+sx*w/2,[ (y-d/2,h),(y,h+2.05),(y+d/2,h)],.12,plaster)
    for dx in (-w*.28,w*.28):shutter(name+'_Window',x+dx,y-d/2-.08,2.3)
    box(name+'_Door',(x,y-d/2-.11,1.42),(1.25,.18,2.8),wood)
    box(name+'_Lintel',(x,y-d/2-.15,2.9),(1.65,.32,.22),stone)
    for dx in (-w/2+.12,w/2-.12):box(name+'_CornerStone',(x+dx,y-d/2-.06,h/2),(.24,.16,h),brick)
for args in [('LaneHouse_A',-35,-23,8,14,5.2),('LaneHouse_B',-18,-24,12,10,5.7),('LaneHouse_C',-35,-5,8,17,6.2),('LaneHouse_D',-18,0,10,10,5.0),('LaneHouse_E',-35,17,8,17,5.8),('LaneHouse_F',-4,-24,12,10,5.6),('LaneHouse_G',-3,29,10,7,5.2)]:house(*args)
def wall(name,x,y,w,d,h=2.5):
    box(name,(x,y,h/2),(w,d,h),brick)
    box(name+'_Coping',(x,y,h+.07),(w+.12,d+.14,.14),tile)
wall('ForecourtSouthWall',-.5,-14,14,.45)
wall('ForecourtNorthWall',2,19,10,.45)
wall('LaneTurnScreen',-12,-7,.45,8,2.7)
wall('CourtyardWestScreen',-10,12,.45,8,2.7)
wall('WestBoundary',-40,3,.45,70,3.1)
wall('EastBoundary',58,0,.45,34,3.1)
wall('SouthBoundary',-16,-32,48,.45,3.1)
wall('NorthBoundary',-16,40,48,.45,3.1)
wall('ChurchNorthBoundary',33,17,50,.45,2.7)
wall('ChurchSouthBoundary',33,-17,50,.45,2.7)
wall('NorthReturnBoundary',8,28.5,.45,23,2.7)
wall('SouthReturnBoundary',8,-24.5,.45,15,2.7)
for x in (-10,-5):
    box('CourtyardGatePier',(x,6,1.8),(.65,.65,3.6),stone)
box('CourtyardGateLintel',(-7.5,6,3.6),(5.65,.60,.30),wood)
roof('CourtyardGateRoof',-7.5,6,1.5,5.8,3.9,.65)

# Walk-through task building: real holes (separate wall segments), blank documents.
active=groups['04_MissionBuilding_Fictional']
mx,my=-20,27.5; mw,md=14,11
box('Mission_Floor',(mx,my,-.05),(mw,md,.16),wood)
for y in (22,33):
    for a,b in ((-27,-20),(-17.6,-13)):
        box('Mission_DoorWallSegment',((a+b)/2,y,1.9),(b-a,.35,3.8),plaster)
    box('Mission_DoorHead',(-18.8,y,3.3),(2.4,.35,1.0),plaster)
    for x in (-20.08,-17.52):box('Mission_DoorJamb',(x,y,1.4),(.16,.48,2.8),wood)
    box('Mission_DoorLintel',(-18.8,y,2.85),(2.72,.5,.16),wood)
for x in (-27,-13):
    box('Mission_SideLowerWall',(x,my,.62),(.35,md,1.24),brick)
    box('Mission_SideUpperWall',(x,my,3.25),(.35,md,1.10),plaster)
    for y in (23.0,27.5,32):box('Mission_SideWindowPier',(x,y,2),(.35,2,1.5),plaster)
    for y in (25.25,29.75):
        for yy in (y-.60,y,y+.60):box('Mission_WindowBar',(x,yy,2),(.12,.08,1.5),wood)
        box('Mission_WindowSill',(x,y,1.25),(.55,2.5,.13),stone)
roof('Mission_TileRoof',mx,my,md,mw,3.9,2.1)
for x in (-27,-13):front_polygon('Mission_Gable',x,[(22,3.8),(27.5,6),(33,3.8)],.18,plaster)
for y in (23,27.5,32):box('Mission_ExposedBeam',(mx,y,3.65),(mw,.20,.28),wood)
# Screen divides room while preserving a 2.7m passage on its east side.
box('Mission_InteriorScreen',(-23,28.3,1.45),(6,.16,2.9),wood)
box('Mission_TableTop',(-23.0,25.7,.90),(2.8,1.2,.13),wood)
for x in (-24.1,-21.9):
    for y in (25.27,26.13):box('Mission_TableLeg',(x,y,.43),(.12,.12,.86),wood)
for i in range(4):box('Mission_BlankDocument_VISUAL_ONLY',(-22.7,25.7,.979+i*.009),(.32,.42,.008),paper,.002)
box('Mission_Bench',(-23,24.1,.5),(2.5,.4,.12),wood)
for x in (-24,-22):box('Mission_BenchLeg',(x,24.1,.24),(.14,.33,.48),wood)
box('Mission_ShelfBack',(-26.66,30.4,1.3),(.10,2.6,2.6),wood)
for z in (.18,1,1.8,2.6):box('Mission_Shelf',(-26.35,30.4,z),(.7,2.6,.10),wood)

active=groups['05_Props']
def crate(name,x,y,z=0,sz=1):
    box(name,(x,y,z+sz/2),(sz,sz,sz),wood)
    for zz in (z+.12,z+sz-.12):
        for sy in (-1,1):box(name+'_Band',(x,y+sy*(sz/2+.01),zz),(sz+.03,.05,.07),metal,.008)
for i,(x,y,s) in enumerate([(-25,-9,1),(-24,-9,1),(-24,-9,1),(-8,1,1.1),(2,14,.9),(-5,15,.9),(-29,30,.8)]):crate('MovableCrate_Fictional_'+str(i),x,y,1 if i==2 else 0,s)
box('LowCover_Fictional',(-23,-12,.47),(3.2,1,.94),brick)
box('LowCover_Courtyard_Fictional',(-2,13,.47),(3,1,.94),brick)
# A modest timber handcart, original geometry.
box('HandcartBed',(-30,6,.65),(1.1,2,.14),wood)
for x in (-30.7,-29.3):
    rod('HandcartWheel',(x-.08,6,.52),(x+.08,6,.52),.50,wood,16)
    rod('HandcartHandle',(x,6,.6),(x,9,.9),.045,wood)
for y in (5.2,6.8):box('HandcartEnd',(-30,y,.98),(1.15,.10,.6),wood)

# Explicit proxy collection: simple boxes only, hidden in review, separate export.
visible=[o for c in list(groups.values())[:5] for o in c.objects if o.type=='MESH']
bpy.context.view_layer.update()
active=groups['90_CollisionProxies']
for o in visible:
    if any(s in o.name for s in ('Substrate','Paving','LongHall','_Walls','DoorWallSegment','DoorHead','SideLowerWall','SideUpperWall','SideWindowPier','Mission_Floor','InteriorScreen','Boundary','Screen','LowCover','ForecourtSouthWall','ForecourtNorthWall')):
        coords=[o.matrix_world @ Vector(v) for v in o.bound_box]
        lo=Vector(tuple(min(v[i] for v in coords) for i in range(3)));hi=Vector(tuple(max(v[i] for v in coords) for i in range(3)))
        p=box('COL_'+o.name,(lo+hi)/2,tuple(hi-lo),proxyMat,0);p.display_type='WIRE';p.hide_render=True
        p['purpose']='Optional box proxy; not connected to Laya physics yet'
active=groups['91_LayoutAndScale']
route=[(-28,-27),(-28,-14),(-20,-14),(-11,-12),(-11,-2),(-11,5),(-7.5,6),(-4,10),(-6,17),(-18.8,19),(-18.8,25),(-18.8,31),(-18.8,36),(-32,36)]
for i,(x,y) in enumerate(route):
    o=bpy.data.objects.new('Route_%02d_Fictional'%i,None);active.objects.link(o);o.location=(x,y,.05);o.empty_display_type='ARROWS';o.empty_display_size=.6
for name,loc in [('Street_Encounter_Fictional',(-23,-12,0)),('Courtyard_Encounter_Fictional',(-4,12,0)),('Document_VisualAnchor',(-22.7,25.7,1)),('Exit_Fictional',(-32,36,0))]:
    o=bpy.data.objects.new(name,None);active.objects.link(o);o.location=loc;o.empty_display_type='CUBE';o.empty_display_size=.4
scale=box('Reference_Player_2m_by_0.9m',(-7,18,1),(.9,.9,2),proxyMat,0);scale.hide_render=True;scale.display_type='WIRE'

# Lighting is for inspection, not the historical night setting.
active=groups['99_ReviewLighting']
scene.render.engine='CYCLES';scene.cycles.samples=24
scene.cycles.use_denoising=True
scene.render.resolution_x=1440;scene.render.resolution_y=1000;scene.render.resolution_percentage=100
scene.world.color=(.5,.5,.5)
scene.world.use_nodes=True;scene.world.node_tree.nodes['Background'].inputs[0].default_value=(.65,.72,.8,1);scene.world.node_tree.nodes['Background'].inputs[1].default_value=.65
bpy.ops.object.light_add(type='SUN',location=(-25,-30,40));sun=move(bpy.context.object);sun.name='Inspection_Sun';sun.data.energy=2.3;sun.data.angle=.12;sun.rotation_euler=(.45,-.5,-.45)
bpy.ops.object.light_add(type='AREA',location=(-23,25.5,3.3));area=move(bpy.context.object);area.name='Inspection_InteriorFill';area.data.energy=1000;area.data.shape='DISK';area.data.size=4
cameras={}
def camera(name,pos,target,lens=40,ortho=None):
    bpy.ops.object.camera_add(location=pos);o=move(bpy.context.object);o.name=name;o.rotation_euler=(Vector(target)-o.location).to_track_quat('-Z','Y').to_euler();o.data.lens=lens;o.data.clip_end=500
    if ortho:o.data.type='ORTHO';o.data.ortho_scale=ortho
    cameras[name]=o;return o
camera('01_Birdseye',(-68,-69,86),(5,3,0),ortho=140)
camera('02_Street',(-27,-16,1.65),(-5,6,6),lens=23)
camera('03_Landmark',(-3,0,11),(7.7,0,11),ortho=38.5)
camera('04_MissionInterior',(-18.6,22.7,1.65),(-23.1,26.6,1.4),lens=22)
scene.view_settings.view_transform='AgX'
scene['setting']='1927-08-01 before dawn; REVIEW uses daylight; fictional gameplay layout'
scene['coordinates']='Metres; +X east +Y north +Z up; origin forecourt reference (0,0,0); not georeferenced'
scene['evidence']='See docs/map-songbaix-references.md; landmark dimensions estimated'

# Consolidate exact repeated meshes (doors, framing, facade details) without joining buildings.
# Export each group at common world origin; importing all at identity assembles the block.
scene.camera=cameras['01_Birdseye']
bpy.context.view_layer.update()
export_names={'01_Ground':'ground','02_Landmark':'landmark','03_StreetBuildings':'street-buildings','04_MissionBuilding_Fictional':'mission-building','05_Props':'props','90_CollisionProxies':'collision-proxies'}
stats={}
for group,stem in export_names.items():
    bpy.ops.object.select_all(action='DESELECT')
    for o in groups[group].objects:o.select_set(True)
    bpy.ops.export_scene.gltf(filepath=str(OUT/(stem+'.glb')),export_format='GLB',use_selection=True,export_yup=True,export_texcoords=True,export_normals=True,export_materials='EXPORT',export_cameras=False,export_lights=False,export_extras=True)
    obs=[o for o in groups[group].objects if o.type=='MESH']
    stats[stem]={'objects':len(obs),'unique_meshes':len(set(o.data for o in obs)),'triangles':sum(sum(len(p.vertices)-2 for p in o.data.polygons) for o in obs)}
for p in sorted(OUT.rglob('*')):
    if p.suffix in ('.glb','.png'):
        meta=p.with_suffix(p.suffix+'.meta')
        if not meta.exists():
            meta.write_text(json.dumps({'uuid':str(uuid.uuid5(uuid.NAMESPACE_URL,'NanChangDemo/'+p.relative_to(ROOT).as_posix()))},indent=2)+'\n',encoding='utf8')
groups['90_CollisionProxies'].hide_viewport=True
for im in bpy.data.images:
    if im.source=='FILE':
        im.pack()
        im.filepath=bpy.path.relpath(im.filepath,start=str(HERE))
for screen in bpy.data.screens:
    for ar in screen.areas:
        if ar.type=='VIEW_3D':
            ar.spaces.active.region_3d.view_distance=105;ar.spaces.active.region_3d.view_location=(7,3,0);ar.spaces.active.shading.type='MATERIAL'
bpy.ops.wm.save_as_mainfile(filepath=str(HERE/'Songbaix_Block.blend'))
(HERE/'model-stats.json').write_text(json.dumps(stats,indent=2),encoding='utf8')
(HERE/'layout.json').write_text(json.dumps({'unit':'metre','axes':'X east, Y north, Z up','route_xy':route,'door_clear_width':2.4,'door_clear_height':2.8,'player_reference':{'height':2,'radius':.45},'landmark_estimate':{'width':26,'length':48,'max_height':22.65}},indent=2),encoding='utf8')
for name,cam in cameras.items():
    scene.camera=cam;scene.render.filepath=str(REVIEW/(name+'.png'));bpy.ops.render.render(write_still=True)
print('SONGBAIX_BUILD_COMPLETE',json.dumps(stats))
