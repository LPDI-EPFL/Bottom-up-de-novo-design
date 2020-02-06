# A bottom up design approach for the *de novo* design of functional proteins
## Table of Contents: 
- [Description](#description)
- [Software prerequisites](#software_prerequisites)
   
## Description
This repository contains additional data presented in the manuscript ["A bottom-up approach for *de novo* design of functional proteins"](link). For each *de novo* designed protein topology presented, this repository provides the input files used for the computational design procedure, as well as score files and models of the designed proteins. 
The repository is organized by the functional motifs that were stabilized, which are epitopes targeted by RSV neutralizing antibodies. 

![](./motifs.png)




([site IV](./siteIV) []

json-format files to organize the secondary structural composition, functional motif and spatial arrangement of each designed topology in a defined layer. And using the python-based algorithm TopoBuilder, it builds the ideal secondary structural elements (SSEs) with embeded motif in a 3D space. Based on the distance between the edge of each SSEs, the length of loop connection was automatically determined 


## Software prerequisites
- Python2.7 
- [Rstoolbox](https://doi.org/10.1186/s12859-019-2796-3) and its dependencies
- [TopoBuilder - Py2 release](https://github.com/LPDI-EPFL/topobuilder/tree/releasepy2)

