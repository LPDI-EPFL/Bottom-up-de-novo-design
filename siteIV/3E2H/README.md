# Design of 3E2H topology to accommodate the RSVF antigenic site IV (101F epitope) 
## 3E2H topology construction and design (the topology contains two ideal beta strand, two ideal helices and a motif) 
The de novo designed 3E2H topology accommodates the RSV antigenic site IV, a motif consisting of a bulged beta strand.  

The antigenic site IV was extracted from the peptide-bound structure with a potent neutralizing antibody 101F (PDB 3O41, chain F). The epitope region consists of residues 429-434 according to the numbering of RSVF structure.

In order to maintain the structural stablization of motif, the built protein fold should avoid to start/end with the motif  
,meaning that the chosen connectivity should always be designed to link the motif at both terminus. The topology was assembled using TopoBuilder with all the tunable parameters specified in json file [here](./1\)Foling_trajectory/3E2H.json). 

### 3E2H folding and design 
Using the provided input files, the 3E2H topology was built and folded using Rosetta FunFolDes, generating approximatelyaround 15000 [decoys](./1\)Foling_trajectory/B1E_C1E_C2H_A1E_A2H/3E2H_folding_design.csv). The top 100 decoys were selected according to several scoring metrics: overall energy, core packing and ramachandran scores, and the best scoring decoys were inspected manually. 

Following manual inspection, we remodeled and shortened a connecting loop between the motif and a following helix, in between residues 22-27, with the provided [blueprint](./2\)Remodel_fix_connection/3E2H_rd1_blueprint) to specify the exact residues need to adapt the loop remodeling. The shortened template subsequently served as template for a second round of 
constrained sequence design and building a disulfide bridge using the [provided script](./3\)Sequence_design_selection/3E2H_layerdesign_protocol.xml). The decoys generated from second round of sequence design were [provided](./3\)Sequence_design_selection/3E2H.minisilent.gz). Based on an ensemble of the 100 best decoys according to total energy, we selected 7 core positions and 6 potential positions close to the binding interface to build a sequence library for combinatorial sampling of a restricted set of amino acids for the given positions (Fig.S3). 

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
