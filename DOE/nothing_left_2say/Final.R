# Read data####
setwd("C:/Users/user/Desktop/R/DOE/Data")
library(readr)
library(dplyr)
library(ggplot2)
df = as_tibble(read.csv("covid_data.csv"))

# a little EDA####
summary(df$SYMPTOM1)

ggplot(data = df, aes(fill=VAX_MANU, x=DIED)) + 
  geom_histogram(stat = 'count')

ggplot(data = df, aes(fill=SEX, x=DIED)) + 
  geom_histogram(stat = 'count')

ggplot(data = df, aes(fill = DIED,x=AGE_YRS)) + 
  geom_histogram()


df_y = df %>% filter(DIED == "Y"&VAX_MANU == "JANSSEN") 

df_y$AGE_YRS %>% summary() 

df$AGE_YRS %>% summary()
#####
