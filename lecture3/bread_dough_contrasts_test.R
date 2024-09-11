# developing a contrast test to test linear trend for the bread dough example
library(daewr)
library(gmodels)
## 1. assign contrast coef using contr.poly, input is # of factor levels
contrasts(bread$time) <- contr.poly(3)
contrasts(bread$time)
## visualize what the contrasts look like:
plot(levels(bread$time),contrasts(bread$time)[,1],
     type = 'b',xlab = 'bread rising time', ylab = 'coeff', 
     main = 'contrasts for linear trend')

plot(levels(bread$time),contrasts(bread$time)[,2],
     type = 'b',xlab = 'bread rising time', ylab = 'coeff', 
     main = 'contrasts for quadratic trend')

## 2. fit the model 
mod1 <- lm(height ~ time, data = bread)
## 3. inspect summary of effects
summary(mod1)

