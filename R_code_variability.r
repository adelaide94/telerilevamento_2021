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

pc1 <- sentpca$map$PC1 #prendo la prima componente principale
pc1sd5 <- focal(pc1, w=matrix(1/25,nrow=5,ncol=5), fun=sd) #calcolo sd sulla pc1 con moving window 5x5
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(pc1sd5, col=clsd) #plotto

# Con la funzione source carico il codice "source_test_lezione.r" in modo che R lo esegua
source("source_test_lezione.r") # "source_test_lezione.r" calcola la sd con finestra 7x7
# carico il codice già creato "source_ggplot.r"
source("source_ggplot.r")

# uso ggplot per plottare le mappa di sd della pc1
p1 <- ggplot()+ #creo finestra vuota
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill= layer))+ #definisco geometria raster della mappa 
scale_fill_viridis()+ #uso scala di colore viridis default, funzione che permette di inserire scale di colore ben visibili anche in condizioni di problematiche ottiche
ggtitle("Standard deviation of PC1 by viridis colour scale") #aggiungo titolo

#uso legenda "magma"
p2 <- ggplot()+ #creo finestra vuota
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill= layer))+ #definisco geometria
scale_fill_viridis(option = "magma")+ #uso scala di colore viridis magma visualizza chiaramente livelli di sd alti
ggtitle("Standard deviation of PC1 by magma colour scale") #aggiungo titolo

#uso legenda "turbo"
p3 <- ggplot()+ #creo finestra vuota
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill= layer))+ #definisco geometria
scale_fill_viridis(option = "turbo")+
ggtitle("Standard deviation of PC1 by turbo colour scale") #aggiungo titolo

grid.arrange(p1, p2, p3, nrow=1) #metto insieme le tre mappe in una pagina 


