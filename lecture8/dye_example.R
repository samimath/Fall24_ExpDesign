## dye example 

batch <- NULL
for(i in 1:6){
  batch <-c(batch,rep(i,5))
}
yield<-c(1440,1440,1520,1545,1580,
         1490,1495,1540,1555,1560,
         1510,1550,1560,1595,1605,
         1440,1445,1465,1545,1595,
         1515,1595,1625,1630,1635,
         1445,1450,1455,1480,1520)

dye <-data.frame(batch = batch, yield = yield)
dye$batch <- as.factor(batch)
## ANOVA example to estimate variance component

mod1 <-aov(yield~batch, data = dye)




## Methods of moment estimates for \sigma_t
s1 <-summary(mod1)
ms_batch <- s1[[1]][1,3] # set equal to theoretical moment sigma_t+5*sigma2
sigma2 <- s1[[1]][2,3]

sigmat<- (ms_batch - sigma2)/5

## Estimating confidence interval for sigmat:
F_U <- qf(0.975,5,24)
F_L <- qf(0.025,5,24)
chi_U <- qchisq(0.975,5)
chi_L <- qchisq(0.025,5)
ssT<- s1[[1]][1,2]
F_star<- s1[[1]][1,4]
CI_U <-ssT*(1-F_U/F_star)/(5*chi_U)
CI_L <-ssT*(1-F_L/F_star)/(5*chi_L)
