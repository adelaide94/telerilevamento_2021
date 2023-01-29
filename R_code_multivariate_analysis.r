# R_code_multivariate_analysis.r

library(raster) #richiamo il pacchetto raster
library(RStoolbox) # richiamo il pacchetto RStoolbox per  la gestione l'analisi multivariata

setwd("C:/lab") # setto la cartella di lavoro
p224r63_2011 <- brick("p224r63_2011_masked.grd") # importo l'immagine con le 7 bande

plot(p224r63_2011) # plotto l'immagine con le varie bande
p224r63_2011 # vedo informazione dell'immagine

# plottiamo i valori dei pixel della banda 1 (x) del dataset p224r63_201 contro i valori dei pixel della banda 2(y) aumentando la dimennsione dei punti e impostando un pch 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2) #guardo la correlazione tra le due bande

# Plotto tutte le possibili correlazioni tra tutte le variabili 
pairs(p224r63_2011) 
