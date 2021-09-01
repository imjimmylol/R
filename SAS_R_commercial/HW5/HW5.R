library(forecast)
library(tseries)
getwd()
setwd(".\\data")
data <- read.csv("visitors.csv")

Aus_ts <- ts(data$Australia, frequency = 4, start = c(1998,4), end = c(2010,4))
China_ts <- ts(data$China, frequency = 4, start = c(1998,4), end = c(2010,4))
jp_ts <- ts(data$Japan, frequency = 4, start = c(1998,4), end = c(2010,4))
uk_ts <- ts(data$United.Kingdom, frequency = 4, start = c(1998,4), end = c(2010,4))


Aus_fit <- decompose(Aus_ts, type="mult")
China_fit <- decompose(China_ts, type="mult")
jp_fit <- decompose(jp_ts,type = 'mult')
uk_fit <- decompose(uk_ts, type = 'mult')

plot(Aus_fit)

remove_lol <- function(x,y){
  (x-y$trend)/y$seasonal
}

Au <- remove_lol(Aus_ts,Aus_fit) %>% na.omit()
Ch <- remove_lol(China_ts,China_fit) %>% na.omit()
Jp <- remove_lol(jp_ts,jp_fit) %>%na.omit()
uk <- remove_lol(uk_ts,uk_fit) %>%na.omit()

adf.test(Au) #reject
adf.test(Ch) #not reject
adf.test(Jp) #reject
adf.test(uk) #not reject

Ch %>% diff() %>% adf.test()
Ch <- Ch %>% diff()
uk %>% diff %>% adf.test()
uk <- uk %>% diff

Ch %>% Box.test(4,"Ljung")
uk %>% Box.test(4,"Ljung") #¥u¦³uk reject H0
Jp %>% Box.test(4,"Ljung")
Au %>% Box.test(4,"Ljung")

tsdisplay(uk_ts)

ma = auto.arima(uk_ts) %>% na.omit()

#predict(ma, 4)
#p=forecast(ma,4)


library(tidyverse)

ma %>% forecast(4) %>% autoplot 

qqnorm(ma$residuals) # residual is normally distributed
Box.test(ma$resid,lag=1,type="Ljung") #do not reject H0
accuracy(ma)
checkresiduals(ma)

#ts(forecast(ma,4)

#accuracy(meanf(uk,h=4), data3)
#accuracy(rwf(data2,h=12,drift=TRUE), data3)
uk_forcast <-forecast(ma,4)
plot(uk_forcast)


uk_ts <- ts(data$United.Kingdom, frequency = 4, start = c(1998,4), end = c(2010,4))
uk_ts_real <- ts(data[50:53,5], frequency = 4, start = c(2011,1), end = c(2011,4))


uk_forcast$mean - uk_ts_real 
(uk_forcast$mean - uk_ts_real)/uk_ts_real





