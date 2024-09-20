library(daewr)
library(dplyr)
mod1 <- aov( rate ~ dose, data = drug )
summary(mod1)
#To interpret the differences in treatment factor levels, comparisons of means should be made. 
contrasts(drug$dose) <- contr.poly(5)
mod2 <- aov( rate ~ rat + dose, data = drug)
summary.aov(mod2,split = list(dose = list("Linear" = 1,
                                          "Quadratic" = 2,
                                          "Cubic" = 3, 
                                          "Quartic" = 4) ) )

## plot the result

R <- do.call("cbind", split(drug$rate, drug$rat))
y <- apply(R, 1, mean )
x <- as.double( levels(drug$dose) )
plot( x, y, xlab = "dose", ylab = "average lever press rate" )
xx <- seq( 0.0, 2.0, .1 )
rate.quad <- lm( y ~ poly( x, 2) )
lines(xx, predict( rate.quad, data.frame( x = xx) ))


## determining # of blocks:
## lambda = b/sigma2 * (sum(tau_j - tau_bar)^2)
## b = to be determined
## sigma2 = 0.00835
## Delta in here is (sum(tau_j - tau_bar)^2)



tau_stats <- drug%>%group_by(dose)%>%summarise(tau_j = mean(rate))
tau_stats[,'tau_bar'] = rep(mean(drug$rate),5)
tau_stats[,'tau_squared'] = (tau_stats$tau_j - tau_stats$tau_bar)^2
Delta = sum((tau_stats$tau_j - tau_stats$tau_bar)^2)


bmin <- 2
bmax <- 10
alpha <- .05
sigma2 = 0.00836
css <- Delta
nu1 <- 5-1
blocks <- c(bmin:bmax)
nu2<-(blocks-1)*4
nc <- (blocks * css) / sigma2
Power <- daewr::Fpower(alpha, nu1, nu2, nc )

data.frame(blocks, nu1, nu2, nc, Power)

## calculate relative efficiency:
RE <-function(df1,df2,mse1,mse2){
  ## df1 = crd, df2 = rcb
  # calculate relative efficiency of design 1 to design 2
  RE = ((df1+1)*(df2+3)*mse2)/((df1+3)*(df2+1)*mse1)
  return(RE)
}


RE(df1 = 45, df2 = 36,mse1 = 0.00835,mse2 = 0.04375)

