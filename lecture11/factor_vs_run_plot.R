library(ggplot2)
factorial_growth<-data.frame(num_factors = 2:9, num_runs = 2^(2:9))
ggplot(factorial_growth)+geom_bar(aes(x=num_factors, y =num_runs),
                                  stat = 'identity')+coord_flip()