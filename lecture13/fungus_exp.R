## fungus experiment example
library(FrF2)
library(daewr)
culture <- FrF2( nruns = 16, nfactors = 8, 
                 generators = c("BCD", "ACD", "ABC","ABD"), 
                 randomize = FALSE)
# check confounding patterns
y<-1:16
aliases( lm (y~(.)^4, 
             data = culture))
y1 <- c(5.75, 6.7, 11.12, 10.67, 4.92, 5.35, 2.81, 10.83,
          + 6.08, 7.27, 9.68, 4.2, 3.9, 3.78, 11.57, 7.39 )
culture <- add.response( culture, y1 )
culture
## compared with the default setting 

culture0 <- FrF2( nruns = 16,nfactors = 8,
                 randomize = FALSE)

## take a look at the model
modf <- lm( y1 ~ (.)^2, data = culture)
summary(modf)

## half normal plot of the effects
daewr::halfnorm(effects = modf$effects[2:16],
                labs = labels(modf),
                refline = FALSE,alpha = 0.4)

## In here, no defining conclusion can be drawn 
## because no effects are obviously significant according to the half normal plot

## A new 2^{5-1} design is tested instead 

culture2 <- FrF2( 16, 5, factor.names = c("B", "C", "E", "G","H"), 
                  randomize = FALSE)
y <- c(3.37, 3.55, 3.78, 2.81, 5.53, 10.43, 5.35, 11.57, 2.93,7.23, 3.9, 10.83, 11.69, 10.59, 4.92, 7.39)
culture2 <- add.response( culture2, y )
culture2
modf2 <- lm( y ~ (.)^2, data = culture2)
summary(modf2)
aliases( lm (y~(.)^4, 
             data = culture2))

## half normal plot of the effects
daewr::halfnorm(effects = modf2$effects[2:16],
                labs = labels(modf2),
                refline = FALSE,alpha = 0.05)

## interaction plot

with(culture2, (interaction.plot( E,C, y, type = "b", 
                              pch =c(18,24), 
                              main = "Interaction Plot of Urea and Ammonium Sulfate",
                              xlab = "Ammonium Sulfate", ylab = "Biomass")))

## inspect design matrix for the assumed model
X<-cbind(model_matrix_full$X.Intercept,# overall effect
                            model_matrix_full$D1,# block effect
                            model_matrix_full$A1,# factor A
                            model_matrix_full$B1,# factor B
                            model_matrix_full$G1, # factor F (shifted to G due to block effect taking spot for'D')
                            model_matrix_full$A1.D1, # factor AD
                            model_matrix_full$C1.G1) # factor CF

solve(t(X)%*%X)