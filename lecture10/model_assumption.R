library(daewr)
## dye example 
data(Naph)
## calculate variance of samples from each group
s2 <- tapply( Naph$yield, Naph$sample, var )
os2 <- sort(s2)
r <- c( 1:length(s2) )
gscore <- qgamma( (r - .5 ) / length (s2), 
                  scale = 2, shape = 5/2)
plot(gscore, os2, 
     main = "Gamma plot of within sample variances", 
     xlab = "Gamma score", 
     ylab = "Sample Variance")
## polymerization example


data(polymer)
y <- array( polymer$strength, c(4,30) )
sd1 <- sqrt( (y[2,] - y[1,])**2 / 2)
sd2 <- sqrt( (2/3) * ( y[3,] - (y[1,] + y[2,]) / 2)**2 )
sd3 <- sqrt( (3/4) * (y[4,] - (y[1,] + y[2,] + y[3,] )/3 )**2)

osd2 <- sort(sd2)
r <- c( 1: length(sd2))
zscore <- qnorm( ( ( r - .5 ) / length(sd2) +1 )/ 2)
plot( zscore, osd2, 
      main = "Half-normal plot of prep(box) standard deviations", 
      xlab = "Half Normal Score", 
      ylab ="std. due to prep within box")


## remove lot 19 from the data and try again
polymer_new <- polymer[polymer$lot!=19,]
### Staggered nested design

library(lme4)
modr4 <- lmer( strength ~ 1 + (1|lot) + (1|lot:box)+
                 (1|lot:box:prep), 
               data = polymer_new)
s4<-summary(modr4)

## Copying a function defined from another script. 
# NOTE: This is not best practice, ideally we should keep these in an R package 
# or at least a function script, but I'm lazy and short on time.
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


# re-run method of moments with cleaned up data 
mod5<-aov(strength ~ lot + lot:box + lot:box:prep, 
          data = polymer_new)
s5 <- summary(mod5)
ms_est<-s5[[1]]$`Mean Sq`
sig2_est_new <- var_est_4_stage(msA = ms_est[1],
                            msB = ms_est[2],
                            msC = ms_est[3],
                            msD = ms_est[4])
print(sig2_est_new)


## getting EBLUP using the ranef (random effect)
rand_ef_modr4 <-ranef(modr4)
## let's take a look at the distribution of 
## random effects for the prep factor nested within box and lot 

hist(rand_ef_modr4$`lot:box:prep`[[1]],10,
     xlab = 'estimated EBLUP',ylab = 'freq')
## normal probability plot to check normality
qqnorm( ranef(modr4)$"lot:box:prep"[[1]], 
        main="prep within box and lot", 
        ylab="EBLUP",xlab ="Normal Score" )


