### Mulit-Star 
starCircle <- function(star, color, inner, outer, bias, lwd){
  innerRadius <- inner
  outerRadius <- outer
  iniAngle <- -pi/star
  
  innerCircle <- matrix(0, nrow=star, ncol=2, dimnames = list(seq(star), c("x","y")))
  outerCircle <- matrix(0, nrow=star, ncol=2, dimnames = list(seq(star), c("x","y")))
  
  ### Save innerPoints and outerPoints to Matrix
  for(k in 1:star){
    innerCircle[k, 1] <- bias*3 + innerRadius*cos( iniAngle + ((2*pi)/star)*k )
    innerCircle[k, 2] <- bias*0 + innerRadius*sin( iniAngle + ((2*pi)/star)*k )
    
    outerCircle[k, 1] <- bias*3 + outerRadius*cos( iniAngle + ((2*pi)/star)*k + pi/star )
    outerCircle[k, 2] <- bias*0 + outerRadius*sin( iniAngle + ((2*pi)/star)*k + pi/star )
  }
  
  ### Plot Star       
  for(k in 1:star){  
    segments(innerCircle[k,1], innerCircle[k,2], outerCircle[k,1], outerCircle[k,2], col=color, lwd=lwd)
      if(k < star){
      segments(outerCircle[k,1], outerCircle[k,2], innerCircle[k+1,1], innerCircle[k+1,2], col=color, lwd=lwd)
    }
    else{
      segments(outerCircle[star,1], outerCircle[star,2], innerCircle[1,1], innerCircle[1,2], col=color, lwd=lwd)
     }
  }  
}

