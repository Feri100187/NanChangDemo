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
        },
        {
          "_$ref": "enemy005"
        },
        {
          "_$ref": "enemy006"
        },
        {
          "_$ref": "enemy007"
        },
        {
          "_$ref": "enemy008"
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
      "combatObjective": "任务：清理街口、院落，取得建筑内虚构任务文件，再抵达终点",
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
      },
      "streetEnemies": [
        {
          "_$ref": "target001"
        },
        {
          "_$ref": "enemy002"
        },
        {
          "_$ref": "enemy005"
        },
        {
          "_$ref": "enemy006"
        }
      ],
      "courtyardEnemies": [
        {
          "_$ref": "enemy003"
        },
        {
          "_$ref": "enemy004"
        },
        {
          "_$ref": "enemy007"
        },
        {
          "_$ref": "enemy008"
        }
      ],
      "missionDocument": {
        "_$ref": "mission_document"
      },
      "documentRange": 2.2,
      "documentAimRadius": 0.3
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
      "directionSeconds": 0.7,
      "reloadSound": "res://f2c87ba9-8fee-4b2b-b1f2-b1674713e6c0",
      "meleeSound": "res://49b90a3d-fd64-4af9-96aa-6e6413cb9e25",
      "heavyMeleeSound": "res://d8fd63f2-3d98-49d3-9700-a104169a0b5f"
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
      },
      "reloadVolumeSlider": {
        "_$ref": "reloadvolumeslider"
      },
      "meleeVolumeSlider": {
        "_$ref": "meleevolumeslider"
      },
      "reloadVolumeText": {
        "_$ref": "reloadvolumelabel"
      },
      "meleeVolumeText": {
        "_$ref": "meleevolumelabel"
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
        "r": 0.6,
        "g": 0.62,
        "b": 0.65
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
              "x": -28,
              "y": 1.65,
              "z": 27,
              "_$type": "Vector3"
            }
          },
          "nearPlane": 0.1,
          "farPlane": 180,
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
          "_$id": "player01",
          "_$type": "Sprite3D",
          "name": "Player",
          "transform": {
            "localPosition": {
              "x": -28,
              "y": 1.1,
              "z": 27,
              "_$type": "Vector3"
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
              "baseDamage": 70,
              "hipRecoil": 1.35,
              "aimRecoil": 1.8,
              "hipCrosshairRecoil": 0.45,
              "horizontalRecoil": 0.12,
              "recoilDistance": 0.1,
              "recoilReturnSpeed": 0.32,
              "reloadPrepareSeconds": 0.7,
              "reloadRoundSeconds": 0.65,
              "reloadFinishSeconds": 0.45
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
              "x": -19,
              "y": 0,
              "z": 12,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "ai_target001_eye"
              },
              "shotPoint": {
                "_$ref": "ai_target001_muzzle"
              },
              "shotBase": {
                "_$ref": "ai_target001_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "ai_target001_patrol_0"
                },
                {
                  "_$ref": "ai_target001_patrol_1"
                },
                {
                  "_$ref": "ai_target001_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
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
                },
                {
                  "_$id": "ai_target001_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "ai_target001_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual1",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "ai_target001_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "weapon01",
          "_$type": "Sprite3D",
          "name": "WeaponPivot",
          "transform": {
            "localPosition": {
              "x": -28,
              "y": 1.65,
              "z": 27,
              "_$type": "Vector3"
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
                  ],
                  "active": false
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
          "_$id": "enemy002",
          "_$type": "Sprite3D",
          "name": "Street_Enemy02",
          "transform": {
            "localPosition": {
              "x": -16,
              "y": 0,
              "z": 9,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "ai_enemy002_eye"
              },
              "shotPoint": {
                "_$ref": "ai_enemy002_muzzle"
              },
              "shotBase": {
                "_$ref": "ai_enemy002_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "ai_enemy002_patrol_0"
                },
                {
                  "_$ref": "ai_enemy002_patrol_1"
                },
                {
                  "_$ref": "ai_enemy002_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
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
                },
                {
                  "_$id": "ai_enemy002_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "ai_enemy002_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual2",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "ai_enemy002_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "enemy003",
          "_$type": "Sprite3D",
          "name": "Courtyard_Enemy01",
          "transform": {
            "localPosition": {
              "x": -3,
              "y": 0.02,
              "z": -10,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "ai_enemy003_eye"
              },
              "shotPoint": {
                "_$ref": "ai_enemy003_muzzle"
              },
              "shotBase": {
                "_$ref": "ai_enemy003_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "ai_enemy003_patrol_0"
                },
                {
                  "_$ref": "ai_enemy003_patrol_1"
                },
                {
                  "_$ref": "ai_enemy003_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
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
                },
                {
                  "_$id": "ai_enemy003_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "ai_enemy003_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual3",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "ai_enemy003_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "enemy004",
          "_$type": "Sprite3D",
          "name": "Courtyard_Enemy02",
          "transform": {
            "localPosition": {
              "x": 2,
              "y": 0.02,
              "z": -7,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "ai_enemy004_eye"
              },
              "shotPoint": {
                "_$ref": "ai_enemy004_muzzle"
              },
              "shotBase": {
                "_$ref": "ai_enemy004_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "ai_enemy004_patrol_0"
                },
                {
                  "_$ref": "ai_enemy004_patrol_1"
                },
                {
                  "_$ref": "ai_enemy004_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
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
                },
                {
                  "_$id": "ai_enemy004_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "ai_enemy004_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "charvisual4",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "ai_enemy004_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "exitzone1",
          "_$type": "Sprite3D",
          "name": "ExitZone_Songbaix_NorthLane",
          "transform": {
            "localPosition": {
              "x": -32,
              "y": 1,
              "z": -36,
              "_$type": "Vector3"
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
          "name": "SpawnPoint_Songbaix_Entry",
          "transform": {
            "localPosition": {
              "x": -28,
              "y": 1.1,
              "z": 27,
              "_$type": "Vector3"
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
              "name": "沿巷前行，房屋门洞均可进入",
              "transform": {
                "localPosition": {
                  "x": -28,
                  "y": 0,
                  "z": 14,
                  "_$type": "Vector3"
                }
              }
            },
            {
              "_$id": "d1wp1",
              "_$type": "Sprite3D",
              "name": "街区共四名敌人：注意西侧及转角屋内",
              "transform": {
                "localPosition": {
                  "x": -20,
                  "y": 0,
                  "z": 14,
                  "_$type": "Vector3"
                }
              }
            },
            {
              "_$id": "d1wp2",
              "_$type": "Sprite3D",
              "name": "搜索转角房屋后，沿院墙进院",
              "transform": {
                "localPosition": {
                  "x": -11,
                  "y": 0,
                  "z": 2,
                  "_$type": "Vector3"
                }
              }
            },
            {
              "_$id": "d1wp3",
              "_$type": "Sprite3D",
              "name": "院区共四名敌人：搜索教堂与北侧小屋",
              "transform": {
                "localPosition": {
                  "x": -4,
                  "y": 0,
                  "z": -10,
                  "_$type": "Vector3"
                }
              }
            },
            {
              "_$id": "d1wp4",
              "_$type": "Sprite3D",
              "name": "清敌后进入任务建筑，文件在西侧木桌",
              "transform": {
                "localPosition": {
                  "x": -18.8,
                  "y": 0,
                  "z": -20,
                  "_$type": "Vector3"
                }
              }
            },
            {
              "_$id": "d1wp5",
              "_$type": "Sprite3D",
              "name": "取得文件后穿过后门",
              "transform": {
                "localPosition": {
                  "x": -18.8,
                  "y": 0,
                  "z": -31,
                  "_$type": "Vector3"
                }
              }
            },
            {
              "_$id": "d1wp6",
              "_$type": "Sprite3D",
              "name": "抵达撤离区",
              "transform": {
                "localPosition": {
                  "x": -32,
                  "y": 0,
                  "z": -36,
                  "_$type": "Vector3"
                }
              }
            }
          ]
        },
        {
          "_$id": "enemy_patrol_routes",
          "_$type": "Sprite3D",
          "name": "EnemyPatrolRoutes",
          "_$child": [
            {
              "_$id": "ai_target001_route",
              "_$type": "Sprite3D",
              "name": "Route_1",
              "transform": {
                "localPosition": {
                  "x": -19,
                  "y": 0,
                  "z": 12,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "ai_target001_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_target001_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_target001_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "ai_enemy002_route",
              "_$type": "Sprite3D",
              "name": "Route_2",
              "transform": {
                "localPosition": {
                  "x": -16,
                  "y": 0,
                  "z": 9,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "ai_enemy002_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_enemy002_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_enemy002_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "ai_enemy003_route",
              "_$type": "Sprite3D",
              "name": "Route_3",
              "transform": {
                "localPosition": {
                  "x": -3,
                  "y": 0.02,
                  "z": -10,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "ai_enemy003_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_enemy003_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_enemy003_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "ai_enemy004_route",
              "_$type": "Sprite3D",
              "name": "Route_4",
              "transform": {
                "localPosition": {
                  "x": 2,
                  "y": 0.02,
                  "z": -7,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "ai_enemy004_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_enemy004_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "ai_enemy004_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "sb_extra_route_5",
              "_$type": "Sprite3D",
              "name": "InteriorPatrol_5",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": 0.05,
                  "z": 0,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "sb_e5_ai_target001_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e5_ai_target001_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e5_ai_target001_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "sb_extra_route_6",
              "_$type": "Sprite3D",
              "name": "InteriorPatrol_6",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 0.05,
                  "z": 5,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "sb_e6_ai_target001_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e6_ai_target001_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e6_ai_target001_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "sb_extra_route_7",
              "_$type": "Sprite3D",
              "name": "InteriorPatrol_7",
              "transform": {
                "localPosition": {
                  "x": 20,
                  "y": 0.08,
                  "z": 0,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "sb_e7_ai_target001_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e7_ai_target001_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e7_ai_target001_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "sb_extra_route_8",
              "_$type": "Sprite3D",
              "name": "InteriorPatrol_8",
              "transform": {
                "localPosition": {
                  "x": -3,
                  "y": 0.05,
                  "z": -29,
                  "_$type": "Vector3"
                }
              },
              "_$child": [
                {
                  "_$id": "sb_e8_ai_target001_patrol_0",
                  "_$type": "Sprite3D",
                  "name": "Patrol_Center",
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e8_ai_target001_patrol_1",
                  "_$type": "Sprite3D",
                  "name": "Patrol_East",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": 1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": 0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                },
                {
                  "_$id": "sb_e8_ai_target001_patrol_2",
                  "_$type": "Sprite3D",
                  "name": "Patrol_West",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "x": -1.6
                    },
                    "localRotation": {
                      "_$type": "Quaternion",
                      "y": -0.7071067811865475,
                      "w": 0.7071067811865476
                    }
                  },
                  "_$comp": [
                    {
                      "_$type": "a97e3d61-e89f-4395-8bb0-38d1db4ee451",
                      "scriptPath": "../src/EnemyPatrolPoint.ts",
                      "waitSeconds": 1.2,
                      "useFacing": true
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "_$id": "mission_document",
          "_$type": "Sprite3D",
          "name": "MissionDocument_Fictional_虚构任务文件",
          "transform": {
            "localPosition": {
              "x": -22.7,
              "y": 1.025,
              "z": -25.7,
              "_$type": "Vector3"
            }
          },
          "_$child": [
            {
              "_$id": "mission_paper",
              "_$type": "Sprite3D",
              "name": "PaperStack",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 0,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.46,
                  "y": 0.06,
                  "z": 0.62
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
                      "_$uuid": "2ef93cde-b34f-4009-af61-61d4fdcbd4e0",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "mission_binding",
              "_$type": "Sprite3D",
              "name": "FolderBinding",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": -0.17,
                  "y": 0.033,
                  "z": 0
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.035,
                  "y": 0.008,
                  "z": 0.62
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
                      "_$uuid": "4f9cf165-5fa2-4287-a91e-4a4402158031",
                      "_$type": "Material"
                    }
                  ]
                }
              ]
            },
            {
              "_$id": "mission_label",
              "_$type": "Sprite3D",
              "name": "BlankLabel_Fictional",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "x": 0,
                  "y": 0.034,
                  "z": -0.12
                },
                "localScale": {
                  "_$type": "Vector3",
                  "x": 0.25,
                  "y": 0.01,
                  "z": 0.1
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
          "_$id": "songbaix_root",
          "_$type": "Sprite3D",
          "name": "Songbaix_Environment",
          "_$child": [
            {
              "_$id": "sb_ground",
              "_$prefab": "24879f08-b276-420a-9997-0e3abb4382c8",
              "name": "Songbaix_ground"
            },
            {
              "_$id": "sb_landmark",
              "_$prefab": "844dfabc-b337-4735-9c7d-fe26ced0468e",
              "name": "Songbaix_landmark"
            },
            {
              "_$id": "sb_street-buildings",
              "_$prefab": "3f1725e6-5a88-47ea-bdc9-f49579df7a78",
              "name": "Songbaix_street-buildings"
            },
            {
              "_$id": "sb_mission-building-game",
              "_$prefab": "c16987c3-4845-428b-9009-4095a1540807",
              "name": "Songbaix_mission-building-game"
            },
            {
              "_$id": "sb_props",
              "_$prefab": "22412755-cf67-4444-8354-1514b2894dd3",
              "name": "Songbaix_props"
            }
          ]
        },
        {
          "_$id": "songbaix_collisions",
          "_$type": "Sprite3D",
          "name": "Songbaix_StaticCollisions",
          "_$child": [
            {
              "_$id": "sb_col_0",
              "_$type": "Sprite3D",
              "name": "COL_Block_Substrate_East",
              "transform": {
                "localPosition": {
                  "x": 33,
                  "y": -0.4000000059604645,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 50,
                  "y": 0.550000011920929,
                  "z": 34,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_1",
              "_$type": "Sprite3D",
              "name": "COL_Block_Substrate_West",
              "transform": {
                "localPosition": {
                  "x": -16,
                  "y": -0.4000000059604645,
                  "z": -4,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 0.550000011920929,
                  "z": 74,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_2",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 10,
                  "z": 11.75,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 20,
                  "z": 2.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_3",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.001",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 11.6899995803833,
                  "z": 9.600000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 16.6200008392334,
                  "z": 1.7999999523162842,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_4",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.002",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 10,
                  "z": 6.900000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 20,
                  "z": 3.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_5",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.003",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 11.6899995803833,
                  "z": 4,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 16.6200008392334,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_6",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.004",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 10,
                  "z": 2.299999952316284,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 20,
                  "z": 1.2000000476837158,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_7",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.005",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 11.739999771118164,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 16.520000457763672,
                  "z": 3.4000000953674316,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_8",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.006",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 10,
                  "z": -2.299999952316284,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 20,
                  "z": 1.2000000476837158,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_9",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.007",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 11.6899995803833,
                  "z": -4,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 16.6200008392334,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_10",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.008",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 10,
                  "z": -6.900000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 20,
                  "z": 3.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_11",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.009",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 11.6899995803833,
                  "z": -9.600000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 16.6200008392334,
                  "z": 1.7999999523162842,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_12",
              "_$type": "Sprite3D",
              "name": "COL_ChurchFacadeSegment.010",
              "transform": {
                "localPosition": {
                  "x": 7.860000133514404,
                  "y": 10,
                  "z": -11.75,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.47999998927116394,
                  "y": 20,
                  "z": 2.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_13",
              "_$type": "Sprite3D",
              "name": "COL_ChurchNorthBoundary",
              "transform": {
                "localPosition": {
                  "x": 33,
                  "y": 1.350000023841858,
                  "z": -17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 50,
                  "y": 2.700000047683716,
                  "z": 0.4500007629394531,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_14",
              "_$type": "Sprite3D",
              "name": "COL_ChurchNorthBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": 33,
                  "y": 2.7699999809265137,
                  "z": -17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 50.1199951171875,
                  "y": 0.1399998664855957,
                  "z": 0.5900001525878906,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_15",
              "_$type": "Sprite3D",
              "name": "COL_ChurchSidePaving",
              "transform": {
                "localPosition": {
                  "x": 33,
                  "y": -0.10000000149011612,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 50,
                  "y": 0.20000000298023224,
                  "z": 34,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_16",
              "_$type": "Sprite3D",
              "name": "COL_ChurchSouthBoundary",
              "transform": {
                "localPosition": {
                  "x": 33,
                  "y": 1.350000023841858,
                  "z": 17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 50,
                  "y": 2.700000047683716,
                  "z": 0.4500007629394531,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_17",
              "_$type": "Sprite3D",
              "name": "COL_ChurchSouthBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": 33,
                  "y": 2.7699999809265137,
                  "z": 17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 50.1199951171875,
                  "y": 0.1399998664855957,
                  "z": 0.5900001525878906,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_18",
              "_$type": "Sprite3D",
              "name": "COL_CourtyardWestScreen",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 1.350000023841858,
                  "z": -12,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4500007629394531,
                  "y": 2.700000047683716,
                  "z": 8,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_19",
              "_$type": "Sprite3D",
              "name": "COL_CourtyardWestScreen_Coping",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 2.7699999809265137,
                  "z": -12,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5699996948242188,
                  "y": 0.1399998664855957,
                  "z": 8.139999389648438,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_20",
              "_$type": "Sprite3D",
              "name": "COL_EastBoundary",
              "transform": {
                "localPosition": {
                  "x": 58,
                  "y": 1.5499999523162842,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4499969482421875,
                  "y": 3.0999999046325684,
                  "z": 34,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_21",
              "_$type": "Sprite3D",
              "name": "COL_EastBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": 58,
                  "y": 3.1700000762939453,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5699996948242188,
                  "y": 0.1399998664855957,
                  "z": 34.13999938964844,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_22",
              "_$type": "Sprite3D",
              "name": "COL_ForecourtNorthWall",
              "transform": {
                "localPosition": {
                  "x": 2,
                  "y": 1.25,
                  "z": -19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 10,
                  "y": 2.5,
                  "z": 0.4500007629394531,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_23",
              "_$type": "Sprite3D",
              "name": "COL_ForecourtNorthWall_Coping",
              "transform": {
                "localPosition": {
                  "x": 2,
                  "y": 2.569999933242798,
                  "z": -19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 10.119999885559082,
                  "y": 0.1399998664855957,
                  "z": 0.5900001525878906,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_24",
              "_$type": "Sprite3D",
              "name": "COL_ForecourtPaving",
              "transform": {
                "localPosition": {
                  "x": -0.19999980926513672,
                  "y": -0.07999999821186066,
                  "z": -2,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 20,
                  "y": 0.20000001788139343,
                  "z": 33,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_25",
              "_$type": "Sprite3D",
              "name": "COL_ForecourtSouthWall",
              "transform": {
                "localPosition": {
                  "x": -0.5,
                  "y": 1.25,
                  "z": 14,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 14,
                  "y": 2.5,
                  "z": 0.4500007629394531,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_26",
              "_$type": "Sprite3D",
              "name": "COL_ForecourtSouthWall_Coping",
              "transform": {
                "localPosition": {
                  "x": -0.5,
                  "y": 2.569999933242798,
                  "z": 14,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 14.119999885559082,
                  "y": 0.1399998664855957,
                  "z": 0.5900001525878906,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_27",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_BackHollowWall_240",
              "transform": {
                "localPosition": {
                  "x": 55.84000015258789,
                  "y": 5.150000095367432,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 10.300000190734863,
                  "z": 25.700000762939453,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_28",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench",
              "transform": {
                "localPosition": {
                  "x": 24,
                  "y": 0.5,
                  "z": 8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_29",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.001",
              "transform": {
                "localPosition": {
                  "x": 24,
                  "y": 0.5,
                  "z": -8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_30",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.002",
              "transform": {
                "localPosition": {
                  "x": 30,
                  "y": 0.5,
                  "z": 8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_31",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.003",
              "transform": {
                "localPosition": {
                  "x": 30,
                  "y": 0.5,
                  "z": -8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_32",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.004",
              "transform": {
                "localPosition": {
                  "x": 36,
                  "y": 0.5,
                  "z": 8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_33",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.005",
              "transform": {
                "localPosition": {
                  "x": 36,
                  "y": 0.5,
                  "z": -8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_34",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.006",
              "transform": {
                "localPosition": {
                  "x": 42,
                  "y": 0.5,
                  "z": 8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_35",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Bench.007",
              "transform": {
                "localPosition": {
                  "x": 42,
                  "y": 0.5,
                  "z": -8,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5999984741210938,
                  "y": 0.15999996662139893,
                  "z": 3.799999713897705,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_36",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": 1.840000033378601,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.09999990463256836,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_37",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.001",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": -1.840000033378601,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.09999990463256836,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_38",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.002",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": 5.239999771118164,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.10000038146972656,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_39",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.003",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": 2.759999990463257,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.09999990463256836,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_40",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.004",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": -2.759999990463257,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.09999990463256836,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_41",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.005",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": -5.239999771118164,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.10000038146972656,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_42",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.006",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": 10.640000343322754,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.10000038146972656,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_43",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.007",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": 8.5600004196167,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.10000038146972656,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_44",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.008",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": -8.5600004196167,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.10000038146972656,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_45",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_OpenDoor.009",
              "transform": {
                "localPosition": {
                  "x": 8.550000190734863,
                  "y": 1.6499998569488525,
                  "z": -10.640000343322754,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.25,
                  "y": 3.0999999046325684,
                  "z": 0.10000038146972656,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_46",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier",
              "transform": {
                "localPosition": {
                  "x": 18,
                  "y": 7.300000190734863,
                  "z": 4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_47",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.001",
              "transform": {
                "localPosition": {
                  "x": 18,
                  "y": 7.300000190734863,
                  "z": -4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_48",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.002",
              "transform": {
                "localPosition": {
                  "x": 26,
                  "y": 7.300000190734863,
                  "z": 4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_49",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.003",
              "transform": {
                "localPosition": {
                  "x": 26,
                  "y": 7.300000190734863,
                  "z": -4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_50",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.004",
              "transform": {
                "localPosition": {
                  "x": 34,
                  "y": 7.300000190734863,
                  "z": 4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_51",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.005",
              "transform": {
                "localPosition": {
                  "x": 34,
                  "y": 7.300000190734863,
                  "z": -4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_52",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.006",
              "transform": {
                "localPosition": {
                  "x": 42,
                  "y": 7.300000190734863,
                  "z": 4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_53",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.007",
              "transform": {
                "localPosition": {
                  "x": 42,
                  "y": 7.300000190734863,
                  "z": -4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_54",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.008",
              "transform": {
                "localPosition": {
                  "x": 50,
                  "y": 7.300000190734863,
                  "z": 4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_55",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_InteriorBlock_Pier.009",
              "transform": {
                "localPosition": {
                  "x": 50,
                  "y": 7.300000190734863,
                  "z": -4.650000095367432,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5,
                  "y": 14.600000381469727,
                  "z": 0.5,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_56",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": 32,
                  "y": 0.015000000596046448,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 0.12999999523162842,
                  "z": 26,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_57",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_SideHollowWall_1_239",
              "transform": {
                "localPosition": {
                  "x": 32,
                  "y": 5.150000095367432,
                  "z": -12.84000015258789,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 10.300000190734863,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_58",
              "_$type": "Sprite3D",
              "name": "COL_Landmark_SideHollowWall_-1_238",
              "transform": {
                "localPosition": {
                  "x": 32,
                  "y": 5.150000095367432,
                  "z": 12.84000015258789,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 10.300000190734863,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_59",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_1_23",
              "transform": {
                "localPosition": {
                  "x": -37.54999923706055,
                  "y": 1.4500000476837158,
                  "z": 16,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_60",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_1_24",
              "transform": {
                "localPosition": {
                  "x": -37.54999923706055,
                  "y": 4.050000190734863,
                  "z": 16,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_61",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_1_25",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 4.050000190734863,
                  "z": 16,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_62",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_1_26",
              "transform": {
                "localPosition": {
                  "x": -32.45000076293945,
                  "y": 1.4500000476837158,
                  "z": 16,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_63",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_1_27",
              "transform": {
                "localPosition": {
                  "x": -32.45000076293945,
                  "y": 4.050000190734863,
                  "z": 16,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_64",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_0",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 0.625,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_65",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_1",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 2,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_66",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_2",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 2.825000047683716,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_67",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_3",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_68",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_4",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 0.625,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_69",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_5",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 2.825000047683716,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_70",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_6",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_71",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_7",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 0.625,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_72",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_8",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 2,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_73",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_9",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 2.825000047683716,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_74",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_10",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_75",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_11",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_76",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_12",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 0.625,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_77",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_13",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 2,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_78",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_14",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 2.825000047683716,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_79",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_15",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_80",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_16",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 0.625,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_81",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_17",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 2.825000047683716,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_82",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_18",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_83",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_19",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 0.625,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_84",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_20",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 2,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_85",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_21",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 2.825000047683716,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_86",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_HollowWall_-1_22",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 4.050000190734863,
                  "z": 30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_87",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -32.68000030517578,
                  "y": 0.25,
                  "z": 19.360000610351562,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.6500015258789062,
                  "y": 0.3999999761581421,
                  "z": 2.4000015258789062,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_88",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -32.84000015258789,
                  "y": 0.4599999785423279,
                  "z": 26.639999389648438,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.3499984741210938,
                  "y": 0.8500000238418579,
                  "z": 0.8499984741210938,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_89",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -37.15999984741211,
                  "y": 0.7799999713897705,
                  "z": 19.360000610351562,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_90",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": -0.020000001415610313,
                  "z": 23,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 7.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 13.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_91",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_SideHollowWall_1_29",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 1.4500000476837158,
                  "z": 26.969999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 5.739999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_92",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_SideHollowWall_1_30",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.050000190734863,
                  "z": 26.969999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.299999952316284,
                  "z": 5.739999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_93",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_SideHollowWall_1_31",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.050000190734863,
                  "z": 23,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.299999952316284,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_94",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_SideHollowWall_1_32",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 1.4500000476837158,
                  "z": 19.030000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 5.739999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_95",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_SideHollowWall_1_33",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.050000190734863,
                  "z": 19.030000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.299999952316284,
                  "z": 5.739999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_96",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_A_SideHollowWall_-1_28",
              "transform": {
                "localPosition": {
                  "x": -39,
                  "y": 2.5999999046325684,
                  "z": 23,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 5.199999809265137,
                  "z": 13.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_97",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_1_57",
              "transform": {
                "localPosition": {
                  "x": -21.549999237060547,
                  "y": 1.4500000476837158,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_98",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_1_58",
              "transform": {
                "localPosition": {
                  "x": -21.549999237060547,
                  "y": 4.300000190734863,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_99",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_1_59",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": 4.300000190734863,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_100",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_1_60",
              "transform": {
                "localPosition": {
                  "x": -14.449999809265137,
                  "y": 1.4500000476837158,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_101",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_1_61",
              "transform": {
                "localPosition": {
                  "x": -14.449999809265137,
                  "y": 4.300000190734863,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_102",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_34",
              "transform": {
                "localPosition": {
                  "x": -23.017499923706055,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_103",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_35",
              "transform": {
                "localPosition": {
                  "x": -23.017499923706055,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_104",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_36",
              "transform": {
                "localPosition": {
                  "x": -23.017499923706055,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_105",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_37",
              "transform": {
                "localPosition": {
                  "x": -23.017499923706055,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_106",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_38",
              "transform": {
                "localPosition": {
                  "x": -21.360000610351562,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_107",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_39",
              "transform": {
                "localPosition": {
                  "x": -21.360000610351562,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_108",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_40",
              "transform": {
                "localPosition": {
                  "x": -21.360000610351562,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_109",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_41",
              "transform": {
                "localPosition": {
                  "x": -19.892499923706055,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_110",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_42",
              "transform": {
                "localPosition": {
                  "x": -19.892499923706055,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_111",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_43",
              "transform": {
                "localPosition": {
                  "x": -19.892499923706055,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_112",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_44",
              "transform": {
                "localPosition": {
                  "x": -19.892499923706055,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_113",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_45",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_114",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_46",
              "transform": {
                "localPosition": {
                  "x": -16.107500076293945,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_115",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_47",
              "transform": {
                "localPosition": {
                  "x": -16.107500076293945,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_116",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_48",
              "transform": {
                "localPosition": {
                  "x": -16.107500076293945,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_117",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_49",
              "transform": {
                "localPosition": {
                  "x": -16.107500076293945,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_118",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_50",
              "transform": {
                "localPosition": {
                  "x": -14.640000343322754,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_119",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_51",
              "transform": {
                "localPosition": {
                  "x": -14.640000343322754,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_120",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_52",
              "transform": {
                "localPosition": {
                  "x": -14.640000343322754,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_121",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_53",
              "transform": {
                "localPosition": {
                  "x": -12.982500076293945,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_122",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_54",
              "transform": {
                "localPosition": {
                  "x": -12.982500076293945,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_123",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_55",
              "transform": {
                "localPosition": {
                  "x": -12.982500076293945,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_124",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_HollowWall_-1_56",
              "transform": {
                "localPosition": {
                  "x": -12.982500076293945,
                  "y": 4.300000190734863,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 2.799999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_125",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -14.520000457763672,
                  "y": 0.25,
                  "z": 21.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.6499996185302734,
                  "y": 0.3999999761581421,
                  "z": 2.4000015258789062,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_126",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -14.760000228881836,
                  "y": 0.4599999785423279,
                  "z": 26.600000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.3500003814697266,
                  "y": 0.8500000238418579,
                  "z": 0.8499984741210938,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_127",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -21.239999771118164,
                  "y": 0.7799999713897705,
                  "z": 21.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_128",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": -0.020000001415610313,
                  "z": 24,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 11.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 9.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_129",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_SideHollowWall_1_67",
              "transform": {
                "localPosition": {
                  "x": -12,
                  "y": 2.8499999046325684,
                  "z": 24,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 5.699999809265137,
                  "z": 9.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_130",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_SideHollowWall_-1_62",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 1.4500000476837158,
                  "z": 26.969999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_131",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_SideHollowWall_-1_63",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 4.300000190734863,
                  "z": 26.969999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.799999952316284,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_132",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_SideHollowWall_-1_64",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 4.300000190734863,
                  "z": 24,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.799999952316284,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_133",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_SideHollowWall_-1_65",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 1.4500000476837158,
                  "z": 21.030000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_134",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_B_SideHollowWall_-1_66",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 4.300000190734863,
                  "z": 21.030000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.799999952316284,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_135",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_1_91",
              "transform": {
                "localPosition": {
                  "x": -37.54999923706055,
                  "y": 1.4500000476837158,
                  "z": -3.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_136",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_1_92",
              "transform": {
                "localPosition": {
                  "x": -37.54999923706055,
                  "y": 4.550000190734863,
                  "z": -3.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_137",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_1_93",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 4.550000190734863,
                  "z": -3.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_138",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_1_94",
              "transform": {
                "localPosition": {
                  "x": -32.45000076293945,
                  "y": 1.4500000476837158,
                  "z": -3.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_139",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_1_95",
              "transform": {
                "localPosition": {
                  "x": -32.45000076293945,
                  "y": 4.550000190734863,
                  "z": -3.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_140",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_68",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 0.625,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_141",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_69",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 2,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_142",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_70",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 2.825000047683716,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_143",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_71",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_144",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_72",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 0.625,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_145",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_73",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 2.825000047683716,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_146",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_74",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_147",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_75",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 0.625,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_148",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_76",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 2,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_149",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_77",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 2.825000047683716,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_150",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_78",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_151",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_79",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_152",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_80",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 0.625,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_153",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_81",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 2,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_154",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_82",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 2.825000047683716,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_155",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_83",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_156",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_84",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 0.625,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_157",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_85",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 2.825000047683716,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_158",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_86",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_159",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_87",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 0.625,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_160",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_88",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 2,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_161",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_89",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 2.825000047683716,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_162",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_HollowWall_-1_90",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 4.550000190734863,
                  "z": 13.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 3.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_163",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -32.68000030517578,
                  "y": 0.25,
                  "z": 0.5799999237060547,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.6500015258789062,
                  "y": 0.3999999761581421,
                  "z": 2.4000000953674316,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_164",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -32.84000015258789,
                  "y": 0.4599999785423279,
                  "z": 9.420000076293945,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.3499984741210938,
                  "y": 0.8500000238418579,
                  "z": 0.8500003814697266,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_165",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -37.15999984741211,
                  "y": 0.7799999713897705,
                  "z": 0.5799999237060547,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 0.9999999403953552,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_166",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": -0.020000001415610313,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 7.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 16.68000030517578,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_167",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_SideHollowWall_1_97",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 1.4500000476837158,
                  "z": 9.720000267028809,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_168",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_SideHollowWall_1_98",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.550000190734863,
                  "z": 9.720000267028809,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 3.299999952316284,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_169",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_SideHollowWall_1_99",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.550000190734863,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 3.299999952316284,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_170",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_SideHollowWall_1_100",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 1.4500000476837158,
                  "z": 0.2800000011920929,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_171",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_SideHollowWall_1_101",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.550000190734863,
                  "z": 0.2800000011920929,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 3.299999952316284,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_172",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_C_SideHollowWall_-1_96",
              "transform": {
                "localPosition": {
                  "x": -39,
                  "y": 3.0999999046325684,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 6.199999809265137,
                  "z": 16.68000030517578,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_173",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_1_125",
              "transform": {
                "localPosition": {
                  "x": -21.049999237060547,
                  "y": 1.4500000476837158,
                  "z": -5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_174",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_1_126",
              "transform": {
                "localPosition": {
                  "x": -21.049999237060547,
                  "y": 3.950000047683716,
                  "z": -5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_175",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_1_127",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": 3.950000047683716,
                  "z": -5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_176",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_1_128",
              "transform": {
                "localPosition": {
                  "x": -14.949999809265137,
                  "y": 1.4500000476837158,
                  "z": -5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_177",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_1_129",
              "transform": {
                "localPosition": {
                  "x": -14.949999809265137,
                  "y": 3.950000047683716,
                  "z": -5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_178",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_102",
              "transform": {
                "localPosition": {
                  "x": -22.237499237060547,
                  "y": 0.625,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_179",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_103",
              "transform": {
                "localPosition": {
                  "x": -22.237499237060547,
                  "y": 2,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_180",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_104",
              "transform": {
                "localPosition": {
                  "x": -22.237499237060547,
                  "y": 2.825000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_181",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_105",
              "transform": {
                "localPosition": {
                  "x": -22.237499237060547,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_182",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_106",
              "transform": {
                "localPosition": {
                  "x": -20.799999237060547,
                  "y": 0.625,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_183",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_107",
              "transform": {
                "localPosition": {
                  "x": -20.799999237060547,
                  "y": 2.825000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_184",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_108",
              "transform": {
                "localPosition": {
                  "x": -20.799999237060547,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_185",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_109",
              "transform": {
                "localPosition": {
                  "x": -19.612499237060547,
                  "y": 0.625,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_186",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_110",
              "transform": {
                "localPosition": {
                  "x": -19.612499237060547,
                  "y": 2,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_187",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_111",
              "transform": {
                "localPosition": {
                  "x": -19.612499237060547,
                  "y": 2.825000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_188",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_112",
              "transform": {
                "localPosition": {
                  "x": -19.612499237060547,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_189",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_113",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_190",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_114",
              "transform": {
                "localPosition": {
                  "x": -16.387500762939453,
                  "y": 0.625,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_191",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_115",
              "transform": {
                "localPosition": {
                  "x": -16.387500762939453,
                  "y": 2,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_192",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_116",
              "transform": {
                "localPosition": {
                  "x": -16.387500762939453,
                  "y": 2.825000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_193",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_117",
              "transform": {
                "localPosition": {
                  "x": -16.387500762939453,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_194",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_118",
              "transform": {
                "localPosition": {
                  "x": -15.199999809265137,
                  "y": 0.625,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_195",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_119",
              "transform": {
                "localPosition": {
                  "x": -15.199999809265137,
                  "y": 2.825000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_196",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_120",
              "transform": {
                "localPosition": {
                  "x": -15.199999809265137,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_197",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_121",
              "transform": {
                "localPosition": {
                  "x": -13.762499809265137,
                  "y": 0.625,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_198",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_122",
              "transform": {
                "localPosition": {
                  "x": -13.762499809265137,
                  "y": 2,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_199",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_123",
              "transform": {
                "localPosition": {
                  "x": -13.762499809265137,
                  "y": 2.825000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_200",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_HollowWall_-1_124",
              "transform": {
                "localPosition": {
                  "x": -13.762499809265137,
                  "y": 3.950000047683716,
                  "z": 5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 2.0999999046325684,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_201",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -15.100000381469727,
                  "y": 0.25,
                  "z": -2.5999999046325684,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.6499996185302734,
                  "y": 0.3999999761581421,
                  "z": 2.4000000953674316,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_202",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -15.300000190734863,
                  "y": 0.4599999785423279,
                  "z": 2.5999999046325684,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.3500003814697266,
                  "y": 0.8500000238418579,
                  "z": 0.8499999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_203",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -20.700000762939453,
                  "y": 0.7799999713897705,
                  "z": -2.5999999046325684,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_204",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -18,
                  "y": -0.020000001415610313,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 9.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 9.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_205",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_SideHollowWall_1_135",
              "transform": {
                "localPosition": {
                  "x": -13,
                  "y": 2.5,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 5,
                  "z": 9.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_206",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_SideHollowWall_-1_130",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 1.4500000476837158,
                  "z": 2.9700000286102295,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_207",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_SideHollowWall_-1_131",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 3.950000047683716,
                  "z": 2.9700000286102295,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.0999999046325684,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_208",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_SideHollowWall_-1_132",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 3.950000047683716,
                  "z": 0,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.0999999046325684,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_209",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_SideHollowWall_-1_133",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 1.4500000476837158,
                  "z": -2.9700000286102295,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_210",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_D_SideHollowWall_-1_134",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 3.950000047683716,
                  "z": -2.9700000286102295,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.0999999046325684,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_211",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_1_159",
              "transform": {
                "localPosition": {
                  "x": -37.54999923706055,
                  "y": 1.4500000476837158,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_212",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_1_160",
              "transform": {
                "localPosition": {
                  "x": -37.54999923706055,
                  "y": 4.349999904632568,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_213",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_1_161",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 4.349999904632568,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_214",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_1_162",
              "transform": {
                "localPosition": {
                  "x": -32.45000076293945,
                  "y": 1.4500000476837158,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_215",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_1_163",
              "transform": {
                "localPosition": {
                  "x": -32.45000076293945,
                  "y": 4.349999904632568,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_216",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_136",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 0.625,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_217",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_137",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 2,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_218",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_138",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 2.825000047683716,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_219",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_139",
              "transform": {
                "localPosition": {
                  "x": -38.45750045776367,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_220",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_140",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 0.625,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_221",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_141",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 2.825000047683716,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_222",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_142",
              "transform": {
                "localPosition": {
                  "x": -37.2400016784668,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_223",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_143",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 0.625,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_224",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_144",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 2,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_225",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_145",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 2.825000047683716,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_226",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_146",
              "transform": {
                "localPosition": {
                  "x": -36.33250045776367,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_227",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_147",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_228",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_148",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 0.625,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_229",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_149",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 2,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_230",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_150",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 2.825000047683716,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_231",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_151",
              "transform": {
                "localPosition": {
                  "x": -33.66749954223633,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4650000035762787,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_232",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_152",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 0.625,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_233",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_153",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 2.825000047683716,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_234",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_154",
              "transform": {
                "localPosition": {
                  "x": -32.7599983215332,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_235",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_155",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 0.625,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_236",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_156",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 2,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_237",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_157",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 2.825000047683716,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_238",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_HollowWall_-1_158",
              "transform": {
                "localPosition": {
                  "x": -31.542499542236328,
                  "y": 4.349999904632568,
                  "z": -8.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.0850000381469727,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_239",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -32.68000030517578,
                  "y": 0.25,
                  "z": -21.420000076293945,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.6500015258789062,
                  "y": 0.3999999761581421,
                  "z": 2.4000015258789062,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_240",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -32.84000015258789,
                  "y": 0.4599999785423279,
                  "z": -12.579999923706055,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.3499984741210938,
                  "y": 0.8500000238418579,
                  "z": 0.8500003814697266,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_241",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -37.15999984741211,
                  "y": 0.7799999713897705,
                  "z": -21.420000076293945,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_242",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -35,
                  "y": -0.020000001415610313,
                  "z": -17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 7.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 16.68000030517578,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_243",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_SideHollowWall_1_165",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 1.4500000476837158,
                  "z": -12.279999732971191,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_244",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_SideHollowWall_1_166",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.349999904632568,
                  "z": -12.279999732971191,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_245",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_SideHollowWall_1_167",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.349999904632568,
                  "z": -17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_246",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_SideHollowWall_1_168",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 1.4500000476837158,
                  "z": -21.719999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_247",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_SideHollowWall_1_169",
              "transform": {
                "localPosition": {
                  "x": -31,
                  "y": 4.349999904632568,
                  "z": -21.719999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 7.239999771118164,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_248",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_E_SideHollowWall_-1_164",
              "transform": {
                "localPosition": {
                  "x": -39,
                  "y": 2.9000000953674316,
                  "z": -17,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 5.800000190734863,
                  "z": 16.68000030517578,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_249",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_1_193",
              "transform": {
                "localPosition": {
                  "x": -7.550000190734863,
                  "y": 1.4500000476837158,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_250",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_1_194",
              "transform": {
                "localPosition": {
                  "x": -7.550000190734863,
                  "y": 4.25,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_251",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_1_195",
              "transform": {
                "localPosition": {
                  "x": -4,
                  "y": 4.25,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_252",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_1_196",
              "transform": {
                "localPosition": {
                  "x": -0.44999998807907104,
                  "y": 1.4500000476837158,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_253",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_1_197",
              "transform": {
                "localPosition": {
                  "x": -0.44999998807907104,
                  "y": 4.25,
                  "z": 19,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.900000095367432,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_254",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_170",
              "transform": {
                "localPosition": {
                  "x": -9.017499923706055,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_255",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_171",
              "transform": {
                "localPosition": {
                  "x": -9.017499923706055,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_256",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_172",
              "transform": {
                "localPosition": {
                  "x": -9.017499923706055,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_257",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_173",
              "transform": {
                "localPosition": {
                  "x": -9.017499923706055,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_258",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_174",
              "transform": {
                "localPosition": {
                  "x": -7.360000133514404,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_259",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_175",
              "transform": {
                "localPosition": {
                  "x": -7.360000133514404,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_260",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_176",
              "transform": {
                "localPosition": {
                  "x": -7.360000133514404,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_261",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_177",
              "transform": {
                "localPosition": {
                  "x": -5.892499923706055,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_262",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_178",
              "transform": {
                "localPosition": {
                  "x": -5.892499923706055,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_263",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_179",
              "transform": {
                "localPosition": {
                  "x": -5.892499923706055,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_264",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_180",
              "transform": {
                "localPosition": {
                  "x": -5.892499923706055,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_265",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_181",
              "transform": {
                "localPosition": {
                  "x": -4,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_266",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_182",
              "transform": {
                "localPosition": {
                  "x": -2.1075000762939453,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_267",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_183",
              "transform": {
                "localPosition": {
                  "x": -2.1075000762939453,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_268",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_184",
              "transform": {
                "localPosition": {
                  "x": -2.1075000762939453,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_269",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_185",
              "transform": {
                "localPosition": {
                  "x": -2.1075000762939453,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5850000381469727,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_270",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_186",
              "transform": {
                "localPosition": {
                  "x": -0.6399999856948853,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_271",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_187",
              "transform": {
                "localPosition": {
                  "x": -0.6399999856948853,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_272",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_188",
              "transform": {
                "localPosition": {
                  "x": -0.6399999856948853,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_273",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_189",
              "transform": {
                "localPosition": {
                  "x": 1.0175000429153442,
                  "y": 0.625,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_274",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_190",
              "transform": {
                "localPosition": {
                  "x": 1.0175000429153442,
                  "y": 2,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_275",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_191",
              "transform": {
                "localPosition": {
                  "x": 1.0175000429153442,
                  "y": 2.825000047683716,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_276",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_HollowWall_-1_192",
              "transform": {
                "localPosition": {
                  "x": 1.0175000429153442,
                  "y": 4.25,
                  "z": 29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.965000033378601,
                  "y": 2.700000047683716,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_277",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -0.5199999809265137,
                  "y": 0.25,
                  "z": 21.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.6500000953674316,
                  "y": 0.3999999761581421,
                  "z": 2.4000015258789062,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_278",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -0.7599999904632568,
                  "y": 0.4599999785423279,
                  "z": 26.600000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.3499999046325684,
                  "y": 0.8500000238418579,
                  "z": 0.8499984741210938,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_279",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -7.239999771118164,
                  "y": 0.7799999713897705,
                  "z": 21.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_280",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -4,
                  "y": -0.020000001415610313,
                  "z": 24,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 11.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 9.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_281",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_SideHollowWall_1_203",
              "transform": {
                "localPosition": {
                  "x": 2,
                  "y": 2.799999952316284,
                  "z": 24,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 5.599999904632568,
                  "z": 9.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_282",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_SideHollowWall_-1_198",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 1.4500000476837158,
                  "z": 26.969999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_283",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_SideHollowWall_-1_199",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 4.25,
                  "z": 26.969999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.700000047683716,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_284",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_SideHollowWall_-1_200",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 4.25,
                  "z": 24,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.700000047683716,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_285",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_SideHollowWall_-1_201",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 1.4500000476837158,
                  "z": 21.030000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_286",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_F_SideHollowWall_-1_202",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 4.25,
                  "z": 21.030000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.700000047683716,
                  "z": 3.740000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_287",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_1_227",
              "transform": {
                "localPosition": {
                  "x": -6.050000190734863,
                  "y": 1.4500000476837158,
                  "z": -32.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_288",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_1_228",
              "transform": {
                "localPosition": {
                  "x": -6.050000190734863,
                  "y": 4.050000190734863,
                  "z": -32.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_289",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_1_229",
              "transform": {
                "localPosition": {
                  "x": -3,
                  "y": 4.050000190734863,
                  "z": -32.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_290",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_1_230",
              "transform": {
                "localPosition": {
                  "x": 0.05000000074505806,
                  "y": 1.4500000476837158,
                  "z": -32.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.9000000953674316,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_291",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_1_231",
              "transform": {
                "localPosition": {
                  "x": 0.05000000074505806,
                  "y": 4.050000190734863,
                  "z": -32.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.9000000953674316,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_292",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_204",
              "transform": {
                "localPosition": {
                  "x": -7.237500190734863,
                  "y": 0.625,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_293",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_205",
              "transform": {
                "localPosition": {
                  "x": -7.237500190734863,
                  "y": 2,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_294",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_206",
              "transform": {
                "localPosition": {
                  "x": -7.237500190734863,
                  "y": 2.825000047683716,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_295",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_207",
              "transform": {
                "localPosition": {
                  "x": -7.237500190734863,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_296",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_208",
              "transform": {
                "localPosition": {
                  "x": -5.800000190734863,
                  "y": 0.625,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_297",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_209",
              "transform": {
                "localPosition": {
                  "x": -5.800000190734863,
                  "y": 2.825000047683716,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_298",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_210",
              "transform": {
                "localPosition": {
                  "x": -5.800000190734863,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_299",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_211",
              "transform": {
                "localPosition": {
                  "x": -4.612500190734863,
                  "y": 0.625,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_300",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_212",
              "transform": {
                "localPosition": {
                  "x": -4.612500190734863,
                  "y": 2,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_301",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_213",
              "transform": {
                "localPosition": {
                  "x": -4.612500190734863,
                  "y": 2.825000047683716,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_302",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_214",
              "transform": {
                "localPosition": {
                  "x": -4.612500190734863,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_303",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_215",
              "transform": {
                "localPosition": {
                  "x": -3,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.200000047683716,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_304",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_216",
              "transform": {
                "localPosition": {
                  "x": -1.3875000476837158,
                  "y": 0.625,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_305",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_217",
              "transform": {
                "localPosition": {
                  "x": -1.3875000476837158,
                  "y": 2,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_306",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_218",
              "transform": {
                "localPosition": {
                  "x": -1.3875000476837158,
                  "y": 2.825000047683716,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_307",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_219",
              "transform": {
                "localPosition": {
                  "x": -1.3875000476837158,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.024999976158142,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_308",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_220",
              "transform": {
                "localPosition": {
                  "x": -0.20000000298023224,
                  "y": 0.625,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_309",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_221",
              "transform": {
                "localPosition": {
                  "x": -0.20000000298023224,
                  "y": 2.825000047683716,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_310",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_222",
              "transform": {
                "localPosition": {
                  "x": -0.20000000298023224,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_311",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_223",
              "transform": {
                "localPosition": {
                  "x": 1.2374999523162842,
                  "y": 0.625,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.25,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_312",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_224",
              "transform": {
                "localPosition": {
                  "x": 1.2374999523162842,
                  "y": 2,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 1.5,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_313",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_225",
              "transform": {
                "localPosition": {
                  "x": 1.2374999523162842,
                  "y": 2.825000047683716,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 0.15000000596046448,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_314",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_HollowWall_-1_226",
              "transform": {
                "localPosition": {
                  "x": 1.2374999523162842,
                  "y": 4.050000190734863,
                  "z": -25.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.524999976158142,
                  "y": 2.299999952316284,
                  "z": 0.3199999928474426,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_315",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_InteriorBlock_BedBase",
              "transform": {
                "localPosition": {
                  "x": -0.10000002384185791,
                  "y": 0.25,
                  "z": -30.81999969482422,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.649999976158142,
                  "y": 0.3999999761581421,
                  "z": 2.4000015258789062,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_316",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_InteriorBlock_Chest",
              "transform": {
                "localPosition": {
                  "x": -0.30000001192092896,
                  "y": 0.4599999785423279,
                  "z": -27.18000030517578,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.350000023841858,
                  "y": 0.8500000238418579,
                  "z": 0.8499984741210938,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_317",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_InteriorBlock_Table",
              "transform": {
                "localPosition": {
                  "x": -5.699999809265137,
                  "y": 0.7799999713897705,
                  "z": -30.81999969482422,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.5,
                  "y": 0.13999998569488525,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_318",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_RoomFloor",
              "transform": {
                "localPosition": {
                  "x": -3,
                  "y": -0.020000001415610313,
                  "z": -29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 9.680000305175781,
                  "y": 0.14000000059604645,
                  "z": 6.680000305175781,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_319",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_SideHollowWall_1_237",
              "transform": {
                "localPosition": {
                  "x": 2,
                  "y": 2.5999999046325684,
                  "z": -29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 5.199999809265137,
                  "z": 6.679999828338623,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_320",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_SideHollowWall_-1_232",
              "transform": {
                "localPosition": {
                  "x": -8,
                  "y": 1.4500000476837158,
                  "z": -26.780000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 2.240000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_321",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_SideHollowWall_-1_233",
              "transform": {
                "localPosition": {
                  "x": -8,
                  "y": 4.050000190734863,
                  "z": -26.780000686645508,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.299999952316284,
                  "z": 2.240000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_322",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_SideHollowWall_-1_234",
              "transform": {
                "localPosition": {
                  "x": -8,
                  "y": 4.050000190734863,
                  "z": -29,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.299999952316284,
                  "z": 2.200000047683716,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_323",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_SideHollowWall_-1_235",
              "transform": {
                "localPosition": {
                  "x": -8,
                  "y": 1.4500000476837158,
                  "z": -31.219999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.9000000953674316,
                  "z": 2.240000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_324",
              "_$type": "Sprite3D",
              "name": "COL_LaneHouse_G_SideHollowWall_-1_236",
              "transform": {
                "localPosition": {
                  "x": -8,
                  "y": 4.050000190734863,
                  "z": -31.219999313354492,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.3199999928474426,
                  "y": 2.299999952316284,
                  "z": 2.240000009536743,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_325",
              "_$type": "Sprite3D",
              "name": "COL_LaneTurnScreen",
              "transform": {
                "localPosition": {
                  "x": -12,
                  "y": 1.350000023841858,
                  "z": 7,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4500007629394531,
                  "y": 2.700000047683716,
                  "z": 8,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_326",
              "_$type": "Sprite3D",
              "name": "COL_LaneTurnScreen_Coping",
              "transform": {
                "localPosition": {
                  "x": -12,
                  "y": 2.7699999809265137,
                  "z": 7,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5699996948242188,
                  "y": 0.1399998664855957,
                  "z": 8.139999389648438,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_327",
              "_$type": "Sprite3D",
              "name": "COL_LowCover_Courtyard_Fictional",
              "transform": {
                "localPosition": {
                  "x": -2,
                  "y": 0.4699999988079071,
                  "z": -13,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3,
                  "y": 0.9399999976158142,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_328",
              "_$type": "Sprite3D",
              "name": "COL_LowCover_Fictional",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 0.4699999988079071,
                  "z": 12,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 3.200000762939453,
                  "y": 0.9399999976158142,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_329",
              "_$type": "Sprite3D",
              "name": "COL_Mission_DoorHead",
              "transform": {
                "localPosition": {
                  "x": -18.799999237060547,
                  "y": 3.299999952316284,
                  "z": -22,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.4000015258789062,
                  "y": 1,
                  "z": 0.34999847412109375,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_330",
              "_$type": "Sprite3D",
              "name": "COL_Mission_DoorHead.001",
              "transform": {
                "localPosition": {
                  "x": -18.799999237060547,
                  "y": 3.299999952316284,
                  "z": -33,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.4000015258789062,
                  "y": 1,
                  "z": 0.34999847412109375,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_331",
              "_$type": "Sprite3D",
              "name": "COL_Mission_DoorWallSegment",
              "transform": {
                "localPosition": {
                  "x": -23.5,
                  "y": 1.899999976158142,
                  "z": -22,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 7,
                  "y": 3.799999952316284,
                  "z": 0.34999847412109375,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_332",
              "_$type": "Sprite3D",
              "name": "COL_Mission_DoorWallSegment.001",
              "transform": {
                "localPosition": {
                  "x": -15.300000190734863,
                  "y": 1.899999976158142,
                  "z": -22,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.600000381469727,
                  "y": 3.799999952316284,
                  "z": 0.34999847412109375,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_333",
              "_$type": "Sprite3D",
              "name": "COL_Mission_DoorWallSegment.002",
              "transform": {
                "localPosition": {
                  "x": -23.5,
                  "y": 1.899999976158142,
                  "z": -33,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 7,
                  "y": 3.799999952316284,
                  "z": 0.34999847412109375,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_334",
              "_$type": "Sprite3D",
              "name": "COL_Mission_DoorWallSegment.003",
              "transform": {
                "localPosition": {
                  "x": -15.300000190734863,
                  "y": 1.899999976158142,
                  "z": -33,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 4.600000381469727,
                  "y": 3.799999952316284,
                  "z": 0.34999847412109375,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_335",
              "_$type": "Sprite3D",
              "name": "COL_Mission_Floor",
              "transform": {
                "localPosition": {
                  "x": -20,
                  "y": -0.04999999701976776,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 14,
                  "y": 0.1599999964237213,
                  "z": 11,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_336",
              "_$type": "Sprite3D",
              "name": "COL_Mission_InteriorScreen",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 1.4500000476837158,
                  "z": -28.299999237060547,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 6,
                  "y": 2.9000000953674316,
                  "z": 0.15999984741210938,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_337",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideLowerWall",
              "transform": {
                "localPosition": {
                  "x": -27,
                  "y": 0.6200000047683716,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.34999847412109375,
                  "y": 1.2400000095367432,
                  "z": 11,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_338",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideLowerWall.001",
              "transform": {
                "localPosition": {
                  "x": -13,
                  "y": 0.6200000047683716,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.35000038146972656,
                  "y": 1.2400000095367432,
                  "z": 11,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_339",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideUpperWall",
              "transform": {
                "localPosition": {
                  "x": -27,
                  "y": 3.25,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.34999847412109375,
                  "y": 1.0999999046325684,
                  "z": 11,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_340",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideUpperWall.001",
              "transform": {
                "localPosition": {
                  "x": -13,
                  "y": 3.25,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.35000038146972656,
                  "y": 1.0999999046325684,
                  "z": 11,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_341",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideWindowPier",
              "transform": {
                "localPosition": {
                  "x": -27,
                  "y": 2,
                  "z": -23,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.34999847412109375,
                  "y": 1.5,
                  "z": 2,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_342",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideWindowPier.001",
              "transform": {
                "localPosition": {
                  "x": -27,
                  "y": 2,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.34999847412109375,
                  "y": 1.5,
                  "z": 2,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_343",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideWindowPier.002",
              "transform": {
                "localPosition": {
                  "x": -27,
                  "y": 2,
                  "z": -32,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.34999847412109375,
                  "y": 1.5,
                  "z": 2,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_344",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideWindowPier.003",
              "transform": {
                "localPosition": {
                  "x": -13,
                  "y": 2,
                  "z": -23,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.35000038146972656,
                  "y": 1.5,
                  "z": 2,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_345",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideWindowPier.004",
              "transform": {
                "localPosition": {
                  "x": -13,
                  "y": 2,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.35000038146972656,
                  "y": 1.5,
                  "z": 2,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_346",
              "_$type": "Sprite3D",
              "name": "COL_Mission_SideWindowPier.005",
              "transform": {
                "localPosition": {
                  "x": -13,
                  "y": 2,
                  "z": -32,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.35000038146972656,
                  "y": 1.5,
                  "z": 2,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_347",
              "_$type": "Sprite3D",
              "name": "COL_NorthBoundary",
              "transform": {
                "localPosition": {
                  "x": -16,
                  "y": 1.5499999523162842,
                  "z": -40,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 3.0999999046325684,
                  "z": 0.4499969482421875,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_348",
              "_$type": "Sprite3D",
              "name": "COL_NorthBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": -15.999999046325684,
                  "y": 3.1700000762939453,
                  "z": -40,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48.1199951171875,
                  "y": 0.1399998664855957,
                  "z": 0.589996337890625,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_349",
              "_$type": "Sprite3D",
              "name": "COL_NorthReturnBoundary",
              "transform": {
                "localPosition": {
                  "x": 8,
                  "y": 1.350000023841858,
                  "z": -28.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4500002861022949,
                  "y": 2.700000047683716,
                  "z": 23,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_350",
              "_$type": "Sprite3D",
              "name": "COL_NorthReturnBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": 8,
                  "y": 2.7699999809265137,
                  "z": -28.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5699996948242188,
                  "y": 0.1399998664855957,
                  "z": 23.139999389648438,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_351",
              "_$type": "Sprite3D",
              "name": "COL_SouthBoundary",
              "transform": {
                "localPosition": {
                  "x": -16,
                  "y": 1.5499999523162842,
                  "z": 32,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 3.0999999046325684,
                  "z": 0.4499988555908203,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_352",
              "_$type": "Sprite3D",
              "name": "COL_SouthBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": -15.999999046325684,
                  "y": 3.1700000762939453,
                  "z": 32,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48.1199951171875,
                  "y": 0.1399998664855957,
                  "z": 0.5899982452392578,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_353",
              "_$type": "Sprite3D",
              "name": "COL_SouthReturnBoundary",
              "transform": {
                "localPosition": {
                  "x": 8,
                  "y": 1.350000023841858,
                  "z": 24.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4500002861022949,
                  "y": 2.700000047683716,
                  "z": 15,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_354",
              "_$type": "Sprite3D",
              "name": "COL_SouthReturnBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": 8,
                  "y": 2.7699999809265137,
                  "z": 24.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5699996948242188,
                  "y": 0.1399998664855957,
                  "z": 15.139999389648438,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_355",
              "_$type": "Sprite3D",
              "name": "COL_StreetPaving",
              "transform": {
                "localPosition": {
                  "x": -16,
                  "y": -0.10000000149011612,
                  "z": -4,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 48,
                  "y": 0.20000000298023224,
                  "z": 74,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_356",
              "_$type": "Sprite3D",
              "name": "COL_WestBoundary",
              "transform": {
                "localPosition": {
                  "x": -40,
                  "y": 1.5499999523162842,
                  "z": -3,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.4499969482421875,
                  "y": 3.0999999046325684,
                  "z": 70,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_col_357",
              "_$type": "Sprite3D",
              "name": "COL_WestBoundary_Coping",
              "transform": {
                "localPosition": {
                  "x": -40,
                  "y": 3.1700000762939453,
                  "z": -3,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.5699996948242188,
                  "y": 0.1399998664855957,
                  "z": 70.13999938964844,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr9",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_0",
              "transform": {
                "localPosition": {
                  "x": -25,
                  "y": 0.5,
                  "z": 9,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1,
                  "y": 1,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr14",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_1",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 0.5,
                  "z": 9,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1,
                  "y": 1,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr19",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_2",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 1.5,
                  "z": 9,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1,
                  "y": 1,
                  "z": 1,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr24",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_3",
              "transform": {
                "localPosition": {
                  "x": -8,
                  "y": 0.550000011920929,
                  "z": -1,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 1.100000023841858,
                  "y": 1.100000023841858,
                  "z": 1.100000023841858,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr29",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_4",
              "transform": {
                "localPosition": {
                  "x": 2,
                  "y": 0.44999998807907104,
                  "z": -14,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.8999999761581421,
                  "y": 0.8999999761581421,
                  "z": 0.8999999761581421,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr34",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_5",
              "transform": {
                "localPosition": {
                  "x": -5,
                  "y": 0.44999998807907104,
                  "z": -15,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.8999999761581421,
                  "y": 0.8999999761581421,
                  "z": 0.8999999761581421,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_pr39",
              "_$type": "Sprite3D",
              "name": "COL_MovableCrate_Fictional_6",
              "transform": {
                "localPosition": {
                  "x": -29,
                  "y": 0.4000000059604645,
                  "z": -30,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.800000011920929,
                  "y": 0.800000011920929,
                  "z": 0.800000011920929,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi0",
              "_$type": "Sprite3D",
              "name": "COL_Mission_Bench",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 0.5,
                  "z": -24.100000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.5,
                  "y": 0.11999999731779099,
                  "z": 0.4000000059604645,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi1",
              "_$type": "Sprite3D",
              "name": "COL_Mission_BenchLeg",
              "transform": {
                "localPosition": {
                  "x": -24,
                  "y": 0.23999999463558197,
                  "z": -24.100000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.14000000059604645,
                  "y": 0.47999998927116394,
                  "z": 0.33000001311302185,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi2",
              "_$type": "Sprite3D",
              "name": "COL_Mission_BenchLeg.001",
              "transform": {
                "localPosition": {
                  "x": -22,
                  "y": 0.23999999463558197,
                  "z": -24.100000381469727,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.14000000059604645,
                  "y": 0.47999998927116394,
                  "z": 0.33000001311302185,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi32",
              "_$type": "Sprite3D",
              "name": "COL_Mission_Shelf",
              "transform": {
                "localPosition": {
                  "x": -26.350000381469727,
                  "y": 0.18000000715255737,
                  "z": -30.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.699999988079071,
                  "y": 0.10000000149011612,
                  "z": 2.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi33",
              "_$type": "Sprite3D",
              "name": "COL_Mission_Shelf.001",
              "transform": {
                "localPosition": {
                  "x": -26.350000381469727,
                  "y": 1,
                  "z": -30.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.699999988079071,
                  "y": 0.10000000149011612,
                  "z": 2.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi34",
              "_$type": "Sprite3D",
              "name": "COL_Mission_Shelf.002",
              "transform": {
                "localPosition": {
                  "x": -26.350000381469727,
                  "y": 1.7999999523162842,
                  "z": -30.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.699999988079071,
                  "y": 0.10000000149011612,
                  "z": 2.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi35",
              "_$type": "Sprite3D",
              "name": "COL_Mission_Shelf.003",
              "transform": {
                "localPosition": {
                  "x": -26.350000381469727,
                  "y": 2.5999999046325684,
                  "z": -30.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.699999988079071,
                  "y": 0.10000000149011612,
                  "z": 2.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi36",
              "_$type": "Sprite3D",
              "name": "COL_Mission_ShelfBack",
              "transform": {
                "localPosition": {
                  "x": -26.65999984741211,
                  "y": 1.2999999523162842,
                  "z": -30.399999618530273,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.10000000149011612,
                  "y": 2.5999999046325684,
                  "z": 2.5999999046325684,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi47",
              "_$type": "Sprite3D",
              "name": "COL_Mission_TableLeg",
              "transform": {
                "localPosition": {
                  "x": -24.100000381469727,
                  "y": 0.4300000071525574,
                  "z": -25.270000457763672,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.11999999731779099,
                  "y": 0.8600000143051147,
                  "z": 0.11999999731779099,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi48",
              "_$type": "Sprite3D",
              "name": "COL_Mission_TableLeg.001",
              "transform": {
                "localPosition": {
                  "x": -24.100000381469727,
                  "y": 0.4300000071525574,
                  "z": -26.1299991607666,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.11999999731779099,
                  "y": 0.8600000143051147,
                  "z": 0.11999999731779099,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi49",
              "_$type": "Sprite3D",
              "name": "COL_Mission_TableLeg.002",
              "transform": {
                "localPosition": {
                  "x": -21.899999618530273,
                  "y": 0.4300000071525574,
                  "z": -25.270000457763672,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.11999999731779099,
                  "y": 0.8600000143051147,
                  "z": 0.11999999731779099,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi50",
              "_$type": "Sprite3D",
              "name": "COL_Mission_TableLeg.003",
              "transform": {
                "localPosition": {
                  "x": -21.899999618530273,
                  "y": 0.4300000071525574,
                  "z": -26.1299991607666,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.11999999731779099,
                  "y": 0.8600000143051147,
                  "z": 0.11999999731779099,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_mi51",
              "_$type": "Sprite3D",
              "name": "COL_Mission_TableTop",
              "transform": {
                "localPosition": {
                  "x": -23,
                  "y": 0.8999999761581421,
                  "z": -25.700000762939453,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 2.799999952316284,
                  "y": 0.12999999523162842,
                  "z": 1.2000000476837158,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_st4",
              "_$type": "Sprite3D",
              "name": "COL_CourtyardGateLintel",
              "transform": {
                "localPosition": {
                  "x": -7.5,
                  "y": 3.5999999046325684,
                  "z": -6,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 5.650000095367432,
                  "y": 0.30000001192092896,
                  "z": 0.6000000238418579,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_st5",
              "_$type": "Sprite3D",
              "name": "COL_CourtyardGatePier",
              "transform": {
                "localPosition": {
                  "x": -10,
                  "y": 1.7999999523162842,
                  "z": -6,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.6499999761581421,
                  "y": 3.5999999046325684,
                  "z": 0.6499999761581421,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_extra_st6",
              "_$type": "Sprite3D",
              "name": "COL_CourtyardGatePier.001",
              "transform": {
                "localPosition": {
                  "x": -5,
                  "y": 1.7999999523162842,
                  "z": -6,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 0.6499999761581421,
                  "y": 3.5999999046325684,
                  "z": 0.6499999761581421,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
              "_$id": "sb_ceiling",
              "_$type": "Sprite3D",
              "name": "COL_MissionCeiling",
              "transform": {
                "localPosition": {
                  "x": -20,
                  "y": 3.9,
                  "z": -27.5,
                  "_$type": "Vector3"
                },
                "localScale": {
                  "x": 14,
                  "y": 0.18,
                  "z": 11,
                  "_$type": "Vector3"
                }
              },
              "_$comp": [
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
          "_$id": "enemy005",
          "_$type": "Sprite3D",
          "name": "Interior_Enemy05_Fictional",
          "transform": {
            "localPosition": {
              "x": -18,
              "y": 0.05,
              "z": 0,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "sb_e5_ai_target001_eye"
              },
              "shotPoint": {
                "_$ref": "sb_e5_ai_target001_muzzle"
              },
              "shotBase": {
                "_$ref": "sb_e5_ai_target001_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "sb_e5_ai_target001_patrol_0"
                },
                {
                  "_$ref": "sb_e5_ai_target001_patrol_1"
                },
                {
                  "_$ref": "sb_e5_ai_target001_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
            }
          ],
          "_$child": [
            {
              "_$id": "sb_e5_head0001",
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
              "_$id": "sb_e5_torso001",
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
              "_$id": "sb_e5_legs0001",
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
              "_$id": "sb_e5_enemyarm1",
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
              "_$id": "sb_e5_enemyarm2",
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
              "_$id": "sb_e5_enemygun1",
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
                  "_$id": "sb_e5_flashen1",
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
                      "_$id": "sb_e5_flashen1h",
                      "_$type": "Sprite3D",
                      "name": "sb_e5_flashen1h",
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
                      "_$id": "sb_e5_flashen1v",
                      "_$type": "Sprite3D",
                      "name": "sb_e5_flashen1v",
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
                      "_$id": "sb_e5_flashen1c",
                      "_$type": "Sprite3D",
                      "name": "sb_e5_flashen1c",
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
                  "_$id": "sb_e5_gunvisual0",
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
                },
                {
                  "_$id": "sb_e5_ai_target001_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "sb_e5_ai_target001_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "sb_e5_charvisual1",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "sb_e5_ai_target001_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "enemy006",
          "_$type": "Sprite3D",
          "name": "Interior_Enemy06_Fictional",
          "transform": {
            "localPosition": {
              "x": -35,
              "y": 0.05,
              "z": 5,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "sb_e6_ai_target001_eye"
              },
              "shotPoint": {
                "_$ref": "sb_e6_ai_target001_muzzle"
              },
              "shotBase": {
                "_$ref": "sb_e6_ai_target001_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "sb_e6_ai_target001_patrol_0"
                },
                {
                  "_$ref": "sb_e6_ai_target001_patrol_1"
                },
                {
                  "_$ref": "sb_e6_ai_target001_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
            }
          ],
          "_$child": [
            {
              "_$id": "sb_e6_head0001",
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
              "_$id": "sb_e6_torso001",
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
              "_$id": "sb_e6_legs0001",
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
              "_$id": "sb_e6_enemyarm1",
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
              "_$id": "sb_e6_enemyarm2",
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
              "_$id": "sb_e6_enemygun1",
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
                  "_$id": "sb_e6_flashen1",
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
                      "_$id": "sb_e6_flashen1h",
                      "_$type": "Sprite3D",
                      "name": "sb_e6_flashen1h",
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
                      "_$id": "sb_e6_flashen1v",
                      "_$type": "Sprite3D",
                      "name": "sb_e6_flashen1v",
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
                      "_$id": "sb_e6_flashen1c",
                      "_$type": "Sprite3D",
                      "name": "sb_e6_flashen1c",
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
                  "_$id": "sb_e6_gunvisual0",
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
                },
                {
                  "_$id": "sb_e6_ai_target001_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "sb_e6_ai_target001_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "sb_e6_charvisual1",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "sb_e6_ai_target001_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "enemy007",
          "_$type": "Sprite3D",
          "name": "Interior_Enemy07_Fictional",
          "transform": {
            "localPosition": {
              "x": 20,
              "y": 0.08,
              "z": 0,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "sb_e7_ai_target001_eye"
              },
              "shotPoint": {
                "_$ref": "sb_e7_ai_target001_muzzle"
              },
              "shotBase": {
                "_$ref": "sb_e7_ai_target001_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "sb_e7_ai_target001_patrol_0"
                },
                {
                  "_$ref": "sb_e7_ai_target001_patrol_1"
                },
                {
                  "_$ref": "sb_e7_ai_target001_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
            }
          ],
          "_$child": [
            {
              "_$id": "sb_e7_head0001",
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
              "_$id": "sb_e7_torso001",
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
              "_$id": "sb_e7_legs0001",
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
              "_$id": "sb_e7_enemyarm1",
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
              "_$id": "sb_e7_enemyarm2",
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
              "_$id": "sb_e7_enemygun1",
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
                  "_$id": "sb_e7_flashen1",
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
                      "_$id": "sb_e7_flashen1h",
                      "_$type": "Sprite3D",
                      "name": "sb_e7_flashen1h",
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
                      "_$id": "sb_e7_flashen1v",
                      "_$type": "Sprite3D",
                      "name": "sb_e7_flashen1v",
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
                      "_$id": "sb_e7_flashen1c",
                      "_$type": "Sprite3D",
                      "name": "sb_e7_flashen1c",
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
                  "_$id": "sb_e7_gunvisual0",
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
                },
                {
                  "_$id": "sb_e7_ai_target001_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "sb_e7_ai_target001_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "sb_e7_charvisual1",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "sb_e7_ai_target001_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "enemy008",
          "_$type": "Sprite3D",
          "name": "Interior_Enemy08_Fictional",
          "transform": {
            "localPosition": {
              "x": -3,
              "y": 0.05,
              "z": -29,
              "_$type": "Vector3"
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
              "patrolSpeed": 0.75,
              "observationPoint": {
                "_$ref": "sb_e8_ai_target001_eye"
              },
              "shotPoint": {
                "_$ref": "sb_e8_ai_target001_muzzle"
              },
              "shotBase": {
                "_$ref": "sb_e8_ai_target001_breech"
              },
              "observationOffset": {
                "_$type": "Vector3",
                "y": 2.3
              },
              "shotOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.8
              },
              "shotBaseOffset": {
                "_$type": "Vector3",
                "x": 0.1,
                "y": 1.84,
                "z": 0.26
              },
              "patrolPoints": [
                {
                  "_$ref": "sb_e8_ai_target001_patrol_0"
                },
                {
                  "_$ref": "sb_e8_ai_target001_patrol_1"
                },
                {
                  "_$ref": "sb_e8_ai_target001_patrol_2"
                }
              ],
              "patrolRadius": 1.6,
              "patrolWaitSeconds": 1.2,
              "turnSpeed": 180
            }
          ],
          "_$child": [
            {
              "_$id": "sb_e8_head0001",
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
              "_$id": "sb_e8_torso001",
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
              "_$id": "sb_e8_legs0001",
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
              "_$id": "sb_e8_enemyarm1",
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
              "_$id": "sb_e8_enemyarm2",
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
              "_$id": "sb_e8_enemygun1",
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
                  "_$id": "sb_e8_flashen1",
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
                      "_$id": "sb_e8_flashen1h",
                      "_$type": "Sprite3D",
                      "name": "sb_e8_flashen1h",
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
                      "_$id": "sb_e8_flashen1v",
                      "_$type": "Sprite3D",
                      "name": "sb_e8_flashen1v",
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
                      "_$id": "sb_e8_flashen1c",
                      "_$type": "Sprite3D",
                      "name": "sb_e8_flashen1c",
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
                  "_$id": "sb_e8_gunvisual0",
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
                },
                {
                  "_$id": "sb_e8_ai_target001_breech",
                  "_$type": "Sprite3D",
                  "name": "ShotBase",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1
                    }
                  }
                },
                {
                  "_$id": "sb_e8_ai_target001_muzzle",
                  "_$type": "Sprite3D",
                  "name": "ShotPoint",
                  "transform": {
                    "localPosition": {
                      "_$type": "Vector3",
                      "y": 1,
                      "z": 0.6585365853658537
                    }
                  }
                }
              ]
            },
            {
              "_$id": "sb_e8_charvisual1",
              "_$prefab": "df374c28-d931-4eb6-9b13-638709b65707",
              "name": "EnemyVisual"
            },
            {
              "_$id": "sb_e8_ai_target001_eye",
              "_$type": "Sprite3D",
              "name": "ObservationPoint",
              "transform": {
                "localPosition": {
                  "_$type": "Vector3",
                  "y": 2.3
                }
              }
            }
          ]
        },
        {
          "_$id": "sb_roomlight",
          "_$type": "Sprite3D",
          "name": "Songbaix_InteriorFill",
          "transform": {
            "localPosition": {
              "x": -23,
              "y": 3,
              "z": -25.5,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.86,
                "b": 0.7
              },
              "intensity": 1.1,
              "range": 10
            }
          ]
        },
        {
          "_$id": "sb_roomfill_0",
          "_$type": "Sprite3D",
          "name": "RoomFill_0",
          "transform": {
            "localPosition": {
              "x": -35,
              "y": 3,
              "z": 23,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 10
            }
          ]
        },
        {
          "_$id": "sb_roomfill_1",
          "_$type": "Sprite3D",
          "name": "RoomFill_1",
          "transform": {
            "localPosition": {
              "x": -18,
              "y": 3,
              "z": 24,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 9
            }
          ]
        },
        {
          "_$id": "sb_roomfill_2",
          "_$type": "Sprite3D",
          "name": "RoomFill_2",
          "transform": {
            "localPosition": {
              "x": -35,
              "y": 3,
              "z": 5,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 10
            }
          ]
        },
        {
          "_$id": "sb_roomfill_3",
          "_$type": "Sprite3D",
          "name": "RoomFill_3",
          "transform": {
            "localPosition": {
              "x": -18,
              "y": 3,
              "z": 0,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 9
            }
          ]
        },
        {
          "_$id": "sb_roomfill_4",
          "_$type": "Sprite3D",
          "name": "RoomFill_4",
          "transform": {
            "localPosition": {
              "x": -35,
              "y": 3,
              "z": -17,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 10
            }
          ]
        },
        {
          "_$id": "sb_roomfill_5",
          "_$type": "Sprite3D",
          "name": "RoomFill_5",
          "transform": {
            "localPosition": {
              "x": -4,
              "y": 3,
              "z": 24,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 9
            }
          ]
        },
        {
          "_$id": "sb_roomfill_6",
          "_$type": "Sprite3D",
          "name": "RoomFill_6",
          "transform": {
            "localPosition": {
              "x": -3,
              "y": 3,
              "z": -29,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 8
            }
          ]
        },
        {
          "_$id": "sb_roomfill_7",
          "_$type": "Sprite3D",
          "name": "RoomFill_7",
          "transform": {
            "localPosition": {
              "x": 22,
              "y": 6,
              "z": 0,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 22
            }
          ]
        },
        {
          "_$id": "sb_roomfill_8",
          "_$type": "Sprite3D",
          "name": "RoomFill_8",
          "transform": {
            "localPosition": {
              "x": 44,
              "y": 6,
              "z": 0,
              "_$type": "Vector3"
            }
          },
          "_$comp": [
            {
              "_$type": "PointLightCom",
              "color": {
                "_$type": "Color",
                "r": 1,
                "g": 0.91,
                "b": 0.8
              },
              "intensity": 0.9,
              "range": 22
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
      "text": "WASD 移动 · 鼠标转向 · 1 汉阳造 / 3 短刀 · 左键单发 / 轻击 · 右键开镜 / 重击 · R 装填 · Space 跳跃 · Shift 疾跑 · C 下蹲 · Esc 释放",
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
      "text": "街口 0/2 · 院落 0/2 · 文件 0/1",
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
      "text": "任务 1/4：清理街口敌人 0/2",
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
      "text": "松柏巷街区 · 历史地标参考 / 虚构任务布局",
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
          "height": 620,
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
              "_$id": "reloadvolumelabel",
              "_$type": "GTextField",
              "name": "ReloadVolumeLabel",
              "x": 60,
              "y": 196,
              "width": 520,
              "height": 36,
              "_mouseState": 1,
              "text": "装填音量  100%",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#ffffff",
              "valign": "middle"
            },
            {
              "_$id": "reloadvolumeslider",
              "_$type": "GSlider",
              "name": "ReloadVolumeSlider",
              "x": 60,
              "y": 240,
              "width": 520,
              "height": 42,
              "_mouseState": 2,
              "value": 100,
              "wholeNumbers": true,
              "_hBar": {
                "_$ref": "reloadvolumesliderbar"
              },
              "_gripButton": {
                "_$ref": "reloadvolumeslidergrip"
              },
              "_$child": [
                {
                  "_$id": "reloadvolumeslidertrack",
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
                  "_$id": "reloadvolumesliderbar",
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
                  "_$id": "reloadvolumeslidergrip",
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
              "_$id": "meleevolumelabel",
              "_$type": "GTextField",
              "name": "MeleeVolumeLabel",
              "x": 60,
              "y": 292,
              "width": 520,
              "height": 36,
              "_mouseState": 1,
              "text": "挥刀音量  100%",
              "font": "Microsoft YaHei",
              "fontSize": 22,
              "color": "#ffffff",
              "valign": "middle"
            },
            {
              "_$id": "meleevolumeslider",
              "_$type": "GSlider",
              "name": "MeleeVolumeSlider",
              "x": 60,
              "y": 336,
              "width": 520,
              "height": 42,
              "_mouseState": 2,
              "value": 100,
              "wholeNumbers": true,
              "_hBar": {
                "_$ref": "meleevolumesliderbar"
              },
              "_gripButton": {
                "_$ref": "meleevolumeslidergrip"
              },
              "_$child": [
                {
                  "_$id": "meleevolumeslidertrack",
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
                  "_$id": "meleevolumesliderbar",
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
                  "_$id": "meleevolumeslidergrip",
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
              "y": 388,
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
              "y": 432,
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
              "y": 486,
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
              "y": 536,
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
              "y": 536,
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