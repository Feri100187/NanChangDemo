{
  "_$ver": 1,
  "_$id": "er2lfkwr",
  "_$type": "Scene",
  "left": 0,
  "right": 0,
  "top": 0,
  "bottom": 0,
  "name": "Scene2D",
  "width": 1334,
  "height": 750,
  "autoDestroyAtClosed": true,
  "_$comp": [
    {
      "_$type": "a65ae9e2-b5cb-4261-88c7-ff3b9ce65234",
      "scriptPath": "../src/LevelController.ts",
      "player": {
        "_$ref": "player01"
      },
      "enemies": [
        {
          "_$ref": "target001"
        },
        {
          "_$ref": "enemy002"
        },
        {
          "_$ref": "enemy003"
        },
        {
          "_$ref": "enemy004"
        }
      ],
      "exitZone": {
        "_$ref": "exitzone1"
      },
      "exitHalfSize": {
        "_$type": "Vector3",
        "x": 2.5,
        "y": 2,
        "z": 2.5
      },
      "remainingText": {
        "_$ref": "targethud"
      },
      "objectiveText": {
        "_$ref": "objective1"
      },
      "resultPanel": {
        "_$ref": "resultpanel"
      },
      "resultTitle": {
        "_$ref": "resulttitle"
      },
      "resultDetail": {
        "_$ref": "resultdetail"
      },
      "restartButton": {
        "_$ref": "restartbtn"
      }
    },
    {
      "_$type": "6e483e4c-9eef-46bf-b163-00576b2619bd",
      "scriptPath": "../src/CombatFeedback.ts",
      "player": {
        "_$ref": "player01"
      },
      "viewCamera": {
        "_$ref": "6jx8h8bvc6"
      },
      "enemies": [
        {
          "_$ref": "target001"
        },
        {
          "_$ref": "enemy002"
        },
        {
          "_$ref": "enemy003"
        },
        {
          "_$ref": "enemy004"
        }
      ],
      "playerShotSound": "res://1fdcce3c-8fd4-4804-a490-220ff795e9d5",
      "enemyShotSound": "res://cb88da38-7519-4806-b36c-afb1fc55a89c",
      "reloadSound": "res://f2c87ba9-8fee-4b2b-b1f2-b1674713e6c0",
      "meleeSound": "res://49b90a3d-fd64-4af9-96aa-6e6413cb9e25",
      "heavyMeleeSound": "res://d8fd63f2-3d98-49d3-9700-a104169a0b5f"
    }
  ],
  "_$child": [
    {
      "_$id": "n9gjxcltvl",
      "_$type": "Scene3D",
      "name": "Scene3D",
      "skyRenderer": {
        "meshType": "dome",
        "material": {
          "_$uuid": "793cffc6-730a-4756-a658-efe98c230292",
          "_$type": "Material"
        }
      },
      "ambientColor": {
        "_$type": "Color",
        "r": 0.424308,
        "g": 0.4578516,
        "b": 0.5294118
      },
      "fogStart": 0,
      "fogEnd": 300,
      "fogColor": {
        "_$type": "Color",
        "r": 0.5,
        "g": 0.5,
        "b": 0.5
      },
      "_$child": [
        {
          "_$id": "6jx8h8bvc6",
          "_$type": "Camera",
          "name": "Main Camera",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 0,
              "y": 1.65,
              "z": 0
            }
          },
          "nearPlane": 0.1,
          "farPlane": 1000,
          "clearFlag": 1,
          "clearColor": {
            "_$type": "Color",
            "r": 0.3921,
            "g": 0.5843,
            "b": 0.9294
          },
          "_$child": []
        },
        {
          "_$id": "6ni3p096l5",
          "_$type": "Sprite3D",
          "name": "Direction Light",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 5,
              "y": 5,
              "z": 5
            },
            "localRotation": {
              "_$type": "Quaternion",
              "x": -0.40821789367673483,
              "y": 0.23456971600980447,
              "z": 0.109381654946615,
              "w": 0.875426098065593
            }
          },
          "_$comp": [
            {
              "_$type": "DirectionLightCom",
              "color": {
                "_$type": "Color",
                "g": 0.96,
                "b": 0.88
              },
              "shadowMode": 1
            }
          ]
        },
        {
          "_$id": "ground01",
          "_$type": "Sprite3D",
          "name": "Ground_100x100",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "y": -0.5
            },
            "localScale": {
              "_$type": "Vector3",
              "x": 100,
              "y": 1,
              "z": 100
            }
          },
          "_$comp": [
            {
              "_$type": "MeshFilter",
              "sharedMesh": {
                "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                "_$type": "Mesh"
              }
            },
            {
              "_$type": "MeshRenderer",
              "receiveShadow": true,
              "lightmapScaleOffset": {
                "_$type": "Vector4"
              },
              "sharedMaterials": [
                {
                  "_$uuid": "cf19231d-929a-4453-9a17-dd640aa6f582",
                  "_$type": "Material"
                }
              ]
            },
            {
              "_$type": "PhysicsCollider",
              "colliderShape": {
                "_$type": "BoxColliderShape"
              },
              "collisionGroup": 1,
              "canCollideWith": -1
            }
          ]
        },
        {
          "_$id": "gridroot",
          "_$type": "Sprite3D",
          "name": "GroundGrid",
          "_$child": [
            {
              "_$id": "grid05",
              "_$type": "Sprite3D",
              "name": "Grid_0_-45",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -45,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid15",
              "_$type": "Sprite3D",
              "name": "Grid_1_-45",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -45
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid010",
              "_$type": "Sprite3D",
              "name": "Grid_0_-40",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -40,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid110",
              "_$type": "Sprite3D",
              "name": "Grid_1_-40",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -40
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid015",
              "_$type": "Sprite3D",
              "name": "Grid_0_-35",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -35,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid115",
              "_$type": "Sprite3D",
              "name": "Grid_1_-35",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -35
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid020",
              "_$type": "Sprite3D",
              "name": "Grid_0_-30",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -30,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid120",
              "_$type": "Sprite3D",
              "name": "Grid_1_-30",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid025",
              "_$type": "Sprite3D",
              "name": "Grid_0_-25",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -25,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid125",
              "_$type": "Sprite3D",
              "name": "Grid_1_-25",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -25
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid030",
              "_$type": "Sprite3D",
              "name": "Grid_0_-20",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -20,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid130",
              "_$type": "Sprite3D",
              "name": "Grid_1_-20",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -20
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid035",
              "_$type": "Sprite3D",
              "name": "Grid_0_-15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -15,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid135",
              "_$type": "Sprite3D",
              "name": "Grid_1_-15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -15
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid040",
              "_$type": "Sprite3D",
              "name": "Grid_0_-10",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid140",
              "_$type": "Sprite3D",
              "name": "Grid_1_-10",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -10
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid045",
              "_$type": "Sprite3D",
              "name": "Grid_0_-5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -5,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid145",
              "_$type": "Sprite3D",
              "name": "Grid_1_-5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": -5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid050",
              "_$type": "Sprite3D",
              "name": "Grid_0_0",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid150",
              "_$type": "Sprite3D",
              "name": "Grid_1_0",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid055",
              "_$type": "Sprite3D",
              "name": "Grid_0_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 5,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid155",
              "_$type": "Sprite3D",
              "name": "Grid_1_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid060",
              "_$type": "Sprite3D",
              "name": "Grid_0_10",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 10,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid160",
              "_$type": "Sprite3D",
              "name": "Grid_1_10",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 10
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid065",
              "_$type": "Sprite3D",
              "name": "Grid_0_15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 15,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid165",
              "_$type": "Sprite3D",
              "name": "Grid_1_15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 15
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid070",
              "_$type": "Sprite3D",
              "name": "Grid_0_20",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 20,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid170",
              "_$type": "Sprite3D",
              "name": "Grid_1_20",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 20
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid075",
              "_$type": "Sprite3D",
              "name": "Grid_0_25",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 25,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid175",
              "_$type": "Sprite3D",
              "name": "Grid_1_25",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 25
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid080",
              "_$type": "Sprite3D",
              "name": "Grid_0_30",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 30,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid180",
              "_$type": "Sprite3D",
              "name": "Grid_1_30",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid085",
              "_$type": "Sprite3D",
              "name": "Grid_0_35",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 35,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid185",
              "_$type": "Sprite3D",
              "name": "Grid_1_35",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 35
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid090",
              "_$type": "Sprite3D",
              "name": "Grid_0_40",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 40,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid190",
              "_$type": "Sprite3D",
              "name": "Grid_1_40",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 40
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid095",
              "_$type": "Sprite3D",
              "name": "Grid_0_45",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 45,
                  "y": 0.006
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 100
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "grid195",
              "_$type": "Sprite3D",
              "name": "Grid_1_45",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.006,
                  "z": 45
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 100,
                  "y": 0.008,
                  "z": 0.035
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "4bd9a026-4e16-4b3d-ab9f-0ee290a8f146",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "player01",
          "_$type": "Sprite3D",
          "name": "Player",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "y": 1.1
            }
          },
          "_$comp": [
            {
              "_$type": "CharacterController",
              "collisionGroup": 32,
              "canCollideWith": -1,
              "radius": 0.45,
              "gravity": {
                "_$type": "Vector3",
                "y": -20
              },
              "maxSlope": 45,
              "stepHeight": 0.15
            },
            {
              "_$type": "da4c9493-bf12-454d-ac0b-0cf4fef45c1b",
              "scriptPath": "../src/PlayerController.ts",
              "walkSpeed": 5,
              "sprintSpeed": 9,
              "crouchSpeed": 2,
              "jumpSpeed": 7,
              "mouseSensitivity": 0.18,
              "body": {
                "_$ref": "body0001"
              },
              "followCamera": {
                "_$ref": "6jx8h8bvc6"
              },
              "statusText": {
                "_$ref": "status01"
              },
              "weaponPivot": {
                "_$ref": "weapon01"
              }
            },
            {
              "_$type": "d533e208-c8c5-4fa1-b915-29081d1e10de",
              "scriptPath": "../src/RifleController.ts",
              "viewCamera": {
                "_$ref": "6jx8h8bvc6"
              },
              "rifleModel": {
                "_$ref": "rifle001"
              },
              "ammoText": {
                "_$ref": "ammo0001"
              },
              "crosshairText": {
                "_$ref": "cross001"
              },
              "magazineSize": 40,
              "startingReserve": 99999,
              "roundsPerMinute": 700,
              "reloadSeconds": 2.2,
              "baseDamage": 28,
              "hitText": {
                "_$ref": "hitinfo1"
              }
            },
            {
              "_$type": "a0710ceb-501a-4b74-8689-684364cac0e4",
              "scriptPath": "../src/PlayerHealth.ts",
              "maxHealth": 100,
              "healthText": {
                "_$ref": "playerhp1"
              }
            }
          ],
          "_$child": [
            {
              "_$id": "body0001",
              "_$type": "Sprite3D",
              "name": "CapsuleBody",
              "transform": {
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.9,
                  "y": 1,
                  "z": 0.9
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "81a027ba-bf6c-4112-8e81-2a9b06c53290",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "target001",
          "_$type": "Sprite3D",
          "name": "敌军01",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 0,
              "y": 0,
              "z": -15
            }
          },
          "_$comp": [
            {
              "_$type": "84bdb250-9790-429d-9b97-68d328d7e6f6",
              "scriptPath": "../src/EnemyAI.ts",
              "player": {
                "_$ref": "player01"
              },
              "maxHealth": 100,
              "sightRange": 26,
              "fieldOfView": 120,
              "alertTime": 1.6,
              "loseTargetTime": 2.2,
              "attackInterval": 0.9,
              "patrolSpeed": 0.75
            }
          ],
          "_$child": [
            {
              "_$id": "head0001",
              "_$type": "Sprite3D",
              "name": "Head",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 2.3,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.55,
                  "y": 0.5,
                  "z": 0.45
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "torso001",
              "_$type": "Sprite3D",
              "name": "Torso",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 1,
                  "z": 0.4
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "legs0001",
              "_$type": "Sprite3D",
              "name": "Legs",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 0.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7,
                  "y": 1,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "enemyarm1",
              "_$type": "Sprite3D",
              "name": "LeftArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "enemyarm2",
              "_$type": "Sprite3D",
              "name": "RightArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "enemygun1",
              "_$type": "Sprite3D",
              "name": "EnemyRifle",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.23,
                  "y": 1.34,
                  "z": 0.55
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.14,
                  "y": 0.14,
                  "z": 0.82
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "weapon01",
          "_$type": "Sprite3D",
          "name": "WeaponPivot",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 0,
              "y": 1.65,
              "z": 0
            }
          },
          "_$child": [
            {
              "_$id": "rifle001",
              "_$type": "Sprite3D",
              "name": "RifleBox",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.34,
                  "y": -0.32,
                  "z": -0.72
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.16,
                  "y": 0.18,
                  "z": 1.05
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": false,
                  "sharedMaterials": [
                    {
                      "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                      "_$type": "Material"
                    }
                  ]
                }
              ],
              "_$child": [
                {
                  "_$id": "sighttop",
                  "_$type": "Sprite3D",
                  "name": "SightTop",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 1.333,
                      "z": 0.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 0.06,
                      "z": 0.014
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "castShadow": false,
                      "sharedMaterials": [
                        {
                          "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "sightbot",
                  "_$type": "Sprite3D",
                  "name": "SightBottom",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 0.667,
                      "z": 0.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 0.06,
                      "z": 0.014
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "castShadow": false,
                      "sharedMaterials": [
                        {
                          "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "sightleft",
                  "_$type": "Sprite3D",
                  "name": "SightLeft",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -0.5,
                      "y": 1,
                      "z": 0.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.07,
                      "y": 0.667,
                      "z": 0.014
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "castShadow": false,
                      "sharedMaterials": [
                        {
                          "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "sightrght",
                  "_$type": "Sprite3D",
                  "name": "SightRight",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0.5,
                      "y": 1,
                      "z": 0.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.07,
                      "y": 0.667,
                      "z": 0.014
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "castShadow": false,
                      "sharedMaterials": [
                        {
                          "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "sightdot",
                  "_$type": "Sprite3D",
                  "name": "RedDot",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 1,
                      "z": 0.3
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.075,
                      "y": 0.067,
                      "z": 0.014
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "castShadow": false,
                      "sharedMaterials": [
                        {
                          "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "bld00000",
          "_$type": "Sprite3D",
          "name": "BuildingsAndCover",
          "_$child": [
            {
              "_$id": "bld00001",
              "_$type": "Sprite3D",
              "name": "House_West",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -11.5,
                  "y": 0,
                  "z": -14
                }
              },
              "_$child": [
                {
                  "_$id": "bld00002",
                  "_$type": "Sprite3D",
                  "name": "BackWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 1.8,
                      "z": -3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 6.5,
                      "y": 3.6,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00003",
                  "_$type": "Sprite3D",
                  "name": "LeftWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.1,
                      "y": 1.8,
                      "z": 0
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.3,
                      "y": 3.6,
                      "z": 6.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00004",
                  "_$type": "Sprite3D",
                  "name": "RightWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.1,
                      "y": 1.8,
                      "z": 0
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.3,
                      "y": 3.6,
                      "z": 6.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00005",
                  "_$type": "Sprite3D",
                  "name": "FrontWall_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.05,
                      "y": 1.8,
                      "z": 3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 3.6,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00006",
                  "_$type": "Sprite3D",
                  "name": "FrontWall_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.05,
                      "y": 1.8,
                      "z": 3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 3.6,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00007",
                  "_$type": "Sprite3D",
                  "name": "DoorLintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 3,
                      "z": 3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.7,
                      "y": 1.2,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00008",
                  "_$type": "Sprite3D",
                  "name": "FlatRoof",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 3.75,
                      "z": 0
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 7,
                      "y": 0.3,
                      "z": 7
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "7fe90ace-ddda-481b-99d5-25ae24500214",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld00009",
                  "_$type": "Sprite3D",
                  "name": "ClosedWindow_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.05,
                      "y": 2.2,
                      "z": 3.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.8,
                      "y": 0.7,
                      "z": 0.04
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "bld0000a",
                  "_$type": "Sprite3D",
                  "name": "ClosedWindow_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.05,
                      "y": 2.2,
                      "z": 3.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.8,
                      "y": 0.7,
                      "z": 0.04
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "bld0000b",
              "_$type": "Sprite3D",
              "name": "House_East",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 11.5,
                  "y": 0,
                  "z": -14
                }
              },
              "_$child": [
                {
                  "_$id": "bld0000c",
                  "_$type": "Sprite3D",
                  "name": "BackWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 1.8,
                      "z": -3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 6.5,
                      "y": 3.6,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000d",
                  "_$type": "Sprite3D",
                  "name": "LeftWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.1,
                      "y": 1.8,
                      "z": 0
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.3,
                      "y": 3.6,
                      "z": 6.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000e",
                  "_$type": "Sprite3D",
                  "name": "RightWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.1,
                      "y": 1.8,
                      "z": 0
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.3,
                      "y": 3.6,
                      "z": 6.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000f",
                  "_$type": "Sprite3D",
                  "name": "FrontWall_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.05,
                      "y": 1.8,
                      "z": 3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 3.6,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000g",
                  "_$type": "Sprite3D",
                  "name": "FrontWall_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.05,
                      "y": 1.8,
                      "z": 3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 3.6,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000h",
                  "_$type": "Sprite3D",
                  "name": "DoorLintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 3,
                      "z": 3.1
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.7,
                      "y": 1.2,
                      "z": 0.3
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000i",
                  "_$type": "Sprite3D",
                  "name": "FlatRoof",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0,
                      "y": 3.75,
                      "z": 0
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 7,
                      "y": 0.3,
                      "z": 7
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "7fe90ace-ddda-481b-99d5-25ae24500214",
                          "_$type": "Material"
                        }
                      ]
                    },
                    {
                      "_$type": "PhysicsCollider",
                      "collisionGroup": 1,
                      "canCollideWith": -1,
                      "colliderShape": {
                        "_$type": "BoxColliderShape",
                        "size": {
                          "_$type": "Vector3",
                          "x": 1,
                          "y": 1,
                          "z": 1
                        }
                      }
                    }
                  ]
                },
                {
                  "_$id": "bld0000j",
                  "_$type": "Sprite3D",
                  "name": "ClosedWindow_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.05,
                      "y": 2.2,
                      "z": 3.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.8,
                      "y": 0.7,
                      "z": 0.04
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "bld0000k",
                  "_$type": "Sprite3D",
                  "name": "ClosedWindow_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.05,
                      "y": 2.2,
                      "z": 3.28
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.8,
                      "y": 0.7,
                      "z": 0.04
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                        "_$type": "Mesh"
                      }
                    },
                    {
                      "_$type": "MeshRenderer",
                      "receiveShadow": true,
                      "castShadow": true,
                      "sharedMaterials": [
                        {
                          "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "bld0000l",
              "_$type": "Sprite3D",
              "name": "CoverWall_West",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -3.8,
                  "y": 1.4,
                  "z": -7
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 5,
                  "y": 2.8,
                  "z": 0.45
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 1,
                  "canCollideWith": -1,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "bld0000m",
              "_$type": "Sprite3D",
              "name": "CoverWall_East",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 3.8,
                  "y": 1.4,
                  "z": -10
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 5,
                  "y": 2.8,
                  "z": 0.45
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 1,
                  "canCollideWith": -1,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            }
          ]
        },
        {
          "_$id": "enemy002",
          "_$type": "Sprite3D",
          "name": "敌军02",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": -4,
              "y": 0,
              "z": -13
            }
          },
          "_$comp": [
            {
              "_$type": "84bdb250-9790-429d-9b97-68d328d7e6f6",
              "scriptPath": "../src/EnemyAI.ts",
              "player": {
                "_$ref": "player01"
              },
              "maxHealth": 100,
              "sightRange": 26,
              "fieldOfView": 120,
              "alertTime": 1.6,
              "loseTargetTime": 2.2,
              "attackInterval": 0.9,
              "patrolSpeed": 0.75
            }
          ],
          "_$child": [
            {
              "_$id": "e2part00",
              "_$type": "Sprite3D",
              "name": "Head",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 2.3,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.55,
                  "y": 0.5,
                  "z": 0.45
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e2part01",
              "_$type": "Sprite3D",
              "name": "Torso",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 1,
                  "z": 0.4
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e2part02",
              "_$type": "Sprite3D",
              "name": "Legs",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 0.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7,
                  "y": 1,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e2part03",
              "_$type": "Sprite3D",
              "name": "LeftArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "e2part04",
              "_$type": "Sprite3D",
              "name": "RightArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "e2part05",
              "_$type": "Sprite3D",
              "name": "EnemyRifle",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.23,
                  "y": 1.34,
                  "z": 0.55
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.14,
                  "y": 0.14,
                  "z": 0.82
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "enemy003",
          "_$type": "Sprite3D",
          "name": "敌军03",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 4,
              "y": 0,
              "z": -19
            }
          },
          "_$comp": [
            {
              "_$type": "84bdb250-9790-429d-9b97-68d328d7e6f6",
              "scriptPath": "../src/EnemyAI.ts",
              "player": {
                "_$ref": "player01"
              },
              "maxHealth": 100,
              "sightRange": 26,
              "fieldOfView": 120,
              "alertTime": 1.6,
              "loseTargetTime": 2.2,
              "attackInterval": 0.9,
              "patrolSpeed": 0.75
            }
          ],
          "_$child": [
            {
              "_$id": "e3part00",
              "_$type": "Sprite3D",
              "name": "Head",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 2.3,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.55,
                  "y": 0.5,
                  "z": 0.45
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e3part01",
              "_$type": "Sprite3D",
              "name": "Torso",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 1,
                  "z": 0.4
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e3part02",
              "_$type": "Sprite3D",
              "name": "Legs",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 0.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7,
                  "y": 1,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e3part03",
              "_$type": "Sprite3D",
              "name": "LeftArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "e3part04",
              "_$type": "Sprite3D",
              "name": "RightArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "e3part05",
              "_$type": "Sprite3D",
              "name": "EnemyRifle",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.23,
                  "y": 1.34,
                  "z": 0.55
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.14,
                  "y": 0.14,
                  "z": 0.82
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "enemy004",
          "_$type": "Sprite3D",
          "name": "敌军04",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 0,
              "y": 0,
              "z": -25
            }
          },
          "_$comp": [
            {
              "_$type": "84bdb250-9790-429d-9b97-68d328d7e6f6",
              "scriptPath": "../src/EnemyAI.ts",
              "player": {
                "_$ref": "player01"
              },
              "maxHealth": 100,
              "sightRange": 26,
              "fieldOfView": 120,
              "alertTime": 1.6,
              "loseTargetTime": 2.2,
              "attackInterval": 0.9,
              "patrolSpeed": 0.75
            }
          ],
          "_$child": [
            {
              "_$id": "e4part00",
              "_$type": "Sprite3D",
              "name": "Head",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 2.3,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.55,
                  "y": 0.5,
                  "z": 0.45
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e4part01",
              "_$type": "Sprite3D",
              "name": "Torso",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 1,
                  "z": 0.4
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e4part02",
              "_$type": "Sprite3D",
              "name": "Legs",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 0.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7,
                  "y": 1,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "receiveShadow": true,
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  },
                  "collisionGroup": 64
                }
              ]
            },
            {
              "_$id": "e4part03",
              "_$type": "Sprite3D",
              "name": "LeftArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "e4part04",
              "_$type": "Sprite3D",
              "name": "RightArm",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.64,
                  "y": 1.5,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.26,
                  "y": 0.82,
                  "z": 0.36
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ]
                },
                {
                  "_$type": "PhysicsCollider",
                  "collisionGroup": 64,
                  "colliderShape": {
                    "_$type": "BoxColliderShape",
                    "size": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "e4part05",
              "_$type": "Sprite3D",
              "name": "EnemyRifle",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.23,
                  "y": 1.34,
                  "z": 0.55
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.14,
                  "y": 0.14,
                  "z": 0.82
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "castShadow": true,
                  "sharedMaterials": [
                    {
                      "_$uuid": "95028424-d9df-40ec-ac59-1cae75f21ee8",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "exitzone1",
          "_$type": "Sprite3D",
          "name": "ExitZone",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 0,
              "y": 1,
              "z": -31
            }
          },
          "_$child": [
            {
              "_$id": "exitfloor",
              "_$type": "Sprite3D",
              "name": "ExitFloor",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": -0.97,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 5,
                  "y": 0.05,
                  "z": 5
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "sharedMaterials": [
                    {
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "exitpostl",
              "_$type": "Sprite3D",
              "name": "ExitPostLeft",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -2.4,
                  "y": 0.75,
                  "z": -2.25
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.2,
                  "y": 3.5,
                  "z": 0.2
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "sharedMaterials": [
                    {
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "exitpostr",
              "_$type": "Sprite3D",
              "name": "ExitPostRight",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 2.4,
                  "y": 0.75,
                  "z": -2.25
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.2,
                  "y": 3.5,
                  "z": 0.2
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "sharedMaterials": [
                    {
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "exitbeam",
              "_$type": "Sprite3D",
              "name": "ExitBeam",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 2.6,
                  "z": -2.25
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 5,
                  "y": 0.2,
                  "z": 0.2
                }
              },
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "6e013e32-fec7-4397-80d1-f918a07607be",
                    "_$type": "Mesh"
                  }
                },
                {
                  "_$type": "MeshRenderer",
                  "sharedMaterials": [
                    {
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "_$id": "help0001",
      "_$type": "GTextField",
      "name": "Controls",
      "x": 24,
      "y": 22,
      "width": 1250,
      "height": 80,
      "text": "WASD 移动 · 鼠标转向 · 1 枪/3 刀 · 左键射击/轻击 · 右键开镜/重击 · R 换弹 · Space 跳跃 · Shift 疾跑 · C 下蹲 · Esc 释放",
      "font": "Microsoft YaHei",
      "fontSize": 17,
      "color": "#ffffff",
      "letterSpacing": 0,
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "status01",
      "_$type": "GTextField",
      "name": "PlayerStatus",
      "x": 24,
      "y": 65,
      "width": 1100,
      "height": 80,
      "text": "站立",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "letterSpacing": 0,
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "ammo0001",
      "_$type": "GTextField",
      "name": "AmmoStatus",
      "x": 24,
      "y": 135,
      "width": 500,
      "height": 36,
      "text": "步枪  40 / 99999   ·   R 换弹",
      "font": "Microsoft YaHei",
      "fontSize": 19,
      "color": "#ffffff",
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "targethud",
      "_$type": "GTextField",
      "name": "RemainingEnemies",
      "x": 24,
      "y": 169,
      "width": 630,
      "height": 36,
      "text": "剩余敌人  4 / 4",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "cross001",
      "_$type": "GTextField",
      "name": "Crosshair",
      "x": 650,
      "y": 355,
      "width": 40,
      "height": 40,
      "text": "+",
      "font": "Microsoft YaHei",
      "fontSize": 34,
      "color": "#ffffff",
      "align": "center",
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "playerhp1",
      "_$type": "GTextField",
      "name": "PlayerHealth",
      "x": 24,
      "y": 205,
      "width": 800,
      "height": 36,
      "text": "生命  100 / 100 HP",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "objective1",
      "_$type": "GTextField",
      "name": "Objective",
      "x": 24,
      "y": 241,
      "width": 1150,
      "height": 36,
      "_mouseState": 1,
      "text": "目标：清除全部敌人，再进入通道尽头的橙色终点区",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "hitinfo1",
      "_$type": "GTextField",
      "name": "HitFeedback",
      "x": 24,
      "y": 277,
      "width": 1100,
      "height": 36,
      "_mouseState": 1,
      "text": "",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "resultpanel",
      "_$type": "GBox",
      "name": "ResultPanel",
      "width": 1334,
      "height": 750,
      "visible": false,
      "_mouseState": 2,
      "zIndex": 100,
      "background": {
        "_$type": "DrawRectCmd",
        "x": 0,
        "y": 0,
        "width": 1,
        "height": 1,
        "percent": true,
        "fillColor": "#101925"
      },
      "_$child": [
        {
          "_$id": "resulttitle",
          "_$type": "GTextField",
          "name": "ResultTitle",
          "x": 307,
          "y": 245,
          "width": 720,
          "height": 64,
          "_mouseState": 1,
          "text": "任务完成",
          "font": "Microsoft YaHei",
          "fontSize": 44,
          "color": "#ffffff",
          "bold": true,
          "align": "center",
          "valign": "middle",
          "strokeColor": "#20332c",
          "stroke": 0
        },
        {
          "_$id": "resultdetail",
          "_$type": "GTextField",
          "name": "ResultDetail",
          "x": 307,
          "y": 323,
          "width": 720,
          "height": 72,
          "_mouseState": 1,
          "text": "",
          "font": "Microsoft YaHei",
          "fontSize": 20,
          "color": "#ffffff",
          "align": "center",
          "valign": "middle",
          "wordWrap": true,
          "leading": 10,
          "strokeColor": "#20332c",
          "stroke": 0
        },
        {
          "_$id": "restartbtn",
          "_$type": "GButton",
          "name": "RestartButton",
          "x": 547,
          "y": 413,
          "width": 240,
          "height": 60,
          "_mouseState": 2,
          "background": {
            "_$type": "DrawRectCmd",
            "x": 0,
            "y": 0,
            "width": 1,
            "height": 1,
            "percent": true,
            "fillColor": "#e7a742"
          },
          "title": "重新开始",
          "titleWidget": {
            "_$ref": "restartlabel"
          },
          "downEffect": 1,
          "_$child": [
            {
              "_$id": "restartlabel",
              "_$type": "GTextField",
              "name": "RestartLabel",
              "width": 240,
              "height": 60,
              "_mouseState": 1,
              "text": "重新开始",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#142132",
              "bold": true,
              "align": "center",
              "valign": "middle",
              "strokeColor": "#20332c",
              "x": 0,
              "y": 0,
              "stroke": 0
            }
          ],
          "mouseThrough": false
        }
      ],
      "mouseThrough": false
    }
  ]
}
