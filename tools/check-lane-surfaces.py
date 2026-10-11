"""Check generated rectangular faces for same-facing coplanar area overlap."""
import json
import math
import struct
import sys
from pathlib import Path

root=Path(__file__).resolve().parents[1]
path=Path(sys.argv[1]) if len(sys.argv)>1 else root/'assets/resources/environment/lane-mission/WindingLanes.glb'
blob=path.read_bytes();length=struct.unpack_from('<I',blob,12)[0]
gltf=json.loads(blob[20:20+length]);binary=blob[28+length:]
def read(index):
    a=gltf['accessors'][index];v=gltf['bufferViews'][a['bufferView']]
    offset=v.get('byteOffset',0)+a.get('byteOffset',0)
    return struct.unpack_from('<'+'f'*(a['count']*3),binary,offset)
planes={};overlaps=[];faces=0
for mesh in gltf['meshes']:
    for primitive in mesh['primitives']:
        positions=read(primitive['attributes']['POSITION']);normals=read(primitive['attributes']['NORMAL'])
        assert all(math.isfinite(v) for v in positions+normals)
        for k in range(0,len(positions),12):
            vertices=[positions[i:i+3] for i in range(k,k+12,3)]
            if len(set(vertices))!=4:continue
            n=normals[k:k+3];axis=max(range(3),key=lambda i:abs(n[i]));a,b=[i for i in range(3)if i!=axis]
            xs=sorted(set(round(v[a],4)for v in vertices));ys=sorted(set(round(v[b],4)for v in vertices))
            if len(xs)!=2 or len(ys)!=2:continue
            faces+=1;rect=(xs[0],xs[1],ys[0],ys[1])
            key=tuple(round(v,4)for v in n)+(round(sum(n[i]*vertices[0][i]for i in range(3)),3),)
            for name,r in planes.get(key,[]):
                w=min(rect[1],r[1])-max(rect[0],r[0]);h=min(rect[3],r[3])-max(rect[2],r[2])
                if w>1e-4 and h>1e-4:overlaps.append({'first':name,'second':mesh['name'],'area':w*h,'plane':key})
            planes.setdefault(key,[]).append((mesh['name'],rect))
print(json.dumps({'faces':faces,'coplanarOverlaps':len(overlaps),'examples':overlaps[:8]},ensure_ascii=True))
if overlaps:sys.exit(1)
