library(leaflet)
library(maps)

airports <- read.csv(file="WaitTimesPerDay.csv", header=TRUE, sep="," 
                     , colClasses = c("character", "numeric", "character", "numeric", "numeric",
                                      "numeric", "numeric", "numeric", "numeric"))

airports$Date <- as.Date(airports$Date, format="%m/%d/%y")

Date1<-as.Date("2015-04-01")
Date2<-as.Date("2015-05-05")

test<-filter(airports,filter (Date>Date1 & Date<Date2))

map = leaflet(airports) %>% addTiles() %>%
  addCircles(lng = ~Lon, lat = ~Lat, weight = 1,
             radius = ~Count * 10, popup = ~Airport, fill = FALSE)

map
