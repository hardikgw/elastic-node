library(MASS)
library(lattice)
library(hexbin)


# The densities of variables  1,2,4,12 show
# that they are not well-suited to smoothing 

Boston1 <- Boston[,c(14,6,13,3,5,7:11)]
windows(width=9,height=9)

source('matrixBinSmooth.R')
matrixBinSmooth(dat=Boston1,title="Boston Housing Data",
  sm=TRUE,smSpan=.6,smDegree=1,power=.4)