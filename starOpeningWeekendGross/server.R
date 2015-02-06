# server.R
library(ggplot2)
library(mapproj)
library(maps)

source("./starCircle_ver4.r")

boxLevel <- readRDS("data/boxLevel.rds")
boxLevel <- boxLevel[order(boxLevel$title),] # order by title

filmingLocations <- readRDS("./data/filmingLocations.rds")

breaks1 = c(0, 100000, 400000, 6500000, 12000000, 25000000, 207500000)

shinyServer(
  function(input, output) {
    
    rating <- reactive({
      paste(boxLevel[which(boxLevel$title == input$title), 9])
      
    })   
    
    ### for img
    pkno <- reactive({
      paste(boxLevel[which(boxLevel$title == input$title), 1])
      
    })   
    
    ### for img link
    link <- reactive({
      paste(imgLink[which(imgLink$pkno %in% boxLevel[which(boxLevel$title == input$title), 1]),]$image_link4movie[1])
      
    }) 
    
    ### for gross
    gross <- reactive({
      paste(boxLevel[which(boxLevel$title == input$title), 5])
      
    })    
    
    ### for break ranges
    ranges1 <- reactive({
      as.integer(breaks1[boxLevel[which(boxLevel$title == input$title), 9]])    
    }) 
    
    ranges2 <- reactive({
      as.integer(breaks1[boxLevel[which(boxLevel$title == input$title), 9]+1])
    }) 
    
    ### for year
    year <- reactive({
      paste(substr(boxLevel[which(boxLevel$title == input$title), 6], 1, 4))
      
    }) 
    
    ### show open weekend gross
    output$text3 <- renderText({
      paste(gross())      
    })
    
    ### show breaks level
    output$text4 <- renderText({
      paste("from ", ranges1(), " to ", ranges2())      
    })
    
    ### show release year
    output$text2 <- renderText({
      paste("Year:", year())
    })
    
    ### plot Multi-Star
    output$star <- renderPlot({
      lim = 1
      starNum = 8
      range <- c(0.2, 0.35)
      step <- seq(-lim, lim, by=mean(range)/.75)
      step <- step + 0.1
      size <- 2.9
      
      ### shift bg color and margin area range.
      par(bg="#36465D", mar=c(0,0,0,0))
      plot(0, 
           xlim=c(-length(step)/size, length(step)/size), 
           ylim=c(-length(step)/size, length(step)/size), 
           type="n", axes=F,
           xlab="", ylab="")
      for(k in 1:rating()){
        starCircle(star=starNum, 
                   color="red", 
                   inner=range[1], 
                   outer=range[2], 
                   bias = step[k]/1.5, lwd=2)
      }     
      
    }, width = "auto", height = "auto")
    
    ### plot map
    output$map1 <- renderPlot({
     
      movieTitle <- paste(input$title)
        setTitle <- subset(filmingLocations, filmingLocations$title == movieTitle) 

        map.world <- map_data("world")  
        country <- subset(map.world, region %in% setTitle$country)  
        
        ggplot() + 
          geom_polygon(data=country, aes(x=long, y=lat, group=group, fill=region, colour=region)) + # fill areas
          borders("world", colour="gray50") +  
          expand_limits(x=country$long, y=country$lat) +
          coord_equal() +
          theme(plot.background = element_rect(fill = "#FFFFFF")) +
          theme(legend.title = element_text(size = 12, angle = 0, colour = "#DC143C", hjust = 1, vjust = 1),
                legend.text = element_text(size = 10, angle = 0, colour = "#FF4500"))
      #}
      
    })
    
    ### show poster
    output$img <- renderImage({
      filename <- normalizePath(file.path("./", paste('img/', pkno(), '.jpg', sep='')))
      list(src = filename)
      }, 
      deleteFile = FALSE)
  }
)
