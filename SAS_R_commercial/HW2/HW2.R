x <- 15

div=function(x){
  if(x%%5==0 & x%%3==0){
    y= 'Divisible'
  }
  else if(x%%3==0){
    y='Divisible3'
  }
  else if(x%%5==0){
    y='Divisible5'
  }
  else{
    y=x
  }
  return(y)
}


result = c()

for ( a in c(1:100)){
  result[a] = div(a)
}

#while °j°éªº¼gªk
#li=c()
#a=0

#while(length(li)<=100){
#  li = append(li,div(a), after = 0)
#  a=a+1
#}

#(result)


######################################################



li = c()

while(length(li)<=39){
  x <- runif(1, 0, 100)
  e <- rnorm(1, 0, 2)
  y = x + e
  if(y>=0 & y<=100){
    li = append(li, y, after = 0)
  }
  else{
    rm(y)
  }
}



CI95 = function(x){
  a = 0.05
  n = length(x)
  mx = mean(x)
  r1 = qnorm(a/2)
  r2 = qnorm(1-a/2)
  CIL = mx-r2*sd(x)/sqrt(n)
  CIR = mx-r1*sd(x)/sqrt(n)
  return(range = c(CIL,CIR,mx))
}

CI95(li)








