library(DoE.base)
library(FrF2)
library(daewr)
## Ina Seito tile company example 
## design matrix for control factor (2^(7-4) design)
des.control <- FrF2(nruns = 8,nfactors = 7,
                    factor.names = c('A','B','C','D','E','F','G'), 
                    generators = c('AB','AC','BC','ABC'))
## design matrix for noise factor
des.noise <- c(1,-1)
## crossed array
des.crossed <- cross.design( design1 = des.control, 
                             design2 = des.noise,
                             randomize = FALSE)

View(daewr::tile)

des.crossed



