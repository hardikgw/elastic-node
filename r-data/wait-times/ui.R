library(shiny)
library (leaflet)
shinyUI(
  navbarPage(
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
                 4,
                 offset = 1,
                 h3("Tools"),
                 tags$ul(
                   tags$li("R, RStudio (charts, development)"),
                   tags$li("Shiny, Shiny Server (UI)"),
                   tags$li("ElasticSearch (Scalability, Aggregation)"),
                   tags$li(
                     "NodeJS (Insert Geo Location for Airports, Data Ingestion, Aggregation)"
                   )
                 ),
                 br(),
                 h3("Dependencies"),
                 tags$ul(tags$li("leaflet (maps)"),
                         tags$li("ggplot2 (charts)")),
                 br(),
                 h3("Platform"),
                 tags$ul(tags$li("Docker"),
                         tags$li("AWS")),
                 br()
               ),
               column(
                 4,
                 offset = 1,
                 h3("Process"),
                 tags$ul(
                   tags$li("Collect data from website"),
                   tags$li("Combine Airport Geo Locations from Airports database"),
                   tags$li("Aggregate by airport, dates"),
                   tags$li("Design UI and Shiny server for hosting")
                 )
               )
             )),
    tabPanel("Background",
             fluidRow(column(
               8,
               offset = 2,
               h3("Inspiration"),
               p(
                 "* US border crossing checkposts are constantly being observed and ",
                 strong("Drug Trafficking Across the Southwest Border"),
                 "  is growing."
               ),
               p(
                 "* Airport data, having same attributes provides template to Border wait times"
               ),
               br(),
               h3("Enhancements"),
               p(
                 "* Current data exists in tabular format wihtout any insights or means to compare how the wait times changes in different months or different times in a day"
               ),
               br(),
               h3("Data Sources"),
               p(
                 "* ",
                 tags$a(href = "https://bwt.cbp.gov/index.html", "CBP Wait Times")
               ),
               p("* ", tags$a(href = "http://awt.cbp.gov/", "Airport Wait Times"))
             ))),
    tabPanel("TODO",
             fluidRow(column(
               8,
               offset = 2,
               tags$ul(
                 tags$li("Map improvement"),
                 tags$li("Statistical analysis on variation of wait times"),
                 tags$li("Variability of wait time by hour and year"),
                 tags$li("Various attributes like number of aircrafts, booths etc."),
                 tags$li("Variability of wait time by other data sources (maintenance)"),
                 tags$li("Userful Charts")
               )
             )))
  )
)