R_code_spectral_signatures.r

# Funzione library per richiamare il pacchetto raster precedentemente installato
library(raster)
library(rgdal)
library(ggplot2)

#la funzione sewd (set working directory) serve a richiamare una specifica cartella di lavoro (directory), in questo caso è "lab", inoltre utilizziamo le virgolette perchè usciamo fuori da R
setwd("C:/lab/")

# Funzione brick per importare i dati, anche qui utilizziamo le virgolette perchè peschiamo i dati al di fuori di R
defor2 <- brick("defor2.jpg") #importo l'immagine e l'associo alla variabile 

# NIR, red, green
plotRGB(defor2, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="hist")

# funzione click per seleionare le firme spettrali
# id= valore identificativo per ogni punto, xy= vogliamo utilizzare un'info spaziale ,cell= pixel, type= punti, pch= caratteristica del punto(apice)

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #clicco nella mappa per avere informazioni di riflettanza nelle 3 bande
# Results: 
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 178.5 435.5 30293      206       6       19
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 571.5 245.5 166916      40      99      139
# defor2.1 ottengo un valore molto alto di riflettanza perchè si tratta della banda del NIR
# defor2.2= 6    ho un valore molto basso perchè si tratta della banda del rosso ed essendo vegetazione in questa determinata banda assorbe
# defor2.3= 19  valore medio basso per la banda del verde 

# costruiamo le colonne del nostro dataset:
# c sta per characters
# nella colonna corrispondente a forest e water inseriremo i valori di riflettanza ottenuti corrispondenti a ciascuna banda
band <- c(1,2,3)
forest <- c(217,6,20)
water <- c(51,92,136)
# creaiamo la nostra tabella, con la funzione data.frame
spectrals <- data.frame (band,forest, water)

# band forest water
# 1    1    217    51
# 2    2      6    92
# 3    3     20   136

# vado a plottare le firme spettrali con la funzione ggplot
# aes: estetics
ggplot(spectrals, aes(x=band)) + geom_line(aes(y=forest), color="green") + geom_line(aes(y=water), color="blue") 
labs(x="band",y="reflectance")

## Multitemporal 

# Funzione brick per importare i dati, anche qui utilizziamo le virgolette perchè peschiamo i dati al di fuori di R
defor1 <- brick("defor1.jpg")
# funzione plot
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# firme spettrali di defor1
# funzione click per seleionare le firme spettrali
# time 1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#     x     y   cell defor1.1 defor1.2 defor1.3
# 1 34.5 333.5 102851      218       17       35
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 50.5 339.5 98583      224       10       34
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 87.5 339.5 98620      215       12       32
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 77.5 374.5 73620      199        1       18
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 87.5 395.5 58636      230       33       63

# time 2
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#    x     y  cell defor2.1 defor2.2 defor2.3
# 1 86.5 338.5 99750      198      162      150
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 101.5 335.5 101916      171      170      150
#       x     y  cell defor2.1 defor2.2 defor2.3
# 1 111.5 345.5 94756      213      195      175
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 101.5 366.5 79689      204       23       38
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 90.5 375.5 73225      217       16       32
 
# costruiamo le colonne del nostro dataset:
band <- c(1,2,3)
time1 <- c(218,17,35)
time2 <- c(198,162,150)
spectralst <- data.frame(band, time1, time2)

# vado a plottare le firme spettrali con la funzione ggplot
# aes: estetics
ggplot(spectrals, aes(x=band)) + geom_line(aes(y=time1), color="red") + geom_line(aes(y=time2), color="grey") 
labs(x="band",y="reflectance")

band <- c(1,2,3)
time1 <- c(218,17,35)
time1p2 <- c(224,10,34)
time2 <- c(198,162,150)
time2p2 <- c(171,170,150)
spectralst <- data.frame(band, time1, time1p2, time2, time2p2)

ggplot(spectrals, aes(x=band)) + geom_line(aes(y=time1), color="red", linetype="dotted") + geom_line(aes(y=time1p2), color="red", linetype="dotted")+ geom_line(aes(y=time2), color="grey", linetype="dotted") + geom_line(aes(y=time2p2), color="grey", linetype="dotted")
labs(x="band",y="reflectance")

# carichiamo l'immagine scaricata dall'earth observatory 
# Funzione brick per importare i dati, anche qui utilizziamo le virgolette perchè peschiamo i dati al di fuori di R
fuji <- brick("fuji_oli_2021001.jpg")
#funzione plot
plotRGB(fuji, r=1, g=2, b=3, stretch="hist")

click(fuji, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# outputs
# x     y  cell fuji_oli_2021001.1 fuji_oli_2021001.2 fuji_oli_2021001.3
# 1 425.5 359.5 86826                 15                 16                  2
#      x     y  cell fuji_oli_2021001.1 fuji_oli_2021001.2 fuji_oli_2021001.3
# 1 386.5 353.5 91107                 14                 15                  0
#      x     y  cell fuji_oli_2021001.1 fuji_oli_2021001.2 fuji_oli_2021001.3
# 1 85.5 351.5 92246                 51                 61                 27

band <- c(1,2,3)
land1 <- c(15,16,2)
land2 <- c(14,15,0)
land3 <- c(51,61,27)
spectralsf <- data.frame(band, land1, land2, land3)

# band land1 land2 land3
# 1    1    15    14    51
# 2    2    16    15    61
# 3    3     2     0    27

ggplot(spectralsf, aes(x=band)) + geom_line(aes(y=land1), color="red") + geom_line(aes(y=land2), color="green")+ geom_line(aes(y=land3), color="blue") 
labs(x="band",y="reflectance")
