# Il mio primo codice in R per il telerilevamento
setwd("C:/lab/") 

#install.packages("raster" )
library(raster)

#uso la funzione brick  
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

#cambio di colore della legenda
cl <- colorRampPalette(c("black","grey","light grey")) (100)

plot(p224r63_2011, col= cl)

# DAY 2
# cambio di colore -> new
cl <- colorRampPalette(c("blue","green"," grey", "red","magenta","yellow")) (100)
plot(p224r63_2011, col= cl)

#DAY 3
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#dev.off ripulisce la finestra grafica
dev.off()

# plotto solo la banda b1 che ho legato all immagine
plot(p224r63_2011$B1_sre)

# plotto la banda1 con una palette
cl <- colorRampPalette(c("blue","green"," grey", "red","magenta","yellow")) (100)
plot(p224r63_2011$B1_sre, col= cl)

# plotto due bande affiancate con la funzione par
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

 
