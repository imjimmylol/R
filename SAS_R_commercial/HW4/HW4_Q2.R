getwd()
setwd(".\\data")
library(readr)
library(tm)
library(wordcloud2)
library(dplyr)

Womens <- read_csv("Womens Clothing E-Commerce Reviews.csv")
a <- filter(Womens, `Recommended IND` == 0)
#b <- b[1:10000,]
a = a[1000,]
a1=Corpus(VectorSource(a$`Review Text`))

a1=tm_map(a1, tolower) 

a1<-tm_map(a1, content_transformer(tolower))

a1=tm_map(a1, removePunctuation) 

a1=tm_map(a1, removeWords, stopwords("english"))

a1_tdm <- TermDocumentMatrix(a1)
inspect(a1_tdm)


review_a1 <- as.matrix(a1_tdm)
freq_df_a <- rowSums(review_a1)
freq_df_a <- sort(freq_df_a, decreasing = T)
freq_df_a[1:10]
barplot(freq_df_a[1:20], col = "royalblue", las = 2)
freq_df_a <- data.frame(word = names(freq_df_a),
                      num = freq_df_a)

en_wc_1 = wordcloud2(freq_df_a,size=0.5)
#en_wc_2 = wordcloud2(freq_df_b,size=0.5) 

