library(shiny)
library (leaflet)
shinyUI(navbarPage(
  "United States Airport Wait Times",
  tabPanel("Plots",
           fluidRow(column(
             10,
             offset = 2,
             sliderInput(
               "date_range",
               "Choose Date Range:",
               min = as.Date("2015-11-06"),
               max = Sys.Date(),
               width = '80%',
               value = c(as.Date("2016-02-25"), Sys.Date())
             )
           )),
           fluidRow(column(
             10,
             offset = 1,
             tabsetPanel(
               tabPanel("Map", leafletOutput("airports")),
               tabPanel(
                 "Histogram",
                 plotOutput("histogram1")
                 ,
                 plotOutput("histogram2")
               ),
               tabPanel(
                 "Boxplot",
                 plotOutput("boxplot1"),
                 br(),
                 plotOutput("boxplot2"),
                 br(),
                 plotOutput("boxplot3"),
                 br(),
                 plotOutput("boxplot4"),
                 br(),
                 plotOutput("boxplot5"),
                 br(),
                 plotOutput("boxplot6")
               ),
               tabPanel(
                 "Scatterplot",
                 plotOutput("scatterplot1"),
                 br(),
                 plotOutput("scatterplot2")
               ),
               tabPanel(
                 "Densityplot",
                 plotOutput("densityplot1"),
                 br(),
                 plotOutput("densityplot2"),
                 br(),
                 plotOutput("densityplot3"),
                 br(),
                 plotOutput("densityplot4")
               )
             )
           ))
           ),
  tabPanel("Architecture")
))