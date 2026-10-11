"""Reusable unit-sized hinged leaves; glass is a genuine alpha-blended material."""
import json
import math
import struct

def build_panels(folder, uid):
    for window in (False, True):
        parts={}
        def quad(mat,points):
            data=parts.setdefault(mat,{'p':[],'n':[],'uv':[],'i':[]})
            a,b,_,d=points;u=[b[i]-a[i]for i in range(3)];v=[d[i]-a[i]for i in range(3)]
            n=[u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]
            length=math.sqrt(sum(x*x for x in n));n=[x/length for x in n];start=len(data['p'])//3
            for p,uv in zip(points,[(0,0),(1,0),(1,1),(0,1)]):data['p']+=p;data['n']+=n;data['uv']+=uv
            data['i'] += [start,start+1,start+2,start,start+2,start+3]
        def box(mat,x,y,z,w,h,d):
            x0,x1=x-w/2,x+w/2;y0,y1=y-h/2,y+h/2;z0,z1=z-d/2,z+d/2
            for face in [[(x0,y0,z1),(x1,y0,z1),(x1,y1,z1),(x0,y1,z1)],[(x1,y0,z0),(x0,y0,z0),(x0,y1,z0),(x1,y1,z0)],
                         [(x1,y0,z1),(x1,y0,z0),(x1,y1,z0),(x1,y1,z1)],[(x0,y0,z0),(x0,y0,z1),(x0,y1,z1),(x0,y1,z0)],
                         [(x0,y1,z1),(x1,y1,z1),(x1,y1,z0),(x0,y1,z0)],[(x0,y0,z0),(x1,y0,z0),(x1,y0,z1),(x0,y0,z1)]]:quad(mat,face)
        if window:
            for x in (.035,.965):box(0,x,.5,0,.07,1,.07)
            for y in (.035,.965):box(0,.5,y,0,.86,.07,.07)
            box(1,.5,.5,0,.86,.86,.012)
            box(2,.9,.5,.055,.07,.025,.04)
        else:
            box(0,.5,.5,0,1,1,.08)
            for y in (.13,.5,.87):box(0,.5,y,.049,.87,.055,.018)
            for z in (-.065,.065):box(2,.86,.5,z,.09,.028,.055)
        chunks=[];views=[];accessors=[];offset=0
        def buffer(values,kind):
            nonlocal offset
            integer=kind=='SCALAR';dims={'VEC3':3,'VEC2':2,'SCALAR':1}[kind]
            b=struct.pack('<'+('I'if integer else'f')*len(values),*values);views.append({'buffer':0,'byteOffset':offset,'byteLength':len(b)})
            chunks.append(b);offset+=len(b)
            a={'bufferView':len(views)-1,'componentType':5125 if integer else 5126,'count':len(values)//dims,'type':kind}
            if kind=='VEC3':a.update(min=[min(values[j::3])for j in range(3)],max=[max(values[j::3])for j in range(3)])
            accessors.append(a);return len(accessors)-1
        meshes=[]
        for mat,data in parts.items():
            meshes.append({'name':['Wood','TransparentGlass','Handle'][mat],'primitives':[{'attributes':{'POSITION':buffer(data['p'],'VEC3'),
                'NORMAL':buffer(data['n'],'VEC3'),'TEXCOORD_0':buffer(data['uv'],'VEC2')},'indices':buffer(data['i'],'SCALAR'),'material':mat}]})
        binary=b''.join(chunks)
        g={'asset':{'version':'2.0','generator':'NanChangDemo openable leaf kit'},'scene':0,'scenes':[{'nodes':list(range(len(meshes)))}],
           'nodes':[{'name':m['name'],'mesh':i}for i,m in enumerate(meshes)],'meshes':meshes,
           'materials':[{'name':'Wood','pbrMetallicRoughness':{'baseColorTexture':{'index':0},'metallicFactor':0,'roughnessFactor':.85}},
                        {'name':'TransparentGlass','alphaMode':'BLEND','pbrMetallicRoughness':{'baseColorFactor':[.62,.86,.90,.23],'metallicFactor':0,'roughnessFactor':.18}},
                        {'name':'IronHandle','pbrMetallicRoughness':{'baseColorFactor':[.12,.14,.14,1],'metallicFactor':.5,'roughnessFactor':.4}}],
           'images':[{'uri':'../../oldtown/textures/Wood_albedo.png'}],'textures':[{'source':0,'sampler':0}],
           'samplers':[{'magFilter':9729,'minFilter':9987,'wrapS':10497,'wrapT':10497}],
           'buffers':[{'byteLength':len(binary)}],'bufferViews':views,'accessors':accessors}
        j=json.dumps(g,separators=(',',':')).encode();j+=b' '*(-len(j)%4)
        output=struct.pack('<III',0x46546c67,2,28+len(j)+len(binary))+struct.pack('<II',len(j),0x4e4f534a)+j+struct.pack('<II',len(binary),0x004e4942)+binary
        name='WindowPanel.glb' if window else 'DoorPanel.glb';file=folder/name
        if not file.exists()or file.read_bytes()!=output:file.write_bytes(output)
        meta=folder/(name+'.meta')
        if not meta.exists():meta.write_text(json.dumps({'uuid':uid(name)},indent=2)+'\n',encoding='utf8')
