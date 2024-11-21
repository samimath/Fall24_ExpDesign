library(DoE.base)



## design matrix for control factor (3^(4-2) design)
des.control <- oa.design(nfactors = 4, nlevels = 3,
                         nruns = 9,
                         factor.names = c("A","B","C","D"))
## design matrix for noise factor
des.noise <- oa.design(nfactors = 3,nlevels = 2, 
                       nruns = 8, 
                       factor.names = c("E","F","G"))
## crossed array
des.crossed <- cross.design( design1 = des.control, 
                             design2 = des.noise,
                             randomize = FALSE)

