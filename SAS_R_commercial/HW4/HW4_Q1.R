getwd()
setwd(".\\data")

library(readr)
financialdata <- read_csv("financialdata.csv")
data = financialdata[,-1]

M = cor(data)
library(reshape2)
library(corrplot) 
library(stats)
melted_cormat <-melt(M)
corrplot(M, method="circle")
pca<- prcomp(data, center = TRUE, scale = TRUE)
summary(pca)



plot(pca, type="line")
abline(h=1, col="blue")
prop = (pca$sdev)^2 / sum((pca$sdev)^2)
prop
library(ggfortify)
autoplot(prcomp(data, center = TRUE, scale = TRUE), 
         loadings = TRUE, loadings.colour = 'black',
         loadings.label = TRUE, loadings.label.size = 5)
library(ggplot2)
ggplot(melt(pca$rotation[,1:3]), aes(Var2, Var1)) +
  geom_tile(aes(fill = value), colour = "white") +
  scale_fill_gradient2(low = "firebrick4", high = "steelblue",
                       mid = "white", midpoint = 0) +
  guides(fill=guide_legend(title="Coefficient")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        axis.title = element_blank())

top3_pc = pca$rotation[,1:3]
pc_var = c()

for(i in 1:5){
  order = order(abs(top3_pc[,i]),decreasing = TRUE)
  pc_var[[i]] =top3_pc[,i][order][1:5] 
}
pc_var[[1]]
pc_var[[2]]
pc_var[[3]]

library(dplyr)

invest_company = as.data.frame(cbind(financialdata[,1],pca$x[,1:3]))
invest_company = invest_company %>%filter(PC1>0 &PC2<0&PC3<0) 
invest_company$comp_id
