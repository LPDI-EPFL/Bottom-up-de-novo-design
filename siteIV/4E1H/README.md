# Design of 4E1H topology to accommodate the RSVF antigenic site IV (101F epitope) 
## 4E1H topology construction and design (the topology contains three ideal beta strand, an ideal helices and a motif) 
As mentioned in the description of [3E2H](../3E2H/README.md), the motif was extracted from previously solved peptide-bound structure with target antibody. In order to build the de novo backbone containing a beta sheet with four strands and packing with a helix, we used the TopoBuilder to modularly assemble those ideal structural elements together with motifas shown in the [sketch](./1\)Folding_trajectory/input_4E1H/A2E_A1E_D1H_B1E_C1E/sketch.pdb). The topology was assembled using TopoBuilder with all the tunable parameters specified in json file [here](./1\)Foling_trajectory/input_4E1H/4E1H.json).   
 
### 4E1H folding and design 
Using the provided [input files](./1\)Foling_trajectory/input_4E1H), the 4E1H topology was built and folded using Rosetta FunFolDes, generating approximately around 10000 decoys. The top 300 decoys(./1\)Foling_trajectory/top_300_folding_pose.zip) were selected according to several scoring metrics: overall energy, core packing and content of secondary structures, and the best scoring decoys were inspected manually. 

Following manual inspection, we remodeled and shortened a connecting loops linking between supporting strand and motif, which is between residues 8-12, and also extending 3 residues at the C-terminus with the provided [blueprint](./2\)Remodel_fix_connection_design/4E1H_rd1_blueprint) to specify the exact residues need to adapt the loop remodeling. The shortened template subsequently served as template for a second round of 
constrained sequence design and building a disulfide bridge using the [provided script](./3\)Sequence_design_selection/3E2H_layerdesign_protocol.xml). The decoys generated from second round of sequence design were [provided](./3\)Sequence_design_selection/3E2H.minisilent.gz). Based on an ensemble of the 100 best decoys according to total energy, we selected 7 core positions and 6 potential positions close to the binding interface to build a sequence library for combinatorial sampling of a restricted set of amino acids for the given positions (Fig.S3). 

### 4E1H library design and testing 
For experimental testing, we assembled the combinatorial library by primers carrying the degenerate codon to cover a defined diversity in 13 critical positions, as detailed below.

| Position| AA to sample|
| :------:|:-----------:|
| 3       | FIL         |
| 7       | IV          |
| 19      | FINY        |
| 27      | ALPV        | 
| 30      | FHLY        | 
| 31      | AV          | 
| 34      | FHLY        | 
| 35      | AV          |
| 38      | ALPV        |
| 46      | IV          | 
| 56      | VF          |
| 58      | CFY         |
| 60      | DFVY        |
| 62      | AV          |

The following animation shows the [best scoring decoy](./3\)Sequence_design_selection/3E2H_rd2_sequence_design.pdb), which was chosen as a template to select critical core positions for combinatorial sampling. Selected core positions encoded in the combinatorial library are highlighted in yellow, and the positions in a proximity of binding interface are colored in XXX, and the site IV epitope shown in orange. 

The library was screened using yeast surface display under double selective pressure: binding to 101F antibodies, and residual binding after pre-treatment of the nonspecific protease chymotrypsin to ensure the designed topology presents the functional motif in its native conformation, while maintaining the stable protein fold (Fig.S8). For each screening condition, the best 1-2% of clones were sorted, and the sorted populations were bulk-sequenced using next-generation sequencing. We then computed an enrichment score for each sequence, which represents the frequency of each sequence under stringed selection conditions. All protein sequences and their computed enrichments under selection for binding to 101F, or 101F+chymotrypsin can be found [here](./4\)NGS_seq/3E2H_NGS.csv). The computational models of the sequences with the strongest enrichments can be found [here](). Followed with next-generation sequencing, we then choose around 10 sequences showing the strongest enrichments for recombinant expression and biophysical characterization.

