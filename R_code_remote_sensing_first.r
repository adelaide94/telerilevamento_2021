# Il mio primo codice in R per il telerilevamento
install.packages("raster") #installo il pacchetto raster, il pacchetto è esterno ad R
library(raster) #richiamo il pacchetto installato
setwd("C:/lab") # indicazione cartella di lavoro

# Importo l'immagine satellitare e la visualizzo
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

### Day 2 
# colour change
cl <- colorRampPalette(c("black","grey","light grey"))(100) #creo una scala di colori
plot(p224r63_2011, col=cl) # visualizzo l'immagine con la scala di colori appena creata

# colour change -> new 
cls <- colorRampPalette(c("blue","red","magenta","pink","white"))(100)
plot(p224r63_2011, col=cls)

### Day 3
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio 

# dev.off ripulisce il comando della finestra grafica
dev.off()

# plotta solo la banda 1 
plot(p224r63_2011$B1_sre)

# plotta solo la banda 1 attraverso la funzione "colorRampPalette"
clt <- colorRampPalette(c('purple','orange','pink','white'))(100)
plot(p224r63_2011$B1_sre, col=clt)

dev.off()

# par(mfrow...) prepara lo schermo a mettere le immagini in un dato numero di righe e colonne
# par(mfcol...) se vogliamo usare prima il numero di colonne
par(mfrow=c(1,2)) # creo una finestra grafica con una riga e due colonne 
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# 2 righe e 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# Plottiamo le 4 immagini di Landsat in 4 righe e 1 colonna
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# Plottiamo le 4 immagini di Landsat in 2 righe e 2 colonna
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# per ogni banda stabiliamo una colorRampPalette
par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

### Day 4
# Visualizing data by RGB plotting

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio 

# RGB permette di visualizzare tre bande per volta 
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # alla componenre R associo la banda del rosso, alla G associo banda del verde e B la banda del blu
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # alla componente R associo la banda 4 cioè NIR
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# Plottiamo le 4 immagini 2x2 multiframe

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
pdf("il_mio_primo_pdf_con_R.pdf") #crea un pdf che viene salvato nella cartella di lavoro
dev.off()

# confronto le immegini applicando due strecth differenti- lineare 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
# uso lo stretch histogram ridando l'immagine allargata nel punto medio di pendenza
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# affianco con la funzione par l'immagine in colori naturali e strech lineare, immagine con una variazione delle bande del verde e del blu  e l'immagine naturale ma con uno stretch histogram 
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# Installo il pacchetto RStoolbox
install.packages("RStoolbox")
# Richiamo pacchetto installato
library(RStoolbox)

# Installo il pacchetto ggplot2
install.packages("ggplot2")
library(ggplot2)

### DAY 5
# Multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd") # importo l'immagine satellitare del 1988 e le assegno un nome
p224r63_1998 

plot(p224r63_1988) # visualizzazione grafica delle singole bande
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") # uso per la visualizzazione tre bande quella del rosso, del verde e del blu
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") # associo NIR alla componente red 

# Visualizzo in una finestra 2x1 l'immagine satellitare del 2011 e del 1988
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #associo l'infrarosso alla componente Red

# creo un pdf
par(mfrow=c(2,2)) 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") # uso stretch lineare
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") # uso histogram stretching
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
pdf("multitemp.pdf")
dev.off()
