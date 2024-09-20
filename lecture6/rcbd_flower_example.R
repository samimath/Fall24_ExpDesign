## make rcbd plan

f <- factor( c(1,2,3,4) )
b1t <- sample(f,4)
b2t <- sample(f,4)
b3t <- sample(f,4)
b4t <- sample(f,4)
t <-c(b1t,b2t,b3t,b4t)
block <- factor( rep(c("carnation", "daisy", "rose", "tulip"),each=4))
flnum <- rep(f,4)
plan<-data.frame(TypeFlower = block, 
                 FlowerNumber = flnum,
                 treatment = t)
write.csv(plan, file = "./lecture6/RCBPlan.csv")


