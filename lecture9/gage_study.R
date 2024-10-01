## gage r and r study
library(daewr)
library(lme4)
modr2 <- lmer(y ~ 1 + (1|part) + 
                (1|oper) + 
                (1|part:oper),
              data = gagerr)
summary(modr2)

modr3 <- lmer(y ~ 1 + (1|part) + 
                (1|oper) + 
                (1|part:oper),
              data = gagerr, REML = FALSE)
summary(modr3)

mod4 <- aov( y ~ 1 + part +oper+ part:oper, data = gagerr)

## calculate confidence interval using the vci function

## delta = linear combination of two mean square error c1ms1 - c2ms2
vci(confl = .90, c1 = .05, ms1 = .01485, 
    nu1 = 2, c2 = .05,
    ms2 = .02689, nu2 = 18)


