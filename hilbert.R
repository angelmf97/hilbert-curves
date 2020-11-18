
library(magrittr)
library(RColorBrewer)
ORDER = 5

generate.order <- function(ORDER, corner = "bottomright", direction = "clockwise"){
  generator <- matrix(c(2,3,1,4), byrow = TRUE, nrow = 2)
  if(ORDER==1){plot.results(generator,2);return(generator)}
  for (n in 1:(ORDER-1)){
    factor <- 2**(2*n)
    increment <- cbind(generator*0+factor, generator*0+factor*2) %>% rbind(cbind(generator*0, generator*0+factor*3))
    h <- cbind(generator, generator)
    generator <- cbind(matrix(rev(generator), byrow = TRUE, 
                              nrow = nrow(generator)), t(generator)) %>% rbind(h, .)
    generator <- generator+increment
    plot.results(generator,2)
    Sys.sleep(2)
  }
  if(corner == "topright"){generator <- apply(t(generator),2,rev)}
  else if(corner == "topleft"){generator <- generator}
  else if(corner == "bottomright"){generator <- apply(generator,2,rev)}
  else if(corner == "bottomleft"){generator <- apply(generator,1,rev)}
  if(direction == "counterclockwise"){generator <- t(generator)}
  return(generator)
}

plot.results <- function(generator, fractionx = 2, fractiony = 2){
  my.dim <- dim(generator)[1]
  points <- matrix(nrow = dim(generator)[1]**2, ncol = 2, c(rep(1:my.dim,each = my.dim), rep(1:my.dim, my.dim)))
  points[,1] <- points[,1]-1/fractionx
  points[,2] <- points[,2]-1/fractionx
  coords <- cbind(c(generator),points)
  sorted <- coords[order(coords[,1]),]
  x <- sorted[,2]
  y <- sorted[,3]
  mypal <- rainbow(my.dim**2-1)
  par(mar=c(5,3,2,2)+0.1)
  plot(x=sorted[,2],y=sorted[,3], cex = 1/ORDER, col = mypal,
       xlim = c(0, my.dim), ylim = c(0, my.dim), xaxs = "i", yaxs = "i",
       xaxt='n', yaxt='n', xlab='',ylab='')
  grid(nx = my.dim, ny = my.dim, lty = 1, lwd = 5/ORDER)
  segments(x[-length(x)],y[-length(y)],x[-1L],y[-1L],col=mypal,lwd=7/ORDER)
}
generator <- generate.order(2, corner = "bottomleft", direction = "clockwise")
plot.results(generator,2)

ggplot() + geom_point(aes(x=sorted[,2],y=sorted[,3])) + geom_line(aes(x=sorted[,2],y=sorted[,3])) + coord_cartesian(ylim = c(0, my.dim), xlim = c(0, my.dim))

init <- c(2,1,3,4)
lower_left <- c(4,1,3,2)
lower_right <- c(2,3,1,4)
matrix(c(lower_left,init,init,lower_right),nrow=4)


library(gsubfn)
library(TurtleGraphics)
init <- "A"
for(n in 1:ORDER){
  init <- gsubfn('.',list("A"="-BF+AFA+FB-","B"="+AF-BFB-FA+"),x=init)
}

a <- gsubfn('.', list("A"="","B"="","F"="turtle_forward(1);","-"="turtle_left(angle = 90);","+"="turtle_right(angle = 90);"),x=init)
turtle_init()
parse(text=a)
eval(parse(text=a))
a
