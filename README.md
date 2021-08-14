# Disk Conformal Map

<img src = "https://github.com/garyptchoi/disk-conformal-map/blob/master/cover.jpg" height="300" />

disk_conformal_map: Conformally map a simply-connected open triangle mesh to the unit disk

This code computes the disk conformal parameterizations (i.e. angle-preserving mappings onto the unit disk) of triangle meshes with disk topology using the fast method in [1], which has been applied for texture mapping, surface registration, mechanical engineering and so on.

Any comments and suggestions are welcome. 

If you use this code in your own work, please cite the following papers:

[1] P. T. Choi and L. M. Lui, 
    "[Fast Disk Conformal Parameterization of Simply-Connected Open Surfaces.](https://doi.org/10.1007/s10915-015-9998-2)"
    Journal of Scientific Computing, 65(3), pp. 1065-1090, 2015.

If the area correction code (mobius_area_correction_disk) is also used, please cite [1] as well as the following paper:

[2] G. P. T. Choi, Y. Leung-Liu, X. Gu, and L. M. Lui, 
    "[Parallelizable global conformal parameterization of simply-connected surfaces via partial welding.](https://doi.org/10.1137/19M125337X)"
    SIAM Journal on Imaging Sciences, 13(3), pp. 1049-1083, 2020.

Copyright (c) 2014-2020, Gary Pui-Tung Choi

https://math.mit.edu/~ptchoi

===============================================================

Usage:
* map = disk_conformal_map(v,f)

Input:
* v: nv x 3 vertex coordinates of a simply-connected open triangle mesh
* f: nf x 3 triangulations of a simply-connected open triangle mesh

Output:
* map: nv x 3 vertex coordinates of the disk conformal map

Remark:
* Please make sure that the input mesh does not contain any unreferenced vertices/non-manifold vertices/non-manifold edges.
* Please remove all valence 1 boundary vertices (i.e. vertices with only 1 face attached to them) before running the program.

===============================================================

Some possible extensions/applications are also provided:
* mobius_area_correction_disk (see demo_extension.m):
We further reduce the global area distortion of a disk conformal parameterization while maintaining the conformality, using the Mobius area correction method in [2]. 
* remeshing (see demo_remeshing.m): 
We can perform remeshing via the disk conformal parameterization as described in [2].
