library(ggplot2)
## tea example for mixture experiments 
### set up data frame
jasmine <-c(1,0.75,0.5,0.25,0)
eg<-c(0,0.25,0.5,0.75,1)
flavor<-c(3.5,4.7,6.2,6,5.2)
tea<-data.frame(cbind(jasmine,eg,flavor))
contour(tea)
plot(eg,flavor,type = 'b',
     xlab='Earl Gray proportion', 
     ylab ='Flavor score',col='forestgreen')
abline(a=3.5,b=1.7, col='red')


jasmine2 <-c(1,2,1,2)
eg2<-c(1,1,2,2)
total <- jasmine2+eg2
flavor2<-c(6.2,6.5,7.6,5.4)
tea2<-data.frame(cbind(jasmine2,eg2,total,flavor2))

ggplot(tea2)+geom_line(aes(x = eg2, y = flavor2, 
                           linetype = as.factor(jasmine2)))+theme_bw()