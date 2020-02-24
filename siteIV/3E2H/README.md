# Design of 3E2H topology to accommodate the RSVF antigenic site IV (101F epitope) 
## 3E2H topology construction and design (the topology contains two ideal beta strand, two ideal helices and a motif) 
The de novo designed 3E2H topology accommodates the RSV antigenic site IV, a motif consisting of a bulged beta strand.  

The antigenic site IV was extracted from the peptide-bound structure with a potent neutralizing antibody 101F (PDB 3O41, chain F). The epitope region consists of residues 429-434 according to the numbering of RSVF structure.

In order to maintain the structural stablization of motif, the built protein fold should avoid to start/end with the motif  
,meaning that the chosen connectivity should always be designed to link the motif at both terminus. For 3E2H, we used the TopoBuilder to built two supporting strands to form a beta-sheet with motif and one helix in another layer to pack against building sheet as shown in the [sketch](./1\)Foling_trajectory/B1E_C1E_C2H_A1E_A2H/input_3E2H/sketch.pdb). Each strand was built with a length of 7 amino acids. The topology was assembled using TopoBuilder with all the tunable parameters specified in json file [here](./1\)Foling_trajectory/3E2H.json). 

TopoBuilder json configuration file: 
```
{
  "layers" : [
     [
      {
        "type" : "E",
        "length" : 7,
        "tilt_y" : 90,
        "shift_x" : -1,
      	"shift_y" : -2,
	      "shift_z" : 13.1
      },
      {
        "type" : "H",
        "length" : 16,
        "shift_x" : 9,
        "tilt_y" : -180,
        "shift_y" : -2,
	      "shift_z" : 10,
        "tilt_x" : -5
      }
    ],
    [
      {
        "type" : "E",
        "length" : 7,
	      "tilt_y" : -95,
	      "shift_x" : -1.3,
	      "shift_y" : -2,
	      "shift_z" : 6.8
      }
    ],
    [
      {
        "type" : "E",
        "ref" : "101.strand1"
      },
      {
        "type" : "H",
 	      "length" : 15,
	      "shift_z" : -3,
        "shift_x" : 11.5,
        "tilt_x" : -5,
        "tilt_y" : -180
      }
    ]
  ],
  "config" : {
    "name" : "101"
  },
  "motifs" : [
    {
      "id" : "101",
      "chain" : "A",
      "pdbfile" : "template.pdb",
      "segments" : [
        {
          "ini" : 28,
          "end" : 34,
          "id" : "strand1"
        }
      ]
    }
  ]
}
```

### 3E2H folding and design 
Using the provided input files, the 3E2H topology was built and folded using Rosetta FunFolDes, generating approximatelyaround 15000 [decoys](./1\)Foling_trajectory/B1E_C1E_C2H_A1E_A2H/3E2H_folding_design.csv). The top 100 decoys were selected according to several scoring metrics: overall energy, core packing and ramachandran scores, and the best scoring decoys were inspected manually. 

Following manual inspection, we remodeled and shortened a connecting loop between the motif and a following helix, in between residues 22-27, with the provided [blueprint](./2\)Remodel_fix_connection/3E2H_rd1_blueprint) to specify the exact residues need to adapt the loop remodeling. For instructions regarding the Rosetta remodel application, please see the offical Rosetta documentation. To run remodel, use: 

```
PATH/TO/ROSETTA/main/source/bin/remodel.linuxgccrelease -database PATH/TO/DATABASE -s   -remodel:blueprint 3E2H_rd1_blueprint -nstruct 50 -remodel:use_pose_relax true -ex1 -ex2 
``` 

The shortened template subsequently served as template for a second round of constrained sequence design and building a disulfide bridge using the [provided script](./3\)Sequence_design_selection/3E2H_layerdesign_protocol.xml).The Design script can be executed by the following command line:  

```
/work/upcorreia/bin/rosetta_bin/stable/RosettaWeekly/rosetta_scripts.linuxiccrelease @flags -s   -parser:protocol 3E2H_layerdesign_protocol.xml 
```

The decoys generated from second round of sequence design were [provided](./3\)Sequence_design_selection/3E2H.minisilent.gz). Based on an ensemble of the 100 best decoys according to total energy, we selected 7 core positions and 6 potential positions close to the binding interface to build a sequence library for combinatorial sampling of a restricted set of amino acids for the given positions (Fig.S3). 

### 3E2H library design and testing 
For experimental testing, we assembled the combinatorial library by primers carrying the degenerate codon to cover a defined diversity in 13 critical positions, as detailed below.

| Position| AA to sample|
| :------:|:-----------:|
| 5       | IV          |
| 7       | IV          |
| 8       | EGKR        |
| 28      | AE          | 
| 29      | FILV        | 
| 33      | RW          | 
| 36      | AG          | 
| 50      | FILM        |
| 53      | HLQR        |
| 54      | LV          | 
| 57      | AV          |
| 60      | EV          |
| 62      | EKQ         |

The following animation shows the [best scoring decoy](./3\)Sequence_design_selection/3E2H_rd2_sequence_design.pdb), which was chosen as a template to select critical core positions for combinatorial sampling. Selected core positions encoded in the combinatorial library are highlighted in green, and the positions in a proximity of binding interface are colored in salmon red, and the site IV epitope shown in orange. 

![](./3E2H.gif)

The library was screened using yeast surface display under double selective pressure: binding to 101F antibodies, and residual binding after pre-treatment of the nonspecific protease chymotrypsin to ensure the designed topology presents the functional motif in its native conformation, while maintaining the stable protein fold (Fig.S8). For each screening condition, the best 1-2% of clones were sorted, and the sorted populations were bulk-sequenced using next-generation sequencing. We then computed an enrichment score for each sequence, which represents the frequency of each sequence under stringed selection conditions. All protein sequences and their computed enrichments under selection for binding to 101F, or 101F+chymotrypsin can be found [here](./4\)NGS_seq/3E2H_NGS.csv). The computational models of the sequences with the strongest enrichments can be found [here](). Followed with next-generation sequencing, we then choose around 10 sequences showing the strongest enrichments for recombinant expression and biophysical characterization.
