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
