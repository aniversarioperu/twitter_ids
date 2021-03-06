library("fitdistrplus")
library("splines")
library("Hmisc")



data <- read.csv("output_r.csv", header=F)
names(data) <- c("x", "y")
attach(data)

x_labels = c("2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014")
y_labels = c("20", "100mil billones","200mil billones","300mil billones","400mil billones")

# http://stackoverflow.com/a/3824248
fit1 <- lm( y~offset(x) -1 )
fit2 <- lm( y~x )
fit3 <- lm( y~poly(x,3) )
fit4 <- lm( y~poly(x,9) )
fit5 <- lm( y~ns(x, 3) )
fit6 <- lm( y~ns(x, 9) )


par(mar=c(6,9,4,2)+0.1,mgp=c(7,1,0))
plot(x, y, xlim=c(0,x[length(x)]), ylim=c(0,y[length(y)]), pch=19, xaxt="n", yaxt="n",
     ylab="tweet ID", xlab="", main="Número de tuits emitidos")
axis(1, at=seq.int(0, x[15], x[15]/8), labels=x_labels)
axis(2, at=seq.int(0, 4e+17, 1e+17), labels=y_labels, las=1)

xx <- seq(0,x[length(x)], length.out=250)
lines(xx, predict(fit1, data.frame(x=xx)), lwd=2, col='blue')
lines(xx, predict(fit2, data.frame(x=xx)), lwd=2, col='green')
lines(xx, predict(fit3, data.frame(x=xx)), lwd=2, col='red')
lines(xx, predict(fit5, data.frame(x=xx)), lwd=2, col='orange')
lines(xx, predict(fit6, data.frame(x=xx)), lwd=2, col='grey')

par(mar=c(4,7,4,2)+0.1,mgp=c(5,1,0))
plot(x, y, xlim=c(0,x[length(x)]*10), ylim=c(0,y[length(y)]*10), pch=19,
     main="Número de tuits emitidos (proyección)", xaxt="n", yaxt="n",
     ylab="tweet ID", xlab="")

x_labels = c("2006", "2010", "2014", "2018", "2022", "2026", "2030", 
             "2034", "2038", "2042", "2046", "2050", "2054", "2058", 
             "2062", "2066", "2070", "2074", "2078", "2082", "2084")
y_labels = c("20", "1 trillón","2 trillones","3 trillones","4 trillones")
axis(1, at=seq.int(0, 2522016000, 252201600/2), labels=x_labels, las=2)
axis(2, at=seq.int(0, 4e+18, 1e+18), labels=y_labels, las=1)


xx <- seq(0,x[length(x)]*10, length.out=250)
lines(xx, predict(fit1, data.frame(x=xx)), lwd=2, col='blue')
lines(xx, predict(fit2, data.frame(x=xx)), lwd=2, col='green')
lines(xx, predict(fit3, data.frame(x=xx)), lwd=2, col='red')
lines(xx, predict(fit5, data.frame(x=xx)), lwd=2, col='orange')
lines(xx, predict(fit6, data.frame(x=xx)), lwd=2, col='grey')
abline(h=4e+18, lty=3)
abline(v=440000000, lty=3)
