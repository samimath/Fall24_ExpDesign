## fractional design generator
library(FrF2)
## define a 5-factor half factorial design in standard order:
design <- FrF2(nruns = 16, nfactors = 5, 
               generators = 'ABCD',randomize = FALSE)
print(design)
## generate alias / confounding patterns
## place holder response vector of the same dimension as the runs 
## (it can be anything)
## (.)^(k-1) denotes the design type e.g. 2 = identify aliases 2-factor interaction
## where we want to identify confounding patterns
y<-1:16
aliases( lm (y~(.)^4, 
             data = design))


### generate 2^{k-2} design
design2 <- FrF2(nruns = 8, nfactors = 5, 
               generators = c('AB','AC'),
               randomize = FALSE)
y2<-1:8
aliases( lm (y2~(.)^3, 
             data = design2))
