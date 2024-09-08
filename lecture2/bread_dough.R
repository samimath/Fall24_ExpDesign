set.seed(2023)
# list of factor levels by number of reps
f <-factor(rep(c(35,40,45), each = 4))
# randomly assign bread dough to treatment levels
fac <- sample(f, 12)
#experimental units
eu <- 1:12
plan <- data.frame(loaf = eu, time = fac)
write.csv(plan, file  = './data/Plan.csv', row.names = FALSE)
#add a column to record height
plan$Height <-NA
#view plan
View(plan)


### 

## plot F distribution with 2 (t-1) and 9 (n-t) deg. of freedom:

x <- seq(from = 0,to =5,by = 0.01)
plot(x,df(x,df1 = 2,df2 = 9), type = 'l')x