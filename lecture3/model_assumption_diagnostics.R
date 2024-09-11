## trying out some variable transformation methods
library(daewr) # load textbook R package
library(MASS) # load Applied Statistics package
## example of finding optimal box-cox parameter

# set up model object using aov (lm also works)
mod1 <- aov(height ~ time, data = bread)
# call the boxcox function with default lambda range
bc <-boxcox(mod1) 
lambda <- bc$x[which.max(bc$y)] ## x = vector of lambdas the algorithm tested, y = log-likelihood value
bread$theight <-bread$height^lambda
# let's also try square-root transformation
bread$sheight <-sqrt(bread$height)
# compare the ANOVA results of the models

mod2 <-aov(theight ~ time, data = bread)
mod3 <-aov(sheight ~ time, data = bread)
summary(mod1)
summary(mod2)
summary(mod3)

# what about weighted least square estimation?

# define standard dev of the response at each treatment level
std <- tapply(bread$height, bread$time, sd)
# define weight vector to be used in the model
weights <- rep(1/std, each = 4)
# create another model
mod4 <- aov(height~time, weights = weights, data = bread)
#summarize results with anova
summary(mod4)
# visualize model diagnostics with mod4
par( mfrow = c(2,2))
plot(mod4, which = 5)
plot(mod4, which = 1)
plot(mod4, which = 2)
plot(residuals(mod4)~loaf, main = 'Residuals vs Exp. Unit', data = bread)


