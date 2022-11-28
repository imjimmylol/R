#pre-proccess#####
getwd()
setwd(".\\data")
data1 <- read.csv("airline_survey.csv")
library(readr)
library(dummies)
library(tidyverse)
sta <- function(x){
  (x - min(x)) / (max(x) - min(x))
}
data1 <- data1[c(1:10000),]
data1 <- data1[,-c(1,2)]

data2 <- data1 %>%
  mutate(
    Age = sta(Age),
    Flight.Distance = sta(Flight.Distance),
    Departure.Delay.in.Minutes = sta(Departure.Delay.in.Minutes),
    Arrival.Delay.in.Minutes = sta(Departure.Delay.in.Minutes)
  )

dummies=dummy.data.frame(data2)

for(i in 12:25){
  dummies[,i] = as.factor(dummies[,i])
}
dummies1 = dummies[,-c(2,4,7,10,23)]

for(i in c(1,2,4,5,6,8:20,23,24)){
  dummies1[,i] = as.factor(dummies1[,i])
}
#clust^^####

# Perform k-prototype clustering
library(clustMixType)
#a = kproto(x = dummies1,k=5 ,iter.max = 100, nstart = 1)

Total_within_sum_of_sqare = c()
Number_of_cluster_k = c(1:20)
for(i in c(1:20)){
  sse = kproto(x = dummies1,k=i ,iter.max = 100, nstart = 1)
  Total_within_sum_of_sqare = append(Total_within_sum_of_sqare, sse$tot.withinss)
}

library(ggplot2)
p_df = data.frame(
  Total_within_sum_of_sqare = Total_within_sum_of_sqare,
  Number_of_cluster_k = c(1:20)
)

# visualiztion choose optim clus : 7
ggplot(data = p_df, mapping = aes(x = Number_of_cluster_k, y = Total_within_sum_of_sqare))+
  geom_line() + geom_point()

# perform k-prototype clus = 7

c1 = kproto(x = dummies1,k=7 ,iter.max = 100, nstart = 1)
c1$cluster
clus_res = c()
for(i in 1:length(c1$cluster)){
  clus_res = append(clus_res,c1$cluster[[i]])
}
# append res to original data frame
data1$clus_res = clus_res %>% as.factor()

# check each clusters satisfation rate
table(c1$cluster, data1$satisfaction)

# numeric 1~5 to fact
for(i in c(7:20)){
  data1[,i] = as.factor(data1[,i]) 
}

library(tidyverse)

dnes_plot_xvar_gvar <- function(df, x_var, group_var) {
  df %>%
    ggplot(aes(x = {{x_var}},
               color = {{group_var}},
               fill  = {{group_var}},
               group = {{group_var}})) +
    geom_histogram(aes(y = ..density..),
                   alpha = 0.4, position = "identity") +
    geom_density(size = 1, fill = NA)
}


dis_plot_xvar_gvar = function (data, column1, column2) {
  ggplot(data, aes_string(x = column1, fill = column2)) +
    geom_bar(position = position_dodge())+
    guides(fill=guide_legend(title=sprintf('%s', column2)))+
    xlab(sprintf('%s', column2))
}


# list for group var to store result 
li = which(sapply(1:(length(data1)-1), function(x)class(data1[,x])=='factor'))
gvar_d = vector(mode="list", length=19)
names(gvar_d) = sapply(li, function(x)names(data1)[x])


library(rlang)

# age with diff catego####
for (i in names(gvar_d)) {
  gvar_d[[i]] <- local({
    eval(substitute(dnes_plot_xvar_gvar(data1, x_var = Age , group_var = x),list (x = ensym(i))))
  })
  
}

gvar_d$Gender
gvar_d$Inflight.wifi.service
gvar_d$Departure.Arrival.time.convenient


# catego bar with group var
gvar_c = vector(mode="list", length=19)
names(gvar_c) = sapply(li, function(x)names(data1)[x])
for (i in names(gvar_c)) {
  gvar_c[[i]] <- local({
    dis_plot_xvar_gvar(column2 = i, column1 = 'clus_res',data = data1)
  })
}
gvar_c$Gender
gvar_c$Inflight.wifi.service
gvar_c$Food.and.drink
# a = gvar_c$Class
# b = gvar_c$satisfaction
# ggpubr::ggarrange(a, b, labels = c("艙等", "滿意度"), ncol = 2, nrow = 1)
