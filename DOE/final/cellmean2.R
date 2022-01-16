library(dplyr)
library(ggplot2)
library(cowplot)

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
reshape_matr_temp = function(df){
  df_res = data.frame(
    type = numeric(0),
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
        type = colnames,
        marry = rownames,
        rate = df[j,i]
      )
      # print(tmp)
      df_res = rbind(df_res, tmp)
    }
  }
  df_res$crime_type = c(1,1,1,2,2,2,3,3,3,4,4,4)
  return(df_res)
}

reshape_matr_marr = function(df){
  df_res = data.frame(
    type = numeric(0),
    temp = numeric(0),
    rate = numeric(0)
  )
  for(i in 1:ncol(df)){
    colnames = names(df)[i]
    # print(rep(colnames, 3))
    for(j in 1:nrow(df)){
      rownames = row.names(df)[j]
      # print(c(colnames, rownames, df[,i][j]))
      tmp = data.frame(
        type = colnames,
        temp = rownames,
        rate = df[j,i]
      )
      # print(tmp)
      df_res = rbind(df_res, tmp)
    }
  }
  df_res$crime_type = c(1,1,1,2,2,2,3,3,3,4,4,4)
  return(df_res)
}
plot_block_temp = function(df){
  ggplot(df, aes(x=crime_type, y=rate, color=marry, shape=marry)) +
    geom_point() + geom_line() + xlab("犯罪種類") 
}
plot_block_marr = function(df){
  ggplot(df, aes(x=crime_type, y=rate, color=temp, shape=temp)) +
    geom_point() + geom_line() + xlab("犯罪種類") 
}

# import data ####
setwd("C:/Users/user/Desktop/R/DOE/Data")
df = readxl::read_xlsx("clean_data.xlsx")

# temp####
marry_iter = c("4.5 ~ 4.83", "4.83 ~ 5.16", "5.16 ~ 5.5")
temp_iter = c("15~20", "20~25", "25~30")
type_iter = c("drug", "rape", "robbey", "theft") 

n_obs =  c()
cell_mean = c()
cell_std = c()

for(i in temp_iter){
  for(j in type_iter){
    for(k in marry_iter){
      df_iter = df %>% filter(marr_level == k) %>% filter(temp_level == i) %>% filter(type == j)
      y = crim_rate(df_iter)
      n_obs = append(n_obs, length(y))
      cell_mean = append(cell_mean, mean(y))
      cell_std = append(cell_std, var(y))
    }
  }
}

# df for plot, block by temp

coln = type_iter
rown = marry_iter

matrix(c(n_obs[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
a = matrix(c(cell_mean[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))


matrix(c(n_obs[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
b = matrix(c(cell_mean[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))

matrix(c(n_obs[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
c = matrix(c(cell_mean[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))

low_temp_df = as.data.frame(a)
low_temp_df = reshape_matr_temp(low_temp_df)
low_temp_plot = plot_block_temp(low_temp_df)

mid_temp_df = as.data.frame(b)
mid_temp_df = reshape_matr_temp(mid_temp_df)
mid_temp_plot = plot_block_temp(mid_temp_df)

high_temp_df = as.data.frame(c)
high_temp_df = reshape_matr_temp(high_temp_df)
high_temp_plot = plot_block_temp(high_temp_df)

temp_legend = plot_grid(low_temp_plot, mid_temp_plot, high_temp_plot , 
          labels = c("15度~20度","20度~25度", "25度~30度"),
          ncol = 1, nrow = 3)


# df for plot, block by marry



# marr####
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

# df for plot, block by temp

coln = type_iter
rown = temp_iter

matrix(c(n_obs[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
a = matrix(c(cell_mean[1:12]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))


matrix(c(n_obs[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
b = matrix(c(cell_mean[13:24]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))

matrix(c(n_obs[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))
c = matrix(c(cell_mean[25:36]), nrow  = 3, ncol = 4,byrow = TRUE,dimnames = list(rown, coln))

low_temp_df = as.data.frame(a)
low_temp_df = reshape_matr_temp(low_temp_df)
low_temp_plot = plot_block_temp(low_temp_df)

mid_temp_df = as.data.frame(b)
mid_temp_df = reshape_matr_temp(mid_temp_df)
mid_temp_plot = plot_block_temp(mid_temp_df)

high_temp_df = as.data.frame(c)
high_temp_df = reshape_matr_temp(high_temp_df)
high_temp_plot = plot_block_temp(high_temp_df)

temp_legend = plot_grid(low_temp_plot, mid_temp_plot, high_temp_plot , 
                        labels = c("4.5 ~ 4.83","4.83 ~ 5.16", "25度~30度"),
                        ncol = 1, nrow = 3)

