### Staggered nested design

library(lme4)
mod2<-aov(strength ~ lot + lot:box + lot:box:prep, data =polymer)
## lot = A , box (in lot) = B, prep (in box) = C, process error = D

## method of moment estimates for variance components

var_est_4_stage<-function(msA,msB,msC,msD){
  ## input variance mean square error estimate from ANOVA table
  ## formula taken from the inverse of Table 5.12 in book
  sig2D <-msD
  sig2C <-(msC - msD)*(3/4)
  sig2B <-(msB - sig2D - (7/6)*sig2C )*(2/3)
  sig2A <- (msA -(sig2D+(3/2)*sig2C+(5/2)*sig2B))/4
  sig2_est <- c(sig2A,sig2B,sig2C,sig2D)
  return(sig2_est)
}

## create summary object of mod2 to get the ANOVA data 
s2 <- summary(mod2)
ms_est<-s2[[1]]$`Mean Sq`
sig2_est <- var_est_4_stage(msA = ms_est[1],
                            msB = ms_est[2],
                            msC = ms_est[3],
                            msD = ms_est[4])


modr3 <- lmer( strength ~ 1 + (1|lot) + (1|lot:box)+
                 (1|lot:box:prep), data = polymer)
#REML estimates for variance components
summary(modr3)
