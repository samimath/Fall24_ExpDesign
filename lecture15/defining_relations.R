## function to find defining relation 
library(FrF2)

make_temp_data<- function(data, factors){
  ## force the values of the design object from FrF2 to be numeric
  temp_data<-data
  def_array<-list()
  #print(head(temp_data))
  for(c in factors){
    #print(c)
    temp_data[,c]<-as.numeric(paste(data[,c]))
  }
  return(temp_data[,factors])
}


def_relation <- function(data, factors){
  temp_data<-make_temp_data(data=data,factors = factors)
  #print(head(temp_data))
  def_array<-list()
  def_out<-NULL
  for(i in 2:length(factors)){
    def_array[[i]]<-combn(x=factors,i)
    #print(def_array[[i]])
    for(j in 1:ncol(def_array[[i]])){
      check_vec<-apply(temp_data[,def_array[[i]][,j]],1,prod)
      if(sum(check_vec)==length(check_vec)){
        out<-paste(def_array[[i]][,j],collapse="", sep="")
        def_out<-c(def_out,out)
      }
    }
  }
  return(def_out)
}

### example

des<- FrF2(nruns = 8,nfactors = 7,
                    factor.names = c('A','B','C','D','E','F','G'), 
                    generators = c('AB','AC','BC','ABC'))

def_relation(data=data.frame(des),factors =c('A','B','C','D','E','F','G'))