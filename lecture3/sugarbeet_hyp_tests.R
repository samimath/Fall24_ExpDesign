library(daewr)
library(gmodels)
# set option to limit number of digits that show up in the console
options(digits = 3)
# CRD model for sugarbeet expr
mod4 <- aov( yield ~ treat, data = sugarbeet )
# Matrix with contrast coefficient for the different generalized hypotheses
con <- matrix(c(1, -1/3, -1/3, -1/3, 
                0, 1, -1, 0,
                0, 0, 1, -1 ), 4, 3 )
L <- t(con)
rownames(L) <- c("-fertilizer effect", "-plowed vs. broadcast" , "-January vs. April")
L

# use the fit.contrast function to compute and test contrasts for the model
fit.contrast(model = mod4, varname = "treat", coeff = L)


## Tukey's HSD test 


mod4.tukey <- TukeyHSD( mod4, ordered = T )
mod4.tukey