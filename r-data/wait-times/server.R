
library(shiny)
library(leaflet)
library(maps)

airports <- read.csv(file="WaitTimesPerDay.csv", header=TRUE, sep="," 
                     , colClasses = c("character", "numeric", "character", "numeric", "numeric",
                                      "numeric", "numeric", "numeric", "numeric"))
airports$Date <- as.Date(airports$Date, format="%m/%d/%y")

shinyServer(function(input, output) {
  subset <- subset(airports, as.Date(Date) >= as.Date("2016-08-01") & as.Date(Date) <= as.Date("2016-08-01"))
  output$airports <- renderLeaflet({
    leaflet(subset) %>% addTiles() %>%
      addCircles(lng = ~Lon, lat = ~Lat, weight = 1,
                 radius = ~Count * 20, popup = ~Airport)
  })
})