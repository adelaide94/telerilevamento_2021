#R_code_classification

library(raster) #richiamo il pacchetto raster
library(RStoolbox) #installo il pacchetto per la gestione l'analisi multivariata

setwd("C:/lab") #setto cartella di lavoro

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #importo su R l'immagine multi layer
so #visualizzo i dati dell'immagine

# visualizzo gli strati RGB applicando un allungamento dell'immagine lineare e ne visuallizzo le tre bande 
plotRGB(so, 1, 2, 3, stretch="lin")

# Unsupervised Classification uso un modello di classificazione non supervisionata ed imposto il numero di classi
set.seed(42) # permette di usare sempre le stesse regole per fare il modello di classificazione 
soc <- unsuperClass(so, nClasses=3)
plot(soc$map) #visualizzo l'informazione delle mie classi legando questo alla mappa

#  Unsupervised Classification # uso un modello di classificazione non supervisionata ed imposto il numero di classi 20 
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map) #visualizzo l'informazione delle mie classi legando questo alla mappa

# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("Sun.png")
# Unsupervised Classification # uso un modello di classificazione non supervisionata ed imposto il numero di classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map) #visualizzo l'informazione delle mie classi legando questo alla mappa

# Grand Canyon 
# Download immagine da 
# https://landsat.visibleearth.nasa.gov/view.php?id=80948


gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") # importo su R l'immagine
plotRGB(gc, 1, 2, 3, stretch="lin") # plotto l'immagine con 3 strati applico un allungamento lineare 
plotRGB(gc, 1, 2, 3, stretch="hist") # plotto l'immagine con 3 strati applico un allungamento hist che mi restituisce un maggior dettaglio

# Unsupervised Classification uso un modello di classificazione non supervisionata ed imposto il numero di classi
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2 #visualizzo la classificazione
plot(gcc2$map) #visualizzo l'informazione delle mie classi legando questo alla mappa

# Unsupervised Classification con 4 classes
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map) #visualizzo l'informazione delle mie classi legando questo alla mappa
