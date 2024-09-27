## soup variabiltiy study
library(daewr)
library(lme4)
rmod2 <- lmer( weight ~ 1 + (1|batch), data = soupmx)
summary(rmod2)
pr1 <- profile( fm1M <- lmer( weight ~ 1 + (1|batch), 
                              data = soupmx, REML = TRUE))
confint(pr1) 

pr2 <- profile( fm1M <- lmer( weight ~ 1 + (1|batch), 
                              data = soupmx, REML = FALSE))
confint (pr2) 