## LSD design example with bioequivalence study
library(daewr)
mod6 <- aov( AUC ~ Subject + Period + Treat, data = bioeqv)
summary(mod6)
model.tables( mod6, type = "means" )$tables$Treat
TukeyHSD( mod6, "Treat")
