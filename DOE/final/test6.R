# read data####

setwd("C:/Users/user/Desktop/R/DOE/Data")
library(readr)
library(dplyr)
library(stringr)
library(hash)
# crime
df =  readxl::read_xlsx("crim109.xlsx")
# temperature
df_temp = readxl::read_xlsx("temperature.xlsx")
names(df_temp) = c("Date", "臺北市", "高雄市", "123", "新竹市", "臺中市", "花蓮市")
df_temp = df_temp[,-4]

# my function####
magic = function(x){
  y = str_sub(x, start = 1, end = 3) %>% parse_number() %>% as.numeric()
  m = str_sub(x, start = 5, end = 8) %>% parse_number() %>% as.character()
  return( paste(as.character(y+1911), m, sep = "-"))
}
d_trans = function(raw_d){
  
  y = str_sub(raw_d, start = 1, end = 3) %>% as.numeric()
  m = str_sub(raw_d, start = 4, end = 5)
  d = str_sub(raw_d, start = 6, end = 7)
  ymd = paste(as.character(y+1911), m, d, sep = "-")
  return(ymd)
  
}
month_trans = function(date){}
loca_trans = function(raw_loca){
  
  return(str_sub(raw_loca, start = 1, end = 3))
  
}
season_trans = function(ymd){
  season = str_sub(ymd, start = 5, end = 6) %>% as.numeric()
  if(season<4){
    return("spring")
  }
  else if((season<=6) & (season>=4)){
    return("summer")
  }
  else if((season<=9) & (season>6)){
    return("autumn")
  }
  else{
    return("winter")
  }
}
crmin_trans = function(crime){
  if(crime == "毒品"){
    return("drug")
  }
  else if(crime == "機車竊盜"|crime == "汽車竊盜"|crime == "住宅竊盜"){
    return("theft")
  }
  else if(crime == "強制性交"){
    return("rape")
  }
  else{
    return("robbery")
  }
}
append_temper = function(loc, m){
  
}
append_popula = function(loc){
  if(loc=="台北市"){
    
  }
}
temp_trans = function(district, month){
  col_index = which(names(df_temp_2000)==district)
  row_index = month
  res = as.numeric(df_temp_2000[row_index,col_index])
  return(res)
}
popl_trans = function(district){
  if(district == "臺北市"){
    return(2602418)  
  }
  else if(district == "高雄市"){
    return(2765932)
  }
  else if(district == "新竹市"){
    return(451412)
  }
  else if(district == "臺中市"){
    return(2820787)
  }
  else(district == "花蓮縣")
    return(324)
}
temp_dummy = function(temp){
  if(temp<=20){
    return("15~20")
  }
  else if(temp<=25&temp>20){
    return("20~25")
  }
  else{
    return("25~30")
  }
}
crmin_trans = function(crime){
  if(crime == "毒品"){
    return("drug")
  }
  else if(crime == "機車竊盜"|crime == "汽車竊盜"|crime == "住宅竊盜"){
    return("theft")
  }
  else if(crime == "強制性交"){
    return("rape")
  }
  else{
    return("robbey")
  }
}
part_trans = function(loca){
  n = c("台北市", "新竹縣", "新竹市")
  m = c("臺中市")
  s = c("高雄市")
  e = c("花蓮市")
  if(loca %in% n){
    return("北部")
  }
  else if(loca %in% m){
    return("中部")
  }
  else  if (loca %in% s){
    return("南部")
  }
  else{
    return("東部")
  }
}
# wash temperature####
df_temp$y_m = sapply(df_temp$Date, magic) %>% as.vector()
df_temp = df_temp[,-1]

df_temp_2000_index = c()
for(i in 1:nrow(df_temp)){
  qq = str_sub(df_temp[i,6], start = 1, end = 4)
  if(qq == "2020"){
    df_temp_2000_index = append(df_temp_2000_index, i)
  }
  else{
    next 
  }
}

df_temp_2000 = df_temp[df_temp_2000_index, ]
# which(names(df_temp_2000)=="臺北市")

# wash criminal data####
df = df[-1,]
df = df %>% filter((type=="毒品")|(type=="機車竊盜")|(type=="汽車竊盜")|(type=="住宅竊盜")|(type=="強制性交")|(type=="強盜")|(type=="搶奪"))
df$district = df$loca %>% loca_trans() 
df$Date = df$dt %>% d_trans() %>% as.Date()
df = df[,-c(2,3)]
df = df %>% filter((district!="外國")&(district!="台灣海")&(district!="金門縣")&(district!="連江縣")&(district!="澎湖縣")&
                     (district!="屏東縣")&(district!="台東縣")&(district!="臺東縣")&(district!="花蓮縣")) 
# df$season =  sapply(df$Date, season_trans) %>% as.vector()

df$month = strftime(df$Date,"%m") %>% as.numeric() 
df$sseason

df = df %>% filter(district == "臺北市"|district == "高雄市"|
                     district == "新竹市"|district == "臺中市")

# 縣市轉換####
df[which(df$district=="台中市"),2] = "臺中市" 
df[which(df$district=="台北市"),2] = "臺北市"
df[which(df$district=="台南市"),2] = "臺南市"
# city = df$district %>% unique()
n = c("臺北市", "新竹縣", "新竹市")
m = c("臺中市")
s = c("高雄市")
e = c("花蓮縣")

part_res = c()
for(i in 1:nrow(df)){
  iter_part = as.character(df[i,3])
  if(iter_part %in% n){
    part_res = append(part_res, "北部")
  }
  else if(iter_part %in% m){
    part_res = append(part_res, "中部")
  }
  else  if (iter_part %in% s){
    part_res = append(part_res, "南部")
  }
  else{
    part_res = append(part_res, "東部")
  }
}
df

# 併入溫度####
temp = c()
for(i in 1:nrow(df)){
  dis = df[i,2] %>% as.character() 
  mont = df[i,4] %>% as.numeric()
  temp = append(temp,temp_trans(dis, mont))
}
df$temp = temp

# 併入人口####
df$popula = sapply(df$district, popl_trans) %>% as.vector()
# finally clean####
df %>% head()
# create temp dummy
df$temp_level = sapply(df$temp, temp_dummy) %>% as.vector()
df$type = sapply(df$type, crmin_trans) %>% as.vector()
df$part = sapply(df$district, part_trans) %>% as.vector()

df = df[,c(1,4:5,6:8)]
df
# seperate data frame####
temp_iter = c("15~20", "20~25", "25~30")

df %>% filter(part == "北部" & temp_level == "25~30" & type == "robbery")



