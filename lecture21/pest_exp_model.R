## pesticide mixture experiment
library(daewr)
library(mixexp)
data(pest)
DesignPoints(pest)
## we can use lm() to fit the model:
pest_qm1<- lm(y ~ x1+x2+x3+x1:x2+x1:x3+x2:x3-1,data = pest)
  
## or MixModel()
pest_qm <-MixModel(frame = pest, ##dataframe
                      response = 'y', ## response 
                      mixcomps = c('x1','x2','x3'), ## mixture components 
                      model = 2 ## quadratic model
                      )

pest_mixtureplot<-MixturePlot(des = pest,
                          mod=2,
                          cols=TRUE)

pest_eff<- EffPlot(des=pest[,c('x1','x2','x3','y')],
                    mod = 2,
                    nfac = 3,
                    dir = 2)

## What if we fit the data with a linear model instead?

pest_lm <-MixModel(frame = pest, ##dataframe
                             response = 'y', ## response 
                             mixcomps = c('x1','x2','x3'), ## mixture components 
                             model = 1 ## linear model
                             )
pest_linear_data <-data.frame(x1=pest$x1,x2=pest$x2,x3=pest$x3,y=predict(pest_lm,pest[,c('x1','x2','x3')]))
pest_mixtureplot_linear<-MixturePlot(des = pest_linear_data,
                              mod=2,cols=TRUE)
peset_eff_linear<-EffPlot(des=pest_linear_data,mod = 1,nfac = 3,dir = 2)

## What about special cubic model?

pest_cm<-MixModel(frame = pest, ##dataframe
                             response = 'y', ## response 
                             mixcomps = c('x1','x2','x3'), ## mixture components 
                             model = 4 ## special cubic model
)
pest_cubic_data <-data.frame(x1=pest$x1,x2=pest$x2,x3=pest$x3,
                             y=predict(pest_cm,pest[,c('x1','x2','x3')]))
pest_mixtureplot_linear<-MixturePlot(des = pest_cubic_data,
                                     mod=4,cols=TRUE)
peset_eff_cm<-EffPlot(des=pest_cubic_data,mod = 4,nfac = 3,dir = 2)

