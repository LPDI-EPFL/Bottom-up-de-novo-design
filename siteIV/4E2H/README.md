# Design of 4E2H topology to accommodate the RSVF antigenic site IV (101F epitope) 
## 4E2H topology construction and design 
As mentioned in the description of [3E2H](../3E2H/README.md), the motif was extracted from a previously solved peptide-bound structure with the target antibody 101F (PDB ID 3O41). To build the *de novo* backbone containing a beta sheet with four strands packing against two helices, we used the TopoBuilder to assemble ideal secondary structure elements together with the site IV motifs as shown in the [sketch](./1\)Folding_trajectory/input_4E2H/A1E_B2H_C1E_D1E_D2H_B1E/sketch.pdb). The json file to define the secondary structure length and their spatial positioning is provided [here](./1\)Folding_trajectory/input_4E2H/4E2H.json).   
 
## 4E2H folding and design 
Using the provided [input files](./1\)Folding_trajectory/input_4E2H/), the 4E2H topology was built and folded using Rosetta FunFolDes, generating approximately [10000 decoys](./1\)Folding_trajectory/4E2H_folding_pose.csv). The top 300 decoys were selected according to several scoring metrics: overall energy, core packing and match of composition of secondary structures, and the best scoring decoys were inspected manually. 

Following manual inspection, we increased the length of one residue in a connecting loop between residues 40 and 42, and remodeled several connecting loops to enforce the formation of secondary structures. The exact residues are specified in the [blueprint](./2\)Remodel_fix_connection/4E2H_rd1_blueprint). For instructions regarding the Rosetta remodel application, please see the offical Rosetta documentation. To run remodel algorithm, use: 

```
PATH/TO/ROSETTA/main/source/bin/remodel.linuxgccrelease -database PATH/TO/DATABASE -s 4E2H_folding_rd1.pdb -remodel:blueprint 4E2H_rd1_blueprint -nstruct 50 -remodel:use_pose_relax true -ex1 -ex2 
```  

The remodeled template subsequently served as template for the constrianed sequence design using the [provided script](./3\)Sequence_design_selection/4E2H_layerdesign_protocol.xml) with a defined [resfile](./3\)Sequence_design_selection/4E2H_rd2_Resfile) to specify the positions and the amino acids sampled. The Design script can be executed by the following command line:  

```
PATH/TO/ROSETTA/main/source/bin/rosetta_scripts.linuxiccrelease @4E2H_rd2_flags -s 4E2H_rd2_seq_design.pdb -parser:protocol 4E2H_layerdesign_protocol.xml
``` 
The decoys generated from the sequence design can be found [here](./3\)Sequence_design_selection/4E2H_rd2.minisilent). 

Based on an ensemble of the 100 best decoys according to total energy, we selected 13 core positions and 6 surface positions close to the binding interface to construct a sequence library for combinatorial sampling of a restricted set of amino acids, most of them suggested by Rosetta (see Fig. S5 of the manuscript). 

## 4E2H library design and testing 
For experimental testing, we assembled a combinatorial library with primers to cover a defined diversity in 19 critical positions, as detailed below.

| Position| AA to sample|
| :------:|:-----------:|
| 2       | NY          |
| 4       | FI          |
| 14      | LV          |
| 15      | AE          | 
| 18      | FLV         | 
| 21      | HQ          | 
| 25      | LW          | 
| 26      | AV          |
| 34      | IV          |
| 38      | AV          | 
| 58      | DV          |
| 59      | FL          |
| 62      | FL          |
| 63      | AE          |
| 65      | AG          |
| 66      | LV          |
| 76      | IV          |
| 78      | IV          |
| 80      | IL          |

The following animation shows the [best scoring decoy](./4E2H.gif), and core positions sampled combinatorially are highlighted in green, and the site IV epitope is shown in orange. 

![](./4E2H.gif)

The library was screened using yeast surface display for binding to 101F, and residual binding after pre-treatment with the nonspecific protease chymotrypsin to ensure the designed topology presents the functional motif in its native conformation, while maintaining the stable protein fold (Fig.S8). For each screening condition, the best 1-2% of clones were sorted, and the sorted populations were bulk-sequenced using next-generation sequencing. We then computed an enrichment score for each sequence, as detailed throughout the manuscript. All protein sequences and their computed enrichments under selection for binding to 101F, or 101F+chymotrypsin can be found [here](./4\)NGS_seq/4b2a_NGS.csv). The computational models of the sequences with the strongest enrichments can be found [here]().
