setwd("C:/Users/user/Desktop/R/DOE/Data")
library(dplyr)
library(stringr)
df = readxl::read_xlsx("crim105.xlsx")

df = df %>% filter((type=="毒品")|(type=="機車竊盜")|(type=="汽車竊盜")|(type=="住宅竊盜")|(type=="強制性交")|(type=="強盜")|(type=="搶奪"))

d_trans = function(raw_d){
  
  y = str_sub(raw_d, start = 1, end = 3) %>% as.numeric()
  m = str_sub(raw_d, start = 4, end = 5)
  d = str_sub(raw_d, start = 6, end = 7)
  ymd = paste(as.character(y+1911), m, d, sep = "-")
  return(ymd)
  
}

loca_trans = function(raw_loca){
  
  return(str_sub(raw_loca, start = 1, end = 3))
  
}
df$district = df$loca %>% loca_trans() 
tmp = df$dt %>% d_trans()  # a=as.POSIXct("2014-05-01", format="%Y-%m-%d")
date = c()
for(i in tmp){
  qq = as.POSIXct(i, format="%Y-%m-%d")
  date = append(date, qq)
}

df = df[,-c(2,3)]
df$date = date


