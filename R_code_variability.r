#  R code variability

library(raster) # richiamo pacchetto
library(RStoolbox)
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplot together
install.packages("viridis")
library(viridis) # for ggplot colouring

setwd('C:/lab') #setto cartella di lavoro 

sent <- brick("sentinel.png") # importo l'immagine sentinel 
# NIR 1, RED 2, GREEN 3 
plotRGB(sent, stretch="lin") # plotto l'immagine 

#riduco l'immagine sentinel ad una solo layer attraverso NDVI
nir <- sent$sentinel.1 # cambio nome alla banda
red <- sent$sentinel.2
ndvi <- (nir - red) / (nir + red) #calcolo indice di vegetazione
plot(ndvi) #plotto l'indice di vegetazione

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) #creo scala di colori
plot(ndvi,col=cl) #plotto l'indice di vegetazione con scala di colori creata

# Calcolo della deviazione standard dell'ndvi con una finestra mobile di 3x3 pixel
ndvisd3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=sd) 
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd3, col=clsd) #plotto

#Calcolo della media dell'ndvi con una finestra mobile con griglia 3x3 pixel
ndvimean3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvimean3, col=clsd) #plotto

# una finestra mobile con griglia 13x13 pixel
ndvisd13 <- focal(ndvi, w=matrix(1/169,nrow=13,ncol=13), fun=sd) #calcolo devizione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd13, col=clsd) #plotto

# Uso moving window 5x5
ndvisd5 <- focal(ndvi, w=matrix(1/25,nrow=5,ncol=5), fun=sd) #calcolo devizione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd5, col=clsd) #plotto

# PCA analisi componenti principali per i raster
sentpca <- rasterPCA(sent)
plot(sentpca$map) # analisi multivariata dell'immagine
summary(sentpca$model) #PC1 contains 67.3604% of the original information
