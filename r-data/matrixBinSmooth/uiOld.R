# ui.R

shinyUI(pageWithSidebar(
  headerPanel("MatrixBinSmooth"),
  sidebarPanel(
    sliderInput("xbins", "X Axis Bins:", 
                min=5, max=30, value=14, step=1),
    sliderInput("gray","Hex Outline Gray",
                 min=0, max=1,value=.7),
    sliderInput("power","Count Exponent",
                 min=.1, max=2.0,value=.4),

    sliderInput("degree","Smooth Degree",
                 min=0,max=2, value=1, step=1), 
    sliderInput("lwd","Smooth Line Width",
                 min = 1, max = 4, value=2,step = 1),
    sliderInput("span","Smooth Span",
                   min=.2, max=2.0,value=.7)
  ),
   
  mainPanel(
   plotOutput(outputId="matBinSm")
  )
))

 