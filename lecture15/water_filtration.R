library(FrF2)
library(daewr)
library(DoE.base)

## Analysis for Arsenic removal experiment

## data:
## original 2^{7-4} desgin
arso1 <- daewr::arso
## augmentation design 
arso2<-daewr::augm

## let's try to recreate the design using FrF2
## first, take the response variable out so we can add them back to the matrix:
## according to the text, generators are: D = AB, E = AC, F = BC, and G = ABC
arso1_check <- FrF2(nruns = 8, 
                    nfactors = 7, 
                    factor.names = c('A','B','C','D','E','F','G'),
                    generators = c('AB','AC','BC','ABC'), randomize = FALSE)

arso2_check<-fold.design(arso1_check,columns = 'full')


## check for aliases:
aliases(lm(y1~(.)^2, data = arso1))
## -4 implies the removal of the 'fold' column which is a dummy column to indicate the foldover portion
aliases(lm(y~(.)^2, data = arso2[,-4]))

## visual analysis of the effect (remove the 'fold' column for effect estimation):
arso_fit <- lm(y ~ (.)^2,data = arso2[,-4])
halfnorm(effects = effects(arso_fit)[-1],alpha = .15)

model_matrix_full<-data.frame(model.matrix(arso_fit))

## e.g. design 1: % removal is assumed to be most explained by A,B,F,AD:
X1<-cbind(model_matrix_full$X.Intercept,# overall effect
          model_matrix_full$A1,# factor A
          model_matrix_full$B1,# factor B
          model_matrix_full$F1, # factor F 
          model_matrix_full$A1.D1) # factor AD) 

y_hat1 <- X1%*%as.matrix(coef(arso_fit)[c(1,2,3,4,11)])


## now if we include both AD and CF (which are confounded in the design matrix),
## we will get singularity
X2<-cbind(model_matrix_full$X.Intercept,# overall effect
          model_matrix_full$A1,# factor A
          model_matrix_full$B1,# factor B
          model_matrix_full$F1, # factor F 
          model_matrix_full$A1.D1,
          model_matrix_full$C1.F1) # factor AD) 
