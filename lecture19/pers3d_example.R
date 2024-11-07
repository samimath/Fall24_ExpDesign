## using R to visualize response surface 
library(plot3D)

x1 = seq(-10, 10, 0.1)
x2 = seq(-10 ,10, 0.1)
## example function
lm1 <- function(x,y){2+ x + 6*y + 3*x*y}
lm2 <- function(x,y){2+ x + 6*y}
## use the 'outer' function to calculate response for every combination of x1, x2
z1<- outer(X=x1,Y=x2,lm1)
z2<- outer(X=x1,Y=x2,lm2)

## surface plot example
persp3D(x = x1, y = x2, z = z1)
persp3D(x = x1, y = x2, z = z2)
persp3D(x = x1, y = x2, z = z)

## contour plot example
contour(x1, x2, z1)
contour(x1, x2, z2)

