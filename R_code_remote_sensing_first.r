# Il mio primo codice in R per il telerilevamento
setwd("C:/lab/") 

#install.packages("raster" )
library(raster)

#uso la funzione brick  
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

#cambio di colore della legenda
cl <- colorRampPalette(c("black","grey","light grey")) (100)

plot(p224r63_2011, col= cl)

# cambio di colore -> new
cl <- colorRampPalette(c("blue","green"," grey", "red","magenta","yellow")) (100)
plot(p224r63_2011, col= cl)
