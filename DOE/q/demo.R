setwd("C:/Users/user/Desktop/R/DOE/q")
df = readr::read_csv("clean_data.xlsx")
df

# 每個cell 例如 結婚率:"5 ~ 5.5" / 氣溫:"20~25" / 犯罪種類 theft

cell_df = df %>% filter(marr_level == "4.5 ~ 5") %>% 
  filter(temp_level == "15~20") %>% 
  filter(type == "drug")

cell_df

cell_df  %>% filter(district == "臺北市")


# 把每個縣市 例如高雄或新北的資料合起來當作observation

crim_rate = function(df){
  res = c()
  uniq_dist = unique(df$district) 
  for(i in uniq_dist){
    df_dist = df %>% filter(district==i)
    num_of_crime = nrow(df_dist) 
    rate_of_crime = num_of_crime/(df_dist$popula[1]) 
    res = append(res, rate_of_crime)
  }
  return(res)
}