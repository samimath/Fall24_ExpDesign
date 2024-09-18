## Voltage experiment example with 2^3 design
library(daewr)
library(dplyr)
#library(DoE.base) --> this may not work for everyone 
# alternative method for orthogonal encoding for the factor levels
# use contr.sum(n), where n = number of levels
# we can use a for loop to assign all the factors the same type of encoding
for(col in c('A','B','C')){
  contrasts(volt[,col])<- -1*contr.sum(2)
}
modv <- lm( y ~ A*B*C, data = volt,x = TRUE )
summary(modv)
# take a look inside the designed matrix:
X<-matrix(as.numeric(modv$x[1:16,]),nrow = 16,ncol = 8)
XtX<-t(X)%*%X