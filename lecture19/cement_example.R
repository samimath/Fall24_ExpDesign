## cement example
library(daewr)
library(rsm)
## load data
cement<-daewr::cement
## let's take a view of the data

## regression model for y : two options:

## option 1 : SO = second order model
mod_rsm1 <- rsm( y ~ SO(x1,x2,x3), data = cement)

## option 2: specify each term 
mod_rsm2 <- rsm(y ~ FO(x1,x2,x3) + ## FO = First Order
                  TWI(x1,x2,x3) + ## TWI = Two-way interaction
                  PQ(x1,x2,x3), ## PQ = Pure quadratic
                data = cement)

## option 3: include only first order and pure quadratic terms
mod_rsm3 <- rsm(y ~ FO(x1,x2,x3) + ## FO = First Order
                  PQ(x1,x2,x3), ## PQ = Pure quadratic
                data = cement)
summary(mod_rsm3)
## Contour plot:

## since this contains 3 factors, let's look at 2 factors at a time:
contour(mod_rsm1, ~x1+x2)
contour(mod_rsm1, ~x1+x3)
contour(mod_rsm1, ~x2+x3)
