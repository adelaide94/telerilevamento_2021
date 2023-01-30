# R_code_multivariate_analysis.r

library(raster) #richiamo il pacchetto raster
library(RStoolbox) # richiamo il pacchetto RStoolbox per  la gestione l'analisi multivariata

setwd("C:/lab") # setto la cartella di lavoro
p224r63_2011 <- brick("p224r63_2011_masked.grd") # importo l'immagine con le 7 bande

plot(p224r63_2011) # plotto l'immagine con le varie bande
p224r63_2011 # vedo informazione dell'immagine

# plottiamo i valori dei pixel della banda 1 (x) del dataset p224r63_201 contro i valori dei pixel della banda 2(y) aumentando la dimennsione dei punti e impostando un pch 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2) #guardo la correlazione tra le due bande

# Plotto tutte le possibili correlazioni di tutti i valori di tutte le bande 
pairs(p224r63_2011)

# aggrego i pixel della mia immagine per ottenere una risoluzione e peso minore
aggregate(p224r63_2011)

par(mfrow=c(2,1)) # apro una finestra grafica 2x1
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin") # plotto l'immagine originale distingundo le 3 bande
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin") # plotto l'immagine ricampionata distingundo le 3 bande

# PCA riduco le bande del mio pacchetto di dati
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

summary(p224r63_2011res_pca$model) # sommario del modello delle componenti collegato alla pca, mi restituisce l'informazione delle componenti con maggiori variabilità
plot(p224r63_2011res_pca$map) # visualizzo le varie componenti collegato alla mappa
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #plotto le prime 3 bande 
