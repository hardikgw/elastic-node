library(ggplot2)
library(rgl)

wh<-read.table(file='WaitTimesPerHour.csv',sep=',',header=TRUE)
attach(wh)
names(wh)

wd<-read.table(file='WaitTimesPerDay.csv',sep=',',header=TRUE)
attach(wd)
names(wd)

g <- ggplot(wh, aes(x = AvgWait, y= Count)) + geom_point(aes(color=Hour)) + facet_wrap(~ Airport)
g
ggplot(wh, aes(x = AvgWait, y= Count, fill = Airport)) +
  geom_histogram(data = wd, fill = "grey", alpha = .5) +
  geom_histogram(colour = "black") +
  facet_wrap(~ Airport) +
  guides(fill = FALSE) +  # to remove the legend
  theme_bw()     

##### EXAMPLE OF HISTOGRAMS  ###############################

ggplot(wd, aes(x = AvgWait, fill = Airport)) +
  geom_histogram(data = wd, fill = "grey", alpha = .5) +
  geom_histogram(colour = "black") +
  facet_wrap(~ Airport) +
  guides(fill = FALSE) +  # to remove the legend
  theme_bw()              # for clean look overall


ggplot(wd, aes(x = MaxWait, fill = Airport)) +
  geom_histogram(data = wd, fill = "grey", alpha = .5) +
  geom_histogram(colour = "black") +
  facet_wrap(~ Airport) +
  guides(fill = FALSE) +  # to remove the legend
  theme_bw()              # for clean look overall

#### EXAMPLE OF SCATTERPLOTS   #################################

ggplot(wd, aes(x =Booths , y =AvgWait, colour = Airport)) +
  geom_point(data = wd, colour = "grey", alpha = .2) +
  geom_point() + 
  facet_wrap(~ Airport) +
  guides(colour = FALSE) +
  theme_bw()

ggplot(wd, aes(x =AvgWait , y =MaxWait, colour = Airport)) +
  geom_point(data = wd, colour = "grey", alpha = .2) +
  geom_point() + 
  facet_wrap(~ Airport) +
  guides(colour = FALSE) +
  theme_bw()

#### EXAMPLE OF BOXPLOTS   #################################


p <- ggplot(wd, aes(factor(Airport), AvgWait))
p + geom_boxplot() + geom_jitter()
p + geom_boxplot(aes(fill = factor(Airport)))


p <- ggplot(wd, aes(factor(Airport), MaxWait))
p + geom_boxplot() + geom_jitter()
p + geom_boxplot(aes(fill = factor(Airport)))


p <- ggplot(wh, aes(factor(Airport), AvgWait))
p + geom_boxplot() + geom_jitter()
p + geom_boxplot(aes(fill = factor(Airport)))


p <- ggplot(wh, aes(factor(Airport), MaxWait))
p + geom_boxplot() + geom_jitter()
p + geom_boxplot(aes(fill = factor(Airport)))

##Comparative density plots

ggplot(wd, aes(x=AvgWait, fill=Airport)) + geom_density(alpha=0.3)

ggplot(wd, aes(x=MaxWait, fill=Airport)) + geom_density(alpha=0.3)

ggplot(wh, aes(x=AvgWait, fill=Airport)) + geom_density(alpha=0.3)

ggplot(wh, aes(x=MaxWait, fill=Airport)) + geom_density(alpha=0.3)

######## FINAL

library(corrplot)
whn<-read.table(file='WaitTimesPerHour.csv',sep=',',header=TRUE)
attach(whn)
names(whn)


## Correlation plots by day
wdn<-read.table(file='WaitTimesPerDay.csv',sep=',',header=TRUE)
attach(wdn)
names(wdn)


wdn1<-cbind(wdn[,1:7],wdn[,9])
pairs(wdn1)

cbd<-cor(wdn1)
corrplot(cbd)

## Correlation plots by hour
wdh<-read.table(file='WaitTimesPerHour.csv',sep=',',header=TRUE)
attach(wdh)
names(wdh)


wdh1<-cbind(wdh[,1:7],wdh[,9])
pairs(wdh1)

cbh<-cor(wdh1)
corrplot(cbh)
# how big and dark blue, there is no -ve correlation 

library(car) 
scatterplotMatrix(~AvgWait+Count+Booths|Airport, data=wd,main="Scatterplots and regression lines per airport") 

pc1<-prcomp(wdh1)

library(scatterplot3d) 

# plot the first, second, and third principal components 
s3d = scatterplot3d(pc1$rotation[,1], pc1$rotation[,2], pc1$rotation[,3], 
                    xlab='Comp.1', ylab='Comp.2', zlab='Comp.3', pch = 20)



#smooth regression line, correlation +ve correlation between booths and count
# not very informative because of lot of data

# Booths and AvgWait not clear relationship because line looks like close to horizontal

plot(pc1) # amount of variation

biplot(pc1)

##### VIOLIN

library(plyr)

hwt <- ggplot(wh, aes(x=Hour, y=AvgWait))+geom_point(shape=19, color=rgb(0,0,1,0.3))
hwt + facet_grid(. ~ Airport)
hwt + facet_wrap( ~ Airport, ncol=3)
hwt

### VIO
allvio <- ggplot(wh, aes(Hour, AvgWait, fill = Hour, colour = Hour))

p2 <- allvio+geom_violin(alpha=0.3, size=0.7, width=0.7, trim = FALSE, scale = "width", adjust = 0.5) + 
  geom_boxplot(width=0.1, outlier.shape = 19, outlier.colour="black", notch = FALSE, 
               notchwidth = .5, alpha = 0.5, colour = "black")+
  labs(y = "Average Wait", x = "Hour")

p2 + facet_wrap( ~ Airport, ncol=6) # not a very pretty sight

p2 <- p2+geom_violin(alpha=0.3, size=0.7, width=0.7, trim = FALSE, scale = "width", adjust = 0.5) + 
  geom_boxplot(width=0.1, outlier.shape = 19, outlier.colour="black", notch = FALSE, 
               notchwidth = .5, alpha = 0.5, colour = "black")+
  labs(y = "Average Wait", x = "Hour")

p2 + facet_wrap( ~ Airport, ncol=2) 

# different range for y axis for the 4 airports
p2 + facet_wrap( ~ Airport, ncol=2, scales = "free_y")

hwtl <- ggplot(wh, aes(x=Hour, y=Count, color = Airport))+geom_line(size = 1)

hwtl + facet_grid(. ~ Airport)

hwtl + facet_wrap( ~ Airport, nrow=2, scales = "free_y")
hwtl
fgi <- hourwt[hourwt[,1]=="GUM" | hourwt[,1]=="FAT" |hourwt[,1]=="FLL" | hourwt[,1]=="IAD" ,]

### gradient colour on AvgWait values

hwt <- ggplot(wh, aes(x=Hour, y=AvgWait, color = AvgWait))+geom_point()+
  scale_color_gradientn(colours=c("blue","green","red"), values = c(0, 0.4, 1))

hwt1 <- hwt + facet_wrap( ~ Airport, ncol=3)

#### Average wait and max wait are correlated
### TODO : change attributes
cor(wh[,5], wh[,6])
# [1] 0.8718369

# graph of average wait coloured by max wait values

hwt1 <- ggplot(wh, aes(x=Hour, y=AvgWait, color = MaxWait))+geom_point()+
  scale_color_gradientn(colours=c("blue","green","red"), values = c(0, 0.3, 1))

hwt1 <- hwt1 + facet_wrap( ~ Airport, ncol=3)

