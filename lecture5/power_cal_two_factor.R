## power calculation for two-factor factorial experiment

library(daewr)
library(ggplot2)

## 1 factor experiment 

rmin <- 2 # smallest number of replicates
rmax <- 8 # largest number of replicates
sigma <- .29
alpha <- .05
Delta <- 0.5
nlev <- 16
nreps <- c(rmin:rmax)
power <- data.frame(Fpower1(alpha, nlev, nreps, Delta, sigma))
options(digits = 5)
power

plot(power$nreps,power$power,'b',xlab = 'nreps',ylab = 'power',main='Power vs # of reps')

## 2 factor experiment 
rmin <- 2 # smallest number of replicates
rmax <- 10 # largest number of replicates
alpha <- .05
sigma <- 0.2
Delta <- 0.5
nlev <- c(2,2)
nreps <- c(rmin:rmax)
result <- Fpower2(alpha, nlev, nreps, Delta, sigma)
options(digits = 5)
result

two_fact_power<-function(nlev,sigma,Delta,rmin=2,rmax=10){
  alpha <- .05
  nreps <- c(rmin:rmax)
  result <- data.frame(Fpower2(alpha, nlev, nreps, Delta, sigma))
  options(digits = 5)
  return(result)
}

## just for fun, what does the power curve look like if we change some properties of the experiment, such as sigma and Delta?
power_array_sigma<-do.call(rbind,lapply(seq(0.1,1,0.1),function(s){two_fact_power(nlev=c(2,2),sigma=s,Delta=1)}))

power_array_Delta<-do.call(rbind,lapply(seq(1,10,1),function(s){two_fact_power(nlev=c(2,2),sigma=1,Delta=s)}))

ggplot(power_array_sigma)+
  geom_point(aes(x=nreps,y=powera,col=as.factor(sigma)))+
  geom_line(aes(x=nreps,y=powera,col=as.factor(sigma)))+
  geom_abline(intercept = 0.8,slope = 0,col='black')+
  ggtitle('Power curve as a function of sigma')


power_array_Delta<-do.call(rbind,lapply(seq(1,10,1),function(s){two_fact_power(nlev=c(2,2),sigma=1,Delta=s)}))

ggplot(power_array_Delta)+
  geom_point(aes(x=nreps,y=powera,col=as.factor(Delta)))+
  geom_line(aes(x=nreps,y=powera,col=as.factor(Delta)))+
  geom_abline(intercept = 0.8,slope = 0,col='black')+
  ggtitle('Power curve as a function of Delta')






