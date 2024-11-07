## example to create a central composite design (CCD) 
## for response surface methodology
library(rsm)
library(daewr)
library(Vdgraph)

rotd <- ccd(basis = 3, # number of factors
            n0 = c(4,2), #  number of center points
            alpha = "rotatable", #settings for the design
            randomize = FALSE)
##taking just the coded factor levels
rotdm <- rotd[ , 3:5]
## distribution of variance of predicted response y 
## note in here we do not need the values for y to estimate its variance
## since by design, it only depends on 
## the distance between the x values from its origin
Vdgraph(rotdm)


### BBD example 
rotd2 <- bbd(k = 3, # number of factors
            n0 = 4) #  number of center points
##taking just the coded factor levels
rotdm2 <- rotd2[ , 3:5]
## distribution of variance
Vdgraph(rotdm2)


### Another CCD example : face centered design

faced <- ccd(basis = 3, # number of factors
            n0 = c(4,2), #  number of center points
            alpha = "faces", #settings for the design
            randomize = FALSE)

##taking just the coded factor levels
facedm<- faced[ , 3:5]
## distribution of variance
Vdgraph(facedm)