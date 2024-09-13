## 1. creating a 2-factor design plan
# creating grid for levels of different factors:

D <- expand.grid( BW = c(3.25, 3.75, 4.25), WL = c(4, 5, 6) )
D

## two ways to create replicates:

## method 1: create 2 reps per combination of level
D1<-rbind(D,D)

## method 2: using do.call
D2 <- do.call(rbind,replicate(2,D,simplify = FALSE))

## method 3: another way is to create a function using for-loop to create r number of reps 
rep_df<-function(D,r){
  # D = all possible unique treatment combinations
  # r = number of reps for each treatment combo
  
  
  for(i in 1:r){
    D<-rbind(D,D)
    print(paste('rep',i,'finished'))
  }
  return(D)
}

D3<-rep_df(D=D,r=2)

## 2. randomizing order of the runs
set.seed(2023)
D4<-D1[order(sample(1:nrow(D1))),]

## 3. save the plan to your current directory
#setwd(dir = './lecture4/')
CopterDes <-D4[c('BW','WL')]
write.csv(CopterDes,'CopterDes.csv',row.names = TRUE)
