# TIME SERIES ANALYS
# GREENLAND INCREASE OF TEMPERATURE potenziale
# data code from Emanuela Cosma

#installo il pacchetto raster e lo richiamo in R
library(raster)

setwd("C:/lab/greenland")
# per importare le immagini .tif uso la funzione raster dell'omonimo pacchetto
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# esercizio, creo un multipannel con PAR CON LE 4 IMMAGGINI
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#voglio applicare ad una lista di f file la stessa funzione (par). 
#faccio prima una lista
list.files
rlist <- list.files(pattern="lst")
rlist

# adesso applico la funzione raster tramite la funzione lapply su tutta la mia rlist
import <- lapply(rlist,raster)
# la funziome stack mi crea un pacchetto unico di tutti i file raster precedentemente caricati in r
#associo ad un valore TGr
TGr <- stack(import)
plot(TGr)
# plot di immagini da satellite in RGB della temperatura delle 4 immagini lst
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")
