# import data####
library(dplyr)
library(ggplot2)
library(plyr)
setwd("C:/Users/user/Desktop/R/DOE/Data")
df = readxl::read_xlsx("aov_data.xlsx")

# function####
marry_level_dum = function(x){
        if(x == "4.5 ~ 4.83"){
                return(1)
        }
        else if(x == "4.83 ~ 5.16"){
                return(2)
        }
        else{return(3)}
}
inte_plot_temp = function(temper, df){
        df_test = df %>% filter(temperature == temper)
        df_int = ddply(df_test,.(marry_level,crime_type),summarise, val = mean(crime_rate)) # cell mean
        
        res = ggplot(df_test, aes(x = marry_level, y = crime_rate, colour = crime_type)) + 
                geom_boxplot() + 
                geom_point(data = df_int, aes(y = val)) +
                geom_line(data = df_int, aes(y = val, group = crime_type)) + 
                theme_bw()
        return(res)
}
inte_plot_temp_test = function(temper, df){
        df_test = df %>% filter(temperature == temper) # cell mean
        df_int = ddply(df_test,.(marry_level,crime_type),summarise, val = mean(crime_rate)) # cell mean
        
        res = ggplot(df_test, aes(x = marry_level, y = crime_rate, colour = crime_type)) + 
                geom_boxplot() + 
                geom_point(data = df_int, aes(y = val)) +
                geom_line(data = df_int, aes(y = val, group = crime_type)) + 
                theme_bw()+ scale_y_continuous(limits = c(0, 1.5))
        return(res)
}
inter_plot_marr = function(marr, df){
        df_test = df %>% filter(marry_level == marr) 
        df_int = ddply(df_test,.(temperature,crime_type),summarise, val = mean(crime_rate)) # cell mean
        
        res2 = ggplot(df_test, aes(x = temperature, y = crime_rate, colour = crime_type)) + 
                geom_boxplot() + 
                geom_point(data = df_int, aes(y = val)) +
                geom_line(data = df_int, aes(y = val, group = crime_type)) + 
                theme_bw()
        return(res2)
}
inter_plot_marr_test = function(marr, df){
        df_test = df %>% filter(marry_level == marr) 
        df_int = ddply(df_test,.(temperature,crime_type),summarise, val = mean(crime_rate)) # cell mean
        
        res2 = ggplot(df_test, aes(x = temperature, y = crime_rate, colour = crime_type)) + 
                geom_boxplot() + 
                geom_point(data = df_int, aes(y = val)) +
                geom_line(data = df_int, aes(y = val, group = crime_type)) + 
                theme_bw() + scale_y_continuous(limits = c(0, 1.5))
        return(res2)
}
df$marr_dummy = sapply(df$marry_level, marry_level_dum) %>% as.vector() 
df$temperature = as.factor(df$temperature)
df$crime_type = as.factor(df$crime_type)
df$marry_level = as.factor(df$marry_level)

# perform anova####
m = aov(log(crime_rate) ~ temperature + crime_type + 
        marry_level + temperature*crime_type +
        temperature*marry_level + marry_level*crime_type +
        temperature * crime_type * marry_level
        ,data = df)

summary(m)

summary(aov(log(crime_rate)~temperature, data = df))
summary(aov(log(crime_rate)~crime_type, data = df))
summary(aov(log(crime_rate)~marry_level, data = df))


plot(m)

plot(TukeyHSD(m, "temperature"))
plot(TukeyHSD(m, "marry_level"))

# contrasts(df$rate) = contr.poly(3)
summary.aov(m, split = list(temperature = list("Linear"=1, "Quadratic" = 2)))
# summary.lm(m, split = list(temperature = list("Linear"=1, "Quadratic" = 2)))

lm(log(crime_rate) ~ temperature + crime_type + 
     marry_level + temperature*crime_type +
     temperature*marry_level + marry_level*crime_type +
     temperature * crime_type * marry_level
   
   ,data = df
   ,contrasts = list(temperature  = contr.treatment(3)))

# interaction plot####

low_temp_plot = inte_plot_temp("15~20", df)
mid_temp_plot = inte_plot_temp("20~25", df)
high_temp_plot = inte_plot_temp("25~30", df)

plot_grid(low_temp_plot, mid_temp_plot, high_temp_plot , 
        labels = c("15度~20度","20度~25度", "25度~30度"),
        ncol =3, nrow = 1)

low_marr_plot = inter_plot_marr("4.5 ~ 4.83", df)
mid_marr_plot = inter_plot_marr("4.83 ~ 5.16", df)
high_marr_plot = inter_plot_marr("5.16 ~ 5.5", df)

plot_grid(low_marr_plot, mid_marr_plot, high_marr_plot , 
          labels = c("4.5 ~ 4.83","4.83 ~ 5.16", "5.16 ~ 5.5"),
          ncol =3, nrow = 1)


low_marr_plot_test = inter_plot_marr_test("4.5 ~ 4.83", df)
mid_marr_plot_test = inter_plot_marr_test("4.83 ~ 5.16", df)
high_marr_plot_test = inter_plot_marr_test("5.16 ~ 5.5", df)

plot_grid(low_marr_plot_test, mid_marr_plot_test, high_marr_plot_test , 
          labels = c("4.5 ~ 4.83","4.83 ~ 5.16", "5.16 ~ 5.5"),
          ncol =3, nrow = 1)

low_temp_plot_test = inte_plot_temp_test("15~20", df)
mid_temp_plot_test = inte_plot_temp_test("20~25", df)
high_temp_plot_test = inte_plot_temp_test("25~30", df)

plot_grid(low_temp_plot_test, mid_temp_plot_test, high_temp_plot_test , 
          labels = c("15度~20度","20度~25度", "25度~30度"),
          ncol =3, nrow = 1)

# cell mean####
df_temp_low = df %>% filter(temperature=="15~20")
df_temp_mid = df %>% filter(temperature=="20~25")
df_temp_high = df %>% filter(temperature=="25~30")
ddply(df_temp_low,.(marry_level,crime_type),summarise, 
      cellmean_temp_15_20 = mean(crime_rate), 
      replication = length(crime_rate), 
      standatd_error = var(crime_rate)) # 溫度15~20

ddply(df_temp_mid,.(marry_level,crime_type),summarise, cellmean_temp_20_25 = mean(crime_rate),
      replication = length(crime_rate), 
      standatd_error = var(crime_rate)) # 溫度20~25
ddply(df_temp_high,.(marry_level,crime_type),summarise, cellmean_temp_25_30 = mean(crime_rate),
      replication = length(crime_rate), 
      standatd_error = var(crime_rate)) # 溫度25~30



