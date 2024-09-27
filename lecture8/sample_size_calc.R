## example to calculate sample size 
## nu2 = t(r-1), testing a range of values
nu2 <- 36:44
## calculate lower and upper value of the chi2 quantile
chiu <- qchisq(.975, nu2)
chil <- qchisq(.025, nu2)
## calculate width of the 95% CI for sigma2
width <- nu2 * (chiu - chil) / (chil * chiu)
## calculate half width 
halfw <- width/2
data.frame(nu2, width, halfw)