#

# Creo il set della working directory
setwd("C:/lab/")

# Uso il pacchetto knitr per includere in R un codice esterno presente nella cartella, creo un report e lo risalvo nella cartella
#chiamo knitr
library(knitr)

#uso stich per generare report,  le figure e permette di saalvare nella cartella originale
stitch("R_code_time_series.r.rtf", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
