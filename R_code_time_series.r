# TIME SERIES ANALYS
# GREENLAND INCREASE OF TEMPERATURE potenziale
# data code from Emanuela Cosma

#installo il pacchetto raster e lo richiamo in R
library(raster)

setwd("C:/lab/greenland")
# per importare le immagini .tif uso la funzione raster dell'omonimo pacchetto
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2000.tif")
plot(lst_2005)
