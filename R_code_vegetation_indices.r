## R_code_vegetation_indices.r

library(raster) #richiamo il pacchetto 
library(RStoolbox) # richiamo il pacchetto per calcolare gli ndvi
install.packages("rasterdiv") #carico il pacchetto rasterdiv per calcolorare gli ndvi del mondo
library(rasterdiv) # richiamo il pacchetto
library(rasterVis)

setwd("C:/lab") # setto la cartella di lavoro

# importo le immagini
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green definisco le immagini
par(mfrow=c(2,1))  #setto la mia finestra grafica con due righe e una colonna per la  multitemporalità
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") 
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# Calcoliamo indice di vegetazione 1, differenza fra il valore dei pixel nella banda NIR e banda RED, faccio l'operazione algebrica
dvi1 <- defor1$defor1.1 - defor1$defor1.2 #collego il dattaset defor1 con la banda chiamata defor1.1  NIR e collego il dattaset defor1 con la banda RED chiamata defor1.2 
plot(dvi1) # visualizzo il risultato per capiro lo stato di salute della vegetazione rappresentata

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # creo scala di colori
plot(dvi1, col=cl, main="DVI at time 1") # plotto l'immagine con la scala di colori creata e aggiungo il titolo

#  Calcoliamo indice di vegetazione 2, differenza fra il valore dei pixel nella banda NIR e banda RED, faccio l'operazione algebrica
dvi2 <- defor2$defor2.1 - defor2$defor2.2 #collego il dattaset defor2 con la banda chiamata defor2.1  NIR e collego il dattaset defor1 con la banda RED chiamata defor2.2
plot(dvi2) # visualizzo il risultato per capiro lo stato di salute della vegetazione rappresenta

dev(off)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # creo scala di colori
plot(dvi2, col=cl, main="DVI at time 2") # plotto l'immagine con la scala di colori creata e aggiungo il titolo

#plotto insieme i due dvi
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# Diffirenza fra i due indici dvi
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue', 'white', 'red'))(100) #creo scala di colori
plot(difdvi, col=cld) # plotto la differenza fra i dvi i valori con maggiore differenza sono rappresentati dal colore rosso ,rappresentativo di maggiore sofferenza da parte della vegetazione

# Calcolo ndvi 
# (NIR-RED) / (NIR+RED)
#ndv1
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl) # lo visualizzo 

#ndvi2
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl) # lo visualizzo

# Differenza fra i due ndvi
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue', 'white', 'red'))(100) # creo scala di colori
plot(difndvi, col=cld)

# RStoolbox::spectralIndices indice per calcolare molti indici

vi1 <- spectralIndices(defor1, green=3, red=2, nir=1) # calcolo tutti gli indici richiamo il nome dell'immagine e indicare  le bande
plot(vi1, col=cl) # visualizzo gli indici calcolati 

vi2 <- spectralIndices(defor2, green=3, red=2, nir=1) # calcolo tutti gli indici
plot(vi2, col=cl)
