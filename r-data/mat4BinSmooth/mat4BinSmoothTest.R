library(MASS)
library(lattice)
library(hexbin)


# The densities of variables  1,2,4,12 show
# that they are not well-suited to smoothing 

Boston1 <- Boston[,c(14,6,13,3)]
datTitle = "Boston Housing Data From Around 1970"
varNam <- 
  c('Median Value ($1000)\nOwner-Occupied\nHomes',
    'Ave. No.\nRooms in\nDwelling',
    '% Pop.\nLower Status',
    '%Non-Retail\nBusiness Areas\nIn Town')
varNam.cex <- 1

windows(width=6,height=6)

source('mat4BinSmooth.R')
mat4BinSmooth(dat=Boston1,datTitle=datTitle,
  varNam=varNam,pScale=3,
  power=.4,
  sm=TRUE,smSpan=.6,smDegree=1)