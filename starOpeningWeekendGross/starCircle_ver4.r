### Mulit-Star 
### star : number of star
### color : color of star
### inner, outer : link circle points from inner to outer
### bias : spacing between star
### lwd : lwd of star
### source("starCircle_ver4.r")
#starCircle(star=starNum, color="black", inner=range[1], outer=range[2], bias = step[k], lwd=1)
starCircle <- function(star, color, inner, outer, bias, lwd){
  innerRadius <- inner
  outerRadius <- outer
  iniAngle <- -pi/star
  
  innerCircle <- matrix(0, nrow=star, ncol=2, dimnames = list(seq(star), c("x","y")))
  outerCircle <- matrix(0, nrow=star, ncol=2, dimnames = list(seq(star), c("x","y")))
  
  ### Save innerPoints and outerPoints to Matrix
  for(k in 1:star){
    innerCircle[k, 1] <- bias*3 + innerRadius*cos( iniAngle + ((2*pi)/star)*k ) -0
    innerCircle[k, 2] <- bias*0 + innerRadius*sin( iniAngle + ((2*pi)/star)*k ) -0
    
    outerCircle[k, 1] <- bias*3 + outerRadius*cos( iniAngle + ((2*pi)/star)*k + pi/star ) -0
    outerCircle[k, 2] <- bias*0 + outerRadius*sin( iniAngle + ((2*pi)/star)*k + pi/star ) -0
  }
  
  ### Plot Star       
  ### shift star
  x=0
  y=1
  shift=1.5
  for(k in 1:star){  
    segments(x*shift+innerCircle[k,1], 
             y*shift-innerCircle[k,2], 
             x*shift+outerCircle[k,1], 
             y*shift-outerCircle[k,2], col=color, lwd=lwd)    
    if(k < star){
      segments(x*shift+outerCircle[k,1], 
               y*shift-outerCircle[k,2], 
               x*shift+innerCircle[k+1,1], 
               y*shift-innerCircle[k+1,2], col=color, lwd=lwd)      
    }
    else{
      segments(x*shift+outerCircle[star,1], 
               y*shift-outerCircle[star,2], 
               x*shift+innerCircle[1,1], 
               y*shift-innerCircle[1,2], col=color, lwd=lwd)
      
    }
  }  
}

