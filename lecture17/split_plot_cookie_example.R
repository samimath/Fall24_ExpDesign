## example of implementing a split-plot design (cookie experiment)
library(daewr)
library(AlgDesign)
library(GAD)
library(ggplot2)
library(lme4)
library(VCA) ## package to check whether a design is balanced or not 

## create subplots
sp <- expand.grid(trayT = factor( c("RoomT", "Hot")),
                  bakeT = factor( c("low", "mid", "high") ))
## create whole-plots 
wp <- data.frame(short = factor( c("100%", "80%") ))
## replicate whole-plots 
wp <- rbind(wp, wp)
## create design where shortening is the whole-plot factor 
## and the rest are subplot factors including interaction
## blocksizes -num of subplots, num of whole-plots
splitP <- optBlock( ~ short * (trayT + bakeT +trayT:bakeT), 
                    withinData = sp, blocksizes = rep(6, 4),
                    wholeBlockData = wp)
## alternative way of design
splitP2 <- optBlock( ~ short * trayT * bakeT, 
                    withinData = sp, blocksizes = rep(6, 4),
                    wholeBlockData = wp)




### analyzing the experiment 
## load data
data(splitPdes)
## note -- the 'batch' variable in the data is not 
## consistent with the 'batch' variable in the design for some reason, 
## I decided to follow the book example, I suspect the batch was changed to allow for a balanced design
## If we were to fix the batch label, this is a command we can use : 
splitPdes$batch <-floor(as.numeric(rownames(splitPdes)))
## visualize the data

ggplot(splitPdes) +geom_boxplot(aes(x=as.factor(short), 
                                    y =y, col = as.factor(batch)))+
  facet_grid(bakeT~trayT) + theme_bw()

## define model - method 1 using aov -- 
## notice here the implementation is slightly different 
## than what was given in the book
##
model0 <- aov(y ~ short + short%in%batch + ## whole-plot factor
               bakeT +trayT + ## subplot factors
               short*bakeT + short*trayT + ## interaction terms
               bakeT*trayT +short*bakeT*trayT,
             data = splitPdes)
summary(model0)



model <- aov(y ~ short + short%in%batch + ## whole-plot factor
               bakeT +trayT + ## subplot factors
               short*bakeT + short*trayT + ## interaction terms
               bakeT*trayT +short*bakeT*trayT + Error(short/batch),
             data = splitPdes)


summary(model)

summary( aov(y ~ short,data = splitPdes))

## define model using lmer
rmodel <- lmer(y ~ 1 + short + ## overall effect + whole-plot factor
                 bakeT + trayT + ## subplot factors
                 short:bakeT +short:trayT +   ## interaction terms
                 bakeT:trayT + short:bakeT:trayT +
                 (1|short:batch), ## random effect from whole-plot
               data = splitPdes)
## inspect effects:
anova(rmodel)
## alternatively, we can write the model this way instead of spelling out 
## all the interaction terms
rmodel2 <- lmer(y~short*bakeT*trayT + (1|short:batch), data = splitPdes)

## returning variance component
rmodel_summ<-summary(rmodel)
## effects due to shortening (A), baking temp (B) and tray temp (C), 
## as well as shortening + tray temp interaction all appear as significant
## we can use an interaction plot to better understand the effect of shortening 
## under different condition
with(splitPdes, interaction.plot(x.factor = short, 
                            trace.factor = trayT, 
                            response = y))

## additional analysis: what if we were to analyze this as if it's a CRD 
## with only factors trayT and bakeT considered?

model1<-aov(y ~bakeT +trayT + ## subplot factors
              bakeT*trayT , ## interaction terms
            data = splitPdes)
anova(model1)

model2<-aov(y ~short,  ## whole-plot factors
            data = splitPdes)
anova(model2)


