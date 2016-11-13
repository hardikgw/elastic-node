
library(shiny)
library(leaflet)
library(maps)

airports <- read.csv(file="WaitTimesPerDay.csv", header=TRUE, sep="," 
                     , colClasses = c("character", "numeric", "character", "numeric", "numeric",
                                      "numeric", "numeric", "numeric", "numeric"))
airports$Date <- as.Date(airports$Date, format="%m/%d/%y")

shinyServer(function(input, output) {
  output$airports <- renderLeaflet({
    subset <- subset(airports, as.Date(Date) >= as.Date(input$date_range[1]) & as.Date(Date) <= as.Date(input$date_range[2]))
    
    leaflet(subset) %>% addTiles() %>%
      addCircles(lng = ~Lon, lat = ~Lat, weight = 1,
                 radius = ~Count/2 * 20, popup = ~Airport)
  })
})