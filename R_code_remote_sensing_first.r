# Il mio primo codice in R per il telerilevamento
setwd("C:/lab/") 

#install.packages("raster")
library(raster)

p224r63_2011 <- brick("p224r63_2011_masked.grd")
