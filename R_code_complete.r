# R complete - Telerilevamento Geo-ecologico

#-------------------------------------------
# Summary:
# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus data
# 4. R code knitr 
# 5. R code multivariete analysis 
# 6. R code classification 
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover 
# 10. R code variability
# 11. R code spectral signatures


#-------------------------------------------
# 1. Remote sensing first code

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

#-------------------------------------------
# 2. R code time series

# TIME SERIES ANALYS
# GREENLAND INCREASE OF TEMPERATURE potenziale

#installo il pacchetto raster e lo richiamo in R
library(raster)

setwd("C:/lab/greenland")
# per importare le immagini .tif uso la funzione raster dell'omonimo pacchetto rappresentative di anni differenti
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# creo un multipannel con PAR CON LE 4 IMMAGINI
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# carico ad una lista di file con stessa funzione (raster). 
#faccio prima una lista dei file lst
list.files
rlist <- list.files(pattern="lst")
rlist

# adesso applico la funzione raster tramite la funzione lapply su tutta la mia rlist
import <- lapply(rlist,raster)
# la funziome stack mi crea un pacchetto unico di tutti i file raster precedentemente caricati in r
#associo ad un valore TGr
TGr <- stack(import)
plot(TGr)
# plot di immagini da satellite in RGB della temperatura delle 4 immagini lst dei vari anni sovrapposte e associate alle bande 
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")


#day 2
#installo il pacchetto rasterVis
install.packages("rasterVis")

#richiamo il pachetto in r
library(rasterVis)
# usiamo levelplot per carcare tutto il blocco TGr ed avere una sola legenda
levelplot(TGr)

#esercizio associo i valori di TGr alla mappa lst_2000 
levelplot(TGr$lst_2000)
# cambio la palette dell'immagine delle immagini singole
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
#applico il colore cl all' immagine finale con col.reagions
levelplot(TGr, col.regions=cl)

# rinomino i layer dell'immagine
levelplot(TGr,col.regions=cl,names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#argomento main mi mette il titolo al grafico
levelplot(TGr,col.regions=cl,main="Lst varietion in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Inizio dell'uso dei dati melt_greenlad provenienti dal sensore a microonde NIBUS7 per l'analisi temporali rispetto alla variazionedel giaccio in Groellandia dal 1978ad oggi

#creO una lista melt costituitita da tutti i file melt della cartella Greenland
meltlist <- list.files(pattern="melt")
meltlist
# applico lapply alla lista meltlist 
melt_import<-lapply(meltlist,raster)
melt_import

# faccio l'unione di tutti i file che ho importato con la funzione stack
melt <- stack (melt_import)
melt
#visualizzo
levelplot(melt)

# posso mostrare la differenza in termini di scioglimento del ghiacchio tra l'immagine 1978 e quella del 2007              
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt 
 #colorRampPalette per singoli file
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.region=clb)

install.packages("knitr")
#-------------------------------------------

# 3. R code Copernicus data
# vISUALIZZARE LE IMMAGINE DI COPERNICUS
#CONTROLLO DI AVERE LE LIBRERIE
library(raster)

#liberia per leggere il formato .ncdf4 e devo istallare il pacchetto
install.packages("ncdf4")
library(ncdf4)

# setto la cartella dei dati
setwd("C:/lab/")
 
 #devo caricare e associare il file scaricato al nome 
vegetation_Properties <- raster("c_gls_FAPAR_202006130000_GLOBE_PROBAV_V1.5.1.nc")
vegetation_Properties

# non uso la RGB ho un singolo strado quindi deciodo la scala di colori
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) #
plot(vegetation_Properties, col=cl)

#-------------------------------------------

# 4. R code knitr 

# Creo il set della working directory
setwd("C:/lab/")

# Uso il pacchetto knitr per includere in R un codice esterno presente nella cartella, creo un report e lo risalvo nella cartella
#chiamo knitr
library(knitr)

#uso stich per generare report,  le figure e permette di saalvare nella cartella originale
stitch("R_code_time_series.r.rtf", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#-------------------------------------------
# 5. R code multivariete analysis

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


#-------------------------------------------

# 6. R code classification 
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

#-------------------------------------------

# 7. R code ggplot2

# Richiamo i pacchetti precedentemente istallati 
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/") #setto la cartella di lavoro

p224r63 <- brick("p224r63_2011_masked.grd")# importo l'immagine con la funzione <brick>

ggRGB(p224r63,3,2,1, stretch="lin") 
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin") #r=3, g=2, b=1 e l'associo alla variabile
p2 <- ggRGB(p224r63,4,3,2, stretch="lin") #r=4, g=3, b=1 e l'associo alla variabile 

#Visualizzo insieme le due immagini RGB
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra


#-------------------------------------------

# 8. R code vegetation indices
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

# worldwide database del progetto Copernicus per il NDVI dal 1999-2017 di tutto il mondo
plot(copNDVI)

# trasformo i pixel con i valori dei pixel 253, 254, 255 (rappresentativi di acqua che voglio rimuovere) in NA
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) 
plot(copNDVI)

# richiamo pacchetto rasterVis
library(rasterVis)

# media dei valori sulle righe e colonne 
levelplot(copNDVI)

#-------------------------------------------

# 9. R code land cover

library(raster)
library(RStoolbox) # serve per la classificatione
install.packages("ggplot2") # installo il pacchetto ggplot2 
library(ggplot2)
install.packages("gridExtra") # installo il pacchetto gridExtra
library(gridExtra) 

setwd("C:/lab/") #setto cartella di lavoro

# carico dataset 
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") # plotto RGB con strech lineare
ggRGB(defor1, 1, 2, 3, stretch="lin") # plotto gli assi e le coordinate spaziali dell'oggetto

# carico seconda immagine
defor2<- brick("defor2.jpg")
plotRGB(defor2, 1, 2, 3, stretch="lin") # plotto RGB con strech lineare
ggRGB(defor2, 1, 2, 3, stretch="lin") #  plotto gli assi e le coordinate spaziali dell'oggetto

# mettiamo in fila le due immagini
par(mfrow=c(1,2)) # creao una finestra grafica con una riga e due colonne
plotRGB(defor1, 1, 2, 3, stretch="lin")
plotRGB(defor2, 1, 2, 3, stretch="lin")

# multiframe con <ggplot2> e <gridExtra>
p1 <- ggRGB(defor1, 1, 2, 3, stretch="lin")
p2 <- ggRGB(defor2, 1, 2, 3, stretch="lin")
grid.arrange(p1, p2, nrow=2) # plotto immagini su due righe 

# Unsupervised classification classificazione non supervisionata randomizzata dell'immagine defor1 in 2 classi 
# class 1: foresta
# class 2: agricoltura

d1c <- unsuperClass(defor1, nClasses=2) #raster layer 
plot(d1c$map) #plotto anche la mappa 

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map) #plotto la mappa
# class 1: agricoltura
# class 2: foresta

# con 3 classi 
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# calcolo frequenza dei pixel d classe nella mappa
freq(d1c$map)
#    value  count
# valore di frequenza di agricoltura [1,]     1 305010 
# valore frequenza di foresta [2,]     2  36282

#calcolo la somma dei pixel
s1 <-  305010 + 36282
# 341292

#calcolo la proporzione 

prop1 <- freq(d1c$map) / s1
# prop foresta: 0.8936922
# prop agricoltura: 0.1063078

s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop foresta: 0.5209263
# prop agricoltura: 0.4790737

# genero la tabella con le variabili inserisco la percentuale iniziale di copertura del primo anno 1992 e del 2006
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.36 , 10.63)
percent_2006 <- c(52.09, 47.90)
percentages <- data.frame(cover, percent_1992, percent_2006) #crea la taballa
percentages

# plotto il dataset dei valori in percentuale delle due classi di copertura , definisco le colonne, uso un grafico a barre bianche dei dati grezzi 
#1992
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
# 2006
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) # plotto i due grafici ggplot di fianco 


#-------------------------------------------

# 10. R code variability
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

#-------------------------------------------

# 11. R code spectral signatures

R_code_spectral_signatures.r

# Funzione library per richiamare il pacchetto raster precedentemente installato
library(raster)
library(rgdal)
library(ggplot2)

#la funzione sewd (set working directory) serve a richiamare una specifica cartella di lavoro (directory), in questo caso è "lab", inoltre utilizziamo le virgolette perchè usciamo fuori da R
setwd("C:/lab/")

# Funzione brick per importare i dati, anche qui utilizziamo le virgolette perchè peschiamo i dati al di fuori di R
defor2 <- brick("defor2.jpg") #importo l'immagine e l'associo alla variabile 

# NIR, red, green
plotRGB(defor2, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="hist")

# funzione click per seleionare le firme spettrali
# id= valore identificativo per ogni punto, xy= vogliamo utilizzare un'info spaziale ,cell= pixel, type= punti, pch= caratteristica del punto(apice)

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #clicco nella mappa per avere informazioni di riflettanza nelle 3 bande
# Results: 
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 178.5 435.5 30293      206       6       19
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 571.5 245.5 166916      40      99      139
# defor2.1 ottengo un valore molto alto di riflettanza perchè si tratta della banda del NIR
# defor2.2= 6    ho un valore molto basso perchè si tratta della banda del rosso ed essendo vegetazione in questa determinata banda assorbe
# defor2.3= 19  valore medio basso per la banda del verde 

# costruiamo le colonne del nostro dataset:
# c sta per characters
# nella colonna corrispondente a forest e water inseriremo i valori di riflettanza ottenuti corrispondenti a ciascuna banda
band <- c(1,2,3)
forest <- c(217,6,20)
water <- c(51,92,136)
# creaiamo la nostra tabella, con la funzione data.frame
spectrals <- data.frame (band,forest, water)

# band forest water
# 1    1    217    51
# 2    2      6    92
# 3    3     20   136

# vado a plottare le firme spettrali con la funzione ggplot
# aes: estetics
ggplot(spectrals, aes(x=band)) + geom_line(aes(y=forest), color="green") + geom_line(aes(y=water), color="blue") 
labs(x="band",y="reflectance")

## Multitemporal 

# Funzione brick per importare i dati, anche qui utilizziamo le virgolette perchè peschiamo i dati al di fuori di R
defor1 <- brick("defor1.jpg")
# funzione plot
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# firme spettrali di defor1
# funzione click per seleionare le firme spettrali
# time 1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#     x     y   cell defor1.1 defor1.2 defor1.3
# 1 34.5 333.5 102851      218       17       35
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 50.5 339.5 98583      224       10       34
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 87.5 339.5 98620      215       12       32
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 77.5 374.5 73620      199        1       18
#     x     y  cell defor1.1 defor1.2 defor1.3
# 1 87.5 395.5 58636      230       33       63

# time 2
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

#    x     y  cell defor2.1 defor2.2 defor2.3
# 1 86.5 338.5 99750      198      162      150
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 101.5 335.5 101916      171      170      150
#       x     y  cell defor2.1 defor2.2 defor2.3
# 1 111.5 345.5 94756      213      195      175
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 101.5 366.5 79689      204       23       38
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 90.5 375.5 73225      217       16       32
 
# costruiamo le colonne del nostro dataset:
band <- c(1,2,3)
time1 <- c(218,17,35)
time2 <- c(198,162,150)
spectralst <- data.frame(band, time1, time2)

# vado a plottare le firme spettrali con la funzione ggplot
# aes: estetics
ggplot(spectrals, aes(x=band)) + geom_line(aes(y=time1), color="red") + geom_line(aes(y=time2), color="grey") 
labs(x="band",y="reflectance")

band <- c(1,2,3)
time1 <- c(218,17,35)
time1p2 <- c(224,10,34)
time2 <- c(198,162,150)
time2p2 <- c(171,170,150)
spectralst <- data.frame(band, time1, time1p2, time2, time2p2)

ggplot(spectrals, aes(x=band)) + geom_line(aes(y=time1), color="red", linetype="dotted") + geom_line(aes(y=time1p2), color="red", linetype="dotted")+ geom_line(aes(y=time2), color="grey", linetype="dotted") + geom_line(aes(y=time2p2), color="grey", linetype="dotted")
labs(x="band",y="reflectance")

# carichiamo l'immagine scaricata dall'earth observatory 
# Funzione brick per importare i dati, anche qui utilizziamo le virgolette perchè peschiamo i dati al di fuori di R
fuji <- brick("fuji_oli_2021001.jpg")
#funzione plot
plotRGB(fuji, r=1, g=2, b=3, stretch="hist")

click(fuji, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# outputs
# x     y  cell fuji_oli_2021001.1 fuji_oli_2021001.2 fuji_oli_2021001.3
# 1 425.5 359.5 86826                 15                 16                  2
#      x     y  cell fuji_oli_2021001.1 fuji_oli_2021001.2 fuji_oli_2021001.3
# 1 386.5 353.5 91107                 14                 15                  0
#      x     y  cell fuji_oli_2021001.1 fuji_oli_2021001.2 fuji_oli_2021001.3
# 1 85.5 351.5 92246                 51                 61                 27

band <- c(1,2,3)
land1 <- c(15,16,2)
land2 <- c(14,15,0)
land3 <- c(51,61,27)
spectralsf <- data.frame(band, land1, land2, land3)

# band land1 land2 land3
# 1    1    15    14    51
# 2    2    16    15    61
# 3    3     2     0    27

ggplot(spectralsf, aes(x=band)) + geom_line(aes(y=land1), color="red") + geom_line(aes(y=land2), color="green")+ geom_line(aes(y=land3), color="blue") 
labs(x="band",y="reflectance")
