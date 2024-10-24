### script to compare foldover designs:

## original design 2^{7-4}:
des_test1 <- FrF2( nruns = 8,  
                  nfactors = 7, 
                  generator = c('AB','AC','BC','ABC'))
## design 2: fold over around column C 
des_test2<- fold.design(des_test1, columns = c(3))

## design 3: fold over around columns E = AC,F=BC,G=ABC
des_test3<- fold.design(des_test, columns = c(5,6,7))

## design 4: fold over around columns C, E = AC,F=BC,G=ABC
des_test4<- fold.design(des_test, columns = c(3,5,6,7))

## design 5: fold over around all the columns
des_test6<- fold.design(des_test, columns = 'full')


## write a function to compare the main and two-way aliases from each design object

compare_designs<-function(design){
  
  des_info <- design.info(design)
  return(des_info$aliased[2])
  
}




k=0
for(i in list(des_test1,des_test2,des_test3,
              des_test4,des_test5,des_test6)){
  k <- k+1
  print(paste('design',k))
  output <- compare_designs(design = i )
  
  print(output)
}

