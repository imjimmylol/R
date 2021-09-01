library(readr)
library(zoo)
library(tidyr)
library(xts)
library(ggplot2)
library(hrbrthemes)
#load data####
df_sales = read_csv('train.csv')
col_index = which(names(df_sales)=='Category'|names(df_sales)=='Sales'|names(df_sales)=='City'|names(df_sales)=='Order Date')
df_sales_col = df_sales[,col_index]
rm(df_sales)
#clean data####
d = lapply(df_sales_col$`Order Date`, function(x, d_loc = 1){
  tmp = strsplit(x, '/') %>% unlist()
  res = tmp[d_loc] %>% unlist()
}) %>% unlist()

m = lapply(df_sales_col$`Order Date`, function(x, d_loc = 2){
  tmp = strsplit(x, '/') %>% unlist()
  res = tmp[d_loc] %>% unlist()
}) %>% unlist()

y = lapply(df_sales_col$`Order Date`, function(x, d_loc = 3){
  tmp = strsplit(x, '/') %>% unlist()
  res = tmp[d_loc] %>% unlist()
}) %>% unlist()

df_sales_col$date = paste(y, m, d, sep ='-')

df_sales_col = df_sales_col[,-1] 
# df_sales_col$Category = as.factor(df_sales_col$Category)


#sales, subset by catego####
product_filter = function(data, prod_name){
  cate_index = which(data$Category == prod_name)
  res = data[cate_index,]
  return(res)
}

plot_prod_serie = function(data, prod_name, start, end){
  data = data %>% product_filter(prod_name)
  data = data[,which(names(data)=='date'|names(data)=='Sales')] %>% as.data.frame()
  data_index = as.Date(data$date)
  data =  xts(data$Sales, order.by = data_index)
  ep = endpoints(data, 'days') 
  data_clean = period.apply(data, ep ,sum) %>% as.data.frame()
  data_clean$day = rownames(data_clean) 
  rownames(data_clean) = NULL
  data_clean$date = as.Date(data_clean$day)
  colnames(data_clean)[1] <- "Sales"
  
  res = ggplot(data_clean, aes(x=date, y=Sales)) +
    geom_line( color="#69b3a2" , size = 1) +
    xlab("") +
    geom_point()+
    theme(axis.text.x=element_text(angle=60, hjust=1))+
    scale_x_date(limit=c(as.Date(start),as.Date(end)))
  
  return(res)
}


# product_filter(data = df_sales, prod_name = 'Office Supplies')


# plot_prod_serie(df_sales_col, 'Office Supplies', start = "2015-01-01", end = "2016-3-31")














