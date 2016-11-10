# ui.R

shinyUI(pageWithSidebar(
  headerPanel("MatrixBinSmooth"),
  sidebarPanel(


    sliderInput("degree","Smooth Degree",
                 min=0,max=2, value=1, step=1), 
    sliderInput("span","Smooth Span",
                   min=.2, max=2,value=.7),
    sliderInput("lwd","Smooth Line Width",
                 min = 1, max = 4, value=2,step = 1),
    sliderInput("xbins", "Bin Cells on X Axis:", 
                min=5, max=30, value=14, step=1),
    sliderInput("power","Bin Cell Count Exponent",
                 min=.1, max=2.0,value=.4),
    sliderInput("gray","Bin Cell Outline Gray",
                 min=0, max=1,value=.7)
    
  ),
   
  mainPanel(
   plotOutput(outputId="matBinSm")
  )
))

 