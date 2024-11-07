## example of implementing a split-plot design (cookie experiment)
library(daewr)
library(AlgDesign)
library(ggplot2)
library(lme4)
library(GAD)


## load the data"

data(splitPdes)



## define model using lmer
model1 <- lmer(y ~ 1 + short + ## overall effect + whole-plot factor
                 bakeT + trayT + ## subplot factors
                 short:bakeT +short:trayT +   ## interaction terms (fixed)
                 bakeT:trayT + short:bakeT:trayT +
                 (1|short:batch), ## random effect from whole-plot
               data = splitPdes)
## review variance components:
summary(model1)
## inspect effects:
anova(model1)


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


