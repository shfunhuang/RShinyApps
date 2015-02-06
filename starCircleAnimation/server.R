# server.R

source("./starCircle_ver4.r")

shinyServer(
  function(input, output) {
    #rating <- input$rating
    
    output$text1 <- renderText({ 
      paste("rating : ", input$rating)
    })

    output$star <- renderPlot({
      ### Multi-Star
      lim = 1
      starNum = 8
      range <- c(0.3, 0.5)
      step <- seq(-lim, lim, by=mean(range))
      
      plot(0, xlim=c(-length(step),length(step)), ylim=c(-length(step),length(step)), type="n", xlab="", ylab="", axe=F)
      # color: black
      for(k in 1:length(step)){
        starCircle(star=starNum, color="black", inner=range[1], outer=range[2], bias = step[k], lwd=1)
      }
      # color: red
      #rating = 3
      for(k in 1:input$rating){
        Sys.sleep(0.1)
        starCircle(star=starNum, color="red", inner=range[1], outer=range[2], bias = step[k], lwd=1.5)
        Sys.sleep(0.1)
      }     
      
    })
  }
)
