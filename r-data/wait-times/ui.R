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
                 plotOutput("boxplot4")
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
           ))),
  tabPanel("Architecture",
           fluidRow(
             column(
               8,
               offset = 2,
               h3("Tools"),
               tags$ul(
                 tags$li("R, RStudio (charts, development"), 
                 tags$li("Shiny, Shiny Server (UI)"),
                 tags$li("ElasticSearch (Scalability, Aggregation)"),
                 tags$li("NodeJS (Insert Geo Location for Airports, Data Ingestion, Aggregation)")
               ),
               br(),
               h3("Dependencies"),
               tags$ul(
                 tags$li("leaflet (maps)"), 
                 tags$li("ggplot2 (charts)")
               ),
               br(),
               h3("Platform"),
               tags$ul(
                 tags$li("Docker"), 
                 tags$li("AWS")
               ),
               br()
             )
           )),
  tabPanel("Background",
           fluidRow(
             column(
               8,
               offset = 2,
               h3("Inspiration"),
               p(
                 "* US border crossing checkposts are constantly being observed and ",
                 strong("Drug Trafficking Across the Southwest Border"),
                 "  is growing."
               ),
               p(
                 "* This data, having same attributes provides template to border checkpost."
               ),
               br(),
               h3("Enhancements"),
               p("* Chart improvement"),
               p("* Statistical analysis between other data sources"),
               br(),
               h3("Data Sources"),
               p("* ",tags$a(href="https://bwt.cbp.gov/index.html", "CBP Wait Times")),
               p("* ",tags$a(href="http://awt.cbp.gov/", "Airport Wait Times"))
             )
           ))
))