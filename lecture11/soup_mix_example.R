## half factorial design example with soup mix experiment

library(FrF2)
library(DoE.base)
library(jtools)
# generate design with actual factor names and levels 
soup <- FrF2(16, 5, generators = "ABCD", 
             factor.names =list(Ports=c(1,3), Temp=c("Cool","Ambient"), 
                                MixTime=c(60,80),BatchWt=c(1500,2000), 
                                delay=c(7,1)), randomize = FALSE)
# add responses from the actual experiment runs 
y <- c(1.13, 1.25, .97, 1.70, 
       1.47, 1.28, 1.18, .98, 
       .78,1.36, 1.85, .62, 
       1.09, 1.10, .76, 2.10 )
# use the add.response function from DoE.base 
## to append that to the design
soup <- add.response( soup , y )
# the factors are squared 
## because we want the model to fit on the 
## main effects and interactions (when both are 'on')
print(aliases(lm( y ~ (.)^4, data = soup)))
mod1 <- lm( y ~ (.)^2, data = soup)
summary(mod1)
jtools::summ(mod1)
## what happens if we don't specify the factor names and run the model the same way?
soup0 <- FrF2(16, 5, generators = "ABCD", randomize = FALSE)
print(soup0)
soup0 <- add.response( soup0 , y )
mod0 <- lm( y ~ (.)^2, data = soup0)
summary(mod0)
print(aliases(lm( y ~ (.)^4, data = soup0)))

## sanity check on model coeficients:
## if we take the design matrix, 
## we should be able to retrieve the value of the response variables
## retrieve design matrix (X)
X_D <-as.matrix(data.frame(model.matrix(mod1)))
## retrieve vector of parameters (beta)
beta_vec <-as.matrix(coef(mod1))
## compute y_hat = X*beta
y_hat <- X_D%*%beta_vec
## compare  y_hat with the original data provided
prinbt(sum(y-y_hat)^2)
### plotting half-normal plot


soupc<-FrF2(16,5,generators="ABCD",randomize=FALSE)
soupc<-add.response(soupc, y)
modc<-lm(y~(.)^2, data=soupc)
LGB(coef(modc)[-1], rpt = FALSE)


