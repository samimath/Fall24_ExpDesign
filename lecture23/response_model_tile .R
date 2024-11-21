## response modeling - tile example 
library(daewr)
library(ggplot2)
smod<-lm(y ~ A + B + C + D + E + F + G + H + 
           A*H + B*H + C*H + D*H +
           E*H + F*H + G*H, data = strungtile)
summary(smod)

effects <- coef(smod)
effects <- effects[c(2:16)]
Wpeffects <- effects[c(1:7)]
Speffects <- effects[c(8:15)]
halfnorm(Wpeffects, names(Wpeffects), alpha=.10)
halfnorm(Speffects, names(Speffects), alpha=.20)

## interaction plot for mean 
interaction.plot(
  x.factor = strungtile$H,
  trace.factor = strungtile$C,
  response = strungtile$y,
  fun = mean,
  ylab = "Mean # of defective tiles per 100",
  xlab = "Kiln position",
  trace.label = "Lime %",
  col = c("#0198f9", "#f95801"),
  lty = 1,
  lwd = 3
)



## interaction plot for variance
interaction.plot(
  x.factor = strungtile$H,
  trace.factor = strungtile$C,
  response = strungtile$y,
  fun = var,
  ylab = "Variance # of defective tiles per 100",
  xlab = "Kiln position",
  trace.label = "Lime %",
  col = c("#0198f9", "#f95801"),
  lty = 1,
  lwd = 3
)
