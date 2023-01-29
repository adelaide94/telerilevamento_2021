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
