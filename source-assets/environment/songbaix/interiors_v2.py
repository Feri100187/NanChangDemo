"""Executed inside build_songbaix.py. All interiors are explicitly game-design additions.
Closed manifold wall meshes have real Boolean openings; collision is split around holes.
"""
room_collision_boxes=[]
room_entries=[]
def remove_prefixes(prefixes):
    for o in list(bpy.data.objects):
        if any(o.name.startswith(p) for p in prefixes):bpy.data.objects.remove(o,do_unlink=True)

def cut(target,cutter):
    bpy.context.view_layer.objects.active=target
    mod=target.modifiers.new('True door or window opening','BOOLEAN');mod.operation='DIFFERENCE';mod.solver='EXACT';mod.object=cutter
    bpy.ops.object.modifier_apply(modifier=mod.name)
    bpy.data.objects.remove(cutter,do_unlink=True)
    target.data.update();uv_mesh(target.data)

def hollow_wall(name,axis,center,length,height,holes,mat=plaster,thick=.32):
    # holes: (horizontal center, width, bottom, top), in wall-local coordinates.
    size=(length,thick,height) if axis=='X' else (thick,length,height)
    o=box(name,(*center,height/2),size,mat,0)
    # Shared primitive cache must not be mutated by a Boolean.
    o.data=o.data.copy()
    for u,w,b,t in holes:
        pos=(center[0]+u,center[1],(b+t)/2) if axis=='X' else (center[0],center[1]+u,(b+t)/2)
        sz=(w,thick+1,t-b) if axis=='X' else (thick+1,w,t-b)
        cutter=box('TemporaryOpening',pos,sz,dark,0);cut(o,cutter)
    xs=sorted(set([-length/2,length/2]+[max(-length/2,min(length/2,u+s*w/2)) for u,w,b,t in holes for s in (-1,1)]))
    zs=sorted(set([0,height]+[max(0,min(height,v)) for u,w,b,t in holes for v in (b,t)]))
    for a,b in zip(xs,xs[1:]):
        for z0,z1 in zip(zs,zs[1:]):
            if b-a<.001 or z1-z0<.001:continue
            u,z=(a+b)/2,(z0+z1)/2
            if any(abs(u-hu)<hw/2 and hb<z<ht for hu,hw,hb,ht in holes):continue
            loc=(center[0]+u,center[1],z) if axis=='X' else (center[0],center[1]+u,z)
            sz=(b-a,thick,z1-z0) if axis=='X' else (thick,b-a,z1-z0)
            room_collision_boxes.append((name+'_%d'%len(room_collision_boxes),loc,sz))
    return o

def portal(name,axis,cx,cy,width=2.2,height=2.9):
    # Raised exterior and interior trims are 7cm proud of wall faces, never coplanar.
    for normal in (-1,1):
        for side in (-1,1):
            loc=(cx+side*(width/2+.09),cy+normal*.23,height/2) if axis=='X' else (cx+normal*.23,cy+side*(width/2+.09),height/2)
            sz=(.18,.10,height) if axis=='X' else (.10,.18,height)
            box(name+'_RaisedJamb',loc,sz,wood,.012)
        loc=(cx,cy+normal*.23,height+.08) if axis=='X' else (cx+normal*.23,cy,height+.08)
        sz=(width+.36,.10,.16) if axis=='X' else (.10,width+.36,.16)
        box(name+'_RaisedLintel',loc,sz,wood,.012)

houses=[('A',-35,-23,8,14,5.2),('B',-18,-24,12,10,5.7),('C',-35,-5,8,17,6.2),('D',-18,0,10,10,5),('E',-35,17,8,17,5.8),('F',-4,-24,12,10,5.6),('G',-3,29,10,7,5.2)]
active=groups['03_StreetBuildings']
for letter,x,y,w,d,h in houses:
    n='LaneHouse_'+letter
    remove_prefixes([n+s for s in ('_Walls','_Plinth','_Door','_Lintel','_Window','_CornerStone')])
    side=1 if x<-30 else -1
    for sign in (-1,1):
        windows=[(-w*.28,1.35,1.25,2.75),(w*.28,1.35,1.25,2.75)] if sign==-1 else []
        hollow_wall(n+'_HollowWall_'+str(sign),'X',(x,y+sign*d/2),w,h,[(0,2.2,-.1,2.9)]+windows)
        portal(n+'_Portal','X',x,y+sign*d/2)
        if sign==-1:
            for u,ww,z0,z1 in windows:
                # One opaque glazed pane, inside a real opening; wooden dividers sit in front.
                box(n+'_WindowPane',(x+u,y-d/2,(z0+z1)/2),(ww,.06,z1-z0),glass,.008)
                for dx in (-ww/2,0,ww/2):box(n+'_WindowFrame',(x+u+dx,y-d/2-.23,2),(.07,.10,1.41),wood,.01)
                for z in (z0,z1):box(n+'_WindowFrame',(x+u,y-d/2-.23,z),(ww+.12,.10,.09),wood,.01)
    for sign in (-1,1):
        holes=[(0,2.2,-.1,2.9)] if sign==side else []
        hollow_wall(n+'_SideHollowWall_'+str(sign),'Y',(x+sign*w/2,y),d-.32,h,holes)
        if holes:portal(n+'_SidePortal','Y',x+sign*w/2,y)
    box(n+'_RoomFloor',(x,y,-.02),(w-.32,d-.32,.14),wood,0)
    # Modest original furniture; circulation axes remain empty.
    bx,by=x+w*.29,y+d*.26
    box(n+'_InteriorBlock_BedBase',(bx,by,.25),(1.65,2.4,.4),wood)
    box(n+'_BedBlanket',(bx,by,.49),(1.58,2.32,.08),plaster)
    tx,ty=x-w*.27,y+d*.26
    box(n+'_InteriorBlock_Table',(tx,ty,.78),(1.5,1,.14),wood)
    for dx in (-.6,.6):
        for dy in (-.38,.38):box(n+'_TableLeg',(tx+dx,ty+dy,.4),(.10,.10,.8),wood)
    box(n+'_InteriorBlock_Chest',(x+w*.27,y-d*.26,.46),(1.35,.85,.85),wood)
    for yy in (y-d*.3,y+d*.3):box(n+'_CeilingBeam',(x,yy,h-.25),(w-.2,.16,.22),wood)
    room_entries.append({'name':n,'outside':[x,y-d/2-1.3],'inside':[x,y-d/2+1.6],'floor':.05,'door_width':2.2,'door_height':2.9})

# Church retains the referenced external outline, but gains a conservative open hall.
active=groups['02_Landmark']
remove_prefixes(['Landmark_Base','Landmark_LongHall','Landmark_Clerestory','Landmark_ClosedDoor','Landmark_DoorMeeting','Landmark_DoorRail','Landmark_Threshold'])
box('Landmark_RoomFloor',(32,0,.015),(48,26,.13),stone,0)
for sign in (-1,1):
    hollow_wall('Landmark_SideHollowWall_'+str(sign),'X',(32,sign*12.84),48,10.3,[],church)
    upper=box('Landmark_UpperShell',(32,sign*4.84,13.1),(48,.32,5.6),church,0)
hollow_wall('Landmark_BackHollowWall','Y',(55.84,0),25.7,10.3,[],church)
box('Landmark_UpperBack',(55.84,0,13.1),(.32,10,5.6),church,0)
front_polygon('Landmark_BackGable',55.68,[(-5,15.9),(0,19.4),(5,15.9)],.32,church)
front_polygon('Landmark_BackAisleGable',55.68,[(-13,10.3),(-5,14.8),(-5,10.3)],.32,church)
front_polygon('Landmark_BackAisleGable',55.68,[(5,10.3),(5,14.8),(13,10.3)],.32,church)
facade=bpy.data.objects.get('Landmark_WestFacade');facade.data=facade.data.copy()
doors=[(0,3.4,4.9),(-4,2.2,4.2),(4,2.2,4.2),(-9.6,1.8,4),(9.6,1.8,4)]
for y,w,h in doors:
    cutter=arch('TemporaryArchOpening',7,y,-.1,w,h+.38,dark,2,True);cut(facade,cutter)
    # Folded-back leaves occupy the sides inside, not the opening or coplanar wall surface.
    for sign in (-1,1):box('Landmark_InteriorBlock_OpenDoor',(8.55,y+sign*(w/2+.14),1.65),(1.25,.10,3.1),wood,.012)
# Collision approximates each arch conservatively; main central opening has ample headroom.
edges=sorted(set([-13,13]+[y+s*w/2 for y,w,h in doors for s in (-1,1)]))
for a,b in zip(edges,edges[1:]):
    middle=(a+b)/2;door=next(((y,w,h) for y,w,h in doors if abs(middle-y)<w/2),None)
    if door:bottom=door[2]-door[1]/2+.28
    else:bottom=0
    room_collision_boxes.append(('ChurchFacadeSegment', (7.86,middle,(bottom+20)/2),(.48,b-a,20-bottom)))
for x in (18,26,34,42,50):
    for sign in (-1,1):
        box('Landmark_InteriorBlock_Pier',(x,sign*4.65,7.3),(.5,.5,14.6),trim)
        box('Landmark_PierFoot',(x,sign*4.65,.24),(.8,.8,.48),stone)
for x in (24,30,36,42):
    for y in (-8,8):
        box('Landmark_InteriorBlock_Bench',(x,y,.50),(.60,3.8,.16),wood)
        for yy in (y-1.45,y+1.45):box('Landmark_BenchLeg',(x,yy,.26),(.42,.13,.52),wood)
room_entries.append({'name':'Landmark','outside':[5,0],'inside':[11,0],'floor':.08,'door_width':3.4,'door_height':3.4})
room_entries.append({'name':'Mission','outside':[-18.8,20],'inside':[-18.8,24],'floor':.03,'door_width':2.4,'door_height':2.77})

# Remove the overlapping body of the old mission lintel and replace it with two raised trims.
active=groups['04_MissionBuilding_Fictional']
remove_prefixes(['Mission_DoorJamb','Mission_DoorLintel'])
for y in (22,33):portal('Mission_ClearPortal','X',-18.8,y,2.4,2.8)
# The stone belt and pilaster fronts previously met in the same X plane. Separate surfaces.
for o in list(groups['02_Landmark'].objects):
    if o.name.startswith('Landmark_LowerBelt'):o.location.x-=.12
    if o.name.startswith(('Landmark_DoorSurround','Landmark_PairedUpperTrim','Landmark_NicheTrim')):o.location.x-=.08

(HERE/'interior-layout.json').write_text(json.dumps({'rooms':room_entries,'note':'Fictional interior layouts, not a historical survey.'},indent=2),encoding='utf8')
