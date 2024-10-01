## nested design example 
## two ways to get estimates of variance components
library(daewr)
library(lme4)
library(lmerTest)
### 1. through ANOVA
mod2 <- aov( elasticity ~ supplier + supplier:batch +
               + supplier:batch:sample, data = rubber)
s2<- summary(mod2)
### 2. using REML estimates
mod3 <- lmer( elasticity ~ 1+ (1|supplier) +(1|supplier:batch) + 
                 (1|supplier:batch:sample), data = rubber)
s3<- summary(mod3)

## summing up the variance component to get total variance
sigmaT<- s3$varcor$`supplier:batch:sample`[1]+ 
s3$varcor$`supplier:batch`[1]+
s3$varcor$supplier[1]+
(s3$sigma)^2


## Additional R tools to analyze random / mixed effects models
# return ANOVA-like table 
ranova(mod3)
## returns standard deviation of each random factor
VarCorr(mod3)

