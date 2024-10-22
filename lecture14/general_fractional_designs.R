## fractional design generator examples
library(FrF2)
library(DoE.base)

## define a 6-factor eigth factorial design in standard order:
design <- FrF2(nruns = 8, nfactors = 6, 
               generators = c('AB','AC','BC'),randomize = FALSE)
print(design)

## define a 6-factor eigth factorial design in standard order:
design2 <- FrF2(nruns = 8, nfactors = 6, 
               generators = c('-AB','-AC','-BC'),randomize = FALSE)
print(design2)
## generate alias / confounding patterns
## place holder response vector of the same dimension as the runs 
## (it can be anything)
## (.)^(k-3) denotes the design type 
## where we want to identify confounding patterns
y<-1:8
aliases( lm (y~(.)^3, 
             data = design))

## quarter fraction design for 2^6 (ABCD |EF)
## design 1: choosing E = ABC, F = BCD
y<-1:16
design1 <- FrF2(nruns = 16, nfactors = 6, 
                generators = c('ABC','BCD'),randomize = FALSE)
aliases(lm(y~(.)^4, data = design1))
## design 2: choosing E = ABC, F = ABD
design2 <- FrF2(nruns = 16, nfactors = 6, 
                generators = c('ABC','ABD'),randomize = FALSE)
aliases(lm(y~(.)^4, data = design2))

## design 3: choosing E = AB, F = BCD
design3 <- FrF2(nruns = 16, nfactors = 6, 
                generators = c('AB','BCD'),randomize = FALSE)

aliases(lm(y~(.)^4, data = design3))


## compare optimal k-p design
## 2^(7-5) design examples 

d1 <- FrF2(nruns = 32, nfactors = 7, 
           generators = c('ABCD','ABCE'),randomize = FALSE)


d2 <- FrF2(nruns = 32, nfactors = 7, 
           generators = c('ABC','ADE'),randomize = FALSE)

## check for clear effects

y<-1:16
d3 <-FrF2(nruns = 16, nfactors = 6, 
          generators = c('ABC','ABD'),randomize = FALSE)
aliases(lm(y~(.)^4, data = d3))

d4 <-FrF2(nruns = 16, nfactors = 6, 
          generators = c('AB','ACD'),randomize = FALSE)

aliases(lm(y~(.)^4, data = d4))


### creating designs with min. aberrations

## 2^{8-4} design
des1 <- FrF2( nruns = 16,  nfactors = 8 , 
              MaxC2 = TRUE)
y <- runif( 16, 0, 1 )

generators(des1)
aliases(lm(y~(.)^4, data = des1))

## 2^{9-4} design
des2 <- FrF2( nruns = 32,  nfactors = 9 , MaxC2 = TRUE)
y <- runif( 32, 0, 1 )
generators(des2)
aliases(lm(y~(.)^5, data = des2))

generators(des1)

des_test <- FrF2( nruns = 8,  
                  nfactors = 7, 
                  generator = c('AB','AC','BC','ABC'))
y <- runif( 8, 0, 1 )
aliases(lm(y~(.)^3, data = des_test))

des_test2<- fold.design(des_test, columns = c(5,6,7))
y <- runif( 16, 0, 1 )
aliases(lm(y~(.)^4, data = des_test2))

des_test3<- fold.design(des_test, columns = 'full')
des_test3
y <- runif( 16, 0, 1 )
aliases(lm(y~(.)^4, data = des_test3))




des_test <- FrF2( nruns = 8,  
                  nfactors = 5, 
                  generator = c('AB','BC'))
y <- runif( 8, 0, 1 )
aliases(lm(y~(.)^6, data = des_test))
aliases(lm(y~(.)^5, data = des_test))
aliases(lm(y~(.)^3, data = des_test))
aliases(lm(y~(.)^2, data = des_test))
