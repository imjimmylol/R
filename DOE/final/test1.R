setwd("C:/Users/user/Desktop/R/DOE/Data")
library(readr)
library(dplyr)
library(stringr)
df =  readxl::read_xlsx("test.xlsx")

# type = c("毒品", "機車竊盜", "汽車竊盜", "住宅竊盜", "強制性交", "強盜", "搶奪")

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

year_index = c()
goal_year = "2017"

for(i in length(tmp)){
  y = str_sub(tmp[i], start = 1, end = 4)
  if(y == goal_year){
    year_index = append(year_index, i)
    
  }
  else{
    next
  }
}

year_index




for(i in tmp){
  qq = as.POSIXct(i, format="%Y-%m-%d")
  date = append(date, qq)
}


df = df %>% na.omit()

df = df[,-c(2,3)]


df %>% head()

# df = df %>% filter()

df$district %>% as.factor() %>% summary()

df = df %>% filter((district!="外國")&(district!="台灣海")&(district!="金門縣")&(district!="連江縣")&(district!="澎湖縣")) 
# df$district %>% as.factor() %>% summary()
df %>% head()

#type data 



