## COdata example
## In this example, we'll do the following:
## 1. Analyze the COdata example using ANOVA 
## 2. Inspect fixed effects from each factor-level combinations
## 3. Inspect interactions between the factors

### First, let's list the packages we need 
library(daewr)
library(gmodels)
library(effects)

### Fit the data with a mixed effects model 

mod1 <-aov(CO~Eth*Ratio, data = COdata)
summary(mod1)

### Take a look at the marginal means and sd for each factors 
model.tables(mod1, type = 'means', se = TRUE)

### interaction plot -- you can use the book example 'interaction.plot', 
### but this one works as well
mod1 <-aov(CO~Eth*Ratio, data = COdata)
plot(effects::allEffects(mod1))

mod2 <-aov(CO~Ratio*Eth, data = COdata)
plot(effects::allEffects(mod2))


