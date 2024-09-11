## power calculation 
library(daewr)
rmin <-2 #smallest number of replicates considered
rmax <-6 # largest number of replicates considered
alpha <- rep(0.05, rmax - rmin +1)
sigma <-sqrt(2.1)
nlev <- 3
nreps <- rmin:rmax
Delta <- 3
power <- Fpower1(alpha,nlev,nreps,Delta,sigma)
power

power_cal<-function(rmin,rmax,Delta){
  alpha <- rep(0.05, rmax - rmin +1)
  sigma <-sqrt(2.1)
  nlev <- 3
  nreps <- rmin:rmax
  Delta <- Delta
  power <- Fpower1(alpha,nlev,nreps,Delta,sigma)
  return(data.frame(power))
}

## how does power and reps change differ as a function of delta?

delta_vs_power <-function(Delta, rmin, rmax){
  power.temp <- power_cal(rmin=rmin,rmax=rmax,Delta=Delta)
  while(max(power.temp$power) < 0.8){
    power.temp <- power_cal(rmin=rmin,rmax=rmax+1,Delta = Delta)
  }
  # return the first row that is closest to 0.8
  return(power.temp[power.temp$power >0.8,][1,])
}

delta_comparison<-data.frame(do.call(rbind,lapply(3:10, function(d){delta_vs_power(Delta = d, rmin=2,rmax = 6)})))

plot(delta_comparison$nreps,delta_comparison$Delta, type = 'b', 
     main = 'Delta vs # of reps needed',
     ylab = 'Delta', xlab ='# of reps needed')
