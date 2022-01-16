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
df_temp2 = readxl::read_xlsx("temp.xlsx")
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
temp_trans = function(district, month){
  col_index = which(names(df_temp_2000)==district)
  row_index = month
  return(df_temp_2000[row_index,col_index] %>% as.numeric())
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
  else if(district == "花蓮市"){
    return(324372)
  }
  else if(district == "南投縣"){
    return(490832)
  }
  else if(district == "苗栗縣"){
    return(542590)
  }
  else if(district == "桃園市"){
    return(2268807)
  }
  else if(district == "基隆市"){
    return(367557)
  }
  else if(district == "新北市"){
    return(2602418)
  }
  else if(district == "嘉義市"){
    return(266005)
  }
  else if(district == "彰化縣"){
    return(1266670)
  }
  else if(district == "臺南市 "){
    return(1874917)
  }
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
loca_trans = function(raw_loca){
  
  return(str_sub(raw_loca, start = 1, end = 3))
  
}
temp_trans_test = function(district, month){
  col_index = which(names(df_temp_2000)==district)
  row_index = month
  res = as.numeric(df_temp_2000[row_index,col_index])
  return(res)
}
marry_trans = function(district){
  if(district == "臺北市"){
    return(4.83)  
  }
  else if(district == "高雄市"){
    return(5.04)
  }
  else if(district == "新竹市"){
    return(5.34)
  }
  else if(district == "臺中市"){
    return(5.5)
  }
  else if(district == "花蓮市"){
    return(5.29)
  }
  else if(district == "南投縣"){
    return(4.72)
  }
  else if(district == "苗栗縣"){
    return(4.97)
  }
  else if(district == "桃園市"){
    return(5.76)
  }
  else if(district == "基隆市"){
    return(4.85)
  }
  else if(district == "新北市"){
    return(5.27)
  }
  else if(district == "嘉義市"){
    return(4.78)
  }
  else if(district == "彰化縣"){
    return(4.74)
  }
  else if(district == "臺南市"){
    return(4.96)
  }
}
marry_rate_interval = function(marry_rate){
  if(marry_rate<=4.5){
    return("4 ~ 4.5")
  }
  else if(marry_rate>4.5&marry_rate<=5){
    return("4.5 ~ 5")
  }
  else if(marry_rate>5&marry_rate<=5.5){
    return("5 ~ 5.5")
  }
  else{
    return("5.5 ~ 6")
  }
}
marry_rate_test = function(marry_rate){
  if(marry_rate>4.5&marry_rate<=4.83){
    return("4.5 ~ 4.83")
  }
  else if(marry_rate>4.83&marry_rate<=5.16){
    return("4.83 ~ 5.16")
  }
  else if(marry_rate>5.16&marry_rate<=5.5){
    return("5.16 ~ 5.5")
  }
  else(
    return(NA)
  )
  }
crim_rate = function(df){
  res = c()
  uniq_dist = unique(df$district) 
  for(i in uniq_dist){
    df_dist = df %>% filter(district==i)
    num_of_crime = nrow(df_dist) 
    rate_of_crime = num_of_crime/(df_dist$popula[1]) 
    res = append(res, rate_of_crime*10000)
  }
  return(res)
}
crim_rate_test = function(df){
  res = c()
  uniq_dist = unique(df$district) 
  for(i in uniq_dist){
    df_dist = df %>% filter(district==i)
    num_of_crime = nrow(df_dist) 
    rate_of_crime = num_of_crime/(df_dist$popula[1]) 
    res = append(res, rate_of_crime*10000)
  }
  return(res*100)
}
cal_crime = function(df){
  
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
df_temp_2000 = cbind(df_temp_2000, df_temp2)
# which(names(df_temp_2000)=="臺北市")

# wash criminal data####

df = df[-1,]
df = df %>% filter((type=="毒品")|(type=="機車竊盜")|(type=="汽車竊盜")|(type=="住宅竊盜")|(type=="強制性交")|(type=="強盜")|(type=="搶奪"))
df$Date = df$dt %>% d_trans() %>% as.Date()
df$district = df$loca %>% loca_trans()
df = df[,-c(2,3)]
df = df %>% filter((district!="外國")&(district!="台灣海")&(district!="金門縣")&(district!="連江縣")&(district!="澎湖縣")&
                     (district!="屏東縣")&(district!="台東縣")&(district!="臺東縣")&(district!="雲林縣")&(district!="嘉義縣")&(district!="宜蘭縣")
                   &(district!="新竹縣")) 
# df$season =  sapply(df$Date, season_trans) %>% as.vector()

df$month = strftime(df$Date,"%m") %>% as.numeric() 

# 縣市轉換####
df[which(df$district=="台中市"),3] = "臺中市" 
df[which(df$district=="台北市"),3] = "臺北市"
df[which(df$district=="台南市"),3] = "臺南市"
df[which(df$district=="花蓮縣"),3] = "花蓮市"

df$district %>% as.factor()%>% summary()

# 併入溫度####
temp = c()
error_index = c()
for(i in 1:nrow(df)){
  dis = df[i,3] %>% as.character()
  mont = df[i,4] %>% as.numeric()
  res = temp_trans_test(dis, mont)
  if (length(res)==1){
    temp = append(temp, res)
  }
  else{
    error_index = append(error_index, i)
    next
  }
  
}

df = df[-error_index,]
df$temp = temp

# 併入人口####
pop = c()
error_index = c()
for(i in 1:nrow(df)){
  dis = df[i,3] %>% as.character()
  res = popl_trans(dis) 
  if (length(res)==1){
    pop = append(pop, res)
  }
  else{
    error_index = append(error_index, i)
    next
  }
  
}

df = df[-error_index,]
df$popula = pop
# 併入結婚率####
df$marr = sapply(df$district,marry_trans) %>% as.vector() 
# finally clean####
df %>% head()
# create temp dummy
df$temp_level = sapply(df$temp, temp_dummy) %>% as.vector()
# create crim dummy
df$type = sapply(df$type, crmin_trans) %>% as.vector()
# create marry dummy
df$marr_level =  sapply(df$marr,marry_rate_test) %>% as.vector()
# rio::export(df, "clean_data.xlsx")
df = df[,c(1,3,5,6:9)]

# test_df = df %>% filter(marr_level == "5 ~ 5.5") %>% filter(temp_level == "20~25") %>% filter(type == "rape")
rio::export(df, "clean_data.xlsx")

marry_iter = c("4.5 ~ 4.83", "4.83 ~ 5.16", "5.16 ~ 5.5")
temp_iter = c("15~20", "20~25", "25~30")
type_iter = c("drug", "rape", "robbey", "theft") 

n_obs =  c()
cell_mean = c()
cell_std = c()

for(k in marry_iter){
  for(i in temp_iter){
    for(j in type_iter){
      df_iter = df %>% filter(marr_level == k) %>% filter(temp_level == i) %>% filter(type == j)
      y = crim_rate(df_iter)
      n_obs = append(n_obs, length(y))
      cell_mean = append(cell_mean, mean(y))
      cell_std = append(cell_std, var(y))
    }
  }
}


temperature = c()
crime_type = c()
marry_level = c()
crime_rate = c()

for(k in marry_iter){
  for(i in temp_iter){
    for(j in type_iter){
      df_iter = df %>% filter(marr_level == k) %>% filter(temp_level == i) %>% filter(type == j)
      y = crim_rate(df_iter)
      for(city in y){
        temperature = append(temperature, i)
        marry_level = append(marry_level, k)
        crime_rate = append(crime_rate, city)
        crime_type = append(crime_type, j)
      }
    }
  }
}

# df_res = data.frame(
#   temperature = temperature,
#   crime_type  = crime_type,
#   marry_level = marry_level,
#   crime_rate = crime_rate
# )
# 
# rio::export(df_res, "aov_data.xlsx")

# test = df %>% filter(marr_level == "4.5 ~ 5") %>% filter(temp_level == "15~20") %>% filter(type == "rape")
coln = type_iter
rown = temp_iter

matrix(c(n_obs[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
a = matrix(c(cell_mean[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
matrix(c(cell_std[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))

matrix(c(n_obs[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
b = matrix(c(cell_mean[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
matrix(c(cell_std[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))

matrix(c(n_obs[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
c = matrix(c(cell_mean[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
matrix(c(cell_std[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
a
qq = as.data.frame(a)
y = c()
x = c()
for(i in 1:ncol(qq)){
  colnames = names(qq)[i]
  rownames = row.names(qq)[i]
  x = append(x, rep(colnames, 3))
  y = append(y, qq[,i])
}
# drug rape robbery theft
z = rep(c("15~20", "20~25", "25~30"), 4)
df_plot = data.frame(
  "crime_type" = x,
  "mean" = y,
  "temperature" = z,
  "crime_dummy" = c(1,1,1,2,2,2,3,3,3,4,4,4)
)
library(ggplot2)

ggplot(df_plot, aes(x=crime_dummy, y=mean, color=temperature, shape=temperature)) +
  geom_point() + geom_line() + xlab("犯罪種類") + ggtitle("結婚率 4.5 ~ 4.83")
ggplot(df_plot, aes(x=crime_dummy, y=mean, color=temperature, shape=temperature)) +
  geom_point() + geom_line() + xlab("犯罪種類") + ggtitle("結婚率 4.83 ~ 5.16")
ggplot(df_plot, aes(x=crime_dummy, y=mean, color=temperature, shape=temperature)) +
  geom_point() + geom_line() + xlab("犯罪種類") + ggtitle("結婚率 5.16 ~ 5.5")

qq = as.data.frame(c)
y = c()
x = c()
for(i in 1:ncol(qq)){
  colnames = names(qq)[i]
  rownames = row.names(qq)[i]
  x = append(x, rep(colnames, 3))
  y = append(y, qq[,i])
}
# drug rape robbery theft
z = rep(c("15~20", "20~25", "25~30"), 4)
df_plot = data.frame(
  "crime_type" = x,
  "mean" = y,
  "temperature" = z,
  "crime_dummy" = c(1,1,1,2,2,2,3,3,3,4,4,4)
)
library(ggplot2)

ggplot(df_plot, aes(x=crime_dummy, y=mean, color=temperature, shape=temperature)) +
  geom_point() + geom_line() + xlab("犯罪種類") + ggtitle("結婚率 5.5 ~ 6")



