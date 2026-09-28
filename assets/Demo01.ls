{
  "_$ver": 1,
  "_$id": "er2lfkwr",
  "_$type": "Scene",
  "left": 0,
  "right": 0,
  "top": 0,
  "bottom": 0,
  "name": "Demo01",
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
        "x": 1.3,
        "y": 2,
        "z": 1
      },
      "combatObjective": "目标：清除街口与院落的敌人，穿过目标建筑抵达终点",
      "restartScene": "Demo01.ls",
      "routePoints": [
        {
          "_$ref": "d1wp0"
        },
        {
          "_$ref": "d1wp1"
        },
        {
          "_$ref": "d1wp2"
        },
        {
          "_$ref": "d1wp3"
        },
        {
          "_$ref": "d1wp4"
        },
        {
          "_$ref": "d1wp5"
        },
        {
          "_$ref": "d1wp6"
        }
      ],
      "routeText": {
        "_$ref": "d1routehud"
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
      },
      "continueButton": {
        "_$ref": "sessionbtn"
      },
      "settingsButton": {
        "_$ref": "settingsbtn"
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
      "playerFlash": {
        "_$ref": "flashply"
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
      "enemyFlashes": [
        {
          "_$ref": "flashen1"
        },
        {
          "_$ref": "flashen2"
        },
        {
          "_$ref": "flashen3"
        },
        {
          "_$ref": "flashen4"
        }
      ],
      "playerShotSound": "res://1fdcce3c-8fd4-4804-a490-220ff795e9d5",
      "enemyShotSound": "res://cb88da38-7519-4806-b36c-afb1fc55a89c",
      "playerVolume": 0.3,
      "enemyVolume": 0.22,
      "flashSeconds": 0.045,
      "damageEdges": {
        "_$ref": "damageedge"
      },
      "damageDirection": {
        "_$ref": "damagedir"
      },
      "damageEdgeOpacity": 0.2,
      "damageSeconds": 0.35,
      "directionSeconds": 0.7
    },
    {
      "_$type": "a836d26b-dc06-4b1c-babe-2e5d7ab93e46",
      "scriptPath": "../src/SettingsController.ts",
      "player": {
        "_$ref": "player01"
      },
      "settingsButton": {
        "_$ref": "settingsbtn"
      },
      "settingsPanel": {
        "_$ref": "settingspanel"
      },
      "settingsCard": {
        "_$ref": "settingscard"
      },
      "volumeSlider": {
        "_$ref": "volumeslider"
      },
      "sensitivitySlider": {
        "_$ref": "sensitivityslider"
      },
      "volumeText": {
        "_$ref": "volumelabel"
      },
      "sensitivityText": {
        "_$ref": "sensitivitylabel"
      },
      "backButton": {
        "_$ref": "settingsback"
      },
      "resetButton": {
        "_$ref": "settingsreset"
      }
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
              "x": -10,
              "y": 1.65,
              "z": 4
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
          }
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
          "name": "Demo01_Ground_32x74",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "y": -0.5,
              "z": -27
            },
            "localScale": {
              "_$type": "Vector3",
              "x": 32,
              "y": 1,
              "z": 74
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
          "name": "RouteFloorMarkers",
          "_$child": [
            {
              "_$id": "d1b0043",
              "_$type": "Sprite3D",
              "name": "RouteDash_1_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "y": 0.025,
                  "z": 3.2
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0044",
              "_$type": "Sprite3D",
              "name": "RouteDash_1_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "y": 0.025,
                  "z": 1.2000000000000002
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0045",
              "_$type": "Sprite3D",
              "name": "RouteDash_1_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "y": 0.025,
                  "z": -0.7999999999999998
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0046",
              "_$type": "Sprite3D",
              "name": "RouteDash_1_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "y": 0.025,
                  "z": -2.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0047",
              "_$type": "Sprite3D",
              "name": "RouteDash_1_9",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "y": 0.025,
                  "z": -4.800000000000001
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0048",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -9.2,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0049",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -7.2,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0050",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -5.2,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0051",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -3.2,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0052",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_9",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -1.1999999999999993,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0053",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_11",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.8000000000000007,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0054",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_13",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 2.8000000000000007,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0055",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 4.800000000000001,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0056",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_17",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 6.800000000000001,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0057",
              "_$type": "Sprite3D",
              "name": "RouteDash_2_19",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 8.8,
                  "y": 0.025,
                  "z": -6
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0058",
              "_$type": "Sprite3D",
              "name": "RouteDash_3_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -6.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0059",
              "_$type": "Sprite3D",
              "name": "RouteDash_3_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -8.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0060",
              "_$type": "Sprite3D",
              "name": "RouteDash_3_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -10.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0061",
              "_$type": "Sprite3D",
              "name": "RouteDash_4_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -12.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0062",
              "_$type": "Sprite3D",
              "name": "RouteDash_4_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -14.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0063",
              "_$type": "Sprite3D",
              "name": "RouteDash_4_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -16.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0064",
              "_$type": "Sprite3D",
              "name": "RouteDash_4_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -18.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0065",
              "_$type": "Sprite3D",
              "name": "RouteDash_4_9",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -20.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0066",
              "_$type": "Sprite3D",
              "name": "RouteDash_4_11",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "y": 0.025,
                  "z": -22.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0067",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 8.2,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0068",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 6.2,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0069",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 4.2,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0070",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 2.2,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0071",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_9",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0.1999999999999993,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0072",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_11",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -1.8000000000000007,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0073",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_13",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -3.8000000000000007,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0074",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -5.800000000000001,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0075",
              "_$type": "Sprite3D",
              "name": "RouteDash_5_17",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -7.800000000000001,
                  "y": 0.025,
                  "z": -24.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0076",
              "_$type": "Sprite3D",
              "name": "RouteDash_6_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -9,
                  "y": 0.025,
                  "z": -25.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0077",
              "_$type": "Sprite3D",
              "name": "RouteDash_6_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -9,
                  "y": 0.025,
                  "z": -27.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0078",
              "_$type": "Sprite3D",
              "name": "RouteDash_6_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -9,
                  "y": 0.025,
                  "z": -29.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0079",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -8.2,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0080",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -6.2,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0081",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -4.2,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0082",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -2.2,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0083",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_9",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -0.1999999999999993,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0084",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_11",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 1.8000000000000007,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0085",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_13",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 3.8000000000000007,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0086",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_15",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 5.800000000000001,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0087",
              "_$type": "Sprite3D",
              "name": "RouteDash_7_17",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 7.800000000000001,
                  "y": 0.025,
                  "z": -30
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0088",
              "_$type": "Sprite3D",
              "name": "RouteDash_8_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 8.5,
                  "y": 0.025,
                  "z": -30.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0089",
              "_$type": "Sprite3D",
              "name": "RouteDash_8_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 8.5,
                  "y": 0.025,
                  "z": -32.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0090",
              "_$type": "Sprite3D",
              "name": "RouteDash_8_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 8.5,
                  "y": 0.025,
                  "z": -34.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0091",
              "_$type": "Sprite3D",
              "name": "RouteDash_9_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 7.7,
                  "y": 0.025,
                  "z": -35.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0092",
              "_$type": "Sprite3D",
              "name": "RouteDash_9_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 5.7,
                  "y": 0.025,
                  "z": -35.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0093",
              "_$type": "Sprite3D",
              "name": "RouteDash_9_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 3.7,
                  "y": 0.025,
                  "z": -35.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0094",
              "_$type": "Sprite3D",
              "name": "RouteDash_9_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 1.7000000000000002,
                  "y": 0.025,
                  "z": -35.5
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.95,
                  "y": 0.018,
                  "z": 0.18
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0095",
              "_$type": "Sprite3D",
              "name": "RouteDash_10_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -36.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0096",
              "_$type": "Sprite3D",
              "name": "RouteDash_10_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -38.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0097",
              "_$type": "Sprite3D",
              "name": "RouteDash_11_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -40.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0098",
              "_$type": "Sprite3D",
              "name": "RouteDash_11_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -42.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0099",
              "_$type": "Sprite3D",
              "name": "RouteDash_11_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -44.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0100",
              "_$type": "Sprite3D",
              "name": "RouteDash_11_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -46.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0101",
              "_$type": "Sprite3D",
              "name": "RouteDash_12_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -48.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0102",
              "_$type": "Sprite3D",
              "name": "RouteDash_12_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -50.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0103",
              "_$type": "Sprite3D",
              "name": "RouteDash_12_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -52.3
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0104",
              "_$type": "Sprite3D",
              "name": "RouteDash_13_1",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -53.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0105",
              "_$type": "Sprite3D",
              "name": "RouteDash_13_3",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -55.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0106",
              "_$type": "Sprite3D",
              "name": "RouteDash_13_5",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -57.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0107",
              "_$type": "Sprite3D",
              "name": "RouteDash_13_7",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 0.025,
                  "z": -59.8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.18,
                  "y": 0.018,
                  "z": 0.95
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
          "_$id": "player01",
          "_$type": "Sprite3D",
          "name": "Player",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": -10,
              "y": 1.1,
              "z": 4
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
              "aimWalkSpeed": 1.5,
              "jumpSpeed": 7,
              "mouseSensitivity": 0.18,
              "body": {
                "_$ref": "body0001"
              },
              "followCamera": {
                "_$ref": "6jx8h8bvc6"
              },
              "weaponPivot": {
                "_$ref": "weapon01"
              },
              "statusText": {
                "_$ref": "status01"
              },
              "spawnPoint": {
                "_$ref": "d1spawn"
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
              "hitText": {
                "_$ref": "hitinfo1"
              },
              "magazineSize": 5,
              "startingReserve": 45,
              "roundsPerMinute": 45,
              "reloadSeconds": 3.3,
              "baseDamage": 70,
              "hipRecoil": 1.35,
              "aimRecoil": 1.8,
              "hipCrosshairRecoil": 0.45,
              "horizontalRecoil": 0.12,
              "recoilDistance": 0.1,
              "recoilReturnSpeed": 0.32
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
              "_$prefab": "f6f03925-bff1-4d9f-80e3-fec7071c2e49",
              "name": "PlayerVisual",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": -1,
                  "z": 0.28
                },
                "localRotation": {
                  "_$type": "Quaternion",
                  "y": 1,
                  "w": 0
                }
              }
            }
          ]
        },
        {
          "_$id": "target001",
          "_$type": "Sprite3D",
          "name": "Street_Enemy01",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": -4,
              "z": -20
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
              "attackInterval": 1.8,
              "shotDamage": 18,
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
                  "x": 0.0012460872530937195,
                  "y": 2.295872211456299,
                  "z": -0.00436006486415863
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.3651001453399658,
                  "y": 0.5382564067840576,
                  "z": 0.4485637843608856
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.008097410202026367,
                  "y": 1.661618709564209,
                  "z": 2.9802322387695312e-8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.5905764102935791,
                  "y": 0.6980665922164917,
                  "z": 0.5021299719810486
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.031143292784690857,
                  "y": 0.656292736530304,
                  "z": 0.008097238838672638
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7886468172073364,
                  "y": 1.312585473060608,
                  "z": 0.48344409465789795
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1789216697216034,
                  "y": 1.9041393995285034,
                  "z": 0.16167497634887695
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.4582168459892273,
                  "y": 0.5020344257354736,
                  "z": 0.753227710723877
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": -0.12187999486923218,
                  "y": 1.8488967418670654,
                  "z": 0.019862256944179535
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.46084141731262207,
                  "y": 0.6116403341293335,
                  "z": 0.48704248666763306
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1,
                  "y": 1.7,
                  "z": 0.26
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
                  "enabled": false,
                  "castShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
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
                  "_$id": "flashen1",
                  "_$type": "Sprite3D",
                  "name": "EnemyMuzzleFlash",
                  "active": false,
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  },
                  "_$child": [
                    {
                      "_$id": "flashen1h",
                      "_$type": "Sprite3D",
                      "name": "flashen1h",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 2,
                          "y": 0.35,
                          "z": 0.24
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen1v",
                      "_$type": "Sprite3D",
                      "name": "flashen1v",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.35,
                          "y": 2,
                          "z": 0.18
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen1c",
                      "_$type": "Sprite3D",
                      "name": "flashen1c",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.8,
                          "y": 0.8,
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "gunvisual0",
                  "_$prefab": "699cea16-d3a0-4cc4-af01-d56bbd95d4ab",
                  "name": "EnemyProvidedRifle",
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 0,
                      "z": 0
                    },
                    "localRotationEuler": {
                      "x": 0,
                      "y": 180,
                      "z": 0
                    },
                    "localScale": {
                      "x": 7.142857142857142,
                      "y": 7.142857142857142,
                      "z": 1.2195121951219512
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual1",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
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
              "x": -10,
              "y": 1.65,
              "z": 4
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
                  "enabled": false,
                  "receiveShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
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
                      "enabled": false,
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
                },
                {
                  "_$id": "sightbot",
                  "_$type": "Sprite3D",
                  "name": "SightBottom",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
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
                      "enabled": false,
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
                      "enabled": false,
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
                      "enabled": false,
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
                },
                {
                  "_$id": "sightdot",
                  "_$type": "Sprite3D",
                  "name": "RedDot",
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 1,
                      "z": 0.15238095238095237
                    },
                    "localScale": {
                      "x": 0.025,
                      "y": 0.022222222222222223,
                      "z": 0.0038095238095238095
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
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "flashply",
                  "_$type": "Sprite3D",
                  "name": "PlayerMuzzleFlash",
                  "active": false,
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 0.7777777777777779,
                      "z": -0.5142857142857143
                    }
                  },
                  "_$child": [
                    {
                      "_$id": "flashplyh",
                      "_$type": "Sprite3D",
                      "name": "flashplyh",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 1.1,
                          "y": 0.18,
                          "z": 0.22
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashplyv",
                      "_$type": "Sprite3D",
                      "name": "flashplyv",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.2,
                          "y": 1.2,
                          "z": 0.16
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashplyc",
                      "_$type": "Sprite3D",
                      "name": "flashplyc",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.55,
                          "y": 0.5,
                          "z": 0.28
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "gunvisual1",
                  "_$prefab": "699cea16-d3a0-4cc4-af01-d56bbd95d4ab",
                  "name": "PlayerProvidedRifle",
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 0,
                      "z": 0
                    },
                    "localRotationEuler": {
                      "x": 0,
                      "y": 0,
                      "z": 0
                    },
                    "localScale": {
                      "x": 6.25,
                      "y": 5.555555555555555,
                      "z": 0.9523809523809523
                    }
                  }
                }
              ]
            }
          ]
        },
        {
          "_$id": "bld00000",
          "_$type": "Sprite3D",
          "name": "Demo01_Blockout",
          "_$child": [
            {
              "_$id": "d1bounds",
              "_$type": "Sprite3D",
              "name": "00_Bounds_Closed",
              "_$child": [
                {
                  "_$id": "d1b0001",
                  "_$type": "Sprite3D",
                  "name": "Boundary_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -14,
                      "y": 3,
                      "z": -27
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.6,
                      "y": 6,
                      "z": 70.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0002",
                  "_$type": "Sprite3D",
                  "name": "Boundary_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 14,
                      "y": 3,
                      "z": -27
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.6,
                      "y": 6,
                      "z": 70.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0003",
                  "_$type": "Sprite3D",
                  "name": "Boundary_South",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3,
                      "z": 8
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 28.6,
                      "y": 6,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0004",
                  "_$type": "Sprite3D",
                  "name": "Boundary_North",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3,
                      "z": -62
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 28.6,
                      "y": 6,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                }
              ]
            },
            {
              "_$id": "d1safe",
              "_$type": "Sprite3D",
              "name": "01_SafeSpawn",
              "_$child": [
                {
                  "_$id": "d1b0005",
                  "_$type": "Sprite3D",
                  "name": "Spawn_Alley_BuildingMass",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 3,
                      "z": 2
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 20,
                      "y": 6,
                      "z": 12
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0006",
                  "_$type": "Sprite3D",
                  "name": "SpawnFloor",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -10,
                      "y": 0.008,
                      "z": 4
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 0.016,
                      "z": 3
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
                      "enabled": false,
                      "receiveShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "7fe90ace-ddda-481b-99d5-25ae24500214",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1alley",
              "_$type": "Sprite3D",
              "name": "02_CornerAlley",
              "_$child": [
                {
                  "_$id": "d1b0007",
                  "_$type": "Sprite3D",
                  "name": "Alley_StreetDoor_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 2.9,
                      "z": -9
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 21,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0008",
                  "_$type": "Sprite3D",
                  "name": "Alley_StreetDoor_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 2.9,
                      "z": -9
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0009",
                  "_$type": "Sprite3D",
                  "name": "Alley_StreetDoor_Lintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9,
                      "y": 4.5,
                      "z": -9
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 2.5999999999999996,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                }
              ]
            },
            {
              "_$id": "d1street",
              "_$type": "Sprite3D",
              "name": "03_StreetFight",
              "_$child": [
                {
                  "_$id": "d1b0010",
                  "_$type": "Sprite3D",
                  "name": "StreetSurface",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 0.006,
                      "z": -18
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 27.3,
                      "y": 0.012,
                      "z": 17
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
                      "enabled": false,
                      "receiveShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
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
                  "_$id": "d1b0011",
                  "_$type": "Sprite3D",
                  "name": "Street_EastBuilding",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 2.4,
                      "z": -17.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 4.8,
                      "z": 9
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0012",
                  "_$type": "Sprite3D",
                  "name": "Street_WestBuilding",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 2.4,
                      "z": -22
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 4.8,
                      "z": 6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0013",
                  "_$type": "Sprite3D",
                  "name": "Street_LowCover_Crouch",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.5,
                      "y": 0.45,
                      "z": -14
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 0.9,
                      "z": 0.8
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0014",
                  "_$type": "Sprite3D",
                  "name": "Street_HighCover",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1.3,
                      "z": -15
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 2.6,
                      "z": 0.8
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0015",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftLowCover",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 0.55,
                      "z": -16
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 1.1,
                      "z": 1
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0016",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftExit_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 2.9,
                      "z": -27
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0017",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftExit_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 2.9,
                      "z": -27
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 21,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0018",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftExit_Lintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -9,
                      "y": 4.5,
                      "z": -27
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 2.5999999999999996,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                }
              ]
            },
            {
              "_$id": "d1transition",
              "_$type": "Sprite3D",
              "name": "04_CoverTransition",
              "_$child": [
                {
                  "_$id": "d1b0019",
                  "_$type": "Sprite3D",
                  "name": "Transition_RightTurn_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 2.9,
                      "z": -32.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 20,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0020",
                  "_$type": "Sprite3D",
                  "name": "Transition_RightTurn_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 2.9,
                      "z": -32.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0021",
                  "_$type": "Sprite3D",
                  "name": "Transition_RightTurn_Lintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.5,
                      "y": 4.5,
                      "z": -32.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 5,
                      "y": 2.5999999999999996,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0022",
                  "_$type": "Sprite3D",
                  "name": "Transition_CourtyardDoor_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 2.9,
                      "z": -38.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 12,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0023",
                  "_$type": "Sprite3D",
                  "name": "Transition_CourtyardDoor_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8,
                      "y": 2.9,
                      "z": -38.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 12,
                      "y": 5.8,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0024",
                  "_$type": "Sprite3D",
                  "name": "Transition_CourtyardDoor_Lintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 4.5,
                      "z": -38.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 2.5999999999999996,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0025",
                  "_$type": "Sprite3D",
                  "name": "Transition_ReloadCover",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3,
                      "y": 0.6,
                      "z": -28.7
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2,
                      "y": 1.2,
                      "z": 1
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0026",
                  "_$type": "Sprite3D",
                  "name": "Transition_ApproachCover",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 5,
                      "y": 0.6,
                      "z": -36.9
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2,
                      "y": 1.2,
                      "z": 1
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                }
              ]
            },
            {
              "_$id": "d1courtyard",
              "_$type": "Sprite3D",
              "name": "05_Courtyard",
              "_$child": [
                {
                  "_$id": "d1b0027",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_LeftHighCover",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 1.3,
                      "z": -41.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 2.6,
                      "z": 0.8
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0028",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_RightLowCover_Crouch",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 0.45,
                      "z": -43
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3,
                      "y": 0.9,
                      "z": 1
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0029",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_WestCover",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11,
                      "y": 1.4,
                      "z": -47
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 2.8,
                      "z": 1
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0030",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_NorthWingWest",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -9.25,
                      "y": 3,
                      "z": -50
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 9.5,
                      "y": 6,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0031",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_NorthWingEast",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9.25,
                      "y": 3,
                      "z": -50
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 9.5,
                      "y": 6,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                }
              ]
            },
            {
              "_$id": "d1building",
              "_$type": "Sprite3D",
              "name": "06_TargetBuilding",
              "_$child": [
                {
                  "_$id": "d1b0032",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_FrontDoor_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.85,
                      "y": 2.2,
                      "z": -50
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3.3,
                      "y": 4.4,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0033",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_FrontDoor_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.85,
                      "y": 2.2,
                      "z": -50
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3.3,
                      "y": 4.4,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0034",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_FrontDoor_Lintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.6,
                      "z": -50
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 1.6000000000000005,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0035",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_RearDoor_Left",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.85,
                      "y": 2.2,
                      "z": -58.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3.3,
                      "y": 4.4,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0036",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_RearDoor_Right",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.85,
                      "y": 2.2,
                      "z": -58.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 3.3,
                      "y": 4.4,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0037",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_RearDoor_Lintel",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.6,
                      "z": -58.5
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 1.6000000000000005,
                      "z": 0.6
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0038",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_WestWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.5,
                      "y": 2.2,
                      "z": -54.25
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.4,
                      "y": 4.4,
                      "z": 8.5
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0039",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_EastWall",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.5,
                      "y": 2.2,
                      "z": -54.25
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.4,
                      "y": 4.4,
                      "z": 8.5
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
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
                  "_$id": "d1b0040",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_Roof",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 4.55,
                      "z": -54.25
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 9.4,
                      "y": 0.3,
                      "z": 9.1
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "7fe90ace-ddda-481b-99d5-25ae24500214",
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
                  "_$id": "d1b0041",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_Storage",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.7,
                      "y": 0.6,
                      "z": -54
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.5,
                      "y": 1.2,
                      "z": 1.5
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "7fe90ace-ddda-481b-99d5-25ae24500214",
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
                  "_$id": "d1b0042",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_EntranceMark",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.1,
                      "z": -49.67
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 2.4,
                      "y": 0.25,
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
            }
          ]
        },
        {
          "_$id": "enemy002",
          "_$type": "Sprite3D",
          "name": "Street_Enemy02",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 5,
              "z": -23
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
              "attackInterval": 1.8,
              "shotDamage": 18,
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
                  "x": 0.0012460872530937195,
                  "y": 2.295872211456299,
                  "z": -0.00436006486415863
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.3651001453399658,
                  "y": 0.5382564067840576,
                  "z": 0.4485637843608856
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.008097410202026367,
                  "y": 1.661618709564209,
                  "z": 2.9802322387695312e-8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.5905764102935791,
                  "y": 0.6980665922164917,
                  "z": 0.5021299719810486
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.031143292784690857,
                  "y": 0.656292736530304,
                  "z": 0.008097238838672638
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7886468172073364,
                  "y": 1.312585473060608,
                  "z": 0.48344409465789795
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1789216697216034,
                  "y": 1.9041393995285034,
                  "z": 0.16167497634887695
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.4582168459892273,
                  "y": 0.5020344257354736,
                  "z": 0.753227710723877
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": -0.12187999486923218,
                  "y": 1.8488967418670654,
                  "z": 0.019862256944179535
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.46084141731262207,
                  "y": 0.6116403341293335,
                  "z": 0.48704248666763306
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1,
                  "y": 1.7,
                  "z": 0.26
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
                  "enabled": false,
                  "castShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
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
                  "_$id": "flashen2",
                  "_$type": "Sprite3D",
                  "name": "EnemyMuzzleFlash",
                  "active": false,
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  },
                  "_$child": [
                    {
                      "_$id": "flashen2h",
                      "_$type": "Sprite3D",
                      "name": "flashen2h",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 2,
                          "y": 0.35,
                          "z": 0.24
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen2v",
                      "_$type": "Sprite3D",
                      "name": "flashen2v",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.35,
                          "y": 2,
                          "z": 0.18
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen2c",
                      "_$type": "Sprite3D",
                      "name": "flashen2c",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.8,
                          "y": 0.8,
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "gunvisual2",
                  "_$prefab": "699cea16-d3a0-4cc4-af01-d56bbd95d4ab",
                  "name": "EnemyProvidedRifle",
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 0,
                      "z": 0
                    },
                    "localRotationEuler": {
                      "x": 0,
                      "y": 180,
                      "z": 0
                    },
                    "localScale": {
                      "x": 7.142857142857142,
                      "y": 7.142857142857142,
                      "z": 1.2195121951219512
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual2",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            }
          ]
        },
        {
          "_$id": "enemy003",
          "_$type": "Sprite3D",
          "name": "Courtyard_Enemy01",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": -6,
              "z": -45
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
              "attackInterval": 1.8,
              "shotDamage": 18,
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
                  "x": 0.0012460872530937195,
                  "y": 2.295872211456299,
                  "z": -0.00436006486415863
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.3651001453399658,
                  "y": 0.5382564067840576,
                  "z": 0.4485637843608856
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.008097410202026367,
                  "y": 1.661618709564209,
                  "z": 2.9802322387695312e-8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.5905764102935791,
                  "y": 0.6980665922164917,
                  "z": 0.5021299719810486
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.031143292784690857,
                  "y": 0.656292736530304,
                  "z": 0.008097238838672638
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7886468172073364,
                  "y": 1.312585473060608,
                  "z": 0.48344409465789795
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1789216697216034,
                  "y": 1.9041393995285034,
                  "z": 0.16167497634887695
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.4582168459892273,
                  "y": 0.5020344257354736,
                  "z": 0.753227710723877
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": -0.12187999486923218,
                  "y": 1.8488967418670654,
                  "z": 0.019862256944179535
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.46084141731262207,
                  "y": 0.6116403341293335,
                  "z": 0.48704248666763306
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1,
                  "y": 1.7,
                  "z": 0.26
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
                  "enabled": false,
                  "castShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
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
                  "_$id": "flashen3",
                  "_$type": "Sprite3D",
                  "name": "EnemyMuzzleFlash",
                  "active": false,
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  },
                  "_$child": [
                    {
                      "_$id": "flashen3h",
                      "_$type": "Sprite3D",
                      "name": "flashen3h",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 2,
                          "y": 0.35,
                          "z": 0.24
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen3v",
                      "_$type": "Sprite3D",
                      "name": "flashen3v",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.35,
                          "y": 2,
                          "z": 0.18
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen3c",
                      "_$type": "Sprite3D",
                      "name": "flashen3c",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.8,
                          "y": 0.8,
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "gunvisual3",
                  "_$prefab": "699cea16-d3a0-4cc4-af01-d56bbd95d4ab",
                  "name": "EnemyProvidedRifle",
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 0,
                      "z": 0
                    },
                    "localRotationEuler": {
                      "x": 0,
                      "y": 180,
                      "z": 0
                    },
                    "localScale": {
                      "x": 7.142857142857142,
                      "y": 7.142857142857142,
                      "z": 1.2195121951219512
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual3",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            }
          ]
        },
        {
          "_$id": "enemy004",
          "_$type": "Sprite3D",
          "name": "Courtyard_Enemy02",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": 6,
              "z": -48
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
              "attackInterval": 1.8,
              "shotDamage": 18,
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
                  "x": 0.0012460872530937195,
                  "y": 2.295872211456299,
                  "z": -0.00436006486415863
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.3651001453399658,
                  "y": 0.5382564067840576,
                  "z": 0.4485637843608856
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "a7732e8c-7c5c-4809-8405-fa82156b8a31",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.008097410202026367,
                  "y": 1.661618709564209,
                  "z": 2.9802322387695312e-8
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.5905764102935791,
                  "y": 0.6980665922164917,
                  "z": 0.5021299719810486
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "d6184b08-3009-49f7-b6b0-646787a302fa",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.031143292784690857,
                  "y": 0.656292736530304,
                  "z": 0.008097238838672638
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.7886468172073364,
                  "y": 1.312585473060608,
                  "z": 0.48344409465789795
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1789216697216034,
                  "y": 1.9041393995285034,
                  "z": 0.16167497634887695
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.4582168459892273,
                  "y": 0.5020344257354736,
                  "z": 0.753227710723877
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": -0.12187999486923218,
                  "y": 1.8488967418670654,
                  "z": 0.019862256944179535
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.46084141731262207,
                  "y": 0.6116403341293335,
                  "z": 0.48704248666763306
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
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
                  "sharedMaterials": [
                    {
                      "_$uuid": "484a7ebf-a01c-443f-bcce-3c33d6d2906a",
                      "_$type": "Material"
                    }
                  ],
                  "enabled": false
                },
                {
                  "_$type": "PhysicsCollider",
                  "colliderShape": {
                    "_$type": "BoxColliderShape"
                  },
                  "collisionGroup": 64,
                  "canCollideWith": -1
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
                  "x": 0.1,
                  "y": 1.7,
                  "z": 0.26
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
                  "enabled": false,
                  "castShadow": true,
                  "lightmapScaleOffset": {
                    "_$type": "Vector4"
                  },
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
                  "_$id": "flashen4",
                  "_$type": "Sprite3D",
                  "name": "EnemyMuzzleFlash",
                  "active": false,
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  },
                  "_$child": [
                    {
                      "_$id": "flashen4h",
                      "_$type": "Sprite3D",
                      "name": "flashen4h",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 2,
                          "y": 0.35,
                          "z": 0.24
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen4v",
                      "_$type": "Sprite3D",
                      "name": "flashen4v",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.35,
                          "y": 2,
                          "z": 0.18
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "_$id": "flashen4c",
                      "_$type": "Sprite3D",
                      "name": "flashen4c",
                      "transform": {
                        "localScale": {
                          "_$type": "Vector3",
                          "x": 0.8,
                          "y": 0.8,
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
                          "lightmapScaleOffset": {
                            "_$type": "Vector4"
                          },
                          "sharedMaterials": [
                            {
                              "_$uuid": "68ae5fed-e57b-4c26-a5c6-f70c77a90c3c",
                              "_$type": "Material"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "gunvisual4",
                  "_$prefab": "699cea16-d3a0-4cc4-af01-d56bbd95d4ab",
                  "name": "EnemyProvidedRifle",
                  "transform": {
                    "localPosition": {
                      "x": 0,
                      "y": 0,
                      "z": 0
                    },
                    "localRotationEuler": {
                      "x": 0,
                      "y": 180,
                      "z": 0
                    },
                    "localScale": {
                      "x": 7.142857142857142,
                      "y": 7.142857142857142,
                      "z": 1.2195121951219512
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual4",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            }
          ]
        },
        {
          "_$id": "exitzone1",
          "_$type": "Sprite3D",
          "name": "07_ExitZone",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "y": 1,
              "z": -60.2
            }
          },
          "_$child": [
            {
              "_$id": "d1b0108",
              "_$type": "Sprite3D",
              "name": "ExitFloor",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": -0.97
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 2.6,
                  "y": 0.05,
                  "z": 2
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0109",
              "_$type": "Sprite3D",
              "name": "ExitLeftPost",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -1.3,
                  "y": 0.2,
                  "z": -0.7
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.15,
                  "y": 2.4,
                  "z": 0.15
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0110",
              "_$type": "Sprite3D",
              "name": "ExitRightPost",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 1.3,
                  "y": 0.2,
                  "z": -0.7
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.15,
                  "y": 2.4,
                  "z": 0.15
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
                      "_$uuid": "ce7179c3-e784-4a36-9677-1618bba55c98",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "d1b0111",
              "_$type": "Sprite3D",
              "name": "ExitTopBar",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 1.45,
                  "z": -0.7
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 2.75,
                  "y": 0.15,
                  "z": 0.15
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
          "_$id": "d1spawn",
          "_$type": "Sprite3D",
          "name": "SpawnPoint_SafeZone",
          "transform": {
            "localPosition": {
              "_$type": "Vector3",
              "x": -10,
              "y": 1.1,
              "z": 4
            }
          }
        },
        {
          "_$id": "d1waypoints",
          "_$type": "Sprite3D",
          "name": "RouteHintPoints",
          "_$child": [
            {
              "_$id": "d1wp0",
              "_$type": "Sprite3D",
              "name": "沿橙色标线前行，到前方转角右转",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -10,
                  "z": -6
                }
              }
            },
            {
              "_$id": "d1wp1",
              "_$type": "Sprite3D",
              "name": "沿小巷向右，到尽头穿过街口门洞",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 9,
                  "z": -9
                }
              }
            },
            {
              "_$id": "d1wp2",
              "_$type": "Sprite3D",
              "name": "街口交火：处理两名敌人，从左前方门洞继续",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -9,
                  "z": -27
                }
              }
            },
            {
              "_$id": "d1wp3",
              "_$type": "Sprite3D",
              "name": "掩体过渡：沿隔墙右行，在尽头左转",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 8.5,
                  "z": -32.5
                }
              }
            },
            {
              "_$id": "d1wp4",
              "_$type": "Sprite3D",
              "name": "沿标线左转，穿过中央门洞进入院落",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "z": -38.5
                }
              }
            },
            {
              "_$id": "d1wp5",
              "_$type": "Sprite3D",
              "name": "院落交火：处理两名敌人，进入对面的目标建筑",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "z": -50
                }
              }
            },
            {
              "_$id": "d1wp6",
              "_$type": "Sprite3D",
              "name": "穿过建筑后门，清敌后进入橙色终点区",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "z": -60.2
                }
              }
            }
          ]
        },
        {
          "_$id": "oldtownart",
          "_$type": "Sprite3D",
          "name": "OldTownArt_SpawnToStreet",
          "_$child": [
            {
              "_$id": "otskins",
              "_$type": "Sprite3D",
              "name": "01_VisibleShells_KeepOriginalColliders",
              "_$child": [
                {
                  "_$id": "ot_d1b0001",
                  "_$type": "Sprite3D",
                  "name": "Boundary_West_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -14,
                      "y": 3,
                      "z": -9.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm3",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0002",
                  "_$type": "Sprite3D",
                  "name": "Boundary_East_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 14,
                      "y": 3,
                      "z": -9.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm4",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0003",
                  "_$type": "Sprite3D",
                  "name": "Boundary_South_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3,
                      "z": 8
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm5",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0005",
                  "_$type": "Sprite3D",
                  "name": "Spawn_Alley_BuildingMass_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 3,
                      "z": 2
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm6",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0007",
                  "_$type": "Sprite3D",
                  "name": "Alley_StreetDoor_Left_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 2.9,
                      "z": -9
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm7",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0008",
                  "_$type": "Sprite3D",
                  "name": "Alley_StreetDoor_Right_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 2.9,
                      "z": -9
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm8",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0009",
                  "_$type": "Sprite3D",
                  "name": "Alley_StreetDoor_Lintel_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9,
                      "y": 4.5,
                      "z": -9
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm9",
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
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0011",
                  "_$type": "Sprite3D",
                  "name": "Street_EastBuilding_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 2.4,
                      "z": -17.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm10",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0012",
                  "_$type": "Sprite3D",
                  "name": "Street_WestBuilding_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 2.4,
                      "z": -22
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm11",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0013",
                  "_$type": "Sprite3D",
                  "name": "Street_LowCover_Crouch_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.5,
                      "y": 0.45,
                      "z": -14
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm12",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0014",
                  "_$type": "Sprite3D",
                  "name": "Street_HighCover_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1.3,
                      "z": -15
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm13",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0015",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftLowCover_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 0.55,
                      "z": -16
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm14",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0016",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftExit_Left_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 2.9,
                      "z": -27
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm15",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0017",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftExit_Right_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 2.9,
                      "z": -27
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm16",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ot_d1b0018",
                  "_$type": "Sprite3D",
                  "name": "Street_LeftExit_Lintel_ArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -9,
                      "y": 4.5,
                      "z": -27
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm17",
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
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "otdetails",
              "_$type": "Sprite3D",
              "name": "02_SharedDoorWindowEavePrefabs",
              "_$child": [
                {
                  "_$id": "otmod0000",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": 6.075000000000001
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0001",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": 6.075000000000001
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0002",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 0.04,
                      "z": 1.625
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0003",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -2.8249999999999993
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0004",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -2.8249999999999993
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0005",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -7.275
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0006",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 0.04,
                      "z": -11.725000000000001
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0007",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -11.725000000000001
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0008",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -16.175
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0009",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -20.625
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0010",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -20.625
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0011",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 0.04,
                      "z": -25.075
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0012",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": 6.322222222222223
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0013",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": 2.366666666666667
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0014",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -1.5888888888888886
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0015",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -5.544444444444444
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0016",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -9.5
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0017",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -13.455555555555556
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0018",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -17.41111111111111
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0019",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -21.366666666666667
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0020",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -25.32222222222222
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0021",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -25.075000000000003
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0022",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -25.075000000000003
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0023",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 0.04,
                      "z": -20.625
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0024",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -16.175
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0025",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -16.175
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0026",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -11.725
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0027",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 0.04,
                      "z": -7.274999999999999
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0028",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -7.274999999999999
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0029",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -2.8249999999999993
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0030",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": 1.625
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0031",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": 1.625
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0032",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 0.04,
                      "z": 6.074999999999999
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0033",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -25.322222222222223
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0034",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -21.366666666666667
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0035",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -17.41111111111111
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0036",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -13.455555555555556
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0037",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -9.5
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0038",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -5.544444444444444
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0039",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -1.5888888888888886
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0040",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": 2.366666666666667
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0041",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": 6.322222222222219
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9888888888888889,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0042",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.5,
                      "y": 1.25,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0043",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.5,
                      "y": 3.62,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0044",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.5,
                      "y": 0.04,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0045",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.5,
                      "y": 1.25,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0046",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.5,
                      "y": 3.62,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0047",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 1.25,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0048",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12,
                      "y": 5.28,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0049",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8,
                      "y": 5.28,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0050",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 5.28,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0051",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 5.28,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0052",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 5.28,
                      "z": -4
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0053",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6,
                      "y": 1.25,
                      "z": -1
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0054",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0005_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6,
                      "y": 3.62,
                      "z": -1
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0055",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0005_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6,
                      "y": 0.04,
                      "z": 5
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0056",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6,
                      "y": 5.28,
                      "z": -2
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0057",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6,
                      "y": 5.28,
                      "z": 2
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0058",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0005_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6,
                      "y": 5.28,
                      "z": 6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0059",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.9,
                      "y": 1.25,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0060",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.9,
                      "y": 3.62,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0061",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -7.699999999999999,
                      "y": 0.04,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0062",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 1.25,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0063",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 3.62,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0064",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0.7000000000000011,
                      "y": 1.25,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0065",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.900000000000002,
                      "y": 0.04,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0066",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.900000000000002,
                      "y": 3.62,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0067",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.9,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0068",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -7.699999999999999,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0069",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0070",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0.7000000000000011,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0071",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.900000000000002,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0072",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.9,
                      "y": 1.25,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0073",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.9,
                      "y": 3.62,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0074",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0.6999999999999993,
                      "y": 0.04,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0075",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 1.25,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0076",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 3.62,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0077",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -7.700000000000001,
                      "y": 1.25,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0078",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.900000000000002,
                      "y": 0.04,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0079",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.900000000000002,
                      "y": 3.62,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0080",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.9,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0081",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 0.6999999999999993,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0082",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0083",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -7.700000000000001,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0084",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0007_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.900000000000002,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0085",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0008_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 1.25,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0086",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0008_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 3.62,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0087",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0008_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0088",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0008_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 1.25,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0089",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0008_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 3.62,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0090",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0008_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0091",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0009_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9,
                      "y": 3.62,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0092",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0009_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9,
                      "y": 5.08,
                      "z": -8.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0093",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0009_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9,
                      "y": 3.62,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0094",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0009_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9,
                      "y": 5.08,
                      "z": -9.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0095",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0011_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.3,
                      "y": 1.25,
                      "z": -19.75
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0096",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0011_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.3,
                      "y": 0.04,
                      "z": -15.25
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0097",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0011_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.3,
                      "y": 4.08,
                      "z": -19.75
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.125,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0098",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0011_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.3,
                      "y": 4.08,
                      "z": -15.25
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.125,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0099",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0012_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.3,
                      "y": 1.25,
                      "z": -22
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0100",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0012_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.3,
                      "y": 4.08,
                      "z": -20.5
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0101",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0012_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.3,
                      "y": 4.08,
                      "z": -23.5
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0102",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0016_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 1.25,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0103",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0016_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 3.62,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0104",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0016_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.5,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0105",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.9,
                      "y": 1.25,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0106",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.9,
                      "y": 3.62,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0107",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -0.6999999999999993,
                      "y": 0.04,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0108",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 1.25,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0109",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 3.62,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0110",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 7.700000000000001,
                      "y": 1.25,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0111",
                  "_$prefab": "bc14d1cd-39a4-4a42-a7ec-c900660011b7",
                  "name": "ClosedDoor_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.900000000000002,
                      "y": 0.04,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0112",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.900000000000002,
                      "y": 3.62,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0113",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.9,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0114",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -0.6999999999999993,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0115",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0116",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 7.700000000000001,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0117",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0017_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.900000000000002,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.05,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0118",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0018_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -9,
                      "y": 3.62,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otmod0119",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0018_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -9,
                      "y": 5.08,
                      "z": -26.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
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
              "_$id": "ottails",
              "_$type": "Sprite3D",
              "name": "03_OriginalGrayBoundaryContinuation",
              "_$child": [
                {
                  "_$id": "ottaild1b0001",
                  "_$type": "Sprite3D",
                  "name": "Boundary_West_OriginalGrayContinuation",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -14,
                      "y": 3,
                      "z": -44.8
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.6,
                      "y": 6,
                      "z": 35
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "ottaild1b0002",
                  "_$type": "Sprite3D",
                  "name": "Boundary_East_OriginalGrayContinuation",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 14,
                      "y": 3,
                      "z": -44.8
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.6,
                      "y": 6,
                      "z": 35
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
                      "enabled": false,
                      "receiveShadow": true,
                      "castShadow": true,
                      "lightmapScaleOffset": {
                        "_$type": "Vector4"
                      },
                      "sharedMaterials": [
                        {
                          "_$uuid": "5d8aa3ed-3796-4b14-bdc1-4f2afdb0096d",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "otpaving",
              "_$type": "Sprite3D",
              "name": "04_FrontPaving",
              "isStatic": true,
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "2ebf2d1a-4fc1-4f32-a039-029fe141d089@lm18",
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
                      "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "otrearart",
          "_$type": "Sprite3D",
          "name": "OldTownArt_TransitionToObjective",
          "isStatic": true,
          "_$child": [
            {
              "_$id": "otrt",
              "_$type": "Sprite3D",
              "name": "01_CoverTransition",
              "isStatic": true,
              "_$child": [
                {
                  "_$id": "otr_d1b0019",
                  "_$type": "Sprite3D",
                  "name": "Transition_RightTurn_Left_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 2.9,
                      "z": -32.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm4",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0020",
                  "_$type": "Sprite3D",
                  "name": "Transition_RightTurn_Right_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 2.9,
                      "z": -32.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm5",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0021",
                  "_$type": "Sprite3D",
                  "name": "Transition_RightTurn_Lintel_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.5,
                      "y": 4.5,
                      "z": -32.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm6",
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
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0022",
                  "_$type": "Sprite3D",
                  "name": "Transition_CourtyardDoor_Left_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 2.9,
                      "z": -38.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm7",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0023",
                  "_$type": "Sprite3D",
                  "name": "Transition_CourtyardDoor_Right_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8,
                      "y": 2.9,
                      "z": -38.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm8",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0024",
                  "_$type": "Sprite3D",
                  "name": "Transition_CourtyardDoor_Lintel_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 4.5,
                      "z": -38.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm9",
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
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0025",
                  "_$type": "Sprite3D",
                  "name": "Transition_ReloadCover_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3,
                      "y": 0.6,
                      "z": -28.7
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm10",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0026",
                  "_$type": "Sprite3D",
                  "name": "Transition_ApproachCover_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 5,
                      "y": 0.6,
                      "z": -36.9
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm11",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otrmod047",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.5,
                      "y": 1.25,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod048",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.5,
                      "y": 3.62,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod049",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.5,
                      "y": 1.25,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod050",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.5,
                      "y": 1.25,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod051",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.5,
                      "y": 3.62,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod052",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 1.25,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod053",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12,
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod054",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod055",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod056",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod057",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod058",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 1.25,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod059",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.5,
                      "y": 3.62,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod060",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.5,
                      "y": 1.25,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod061",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.5,
                      "y": 1.25,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod062",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.5,
                      "y": 3.62,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod063",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.5,
                      "y": 1.25,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod064",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod065",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod066",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod067",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod068",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0019_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12,
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod069",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0020_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 1.25,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod070",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0020_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 3.62,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod071",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0020_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod072",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0020_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 1.25,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod073",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0020_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 3.62,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod074",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0020_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.5,
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod075",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0021_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.5,
                      "y": 3.62,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod076",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0021_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.5,
                      "y": 5.08,
                      "z": -32.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.25,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod077",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0021_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.5,
                      "y": 3.62,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod078",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0021_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.5,
                      "y": 5.08,
                      "z": -32.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.25,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod079",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0022_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11,
                      "y": 1.25,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod080",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0022_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11,
                      "y": 3.62,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod081",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0022_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -5,
                      "y": 1.25,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod082",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0022_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12,
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod083",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0022_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod084",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0022_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod085",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0022_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -5,
                      "y": 1.25,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod086",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0022_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -5,
                      "y": 3.62,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod087",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0022_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11,
                      "y": 1.25,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod088",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0022_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4,
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod089",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0022_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8,
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod090",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0022_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12,
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod091",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0023_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 5,
                      "y": 1.25,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod092",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0023_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 5,
                      "y": 3.62,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod093",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0023_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11,
                      "y": 1.25,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod094",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0023_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod095",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0023_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8,
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod096",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0023_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12,
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod097",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0023_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11,
                      "y": 1.25,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod098",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0023_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11,
                      "y": 3.62,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod099",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0023_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 5,
                      "y": 1.25,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod100",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0023_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12,
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod101",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0023_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8,
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod102",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0023_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod103",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0024_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.62,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod104",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0024_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 5.08,
                      "z": -38.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod105",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0024_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.62,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod106",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0024_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 5.08,
                      "z": -38.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
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
              "_$id": "otrc",
              "_$type": "Sprite3D",
              "name": "02_Courtyard",
              "isStatic": true,
              "_$child": [
                {
                  "_$id": "otr_d1b0027",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_LeftHighCover_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.5,
                      "y": 1.3,
                      "z": -41.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm12",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0028",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_RightLowCover_Crouch_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4,
                      "y": 0.45,
                      "z": -43
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm13",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0029",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_WestCover_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11,
                      "y": 1.4,
                      "z": -47
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm14",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0030",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_NorthWingWest_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -9.25,
                      "y": 3,
                      "z": -50
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm15",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0031",
                  "_$type": "Sprite3D",
                  "name": "Courtyard_NorthWingEast_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 9.25,
                      "y": 3,
                      "z": -50
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm16",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otrmod107",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0030_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.625,
                      "y": 1.25,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod108",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0030_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.625,
                      "y": 3.62,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod109",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0030_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.875,
                      "y": 1.25,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod110",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0030_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.625,
                      "y": 5.28,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod111",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0030_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.875,
                      "y": 5.28,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod112",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0030_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.875,
                      "y": 1.25,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod113",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0030_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.875,
                      "y": 3.62,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod114",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0030_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.625,
                      "y": 1.25,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod115",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0030_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -6.875,
                      "y": 5.28,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod116",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0030_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -11.625,
                      "y": 5.28,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod117",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0031_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.875,
                      "y": 1.25,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod118",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0031_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.875,
                      "y": 3.62,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod119",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0031_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.625,
                      "y": 1.25,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod120",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0031_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.875,
                      "y": 5.28,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod121",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0031_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.625,
                      "y": 5.28,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod122",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0031_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.625,
                      "y": 1.25,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod123",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0031_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.625,
                      "y": 3.62,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod124",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0031_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.875,
                      "y": 1.25,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod125",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0031_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 11.625,
                      "y": 5.28,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod126",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0031_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 6.875,
                      "y": 5.28,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.1875,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "otro",
              "_$type": "Sprite3D",
              "name": "03_TargetBuilding_ExteriorInterior",
              "isStatic": true,
              "_$child": [
                {
                  "_$id": "otr_d1b0032",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_FrontDoor_Left_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.85,
                      "y": 2.2,
                      "z": -50
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm17",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0033",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_FrontDoor_Right_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.85,
                      "y": 2.2,
                      "z": -50
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm18",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0034",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_FrontDoor_Lintel_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.6,
                      "z": -50
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm19",
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
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0035",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_RearDoor_Left_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.85,
                      "y": 2.2,
                      "z": -58.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm20",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0036",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_RearDoor_Right_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.85,
                      "y": 2.2,
                      "z": -58.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm21",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0037",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_RearDoor_Lintel_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.6,
                      "z": -58.5
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm22",
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
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0038",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_WestWall_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.5,
                      "y": 2.2,
                      "z": -54.25
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm23",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0039",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_EastWall_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.5,
                      "y": 2.2,
                      "z": -54.25
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm24",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0040",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_Roof_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 4.55,
                      "z": -54.25
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm25",
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
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0041",
                  "_$type": "Sprite3D",
                  "name": "TargetBuilding_Storage_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.7,
                      "y": 0.6,
                      "z": -54
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm26",
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
                          "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otrmod127",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0032_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.18,
                      "y": 1.2,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod128",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0032_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.85,
                      "y": 3.6800000000000006,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.825,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod129",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0032_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.18,
                      "y": 1.2,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod130",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0033_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.18,
                      "y": 1.2,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod131",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0033_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.85,
                      "y": 3.6800000000000006,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.825,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod132",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0033_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.18,
                      "y": 1.2,
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod133",
                  "_$prefab": "7f2c07ec-df2e-4713-99ef-7fe375818217",
                  "name": "OpenPortal_d1b0034_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod134",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0034_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.6800000000000006,
                      "z": -49.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.6,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod135",
                  "_$prefab": "7f2c07ec-df2e-4713-99ef-7fe375818217",
                  "name": "OpenPortal_d1b0034_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "z": -50.3
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod136",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0035_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.18,
                      "y": 1.2,
                      "z": -58.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod137",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0035_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -3.18,
                      "y": 1.2,
                      "z": -58.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod138",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0035_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -2.85,
                      "y": 3.6800000000000006,
                      "z": -58.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.825,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod139",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0036_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.18,
                      "y": 1.2,
                      "z": -58.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod140",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0036_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 3.18,
                      "y": 1.2,
                      "z": -58.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9,
                      "y": 0.95,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod141",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0036_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 2.85,
                      "y": 3.6800000000000006,
                      "z": -58.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.825,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod142",
                  "_$prefab": "7f2c07ec-df2e-4713-99ef-7fe375818217",
                  "name": "OpenPortal_d1b0037_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "z": -58.2
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod143",
                  "_$prefab": "7f2c07ec-df2e-4713-99ef-7fe375818217",
                  "name": "OpenPortal_d1b0037_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "z": -58.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod144",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0037_-z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3.6800000000000006,
                      "z": -58.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 1,
                      "w": 6.123233995736766e-17
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.6,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod145",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0038_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.3,
                      "y": 1.45,
                      "z": -54.25
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod146",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0038_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.7,
                      "y": 1.45,
                      "z": -54.25
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod147",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0038_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.7,
                      "y": 3.6800000000000006,
                      "z": -56.375
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0625,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod148",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0038_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.7,
                      "y": 3.6800000000000006,
                      "z": -52.125
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0625,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod149",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0039_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.7,
                      "y": 1.45,
                      "z": -54.25
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod150",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0039_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.7,
                      "y": 3.6800000000000006,
                      "z": -52.125
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0625,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod151",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0039_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.7,
                      "y": 3.6800000000000006,
                      "z": -56.375
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0625,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod152",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0039_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.3,
                      "y": 1.45,
                      "z": -54.25
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
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
              "_$id": "otrb",
              "_$type": "Sprite3D",
              "name": "04_RearBoundary",
              "isStatic": true,
              "_$child": [
                {
                  "_$id": "otr_d1b0001",
                  "_$type": "Sprite3D",
                  "name": "Boundary_West_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -14,
                      "y": 3,
                      "z": -44.8
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm1",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0002",
                  "_$type": "Sprite3D",
                  "name": "Boundary_East_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 14,
                      "y": 3,
                      "z": -44.8
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm2",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otr_d1b0004",
                  "_$type": "Sprite3D",
                  "name": "Boundary_North_RearArtSkin",
                  "isStatic": true,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 3,
                      "z": -62
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "MeshFilter",
                      "sharedMesh": {
                        "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm3",
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
                          "_$uuid": "a314dbce-a094-47ea-8f5f-6a6ccb4c7ea4",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "dfb20d1c-5760-47b7-abdd-e009ca90533a",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "01de3f07-6d18-47f6-a9c6-db5fbf9f7a91",
                          "_$type": "Material"
                        },
                        {
                          "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
                          "_$type": "Material"
                        }
                      ]
                    }
                  ]
                },
                {
                  "_$id": "otrmod000",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -29.799999999999997
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod001",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -29.799999999999997
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod002",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -34.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod003",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -39.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod004",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -39.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod005",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -44.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod006",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -49.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod007",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -49.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod008",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -54.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod009",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 1.25,
                      "z": -59.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod010",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 3.62,
                      "z": -59.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod011",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -29.24444444444444
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod012",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -33.133333333333326
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod013",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -37.02222222222222
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod014",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -40.91111111111111
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod015",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -44.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod016",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -48.68888888888888
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod017",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -52.577777777777776
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod018",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -56.46666666666667
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod019",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0001_+x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -13.7,
                      "y": 5.28,
                      "z": -60.355555555555554
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod020",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -59.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod021",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -59.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod022",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -54.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod023",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -49.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod024",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -49.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod025",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -44.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod026",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -39.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod027",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -39.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod028",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -34.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod029",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 1.25,
                      "z": -29.799999999999997
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod030",
                  "_$prefab": "5bd0be73-3034-4102-8a39-b8012884d2d4",
                  "name": "ClosedWindow_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 3.62,
                      "z": -29.799999999999997
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.75,
                      "y": 0.75,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod031",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -60.355555555555554
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod032",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -56.46666666666667
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod033",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -52.577777777777776
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod034",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -48.68888888888888
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod035",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -44.8
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod036",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -40.91111111111111
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod037",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -37.02222222222222
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod038",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -33.133333333333326
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod039",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0002_-x",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 13.7,
                      "y": 5.28,
                      "z": -29.24444444444444
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 0.9722222222222222,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod040",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -12.257142857142858,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod041",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -8.17142857142857,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod042",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -4.085714285714285,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod043",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.7763568394002505e-15,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod044",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 4.085714285714289,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod045",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 8.171428571428574,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                },
                {
                  "_$id": "otrmod046",
                  "_$prefab": "d60bdbfe-4b7d-4b55-9b2a-3bda6829bfb0",
                  "name": "TileEave_d1b0004_+z",
                  "active": true,
                  "isStatic": true,
                  "layer": 0,
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 12.25714285714286,
                      "y": 5.28,
                      "z": -61.7
                    },
                    "localRotation": {
                      "_$type": "Quaternion"
                    },
                    "localScale": {
                      "_$type": "Vector3",
                      "x": 1.0214285714285716,
                      "y": 1,
                      "z": 1
                    }
                  }
                }
              ]
            },
            {
              "_$id": "otrp",
              "_$type": "Sprite3D",
              "name": "05_RearPaving",
              "isStatic": true,
              "_$comp": [
                {
                  "_$type": "MeshFilter",
                  "sharedMesh": {
                    "_$uuid": "9e698910-86b0-46fa-98bd-197993ad9493@lm27",
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
                      "_$uuid": "2f3dd07f-7c83-4f2b-9d34-f020173fc4d8",
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
      "text": "WASD 移动 · 鼠标转向 · 左键单发 · 右键开镜 · R 装填 · Space 跳跃 · Shift 疾跑 · C 下蹲 · Esc 释放",
      "font": "Microsoft YaHei",
      "fontSize": 18,
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
      "text": "汉阳造  5 / 45   ·   单发 · R 装填",
      "font": "Microsoft YaHei",
      "fontSize": 19,
      "color": "#ffffff",
      "letterSpacing": 0,
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
      "letterSpacing": 0,
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
      "letterSpacing": 0,
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
      "letterSpacing": 0,
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
      "text": "目标：清除街口与院落的敌人，穿过目标建筑抵达终点",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "letterSpacing": 0,
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "hitinfo1",
      "_$type": "GTextField",
      "name": "HitFeedback",
      "x": 24,
      "y": 317,
      "width": 1100,
      "height": 36,
      "_mouseState": 1,
      "text": "",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#ffffff",
      "letterSpacing": 0,
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
          "letterSpacing": 0,
          "strokeColor": "#20332c"
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
          "letterSpacing": 0,
          "strokeColor": "#20332c"
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
            "fillColor": "#e7a742"
          },
          "title": "重新开始",
          "titleColor": "#142132",
          "titleFontSize": 22,
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
              "letterSpacing": 0,
              "strokeColor": "#20332c"
            }
          ]
        },
        {
          "_$id": "sessionbtn",
          "_$type": "GButton",
          "name": "StartContinueButton",
          "x": 547,
          "y": 445,
          "width": 240,
          "height": 60,
          "_mouseState": 2,
          "background": {
            "_$type": "DrawRectCmd",
            "fillColor": "#e7a742"
          },
          "title": "开始游戏",
          "titleColor": "#142132",
          "titleFontSize": 22,
          "titleWidget": {
            "_$ref": "sessionlabel"
          },
          "downEffect": 1,
          "_$child": [
            {
              "_$id": "sessionlabel",
              "_$type": "GTextField",
              "name": "StartContinueLabel",
              "width": 240,
              "height": 60,
              "_mouseState": 1,
              "text": "开始游戏",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#142132",
              "bold": true,
              "align": "center",
              "valign": "middle",
              "letterSpacing": 0,
              "strokeColor": "#20332c"
            }
          ]
        },
        {
          "_$id": "settingsbtn",
          "_$type": "GButton",
          "name": "SettingsButton",
          "x": 547,
          "y": 569,
          "width": 240,
          "height": 56,
          "_mouseState": 2,
          "background": {
            "_$type": "DrawRectCmd",
            "fillColor": "#e7a742"
          },
          "title": "设置",
          "titleColor": "#142132",
          "titleFontSize": 22,
          "titleWidget": {
            "_$ref": "settingsbtnlabel"
          },
          "downEffect": 1,
          "_$child": [
            {
              "_$id": "settingsbtnlabel",
              "_$type": "GTextField",
              "name": "SettingsButtonLabel",
              "width": 240,
              "height": 56,
              "_mouseState": 1,
              "text": "设置",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#142132",
              "bold": true,
              "align": "center",
              "valign": "middle",
              "x": 0,
              "y": 0
            }
          ]
        }
      ]
    },
    {
      "_$id": "d1routehud",
      "_$type": "GTextField",
      "name": "Demo01_RouteHint",
      "x": 24,
      "y": 277,
      "width": 1150,
      "height": 36,
      "_mouseState": 1,
      "text": "路线：沿橙色标线前行，到前方转角右转",
      "font": "Microsoft YaHei",
      "fontSize": 18,
      "color": "#8fffb0",
      "letterSpacing": 0,
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "d1prototypehud",
      "_$type": "GTextField",
      "name": "Demo01_PrototypeLabel",
      "x": 920,
      "y": 65,
      "width": 390,
      "height": 36,
      "_mouseState": 1,
      "text": "DEMO 01 · 虚构布局玩法原型",
      "font": "Microsoft YaHei",
      "fontSize": 16,
      "color": "#dddddd",
      "letterSpacing": 0,
      "stroke": 2,
      "strokeColor": "#20332c"
    },
    {
      "_$id": "damageedge",
      "_$type": "GBox",
      "name": "DamageEdges",
      "width": 1334,
      "height": 750,
      "visible": false,
      "_mouseState": 1,
      "zIndex": 80
    },
    {
      "_$id": "damagedir",
      "_$type": "GTextField",
      "name": "DamageDirection",
      "width": 36,
      "height": 36,
      "visible": false,
      "_mouseState": 1,
      "zIndex": 81,
      "text": "▲",
      "font": "Microsoft YaHei",
      "fontSize": 28,
      "color": "#ff8066",
      "align": "center",
      "valign": "middle",
      "letterSpacing": 0,
      "stroke": 2,
      "strokeColor": "#3f1414"
    },
    {
      "_$id": "settingspanel",
      "_$type": "GBox",
      "name": "SettingsPanel",
      "width": 1334,
      "height": 750,
      "visible": false,
      "_mouseState": 2,
      "zIndex": 110,
      "background": {
        "_$type": "DrawRectCmd",
        "fillColor": "#101925"
      },
      "_$child": [
        {
          "_$id": "settingscard",
          "_$type": "GBox",
          "name": "SettingsCard",
          "width": 640,
          "height": 420,
          "_mouseState": 2,
          "background": {
            "_$type": "DrawRectCmd",
            "fillColor": "#18283b"
          },
          "_$child": [
            {
              "_$id": "settingstitle",
              "_$type": "GTextField",
              "name": "SettingsTitle",
              "x": 60,
              "y": 24,
              "width": 520,
              "height": 56,
              "_mouseState": 1,
              "text": "设置",
              "font": "Microsoft YaHei",
              "fontSize": 36,
              "color": "#ffcf80",
              "bold": true,
              "valign": "middle"
            },
            {
              "_$id": "volumelabel",
              "_$type": "GTextField",
              "name": "VolumeLabel",
              "x": 60,
              "y": 100,
              "width": 520,
              "height": 36,
              "_mouseState": 1,
              "text": "音量  100%",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#ffffff",
              "valign": "middle"
            },
            {
              "_$id": "volumeslider",
              "_$type": "GSlider",
              "name": "VolumeSlider",
              "x": 60,
              "y": 144,
              "width": 520,
              "height": 42,
              "_mouseState": 2,
              "value": 100,
              "wholeNumbers": true,
              "_hBar": {
                "_$ref": "volumesliderbar"
              },
              "_gripButton": {
                "_$ref": "volumeslidergrip"
              },
              "_$child": [
                {
                  "_$id": "volumeslidertrack",
                  "_$type": "GBox",
                  "name": "Track",
                  "y": 17,
                  "width": 520,
                  "height": 8,
                  "_mouseState": 1,
                  "background": {
                    "_$type": "DrawRectCmd",
                    "fillColor": "#34485d"
                  }
                },
                {
                  "_$id": "volumesliderbar",
                  "_$type": "GBox",
                  "name": "Fill",
                  "y": 17,
                  "width": 520,
                  "height": 8,
                  "_mouseState": 1,
                  "background": {
                    "_$type": "DrawRectCmd",
                    "fillColor": "#e7a742"
                  }
                },
                {
                  "_$id": "volumeslidergrip",
                  "_$type": "GBox",
                  "name": "Grip",
                  "x": 508,
                  "width": 24,
                  "height": 42,
                  "_mouseState": 2,
                  "background": {
                    "_$type": "DrawRectCmd",
                    "fillColor": "#ffcf80"
                  }
                }
              ],
              "min": 0,
              "max": 100,
              "changeOnClick": true
            },
            {
              "_$id": "sensitivitylabel",
              "_$type": "GTextField",
              "name": "SensitivityLabel",
              "x": 60,
              "y": 208,
              "width": 520,
              "height": 36,
              "_mouseState": 1,
              "text": "鼠标灵敏度  1.00 倍",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#ffffff",
              "valign": "middle"
            },
            {
              "_$id": "sensitivityslider",
              "_$type": "GSlider",
              "name": "SensitivitySlider",
              "x": 60,
              "y": 252,
              "width": 520,
              "height": 42,
              "_mouseState": 2,
              "value": 100,
              "min": 25,
              "max": 300,
              "wholeNumbers": true,
              "_hBar": {
                "_$ref": "sensitivitysliderbar"
              },
              "_gripButton": {
                "_$ref": "sensitivityslidergrip"
              },
              "_$child": [
                {
                  "_$id": "sensitivityslidertrack",
                  "_$type": "GBox",
                  "name": "Track",
                  "y": 17,
                  "width": 520,
                  "height": 8,
                  "_mouseState": 1,
                  "background": {
                    "_$type": "DrawRectCmd",
                    "fillColor": "#34485d"
                  }
                },
                {
                  "_$id": "sensitivitysliderbar",
                  "_$type": "GBox",
                  "name": "Fill",
                  "y": 17,
                  "width": 520,
                  "height": 8,
                  "_mouseState": 1,
                  "background": {
                    "_$type": "DrawRectCmd",
                    "fillColor": "#e7a742"
                  }
                },
                {
                  "_$id": "sensitivityslidergrip",
                  "_$type": "GBox",
                  "name": "Grip",
                  "x": 508,
                  "width": 24,
                  "height": 42,
                  "_mouseState": 2,
                  "background": {
                    "_$type": "DrawRectCmd",
                    "fillColor": "#ffcf80"
                  }
                }
              ],
              "changeOnClick": true
            },
            {
              "_$id": "settingshint",
              "_$type": "GTextField",
              "name": "SettingsHint",
              "x": 60,
              "y": 298,
              "width": 520,
              "height": 30,
              "_mouseState": 1,
              "text": "调整立即生效 · 自动保存 · Esc 返回",
              "font": "Microsoft YaHei",
              "fontSize": 16,
              "color": "#b9c8d8",
              "valign": "middle"
            },
            {
              "_$id": "settingsreset",
              "_$type": "GButton",
              "name": "SettingsResetButton",
              "x": 60,
              "y": 346,
              "width": 240,
              "height": 56,
              "_mouseState": 2,
              "background": {
                "_$type": "DrawRectCmd",
                "fillColor": "#aab9c9"
              },
              "title": "恢复默认",
              "titleColor": "#142132",
              "titleFontSize": 22,
              "titleWidget": {
                "_$ref": "settingsresetlabel"
              },
              "downEffect": 1,
              "_$child": [
                {
                  "_$id": "settingsresetlabel",
                  "_$type": "GTextField",
                  "name": "SettingsResetButtonLabel",
                  "width": 240,
                  "height": 56,
                  "_mouseState": 1,
                  "text": "恢复默认",
                  "font": "Microsoft YaHei",
                  "fontSize": 22,
                  "color": "#142132",
                  "bold": true,
                  "align": "center",
                  "valign": "middle",
                  "x": 0,
                  "y": 0
                }
              ]
            },
            {
              "_$id": "settingsback",
              "_$type": "GButton",
              "name": "SettingsBackButton",
              "x": 340,
              "y": 346,
              "width": 240,
              "height": 56,
              "_mouseState": 2,
              "background": {
                "_$type": "DrawRectCmd",
                "fillColor": "#e7a742"
              },
              "title": "返回",
              "titleColor": "#142132",
              "titleFontSize": 22,
              "titleWidget": {
                "_$ref": "settingsbacklabel"
              },
              "downEffect": 1,
              "_$child": [
                {
                  "_$id": "settingsbacklabel",
                  "_$type": "GTextField",
                  "name": "SettingsBackButtonLabel",
                  "width": 240,
                  "height": 56,
                  "_mouseState": 1,
                  "text": "返回",
                  "font": "Microsoft YaHei",
                  "fontSize": 22,
                  "color": "#142132",
                  "bold": true,
                  "align": "center",
                  "valign": "middle",
                  "x": 0,
                  "y": 0
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}