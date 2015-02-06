# ui.R

shinyUI(fluidPage(
  titlePanel("StarCircleAnimation"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Opening weekend Gross Level Test"),           
      
      sliderInput("rating", 
                  label = "Number of star",
                  min = 1, max = 6, value = 1)
      ),
      
    mainPanel(
      textOutput("text1"),
      plotOutput("star", width = "400px", height="400px")
    )
  )
))


