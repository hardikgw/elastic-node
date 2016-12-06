if("package:googleCharts" %in% search()) detach("package:googleCharts", unload=TRUE)
library(shiny)
column2 = column
library (leaflet)
library(googleCharts)

xlim <- list(
  min = min(wtd$AvgWait),
  max = max(wtd$AvgWait)
)
ylim <- list(
  min = min(wtd$Booths),
  max = max(wtd$Booths) + 3
)

shinyUI(
  navbarPage(
    googleChartsInit(),
    "United States Airport Wait Times",
    tabPanel("Plots",
             fluidRow(column2(
               10,
               offset = 2,
               sliderInput(
                 "date_range",
                 "Choose Date Range:",
                 min = min(wtd$Date),
                 max = max(wtd$Date),
                 width = '80%',
                 value = c(min(wtd$Date),  min(wtd$Date) + 14),
                 animate = animationOptions(interval=5000)
               )
             )),
             fluidRow(column2(
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
    tabPanel("Data Analysis",
             fluidRow(column2(
               10,
               offset = 2,
               sliderInput(
                 "chart_range",
                 "Choose Date Range:",
                 min = min(wtd$Date),
                 max = max(wtd$Date),
                 width = '80%',
                 value = c(min(wtd$Date),  min(wtd$Date) + 14),
                 animate = animationOptions(interval=500)
               )
             )),
             fluidRow(column2(
               10,
               offset = 1,
               tabsetPanel(
                 tabPanel("Corr By Hour", plotOutput("cp")),
                 tabPanel("Principal Component", 
                          plotOutput("pca"),
                          plotOutput("pcp"),
                          plotOutput("pcb")),
                 tabPanel("Regression Charts", plotOutput("rc")),
                 tabPanel("Kernel Density", plotOutput(outputId="kd",width = "100%")),
                 tabPanel("Avg by Max", plotOutput(outputId="am",width = "100%")),
                 tabPanel("Average Wait", plotOutput(outputId="aw", width = "100%")),
                 tabPanel("Animation", 
                          
                          googleBubbleChart("g",
                                            width="100%", height = "475px",
                                            # Set the default options for this chart; they can be
                                            # overridden in server.R on a per-update basis. See
                                            # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                                            # for option documentation.
                                            options = list(
                                              fontSize = 13,
                                              hAxis = list(
                                                title = "Wait Time in Minutes",
                                                viewWindow = xlim
                                              ),
                                              vAxis = list(
                                                title = "Number of Passengers",
                                                viewWindow = ylim
                                              ),
                                              # The default padding is a little too spaced out
                                              chartArea = list(
                                                top = 50, left = 75,
                                                height = "75%", width = "75%"
                                              ),
                                              # Allow pan/zoom
                                              explorer = list(),
                                              # Set bubble visual props
                                              bubble = list(
                                                opacity = 0.4, stroke = "none",
                                                # Hide bubble label
                                                textStyle = list(
                                                  color = "none"
                                                )
                                              ),
                                              # Set fonts
                                              titleTextStyle = list(
                                                fontSize = 16
                                              ),
                                              tooltip = list(
                                                textStyle = list(
                                                  fontSize = 12
                                                )
                                              )
                                            )
                          )
                          
                          )
               )
             ))),
    tabPanel("Architecture",
             fluidRow(
               column2(
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
               column2(
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
             fluidRow(column2(
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
               p("* ", tags$a(href = "http://awt.cbp.gov/", "Airport Wait Times")),
               br(),
               h3("Source Code"),
               p("* ", tags$a(href = "https://github.com/hardikgw/elastic-node/tree/master/r-data/wait-times", "Data and R code on Github")),
               p("* ", tags$a(href = "https://github.com/hardikgw/cbp-wait-times", "Elastic Search data ingestion and aggregation")),
               p("* ", tags$a(href = "https://hub.docker.com/r/channelit/shiny-loaded/", "Shiny Docker Image built from source"))
             ))),
    tabPanel("TODO",
             fluidRow(column2(
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