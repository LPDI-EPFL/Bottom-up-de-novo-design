# Assembly of a dual motif scaffold accommodating RSVF site II and RSVG 2D10 epitope
To showcase the ability of assembling a topology from scratch that acccommodates two distinct binding motifs, we built a 4H topology around the RSVF site II (PDB codes [3IXT](https://www.rcsb.org/structure/3IXT)) and the RSVG 2D10 motif (PDB codes [5WN9](https://www.rcsb.org/structure/5WN9)). The secondary structure of the site II is a regular helix-loop-helix motif (HLH), whereas the 2D10 motif consists of an irregular helix-loop (HL) structure. 

It is important to note that while each motif was relatively frequently found in the natural protein repertoire, the number of available template structures that can simultaneously accommodate both motifs was extremely limited, as shown in the figure below. This is an illustrative example of the limited utility of a top-down approach for the design of protein scaffolds accommodating multiple functional motifs, highlighting the need for a bottom-up approach as presented in our manuscript. 

![](Mota_2D10_scaffold_search.png)

## 4H topology building and design 
The motifs were extracted from previously solved peptide-bound structures with their target antibodies. We  extended  the epitopes by 3-4 helical turns for each epitope using Rosetta remodel. We then used the TopoBuilder to assemble them  in a back-to-back orientation as shown in the [sketch](./1\)Folding_trajectory/input_4H/A1H_B1H/sketch.pdb). Distances and spatial positioning between the different secondary structures were defined as specified [here](./1\)Folding_trajectory/input_4H/twoMoitf.json).   
 
### 4H folding and design 
Using the provided [input files](./1\)Folding_trajectory/input_4H), the 4H topology was folded using Rosetta [FunFolDes](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006623), generating approximately [10,000 decoys](./1\)Folding_trajectory/4H_folding_pose.csv). Around 100 decoys were selected according to several scoring metrics: overall energy, core packing and RMSD drifting for both epitopes, and the best scoring decoys were inspected manually. 

Following manual inspection, we increased the length in a connecting loop  between residues 46-48 by one residue using Rosetta Remodel, as specified in the [blueprint file](./2\)Remodel_fix_connection/4H_rd1_blueprint). Remodel was executed using the following command line: 

```
PATH/TO/ROSETTA/main/source/bin/remodel.linuxgccrelease -database PATH/TO/DATABASE -s 4H_folding_rd1.pdb -remodel:blueprint 4H_rd1_blueprint -nstruct 50 -remodel:use_pose_relax true -ex1 -ex2 
```  

The [remodeled template](./3\)Sequence_design_selection/4H_seq_design_rd2.pdb) subsequently served as template for the constrained sequence design using the [provided script](./3\)Sequence_design_selection/4H_rd2_seq_design_protocol.xml) with a [layerSelector](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/ResidueSelectors/ResidueSelectors) to automatically design each residue based on the extent of solvent exposure. The Design script can be executed by the following command line:  

```
PATH/TO/ROSETTA/main/source/bin/rosetta_scripts.linuxiccrelease @flags -s 4H_seq_design_rd2.pdb -parser:protocol 4H_rd2_seq_design_protocol.xml
``` 
The decoys generated from the sequence design are provided [here](./3\)Sequence_design_selection/4H_rd2_seq_design.csv). 

Based on an ensemble of the 100 best decoys according to total energy, we selected 12 core positions and 8 surface positions close to the binding interface to construct a sequence library for combinatorial sampling. 

### 4H library design and testing 
For experimental testing, we assembled a combinatorial library using overlapping oligos with degenerate codons to encode a defined diversity in 20 critical positions, as detailed below.

| Position| AA to sample|
| :------:|:-----------:|
| 5       | EV          |
| 6       | LV          |
| 9       | RW          |
| 10      | LV          | 
| 13      | LV          | 
| 16      | KQ          | 
| 17      | IV          | 
| 30      | IV          |
| 33      | LQ          |
| 37      | LV          | 
| 40      | LQ          |
| 41      | LV          |
| 42      | RW          |
| 50      | FLV         |
| 51      | HQ          |
| 54      | LV          |
| 57      | EKQ         |
| 58      | LV          |
| 75      | LV          |
| 78      | LV          |

The following animation shows the [best scoring decoy](./4H.gif), with the sampled core positions highlighted in green, and the sampled surface positions are shown in light red. Mota epitope and 2D10 epitope are colored in cyan and wheat, respectively. 

![](./4H.gif)

In order to ensure that both functional motifs are stabilized in their native conformation, the library was screened using yeast surface display for binding to Mota and 2D10 antibodies. For each screening condition, the best 1-2% of clones were sorted, and the sorted populations were bulk-sequenced using next-generation sequencing. We then computed an enrichment score for each sequence, as detailed throughout the manuscript. All protein sequences and their computed enrichments under selection for binding to Mota and 2D10 can be found [here](./4\)NGS_seq/4H_NGS.csv). The computational models of the sequences with the strongest enrichments can be found [here](). Sequences with strongest enrichments were subsequently expressed recombinantly and characterized biophysically. 
