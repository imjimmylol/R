library(devtools)
library(jiebaR)
library(tm)
library(tmcn)
library(devtools)
library(wordcloud2)
library(tidyverse)
#load data####
df_nlp = readxl::read_xlsx('nlp.xlsx')

#function####
get_adj = function(x){
  stopifnot(inherits(x,"character"))
  index = names(x) %in% c('Ag','a','ad','an','b')
  x[index]
}

get_noun = function(x){
  stopifnot(inherits(x,"character"))
  index = names(x) %in% c("n","nr","nr1","nr2","nrj","nrf","ns","nsf","nt","nz","nl","ng",'x')
  x[index]
}
cc = worker('tag')
plot_word_cloud <- function(data, key_word, char_len, char_freq){
  
  
  key_word_index = which(grepl(pattern = key_word, x = data) == TRUE)
  df_nlp_keywords = df_nlp[key_word_index,]
  excerpt_seg_adj = get_adj(cc[df_nlp_keywords$excerpt])
  adj_freq = freq(excerpt_seg_adj)
  
  adj_filter_len = adj_freq[which(unlist(lapply(adj_freq$char, nchar))>char_len),]
  filter_res = adj_filter_len %>% filter(freq > char_freq)
  res = wordcloud2(filter_res, fontFamily = "BiauKa")
  return(res)
}

#demo####
# p = plot_word_cloud(df_nlp$excerpt, '雙主修', 0, 0)
# p2 = plot_word_cloud(df_nlp$excerpt, input$key_word, input$char_len, input$char_freq)
#nlp####
# cc = worker('tag')
# key_word = '大家好'
# key_word_index = which(grepl(pattern = key_word, x = df_nlp$excerpt) == TRUE)
# df_nlp_keywords = df_nlp[key_word_index,]
# 
# excerpt_seg = cc[df_nlp_keywords$excerpt]
# excerpt_seg_adj = get_adj(excerpt_seg)
# 
# adj_freq = freq(excerpt_seg_adj)
# 
# adj_char_len = 1
# adj_char_freq = 1
# 
# adj_filter_len = adj_freq[which(unlist(lapply(adj_freq$char, nchar))>adj_char_len),]
# filter_res = adj_filter_len %>% filter(freq > adj_char_freq)
# wordcloud2(filter_res, fontFamily = "BiauKa")


