## yarn experiment 
library(mixexp)
library(daewr)
## in the design set up there are only design points to study pure blends and binary mix, 
## so we will use a quadratic model to fit the data
yarn_data<-read.csv('lecture21/yarn_exp_data.csv',header = TRUE)
## model implementation using lm
yarn_qm<-lm(y~x1+x2+x3+x1*x2+x1*x3+x2*x3 -1, data = yarn_data)


## model implementation using MixModel
yarn_qm2 <-MixModel(frame = yarn_data, 
                    response = 'y',
                    mixcomps = c('x1','x2','x3'),
                    model = 2)

mixtureplot1<-MixturePlot(des = yarn_data[,c('x1','x2','x3','y')],
            cols=TRUE,
            mod=2)
## effect plot to investigate the changes in responses 
## by varying mixture components
EffPlot(des=yarn_data[,c('x1','x2','x3','y')],mod = 2,nfac = 3,dir = 2)
