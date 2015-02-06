# ui.R

boxLevel <- readRDS("data/boxLevel.rds")
filmingLocations <- readRDS("./data/filmingLocations.rds")
filmingUSA <- subset(filmingLocations, filmingLocations$country == "USA")
filmingUSA <- data.frame(states = tolower(filmingUSA$state), filmingUSA)
filmingUSA <- subset(filmingUSA, filmingUSA$states != 99999)

shinyUI(
  fluidPage(
    
  titlePanel(h1("movieGrossVis")), 
            style="
                    font-family: 'Script MT Bold';
                    font-size: 20px;
                    font-weight: normal;
                    text-shadow: 1px 1px #FF0000;
                    line-height: 25px; 
                    color: #FFD700;
                    background-color: #36465D;", 
					
    fluidRow(
      column(width=3,
             selectInput(inputId = 'title',
                       label = h3('Select a Movie Title'), 
                       choices = as.character(boxLevel[order(boxLevel$title),]$title), 
                       multiple = F, 
                       selectize = T,
                       width = "200px",
                       selected = "Inception"),
             
      column(width=3,
            textOutput("text2"), 
            imageOutput("img", width = "500%", height="500%")              
      )
           
           ),
      
      column(width=3,
             helpText("Open Weekend Gross:", 
                      style="
                      font-family: 'Script MT Bold';
                      font-size: 30px;
                      font-weight: normal;
                      text-shadow: 1px 1px #FF0000;
                      line-height: 20px; 
                      color: #FED200;"),
           textOutput("text3"),
           br(),
           br(),
           helpText("Breaks Range:",
                    style="
                    font-family: 'Script MT Bold';
                    font-size: 30px;
                    font-weight: normal;
                    text-shadow: 1px 1px #FF0000;
                    line-height: 20px; 
                    color: #FED200;"),
           textOutput("text4"),
           br(),
           br(),
           helpText("Movie's Gross Level:",
                    style="
                    font-family: 'Script MT Bold';
                    font-size: 30px;
                    font-weight: normal;
                    text-shadow: 1px 1px #FF0000;
                    line-height: 20px; 
                    color: #FED200;"),
           plotOutput("star", width = "200px", height="200px")
           )

  ),
  
  fluidRow(
    helpText(h3("World Map of Filming Location:"),
             style="
                    font-family: 'Script MT Bold';
                    font-size: 15px;
                    font-weight: normal;
                    text-shadow: 1px 1px #FF0000;
                    line-height: 15px; 
                    color: #FED200;"),
    plotOutput("map1", width = "850px")
    )
))


