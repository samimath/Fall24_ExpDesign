## gap test example 
library(daewr)
data(BoxM)
## fit model to data:

modg <- lm( y ~ A*B*C*D, data = BoxM)
## take a look at the half-normal plot 
LGB( coef(modg)[-1])
## run the gaptest to see if any outliers had inflated, or buried effects
correctedBoxM<-Gaptest(BoxM)

