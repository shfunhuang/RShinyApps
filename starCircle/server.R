# server.R

source("./starCircle_ver2.r")

shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({ 
      paste("star : ", input$var)
    })
    
    output$text2 <- renderText({ 
      paste("color : ", input$color)
    })
    
    output$text3 <- renderText({ 
      paste("range : ", input$range[1], "~" , input$range[2])
    })
    
    output$star <- renderPlot({ 
      starCircle(star=input$var  , color=input$color, inner=input$range[1], outer=input$range[2])
    })
  }
)



