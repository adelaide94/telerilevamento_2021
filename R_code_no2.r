# R_code_no2.r


# fase  1: set working directory EN
setwd("C:/lab/EN/")

# Funzione library per richiamare il pacchetto raster precedentemente installato
library(raster)

# fase 2: importare la prima banda
EN0001 <- raster ("EN_0001.png")
# Funzione plot
plot(EN0001) 

clr <- colorRampPalette(c("red","orange","pink","yellow")) (100)
plot(EN0001, col=clr)

# fase 3: importare l'ultima banda e plottarla con la precedente colorRampPalette
EN0013 <- raster ("EN_0013.png")
# Funzione plot
plot(EN0013) 

clr <- colorRampPalette(c("red","orange","pink","yellow")) (100)
plot(EN0013, col=clr)

# fase 4: fare la differenza dell'immagine associare ad un oggetto e plottare 
ENdif <- EN0013-EN0001
plot(ENdif, col=clr)

# 
ENdif <- EN0001-EN0013
plot(ENdif, col=clr)

# fase 5 plottare le immagini insieme
par(mfrow=c(3,1))
plot(EN0001, col=clr, main="NO2 in January")
plot(EN0013, col=clr, main="NO2 in March")
plot(ENdif, col=clr, main="Difference between January - March")

# fase 6: importare tutto il set di dati di 16 immagini una banda per immagine
#faccio una lista 
rlist <- list.files(pattern="EN")
#applico la funzione raster alla lista
import <- lapply(rlist,raster)
import

# funzione stack compatta la lista 
NO2 <- stack(import)
plot(NO2)

# fase 7: replicare il plot delle immagini 1 e 13

par(mfrow=c(2,1))
plot(NO2$EN_0001, col=clr)
plot(NO2$EN_0013, col=clr)

# fase 8: calcolo della PCA delle 13 componenti
NO2_pca <- rasterPCA(NO2)
summary(NO2_pca$model)

plotRGB(NO2_pca$map, r=1, g=2, b=3, stretch=”lin”)

# fase 8: calcolo la variabilità della prima componente (deviazione standard)

PC1sd<- focal(NO2_pca$map$PC1, w=matrix(1/9, nrow=3,ncol=3), fun=sd)
plot(PC1sd, col=clr)


