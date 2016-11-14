
library(shiny)
library(leaflet)
library(maps)
library(ggplot2)

wtd <- read.csv(file="WaitTimesPerDay.csv", header=TRUE, sep="," 
                     , colClasses = c("character", "numeric", "character", "numeric", "numeric",
                                      "numeric", "numeric", "numeric", "numeric"))

wth <- read.csv(file="WaitTimesPerHour.csv", header=TRUE, sep="," 
                     , colClasses = c("character", "numeric", "character","character" ,"numeric", "numeric",
                                      "numeric", "numeric", "numeric", "numeric"))


wtd$Date <- as.Date(wtd$Date, format="%m/%d/%y")
wth$Date <- as.Date(wth$Date, format="%m/%d/%y")

shinyServer(function(input, output) {
  
  output$airports <- renderLeaflet({
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    leaflet(wd) %>% addTiles() %>%
      addCircles(lng = ~Lon, lat = ~Lat, weight = 1,
                 radius = ~Count/2 * 20, popup = ~Airport)
  })

  ##### HISTOGRAMS  ###############################
  output$histogram1 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    p <- ggplot(wd, aes(x = AvgWait, fill = Airport)) +
      geom_histogram(data = wd, fill = "grey", alpha = .5) +
      geom_histogram(colour = "black") +
      facet_wrap(~ Airport) +
      guides(fill = FALSE) +  # to remove the legend
      theme_bw()              # for clean look overall
    print(p)
  })
  
  output$histogram2 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    p <- ggplot(wd, aes(x = MaxWait, fill = Airport)) +
      geom_histogram(data = wd, fill = "grey", alpha = .5) +
      geom_histogram(colour = "black") +
      facet_wrap(~ Airport) +
      guides(fill = FALSE) +  # to remove the legend
      theme_bw()              # for clean look overall
    print(p)
  })
  
  #### SCATTERPLOTS   #################################
  
  output$scatterplot1 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    p <- ggplot(wd, aes(x =Booths , y =AvgWait, colour = Airport)) +
      geom_point(data = wd, colour = "grey", alpha = .2) +
      geom_point() + 
      facet_wrap(~ Airport) +
      guides(colour = FALSE) +
      theme_bw()
    print(p)
  })
  
  output$scatterplot2 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    p <- ggplot(wd, aes(x =AvgWait , y =MaxWait, colour = Airport)) +
      geom_point(data = wd, colour = "grey", alpha = .2) +
      geom_point() + 
      facet_wrap(~ Airport) +
      guides(colour = FALSE) +
      theme_bw()
    print(p)
  })
  
  #### BOXPLOTS   #################################
  
  output$boxplot1 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    ggplot(wd, aes(x =AvgWait , y =MaxWait, colour = Airport)) +
      geom_point(data = wd, colour = "grey", alpha = .2) +
      geom_point() + 
      facet_wrap(~ Airport) +
      guides(colour = FALSE) +
      theme_bw()
  })
  
  output$boxplot2 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    p <- p <- ggplot(wd, aes(factor(Airport), AvgWait))
    p + geom_boxplot() + geom_jitter()
    p + geom_boxplot(aes(fill = factor(Airport)))
    print(p)
  })
  
  output$boxplot3 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    ggplot(wd, aes(factor(Airport), AvgWait)) +
    geom_boxplot() + geom_jitter() +
    geom_boxplot(aes(fill = factor(Airport)))
  })
  
  output$boxplot4 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    ggplot(wd, aes(factor(Airport), MaxWait)) +
    geom_boxplot() + geom_jitter() +
    geom_boxplot(aes(fill = factor(Airport)))
  })
  
  output$boxplot5 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    ggplot(wh, aes(factor(Airport), AvgWait)) +
    geom_boxplot() + geom_jitter() +
    geom_boxplot(aes(fill = factor(Airport)))
  })
  
  output$boxplot6 <- renderPlot({ 
    wd <- subset(wtd, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    wh <- subset(wth, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    ggplot(wh, aes(factor(Airport), MaxWait)) +
    geom_boxplot() + geom_jitter() +
    geom_boxplot(aes(fill = factor(Airport)))
  })

})