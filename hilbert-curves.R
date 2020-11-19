#!/usr/bin/Rscript

library(magrittr)

generate.hilbert <- function(generator, n){
  factor <- 2**(2*n)
  increment <- cbind(generator*0+factor, generator*0+factor*2) %>% rbind(cbind(generator*0, generator*0+factor*3))
  h <- cbind(generator, generator)
  generator <- cbind(matrix(rev(generator), byrow = TRUE, 
                            nrow = nrow(generator)), t(generator)) %>% rbind(h,.)
  generator <- generator+increment
  return(generator)
}

reorient <- function(generator, corner = "bottomright", orientation = "clockwise"){
  if(corner == "bottomleft"){generator <- generator}
  else if(corner == "topleft"){generator <- apply(generator,2,rev) %>% t()}
  else if(corner == "topright"){generator <- apply(generator,1,rev) %>% t() %>% apply(2,rev)}
  else if(corner == "bottomright"){generator <- apply(t(generator),2,rev)}
  if(orientation == "clockwise"){
    if(corner %in% c("bottomleft","topright")){
      generator <- matrix(rev(generator), byrow = TRUE, 
                          nrow = nrow(generator))}
    else{
      generator <- t(generator)
    }
  }
  return(generator)
}

plot.results <- function(generator, xfrac = 1/2, yfrac = 1/2, n){
  generator <- apply(generator,2,rev)
  my.dim <- dim(generator)[1]
  points <- matrix(nrow = dim(generator)[1]**2, ncol = 2, c(rep(1:my.dim,each = my.dim), rep(1:my.dim, my.dim)))
  points[,1] <- points[,1]-xfrac
  points[,2] <- points[,2]-yfrac
  coords <- cbind(c(generator),points)
  sorted <- coords[order(coords[,1]),]
  x <- sorted[,2]
  y <- sorted[,3]
  mypal <- rainbow(my.dim**2-1)
  plot(x=sorted[,2],y=sorted[,3], cex = 1/n, col = mypal,
       xlim = c(0, my.dim), ylim = c(0, my.dim), xaxs = "i", yaxs = "i",
       xaxt='n', yaxt='n', xlab=paste("Order",n),ylab='')
  grid(nx = my.dim, ny = my.dim, lty = 1, lwd = 1/n)
  segments(x[-length(x)],y[-length(y)],x[-1L],y[-1L],col=mypal,lwd=3/n)
}

main <- function(order, corner = "bottomleft", orientation = "clockwise",
                 xfrac = 1/2, yfrac = 1/2, animation = TRUE,
                 sleeptime = 2){
  generator <- matrix(1,nrow=1)
  for(n in 1:order){
    generator <- generate.hilbert(generator, n = n)
    generator <- reorient(generator, corner = corner, orientation = orientation)
    if(animation==TRUE){
      plot.results(generator,xfrac, yfrac, n = n)
      Sys.sleep(sleeptime)
    }
    if(animation==FALSE){plot.results(generator,2, n = order)}
  }
}

main(1, animation = TRUE)

