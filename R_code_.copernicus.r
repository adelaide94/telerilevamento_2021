# vISUALIZZARE LE IMMAGINE DI COPERNICUS
#CONTROLLO DI AVERE LE LIBRERIE
library(raster)

#liberia per leggere il formato .ncdf4 e devo istallare il pacchetto
install.packages("ncdf4")
library(ncdf4)

# setto la cartella dei dati
setwd("C:/lab/")
 
 #devo caricare e associare il file scaricato al nome 
vegetation_Properties <- raster("c_gls_FAPAR_202006130000_GLOBE_PROBAV_V1.5.1.nc")
vegetation_Properties

# non uso la RGB ho un singolo strado quindi deciodo la scala di colori
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) #
plot(vegetation_Properties, col=cl)
