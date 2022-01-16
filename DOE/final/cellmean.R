library(dplyr)
library(tidyr)
library(ggplot2)

# function  
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
reshape_matr = function(df){
  df_res = data.frame(
    temp = numeric(0),
    marr = numeric(0),
    rate = numeric(0)
  )
  for(i in 1:ncol(df)){
    colnames = names(df)[i]
    # print(rep(colnames, 3))
    for(j in 1:nrow(df)){
      rownames = row.names(df)[j]
      # print(c(colnames, rownames, df[,i][j]))
      tmp = data.frame(
        temp = colnames,
        marry = rownames,
        rate = df[j,i]
      )
      df_res = rbind(df_res, tmp)
    }
  }
  return(df_res)
}

# import data
setwd("C:/Users/user/Desktop/R/DOE/Data")
df = readxl::read_xlsx("clean_data.xlsx")

# cell mean
marry_iter = c("4.5 ~ 4.83", "4.83 ~ 5.16", "5.16 ~ 5.5")
temp_iter = c("15~20", "20~25", "25~30")
type_iter = c("drug", "rape", "robbey", "theft") 

n_obs =  c()
cell_mean = c()
cell_std = c()

for(k in type_iter){
  for(i in temp_iter){
    for(j in marry_iter){
      df_iter = df %>% filter(marr_level == j) %>% filter(temp_level == i) %>% filter(type == k)
      y = crim_rate(df_iter)
      n_obs = append(n_obs, length(y))
      cell_mean = append(cell_mean, mean(y))
      cell_std = append(cell_std, var(y))
    }
  }
}

# df for plot, by 

coln = temp_iter
rown = marry_iter

matrix(c(n_obs[1:9]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))
a = matrix(c(cell_mean[1:9]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))


matrix(c(n_obs[10:18]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))
b = matrix(c(cell_mean[10:18]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))


matrix(c(n_obs[19:27]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))
c = matrix(c(cell_mean[19:27]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))

matrix(c(n_obs[28:36]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))
d = matrix(c(cell_mean[28:36]), nrow  = 3, ncol = 3,byrow = TRUE,dimnames = list(rown, coln))


# drug

drug_df = as.data.frame(a)
drug_df = reshape_matr(drug_df)
drug_df
# z = rep(c("15~20", "20~25", "25~30"), 4)
# df_plot = data.frame(
#   "crime_type" = x,
#   "mean" = y,
#   "temperature" = z,
#   "crime_dummy" = c(1,1,1,2,2,2,3,3,3,4,4,4)
# )
