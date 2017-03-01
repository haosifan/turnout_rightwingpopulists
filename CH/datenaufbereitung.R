###########################################################################
########### Datenaufbereitung CH - Nationalratswahlen #####################
###########################################################################
# Dieses Skript stellt aus csv-Dateien mit Wahlergebnissen aus der Schweiz
# der Nationalratswahlen 2015 und 2011 ein gemeinsamen Datensatz zusammen, der 
# für jede Einheit auf der Bezirksebene die Wahlergebnisse enthält, und 
# darüber hinaus die Veränderung in der Wahlbeteiligung sowie die Veränderung des 
# SVP-Ergebnisses
###########################################################################
# Quellen:
# https://www.bfs.admin.ch/bfs/de/home/statistiken/kataloge-datenbanken/tabellen.assetdetail.184408.html
# https://www.bfs.admin.ch/bfs/de/home/statistiken/kataloge-datenbanken/tabellen.assetdetail.290154.html
###########################################################################


library(dplyr)

ch_11 <- read.csv2("CH_Bezirke_2011.csv")
ch_15 <- read.csv2("CH_Bezirke_2015.csv")

# Luzern und der Bezirk CH de l'étranger sind nicht deckungsgleich zwischen 
# 2011 und 2015 und werden daher aus dem Datensatz entfernt.

ch_15 <- ch_15[ch_15$Bezirks.Nr.!=9100,]
ch_15 <- ch_15[ch_15$Kanton!="LU",]
ch_11 <- ch_11[ch_11$Kanton!="LU",]

# Append und Berechnung der Diffs

ch_15 <- ch_15 %>% select(Bezirks.Nr.:SVP,wb)
ch_11 <- ch_11 %>% select(Bezirks.Nr.:SVP,wb)

ch_df <- rbind(ch_15,ch_11) %>% arrange(Bezirks.Nr.,t) %>% group_by(Bezirks.Nr.) %>% 
  mutate(diff_turnout = wb-lag(wb), diff_svp = SVP - lag(SVP))
