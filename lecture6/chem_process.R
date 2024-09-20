library(daewr)
modf <- lm( y ~ A*B*C*D, data = chem)
summary(modf)


## get design matrix X:

X <- as.matrix(data.frame(model.matrix(modf)))

# compute X'X:
XtX <- t(X)%*%X

## assess model effects through graphical approach
## 1. Normal probability plot 

fullnormal(coef(modf)[-1],alpha=.025)

## 2. half-normal plot
LGB( coef(modf)[-1], rpt = FALSE)

## 3, Looks like AB has significant interaction effect
## so let's take a look at their interaction

with(chem, (interaction.plot( A, B, y, type = "b", 
                              pch =c(18,24), 
                              main = "Interaction Plot of Catalyst by Excess A",
                              xlab = "Excess Reactant A", ylab = "Percent Conversion")))

