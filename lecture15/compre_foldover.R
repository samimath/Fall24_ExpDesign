### script to compare foldover designs:

## original design:
des_test <- FrF2( nruns = 8,  
                  nfactors = 7, 
                  generator = c('AB','AC','BC','ABC'))
## 
des_test2<- fold.design(des_test, columns = c(3))

## 
des_test3<- fold.design(des_test, columns = c(3))
aliases(lm(y~(.)^2, data = des_test2))

des_test4<- fold.design(des_test, columns = 'full')


## write a function to compare the design info from each design object

compare_designs<-function(design){
  
  des_info <- design.info(design)
  return(des_info$aliased[2])
  
}


compare_designs(design = des_test )
compare_designs(design = des_test2 )
compare_designs(design = des_test3 )
compare_designs(design = des_test4 )