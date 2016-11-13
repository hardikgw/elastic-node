library(shiny)
library (leaflet)

shinyUI(fluidPage(
  
  titlePanel("CBP Wait Times"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("date_range", 
                  "Choose Date Range:", 
                  min = as.Date("2015-11-06"), max = Sys.Date(), 
                  value = c(as.Date("2016-02-25"), Sys.Date())
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("airports")
    )
  )
))