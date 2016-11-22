library(ggplot2)

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


