## setting up mixture experiments
library(mixexp)
library(daewr)
## Simple Lattice Design with 3 components 
## and 2 segments
SLD(3,2)
## Simple centroid design with 4 components
SCD(4)
## Visualize design points of a SLD
des <-SLD(3,2)
DesignPoints(des)

