# import data
library(dplyr)
library(ggplot2)
setwd("C:/Users/user/Desktop/R/DOE/Data")
df = readxl::read_xlsx("aov_data.xlsx")

df$temperature = as.factor(df$temperature)
df$crime_type = as.factor(df$crime_type)
df$marry_level = as.factor(df$marry_level)
df$crime_rate = log(df$crime_rate)
# perform anova
m = aov(crime_rate ~ temperature + crime_type + 
          marry_level + temperature*crime_type +
          temperature*marry_level + marry_level*crime_type +
          temperature * crime_type * marry_level
        ,data = df)

summary(m)

plot(m)

plot(TukeyHSD(m, "temperature"))
plot(TukeyHSD(m, "crime_type"))

contrasts(df$rate) = contr.poly(3)
summary.aov(m, split = list(temperature = list("Linear"=1, "Quadratic" = 2)))
# summary.lm(m, split = list(temperature = list("Linear"=1, "Quadratic" = 2)))

lm(crime_rate ~ temperature + crime_type + 
     marry_level + temperature*crime_type +
     temperature*marry_level + marry_level*crime_type +
     temperature * crime_type * marry_level
   
   ,data = df
   ,contrasts = list(temperature = contr.treatment(3)))

