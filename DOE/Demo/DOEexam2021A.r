#
#    Tsung-Chi Cheng
#
##############################################################################
#      Table 3.3,    p. 85    Grain production and plant density
##############################################################################
grain <- c(12.2,11.4,12.4,16.0,15.5,16.5,18.6,20.2,18.2,17.6,19.3,17.1,18.0,16.4,16.6)
density <- rep(seq(10,50,by=10),rep(3,5))
plant <- data.frame(grain,density)

# apply(plant, 1, mean) 1為對row r為對col
# apply(plant^2, 2, sum)


tapply(plant[,1],INDEX=plant[,2],mean) #製作trearment mean i.e. y_i.            # Table 3.3
tapply(plant[,1],INDEX=plant[,2],sd)   #製作trearment std
round(tapply(plant[,1],INDEX=plant[,2],sd),2)

plot(grain~density,data=plant,pch=16,col=3,cex=1.5)    # Figure 3.2,  p. 85

################
plant.fit1 <- lm(grain~as.factor(density),data=plant) # 按照英文字順序或數字做為回歸的base line
summary(plant.fit1)
model.matrix(plant.fit1)
anova(plant.fit1)                                                     # Table 3.5,  p. 88
# aov(grain~as.factor(density),data=plant)
# qf(0.95, 4, 10) f-value
# 1 - pf(29.28, 4, 10) p-value


##########################

palnt.aov1 <- aov(grain~as.factor(density),data=plant)
summary(palnt.aov1)

TukeyHSD(palnt.aov1) # 對aov結果進行更多處理
plot(TukeyHSD(palnt.aov1),las=1) # 沒有包含0 reject Ho(有差異)

library(agricolae)
palnt.LSD <- LSD.test(palnt.aov1, "as.factor(density)") 
palnt.Tukey <- HSD.test(palnt.aov1, "as.factor(density)")
palnt.Scheffe <- scheffe.test(palnt.aov1, "as.factor(density)")
palnt.Duncan <- duncan.test(palnt.aov1, "as.factor(density)")
palnt.SNK <- SNK.test(palnt.aov1, "as.factor(density)")


##########################################


# 製作 on poly
c4 <- contr.poly(5) # 5個level
x = scale(c4, scale = 1/sqrt(scan())) # 10 14 10 70
x1 = zapsmall(x, digits = 15)
p1 = cbind(1, x1)


library(car)
Anova(lm1 <- lm(grain~C(as.factor(density),c4[,1],1),data=plant), type="III")          #          but F value is different   # 
Anova(lm1 <- lm(grain~C(as.factor(density),c4[,2],1),data=plant), type="III")
Anova(lm1 <- lm(grain~C(as.factor(density),c4[,3],1),data=plant), type="III")
Anova(lm1 <- lm(grain~C(as.factor(density),c4[,4],1),data=plant), type="III")

Anova(lm1 <- lm(grain~C(as.factor(density),c4[,1],1)+C(as.factor(density),c4[,2],1)+C(as.factor(density),c4[,3],1)+C(as.factor(density),c4[,4],1),data=plant), type="III")

plant.fit2 <- lm(grain~contr.poly(density)[,1:4],data=plant)
summary(plant.fit2)
anova(plant.fit2)

#######################################
#   Table 3.4,   p.87
#
x <- scale(contr.poly(5),scale=1/sqrt(scan()))
#    (input 10 14 10 70)

x1 <- zapsmall(x, digits=15)
p1 <- cbind(1,x1)

orth.x <- matrix(rep(c(x1),rep(3,20)),ncol=4)
data.frame(plant,orth.x)

sum1 <- tapply(plant[,1],INDEX=plant[,2],mean) %*%p1
divisor1 <- diag(t(p1)%*%p1) 
3*sum1^2/divisor1
sum1/divisor1
##########################
plant.fit3 <- lm(grain~orth.x)
summary(plant.fit3)                    #     eq (3.15), p. 87

plant.fit4 <- lm(grain~orth.x[,c(1:2)])
summary(plant.fit4)                    #     eq (3.16), p. 88

plant.fit5 <- lm(grain~density+I(density^2),data=plant)
summary(plant.fit5)                    #     eq (3.17), p. 89

#############
density2 <- density^2
plant2 <- data.frame(plant,density2)

plant.fit5 <- lm(grain~density+density2,data=plant2)
summary(plant.fit5)

density1 <- seq(10,50,by=2)
density.n <- data.frame(density1,density1^2)
names(density.n) <- c('density','density2')

yhat <- predict(plant.fit5,newdata=density.n)

densityA <- seq(10,50,by=10)

plot(grain~density,data=plant,pch=0,col=3)       # Figure 3.3,  p. 90
lines(density1,yhat,col=4)
points(densityA,tapply(plant[,1],INDEX=plant[,2],mean) ,col=6,pch=16)

##############################################################
#   p. 35, ex 1.12
##############################################################
Trt3 <- c('A','B','B','A','A','B')  
Y <- c(7,10,9, 5,10,12)

Bset <- combn(c(1:6),3) #隨機assign 1,2, 3排A, 其他排B
A <- which(Trt3=='A')
mean0 <- mean(Y[A])-mean(Y[-A])
mean1 <- c()
NIT <- ncol(Bset)
for (i in 1:NIT){
     Trt1 <- rep('B',6)    
     Trt1[Bset[,i]] <- 'A'
     mean1[i] <- mean(Y[Bset[,i]])-mean(Y[-Bset[,i]])
     cat(i,Trt1,mean1[i],'\n')
}

sum(mean1<=mean0)/NIT # p-value > 0.05
