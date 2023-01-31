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
