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
plot(p224r63_2011,col= cls)

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

# 
 par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)

# DAY 4
# RGB red green blu

#strech
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
# associo la banda del rosso all'infrarosso per evidenziare la riflettanza nel rosso della vegetazione   
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# inverto 3 e 4
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
# exercise :  fare un multiframe 2x2 con le precedenti codici
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# uso la funzione per uno streth non lin ma hit che da una magggiore pendenza allo stretch dando maggiore dettaglio all'immagine
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
pl
# faccio un par multiframe, con falsi colore e con histagram strech
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# DAY 5
#Multitemporale setDEV
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

par(mfrow=c(3,1 ))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# esercizio di confronto tra amazzonia 2011 e 1988 con sistema RGD con banda dell'infrarosso
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4,
        g=3, b=2, stretch="Lin")???

# es di confronto MULTITEMP tra amazzonia 2011 e 1988 con sistema RGD con banda dell'infrarosso con gli strecth par ed hista
library(raster)
setwd("C:/lab/")

p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_2011 <- brick("p224r63_2011_masked.grd")

pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
    

