# 3E2H folding and design 
Using the provided input files, the 3H1L_02 topology was built and folded using Rosetta FunFolDes, generating approximately 20,000 [decoys](./4hb_folding_design_scores.csv). The top 100 decoys were selected according to overall Rosetta energy. 
Following manual inspection, we remodeled and shortened the connecting loops between the different helices, in particular between residues 22-25, 41-47 and 60-67 by a total of 4 residues. The shortened template subsequently served as template for a second round of folding and constrained sequence design using the provided script. Based on an ensemble of the 50 best decoys according to total energy, we selected 12 core positions, including 4 potential positions for disulfide formation, and built a sequence library for combinatorial sampling of a restricted set of amino acids for the selected positions. 

# 3H1L_02 library design and testing 
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
