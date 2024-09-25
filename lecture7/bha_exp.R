library(daewr)
library(lme4)
## CRBD design (with blocking)
mod3 <- aov( y ~ block + strain * treat, data = bha)
summary(mod3)
## CRD design without blocking 
mod4 <- aov( y ~ strain * treat, data = bha)
summary(mod4)
mod5<-aov(y~block+block:strain+block:strain:treat,data=bha)



## calculate relative efficiency:
RE <-function(df1,df2,mse1,mse2){
  ## df1 = crd, df2 = rcb
  # calculate relative efficiency of design 1 to design 2
  RE = ((df1+1)*(df2+3)*mse2)/((df1+3)*(df2+1)*mse1)
  return(RE)
}

# df_crd = 7, sigma_crd = 2.6
# df_rcb = 8, sigma_rcb = 8.2
RE_bha <- RE(df1 = 7, df2 = 8, mse1 = 2.6,mse2 = 8.2 )