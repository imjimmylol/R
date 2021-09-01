########################1. 線上連續劇觀看資料########################

library(tidyverse)
library(readr)
library(ggplot2)
getwd()
setwd(".\\data")

watch_table <- read_csv("watch_table.csv")
user_table <- read_csv("user_table.csv")
drama_table <- read_csv('drama_table.csv')

#1.將 watch.table 與其他兩個報表合併為full.table
g1 <- watch_table %>% left_join (user_table)
full_table <- g1 %>% left_join(drama_table)

#2.分析full.table，計算每部劇男生、女生觀看次數

full_table %>% 
  group_by(drama_name,gender) %>%
  summarise("觀看次數" = length(gender))

#3.找出用Android系統的，針對這類客戶進行分析

gand <- filter(full_table,device == 'Android') %>%
  summarise('平均年齡'=mean(age),
            '最多使用地區'=max(location),
            '最多使用的性別'=max(gender))

print(gand)
#Android 用戶的平均年齡為28-29歲，而主要分布在台北市，多為男性


#4.針對台北男性這類客戶進行分析。
b <- filter(full_table, gender=='male'&location=='Taipei')


#不同劇的觀看的次數分配

qplot(drama_name,data=b)

#由此可知最受這類客戶歡迎的劇為from 5 to 9

#不同人的看劇習慣
b %>%
  group_by(user_name,drama_name)%>%
  summarise('什麼劇看了幾次' = length(drama_name))

#Alex Chu 比較喜歡 From 5 to 9
#jay chou 比較喜歡 she was pretty


######################2. kaggle上2019紐約Airbnb的資料##########################

#1. 找出 neighbourhood_group == "Manhattan"的資料，利用ggplot畫經緯度的scatter plot

fulldata <- read_csv('wtf.csv')

n1 <- filter(fulldata,neighbourhood_group == 'Manhattan')

qplot(latitude,longitude,data=n1)

#2. 針對曼哈頓資料，對number_of_reviews >=400的畫bar chart。

n2 <- filter(fulldata,neighbourhood_group == 'Manhattan'& number_of_reviews >=400)

qplot(number_of_reviews ,data=n2)

#3. 針對曼哈頓資料，number_of_reviews >=400的中，哪個neighbourhood擁有最多number_of_reviews。

n3 <- filter(fulldata,number_of_reviews >=400)

n3[which.max(n3$number_of_reviews),]$neighbourhood


#4. 建立一筆新資料，將3.找出的neighbourhood篩選出來，去除掉NA值後，進行EDA分析，並簡單介紹最高房價及最低房價分別的類型。

#EDA分析
names(fulldata)

n4 <- na.omit(fulldata) %>% 
  filter(number_of_reviews >=400) %>%
  
  group_by(neighbourhood_group,room_type) %>%
  
  summarise('不同區域下不同房型平均價格'=mean(price),
            '不同區域下不同房型最貴'=max(price),
            '不同區域下不同房型最便宜價格'=min(price))

print(n4)
#由此可知平均房價由大至小為Manhattan>Brooklyn>Queens
#而相同地區下又以Entire home/apt 比Private room還要貴  
ggplot(na.omit(fulldata), aes(latitude,price)) +geom_point()+geom_line()
#此圖可以看出在房價的最高點(精華區)位於緯度40.7至40.8之間

ggplot(na.omit(fulldata), aes(number_of_reviews,price)) +geom_point()+geom_line() +facet_grid(.~neighbourhood_group)+geom_smooth()
#由此圖可以看出對每一區而言通常價格越低評論就會越多，可能是滿意cp值或不滿服務品質所以大量的進行回復


#最高房價及最低房價分別的類型由eda得知

#最高房價類型 特徵 位於Manhattan,房型為Entire home/apt 
#最低房價類型 特徵 位於Queens,房型為Private room
  

