library(forecast)
getwd()
setwd(".\\data")
data <- read.csv("visitors.csv")

#檢查平穩
ts(data, frequency = 4, start = c(1998,4), end = c(2010,4))
for(i in 2:4){
  print(adf.test(ts(data[,i])))
} #結果非平穩


#差分轉換#####

data_sta_aus <- diff(ts(data$Australia)) 
data_sta_ch <- diff(ts(data$China),difference=3)
data_sta_jp <- diff(ts(data$Japan),difference=2)
data_sta_uk <- diff(ts(data$United.Kingdom))
adf.test(data_sta_aus)
adf.test(data_sta_ch)
adf.test(data_sta_jp)
adf.test(data_sta_uk)


#檢查白噪音(只剩下日本data)
Box.test(data_sta_aus,4,"Ljung") #do not reject H0 (去除)
Box.test(data_sta_ch,4,"Ljung") #do not reject H0 (去除)
Box.test(data_sta_jp,4,"Ljung") #reject H0
Box.test(data_sta_uk,4,"Ljung") #do not (去除)

#畫acf,pacf
tsdisplay(ts(data_sta_jp))
