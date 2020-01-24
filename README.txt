disk_conformal_map: Conformally map a simply-connected open triangle mesh to the unit disk

This code computes the disk conformal parameterizations (i.e. angle-preserving mappings onto the unit disk) of triangle meshes with disk topology using the fast method in [1], which has been applied for texture mapping, surface registration, mechanical engineering and so on.
Any comments and suggestions are welcome. 

If you use this code in your own work, please cite the following paper:
[1] P. T. Choi and L. M. Lui, 
    "Fast Disk Conformal Parameterization of Simply-Connected Open Surfaces."
    Journal of Scientific Computing, 65(3), pp. 1065-1090, 2015.

Copyright (c) 2014-2019, Gary Pui-Tung Choi
https://scholar.harvard.edu/choi

===============================================================



Usage:
map = disk_conformal_map(v,f)


Input:
v: nv x 3 vertex coordinates of a simply-connected open triangle mesh
f: nf x 3 triangulations of a simply-connected open triangle mesh

Output:
map: nv x 3 vertex coordinates of the disk conformal map

Remark:
1. Please make sure that the input mesh does not contain any unreferenced vertices/non-manifold vertices/non-manifold edges.
2. Please remove all valence 1 boundary vertices (i.e. vertices with only 1 face attached to them) before running the program.
