library(daewr)
library(ggplot2)

# let's visualize the data 
ggplot(rcb)+geom_boxplot(aes(x=teehgt, y=cdistance, fill = id))+facet_wrap(.~id,nrow = 3)

mod3 <- aov(cdistance ~ teehgt*id, data = rcb)
summary(mod3)
mod4 <- aov(cdistance ~ teehgt + Error(id/teehgt), data = rcb)
summary(mod4)

# alternative way to model GCB
# first calculate cell means by id and teehgt 
# (average out the replicates)
cellmeans <- tapply( rcb$cdistance, 
                     list(rcb$id, rcb$teehgt),mean)
dim(cellmeans) <- NULL
# create a new, aggregated data set
teehgt <- factor( rep(c(1,2,3), each = 9) )
id<-factor( rep(c(1,2,3,4,5,6,7,8,9), 3) )
mod5 <- aov( cellmeans ~id + teehgt )


