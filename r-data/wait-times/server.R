
library(shiny)
library(leaflet)
library(maps)
library(ggplot2)
library(car) 
library(corrplot)
library(scatterplot3d) 

defaultColors <- c("#3366cc", "#dc3912", "#ff9900", "#109618", "#990099", "#0099c6", "#dd4477",
                   "#66AA00", "#B82E2E", "#316395", "#994499", "#22AA99", "#AAAA11", "#6633CC",
                   "#E67300", "#8B0707", "#329262", "#5574A6", "#3B3EAC", "#5bc0de", "#5cb85c",
                   "#E9967A", "#FFFACD", "#ff9900", "#90EE90", "#DDA0DD")

series <- structure(
  lapply(defaultColors, function(color) { list(color=color) }),
  names = levels(wtd$Airport)
)
shinyServer(function(input, output) {
  
  wd <- reactive({
    subset(
      wtd,
      as.Date(Date) >= as.Date(input$date_range[1]) &
        as.Date(Date) <= as.Date(input$date_range[2])
    )
  })
  
  wdc <- reactive({
    subset(wtd,as.Date(Date) == as.Date(input$chart_range),select=c(Airport,AvgWait,Booths,Airport,Count))[order(subset(wtd,as.Date(Date) == as.Date(input$chart_range))$Airport),]
  })
  
  wh <- reactive({
    subset(
      wth,
      as.Date(Date) >= as.Date(input$date_range[1]) &
        as.Date(Date) <= as.Date(input$date_range[2])
    )
  })
  
  
  output$airports <- renderLeaflet({
    leaflet(wd()) %>% addTiles() %>%
      addCircles(
        lng = ~ Lon,
        lat = ~ Lat,
        weight = 1,
        radius = ~ (AvgWait ^ 2) * 20,
        popup = ~ Airport
      )
  })
  
  ##### HISTOGRAMS  ###############################
  output$histogram1 <- renderPlot({
    ggplot(wd(), aes(x = AvgWait, fill = Airport)) +
      geom_histogram(data = wd(),
                     fill = "grey",
                     alpha = .5) +
      geom_histogram(colour = "black") +
      facet_wrap( ~ Airport) +
      guides(fill = FALSE) +  # to remove the legend
      theme_bw()              # for clean look overall
  })
  
  output$histogram2 <- renderPlot({
    ggplot(wd(), aes(x = Count, fill = Airport)) +
      geom_histogram(data = wd(),
                     fill = "grey",
                     alpha = .5) +
      geom_histogram(colour = "black") +
      facet_wrap( ~ Airport) +
      guides(fill = FALSE) +  # to remove the legend
      theme_bw()              # for clean look overall
  })
  
  #### SCATTERPLOTS   #################################
  
  output$scatterplot1 <- renderPlot({
    ggplot(wd(), aes(x = Booths , y = AvgWait, colour = Airport)) +
      geom_point(data = wd(),
                 colour = "grey",
                 alpha = .2) +
      geom_point() +
      facet_wrap( ~ Airport) +
      guides(colour = FALSE) +
      theme_bw()
  })
  
  output$scatterplot2 <- renderPlot({
    ggplot(wh(), aes(x = AvgWait, y= Count)) +
    geom_point(aes(color=Hour)) + 
    facet_wrap(~ Airport)})
  
  # output$scatterplot2 <- renderPlot({
  #   ggplot(wd(), aes(x = AvgWait , y = MaxWait, colour = Airport)) +
  #     geom_point(data = wd(),
  #                colour = "grey",
  #                alpha = .2) +
  #     geom_point() +
  #     facet_wrap( ~ Airport) +
  #     guides(colour = FALSE) +
  #     theme_bw()
  # })
  
  #### BOXPLOTS   #################################
  
  output$boxplot1 <- renderPlot({
    ggplot(wd(), aes(factor(Airport), AvgWait)) +
      geom_boxplot() + geom_jitter() +
      geom_boxplot(aes(fill = factor(Airport)))
  })
  
  output$boxplot2 <- renderPlot({
    ggplot(wd(), aes(factor(Airport), MaxWait)) +
      geom_boxplot() + geom_jitter() +
      geom_boxplot(aes(fill = factor(Airport)))
  })
  
  # output$boxplot3 <- renderPlot({
  #   ggplot(wh(), aes(factor(Airport), AvgWait)) +
  #     geom_boxplot() + geom_jitter() +
  #     geom_boxplot(aes(fill = factor(Airport)))
  # })
  
  # output$boxplot4 <- renderPlot({
  #   ggplot(wh(), aes(factor(Airport), MaxWait)) +
  #     geom_boxplot() + geom_jitter() +
  #     geom_boxplot(aes(fill = factor(Airport)))
  # })
  
  #### DENSITYPLOTS   #################################
  
  output$densityplot1 <- renderPlot({
    ggplot(wd(), aes(x = AvgWait, fill = Airport)) + geom_density(alpha = 0.3)
  })
  
  output$densityplot2 <- renderPlot({
    ggplot(wd(), aes(x = MaxWait, fill = Airport)) + geom_density(alpha = 0.3)
  })
  
  output$densityplot3 <- renderPlot({
    ggplot(wd(), aes(x = Booths, fill = Airport)) + geom_density(alpha = 0.3)
  })
  # 
  # output$densityplot4 <- renderPlot({
  #   ggplot(wh(), aes(x = MaxWait, fill = Airport)) + geom_density(alpha = 0.3)
  # })
  output$cp <- renderPlot({
    wdh1<-cbind(wth[,1:7],wth[,9])
    cbh<-cor(wdh1)
    corrplot(cbh)
  })
  output$pca <- renderPlot({
    wdn1<-cbind(wtd[,1:7],wtd[,9])
    pc1<-prcomp(wdn1)
    scatterplot3d(pc1$rotation[,1], pc1$rotation[,2], pc1$rotation[,3], 
                        xlab='Comp.1', ylab='Comp.2', zlab='Comp.3', pch = 20)
  })
  output$rc <- renderPlot({
    scatterplotMatrix(~AvgWait+Count+Booths|Airport, data=wtd,main="Scatterplots and regression lines per airport") 
  })
  
  output$g <- reactive({
    list(
      data = googleDataTable(wdc()),
      options = list(
        title = sprintf(
          "Wait Times vs Number of Passengers",
          input$Date),
        series = series
      )
    )
  })
})