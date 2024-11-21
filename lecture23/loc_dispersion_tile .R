## location dispersion modeling - tile example 

library(daewr)

modyb <- lm(ybar ~ A + B + C + D + E + F + G, 
            data = tile)
summary(modyb)
cfs <- coef(modyb)[-1]
halfnorm(cfs,names(cfs), alpha=.2)

modlv <- lm(lns2 ~ A + B + C + D + E + F + G, 
            data = tile)
summary(modlv)

cfs <- coef(modlv)[-1]


halfnorm(cfs,names(cfs),alpha=0.2)




