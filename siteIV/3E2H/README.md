# Design of 3E2H topology to accommodate the RSVF antigenic site IV (101F epitope) 
## 3E2H topology construction and design (the topology contains two ideal beta strand, two ideal helices and a motif) 
The de novo designed 3E2H topology accommodates the RSV antigenic site IV, a motif consisting of a bulged beta strand.  

The antigenic site IV was extracted from the peptide-bound structure with a potent neutralizing antibody 101F (PDB 3O41, chain F). The epitope region consists of residues 429-434 according to the numbering of RSVF structure.

In order to maintain the structural stablization of motif, the built protein fold should avoid to start/end with the motif  
,meaning that the chosen connectivity should always be designed to link the motif at both terminus. The topology was assembled using TopoBuilder with all the tunable parameters specified in json file [here](./1\)Foling_trajectory/3E2H.json). 

### 3E2H folding and design 
Using the provided input files, the 3E2H topology was built and folded using Rosetta FunFolDes, generating approximatelyaround 15000 decoys were generated [decoys](./1\)Foling_trajectory/B1E_C1E_C2H_A1E_A2H/3E2H_folding_design.csv). The top 100 decoys were selected according to several scoring metrics: overall energy, core packing and ramachandran scores, and the best scoring decoys were inspected manually. 

Following manual inspection, we remodeled and shortened the connecting loops between the different SSEs, in particular between residues 
22-25, 41-47 and 60-67 by a total of 4 residues. The shortened template subsequently served as template for a second round of folding and constrained sequence design using the provided script. Based on an ensemble of the 50 best decoys according to total energy, we selected 12 core positions, including 4 potential positions for disulfide formation, and built a sequence library for combinatorial sampling of a restricted set of amino acids for the selected positions. 

For experimental testing, we designed a combinatorial library sampling a defined diversity in 12 critical core positions, as detailed [here](./B1H_A1H_B2E_A2H/output/). 
The library was screened using yeast surface display followed by next-generation sequencing, followed by recombinant expression and biophysical characterization of 13 selected clones. 

The computational models of the sequences with the strongest enrichments can be found [here](./output/pdb_files_of_best_models). All protein sequences and their computed enrichments under selection for binding to D25, 5C4, or D25+chymotrypsin / 5C4 + chymotrypsin can be found [here](./B1H_A1H_B2E_A2H/output/3H1L_02_sequences_enrichment.csv). 

### 3E2H library design and testing 
| Position| AA to sample|
| :------:|:-----------:|
| 29      | EL          |
| 39      | MLA         |
| 42      | CT          |
| 45      | AVILMFW     | 
| 46      | CD          | 
| 49      | MLFIW       | 
| 66      | AVILMFW     | 
| 69      | AVILMFW     |
| 73      | AVILMFW     |
| 74      | CR          | 
| 76      | QAVLMFW     |
| 80      | ACIFW       |

The following animation shows the best scoring decoy, which was chosen as a template to select critical core positions for combinatorial sampling. Selected positions encoded in the combinatorial library are highlighted in yellow, the site 0 epitope shown in purple. 
