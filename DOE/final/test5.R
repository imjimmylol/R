setwd("C:/Users/user/Desktop/R/DOE/Data")
library(readr)
library(dplyr)
library(stringr)
library(hash)
df =  readxl::read_xlsx("crim109.xlsx")

magic = function(x){
  y = str_sub(x, start = 1, end = 3) %>% parse_number() %>% as.character()
  m = str_sub(x, start = 5, end = 7) %>% parse_number() %>% as.character()
  return( paste(y, m, sep = "-"))
}
df_temp = readxl::read_xlsx("temperature.xlsx")
names(df_temp) = c("Date", "臺北市", "高雄市", "123", "新竹市", "臺中市", "花蓮市")
df_temp = df_temp[,-4]

sapply(df_temp$Date, magic) %>% as.vector()

df = df[-1,]
df = df %>% filter((type=="毒品")|(type=="機車竊盜")|(type=="汽車竊盜")|(type=="住宅竊盜")|(type=="強制性交")|(type=="強盜")|(type=="搶奪"))

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
    return("robbey")
  }
}

append_temper = function(loc, m){
  
}

append_popula = function(loc){
  if(loc=="台北市"){
    
  }
}

df$crime_type =  sapply(df$type, crmin_trans) %>% as.vector()



df$district = df$loca %>% loca_trans() 
df$Date = df$dt %>% d_trans() %>% as.Date()
df = df[,-c(2,3)]
df = df %>% filter((district!="外國")&(district!="台灣海")&(district!="金門縣")&(district!="連江縣")&(district!="澎湖縣")&
                     (district!="屏東縣")&(district!="台東縣")&(district!="臺東縣")&(district!="花蓮縣")) 
# df$district %>% as.factor() %>% summary()
df$season =  sapply(df$Date, season_trans) %>% as.vector()

df$month = strftime(df$Date,"%m") 

df = df %>% filter(district == "臺北市"|district == "高雄市"|
                           district == "新竹市"|district == "臺中市")


# 縣市轉換
df[which(df$district=="臺中市"),2] = "台中市" 
df[which(df$district=="臺北市"),2] = "台北市"
df[which(df$district=="臺南市"),2] = "台南市"
# city = df$district %>% unique()
n = c("台北市", "新竹縣", "新竹市")
m = c("臺中市")
s = c("高雄市")
e = c("花蓮市")

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

# 溫度append



df$part = part_res









