library(shiny)
library(lattice)
library(hexbin)
source('mat4BinSmooth.R')
library(MASS)

Boston1 <- Boston[,c(14,6,13,3)]
datTitle = "Boston Housing Data From Around 1970"
varNam <- 
  c('Median Value ($1000)\nOwner-Occupied\nHomes',
    'Ave. No.\nRooms in\nDwelling',
    '% Pop.\nLower Status',
    '%Non-Retail\nBusiness Areas\nIn Town')
pScale <- 3
varNamCex<- 1.09
axisTextCex <- .97
titleCex <- 1.5

shinyServer(
  function(input, output) {
    output$matBinSm <- renderPlot({
      args <- vector("list",length=0)
      args$dat <- Boston1
      args$datTitle <- datTitle
      args$titleCex <- titleCex 
      args$varNam <- varNam
      args$varNamCex <- varNamCex
      args$axisTextCex <- axisTextCex
      args$xbins  <- input$xbins

      args$border <- gray(input$gray)
      args$power <- input$power
      args$smSpan <- input$span
      args$smDegree <- input$degree
      args$smLwd <- input$lwd

      do.call(mat4BinSmooth,args)  
    }, height=656,width=656)
})