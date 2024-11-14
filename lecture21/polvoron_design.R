## constrained mixture experiment example with 3 components
library(AlgDesign)
library(mixexp)
## create extreme vertices in a design space with constrained components
des<-Xvert(nfac = 3, # number of mixture components
           uc=c(.8,.95,.50), #upperbound of the components
           lc=c(0,.10,.05), # lowerbound of the components
           ndm=1,# number edge centroids to include in design
           plot=TRUE)

## create a D-optimal design with a subset of runs (as an example)
desPolv <- optFederov(~ -1 + x1 + x2+ x3 + x1:x2 + x1:x3
                        +  + x2:x3 + x1*x2*x3, 
                      des ,
                      nTrials=9)
DesignPoints(desPolv$design, 
             x1lower = 0, x1upper = .8,
             x2lower = .1, x2upper = .95, 
             x3lower = .05, x3upper = .50,
             pseudo=FALSE)

data(polvdat)
polvron_scm<-MixModel(frame = polvdat, ##dataframe
         response = 'y', ## response 
         mixcomps = c('x1','x2','x3'), ## mixture components 
         model = 4 ## special cubic model
)
summary(polvron_scm)
polvron_mixtureplot<-MixturePlot(des = polvdat,
                                     mod=4,cols=TRUE)
polvron_eff<-EffPlot(des=polvdat,mod = 4,nfac = 3,dir = 2)


