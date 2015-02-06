# ui.R

source("./starCircle_ver2.r")

shinyUI(fluidPage(
  titlePanel("starCircleVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create a starCircle between 4~50"),
      
      selectInput("color", 
                  label = "Choose a color",
                  choices = list("Crimson" = "#DC143C",
                                 "Red" = "#FF0000",
                                 "Orange" = "#FFA500",
                                 "DarkOrange" = "#FF8C00",
                                 "Yellow" = "#FFFF00",
                                 "Gold" = "#FED200",
                                 "Lime" = "#00FF00",
                                 "ForestGreen" = "#228B22",
                                 "RoyalBlue" = "#4169E1",
                                 "Blue" = "#0000FF",
                                 "Navy" = "#000080",
                                 "MidnightBlue" = "#191970",
                                 "Magenta" = "#FF00FF",
                                 "DarkViolet" = "#9400D3"),
                  selected = "#DC143C"),
      
      sliderInput("var", 
                  label = "Number of star",
                  min = 4, max = 50, value = 12),
      
      sliderInput("range", 
                  label = "Range of inner and outer:",
                  min = 1, max = 2, value = c(1,2))
      
      ),
    
    mainPanel(
      textOutput("text1"),
      textOutput("text2"),
      textOutput("text3"),
      plotOutput("star", width = "300px", height="300px"),
      h6("Graphic by Shfun Huang", align = "left")
    )
  )
))

