## parametric model - cubic Scheffe example
#set up parameter values
b1<-50
b2<-100
b12<- 200
d12<- 0
# set up design points
x1<-seq(0,1,0.1)
x2<-1-x1
#set up model
cubic_scheffe <- b1*x1+b2*x2+b12*x1*x2+d12*x1*x2*(x1-x2)

plot(x1,cubic_scheffe,type='b')
