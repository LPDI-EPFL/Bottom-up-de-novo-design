# Building of the 3H1L_01 topology to accommodate RSVF antigenic site 0 
To accommodate the antigenic site 0 (RSVF structure: PDB DI 4jhw, residues 196-212 and 63-69), we used the TopoBuilder to built two supporting helices as shown in the [sketch](./A1H_B1C_A2H_B2H/sketch.pdb) and the illustration below. Each helix was built with a length of 20 amino acids, with a distance between each other and to the site 0 epitope of 11 A. The configuration file to built the topology can be found below or downloaded [here](./Topo2H_rev.json).  

![](Topo2H.png)


TopoBuilder json configuration file: 
```
{
  "config": {
    "name": "3H1L_01",
    "default_z": 11,
    "default_x_h": 11
  },
  "layers" : [
    [
      {
        "type" : "H",
        "length" : 20,
	"shift_x" : 0,
	"shift_y" : -6,  
	"tilt_y": 0,
	"tilt_z": 0
      },
       
	{"type" : "H",
        "length" : 20,
	"shift_x" : 11,
	"shift_y": -6, 
	"tilt_y": 0,
"tilt_z": 0}
    ],
    [      {
        "type" : "C",
        "edge": -1,
        "ref": "d25_1.loop"
      },
	{"type" : "H",
        "ref": "d25_1.helix"}
    ]
  ],
  "motifs": [
    {
      "id": "d25_1",
      "pdbfile": "4jhw.pdb",
      "chain": "F",
      "segments": [
        {
          "ini": 62,
          "end": 69,
          "id": "loop"
        },
        {
          "ini": 196,
          "end": 212,
          "id": "helix"
        }
      ]
    }
  ]
}
```


Following a first round of folding (see [output](./A1H_B1C_A2H_B2H/out)), we selected one of the best decoys according to total rosetta energy and optimized the loop connections using Rosetta Remodel. A blueprint file to build the connecting loops can be found [here](./3H1L.blueprint). 
For instructions regarding the Rosetta remodel application, please see the offical Rosetta documentation. To run remodel, use: 
```
PATH/TO/ROSETTA/main/source/bin/remodel.linuxgccrelease -database PATH/TO/DATABASE -s 3H1L_01_remodel_input.pdb  -remodel:blueprint 3H1L_01.remodel.blueprint -nstruct 100 -remodel:use_pose_relax true -ex1 -ex2 
``` 

In the following animation, the segments that were remodeled are colored red, the segments built by TopoBuilder are grey, and the site 0 epitope is colored purple. 

![](3H1L_01_loops.gif)

Following remodeling, we selected one decoy as design template for a second round of folding and desing using Rosetta FunFolDes with the provided [input_files](./input_files_FunFolDes). 

The FunFolDes [script](./input_files_FunFolDes/3H1L_01.rd2_folding.xml) can be executed with: 

```
/work/upcorreia/bin/rosetta_bin/stable/RosettaWeekly/rosetta_scripts.linuxiccrelease -s 3H1L_01.rd2_folding.template.pdb  -parser:protocol 3H1L_01.rd2_folding.xml
```

We generated ~20,000 decoys, which were subsequently ranked according to overall Rosetta energy, backbone geometry and core packing for subsequent experimental testing. 




