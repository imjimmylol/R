# read data####
setwd("C:/Users/user/Desktop/R/DOE/Data")
library(readr)
library(dplyr)
library(ggplot2)
df = as_tibble(read.csv("covid_data_pain.csv", encoding = "CP950"))

df = df[c(1,2,8:10)]

# wash data####
summary(df$AGE_YRS)
age = c()
for(i in df$AGE_YRS){
  if(15<i & i<=35){
    age = append(age, "15_35")
  }
  else if(35<i & i<=55){
    age = append(age, "35_55")
  }
  else if(55<i & i<=75){
    age = append(age, "55_75")
  }
  else{
    age = append(age, "75_95")
  }
}
df$age = as.character(age)

# df_ijk_trans  = function(df, age, pain, vax){
#   df_res = df %>% filter(age == as.character(age) & Pain_type == pain & VAX_MANU==vax)
#   return(df_res)
# }

df_ijk_trans_test  = function(df, age, pain, vax){
  index = which(df$age == age & df$Pain_type == pain & df$VAX_MANU == vax)
  return(df[index,])
}


age_iter = c("15_35", "35_55", "55_75", "75_95")
# pain_iter = c("¥|ªÏµh", "¨ä¥Lµh", "ÀYÀVµh", "Âß·Fµh")
pain_iter = c("¥|ªÏµh", "ÀYÀVµh", "Âß·Fµh")
vax_iter = c("MODERNA", "PFIZER\\BIONTECH", "JANSSEN") 

df = df %>% filter(Pain_type!="¨ä¥Lµh")

qq = c("15_35","¥|ªÏµh", "MODERNA")

# calculate cell mean####
library(hash)
magic = function(df){
  res = hash()
  p = sum(df$DIED=="Y")/(length(df$DIED))
  n = df %>% nrow()
  q = 1-p
  res[["n_obs"]] = n 
  res[["mean"]] = n*p
  res[["std"]] = n*p*q
  return(res)
  
}

n_obs =  c()
cell_mean = c()
cell_std = c()


for(k in vax_iter){
  for(i in age_iter){
    for(j in pain_iter){
      i = as.character(i)
      tmp = magic(df_ijk_trans(df, age = i,pain = j, vax = k))
      n_obs = append(n_obs, tmp$n_obs)
      cell_mean = append(cell_mean, tmp$mean)
      cell_std = append(cell_std, tmp$std)
    }
  }
}
coln = age_iter 
rown = pain_iter






