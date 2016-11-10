library(shiny)
library(lattice)
library(hexbin)
source('matrixBinSmooth.R')
library(MASS)
Boston1 <- Boston[,c(14,6,13,1,3,7,8:11)]

shinyServer(
  function(input, output) {
    output$matBinSm <- renderPlot({
      args <- vector("list",length=0)
      args$dat <- Boston1
      args$title <- "Boston Housing"
      args$xbins  <- input$xbins
      args$border <- gray(input$gray)
      args$power <- input$power
      args$smSpan <- input$span
      args$smDegree <- input$degree
      args$smLwd <- input$lwd

      do.call(matrixBinSmooth,args)  
    }, height=656,width=656)
})