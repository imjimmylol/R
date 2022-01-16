city = c("A","B","C")
rate = c("0.5", "1", "1.5")
y = c(26.4, 23.5, 25.4, 22.9,
  25.2, 39.2, 25.5, 31.9,
  26, 44.6, 35.5, 38.6,
  
  30.1, 31, 30.8, 32.8,
  47.7, 39.1, 55.3, 50.7,
  73.8, 71.1, 68.4, 77.1,
  
  19.4, 19.3, 18.7, 19,
  23.2, 21.3, 23.3, 19.9,
  18.9, 19.8, 19.6, 21.9)

ouo_city = c()
ouo_rate = c()
for(i in city){
  ouo_city = append(ouo_city, rep(i, 12))
}
for(i in rate){
  ouo_rate = append(ouo_rate, rep(i, 4))
}
ouo_rate = rep(ouo_rate, 3)

df = data.frame(
  city = as.factor(ouo_city),
  rate = ouo_rate,
  y = y
)

m = aov(y ~ city + rate + city*rate , data = df)

contrasts(df$rate) = contr.poly(3)
summary.aov(m, split = list(rate = list("Linear"=1, "Quadratic" = 2)))
summary(lm(y ~ city + rate + city*rate, df, contrasts = list(rate = contr.treatment(3))))





