## signal to noise example 

test_data<-data.frame(sample1 = c(10,10,10,10),
                      sample2 = c(12,6,14.6,3),
                      sample3 = c(3,7,11,15),
                      sample4 = c(1,1,1,20))

sn_s_func<-function(y){
  return(-10*log(sum(y^2)/length(y),base = 10))
}
sn_s <- apply(test_data,2,sn_s_func)




mean_vals <- apply(test_data,2,mean)
sd_vals <- apply(test_data,2,sd)

## reshape data to plot it in ggplot

library(reshape) 
library(ggplot2)

ggplot(melt(test_data))+ 
  geom_point(aes(x=rep(1:4,4),
                 y=value, col = variable), size =3 )+
  facet_wrap(~variable,ncol=2)+
  theme_bw()