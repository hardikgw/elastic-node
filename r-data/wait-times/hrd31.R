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

