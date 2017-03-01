###########################################################################
########### Datenaufbereitung AT - Europawahlen ###########################
###########################################################################
# Dieses Skript stellt aus csv-Dateien mit Wahlergebnissen aus Österreich
# der Bundespräsidentenwahl 2016 ein gemeinsamen Datensatz zusammen, der für jede
# Einheit die Wahlergebnisse enthält, und darüber hinaus
# die Veränderung in der Wahlbeteiligung sowie die Veränderung des 
# FPÖ/Hofer-Ergebnisses. Zeitpunkt 0 ist die Stichwahl, Zeitpunkt 1 ist die Wiederholungswahl
###########################################################################
# Quellen:
# http://www.bmi.gv.at/cms/BMI_wahlen/bundespraes/bpw_2016/Ergebnis_2WG_WH.aspx
# http://www.bmi.gv.at/cms/BMI_wahlen/bundespraes/bpw_2016/Ergebnis_2WG.aspx
###########################################################################


library(dplyr)

## T0 - 1. Wahl

at_0 <- read.csv2("Endgueltiges_Gesamtergebnis_BPW16_2WG.csv")
at_0 <- at_0[grep(pattern = "[1-9]00$", x=as.character(at_0$GKZ)),]

## Löschen von Tausendertrennzeichen
at_0[,c(3:7,9)] <- at_0 %>% 
  select(Wahlberechtigte,Abgegebene,Ungültige,Gültige,Hofer,Van.der.Bellen) %>% 
  lapply(function(y) gsub("\\.", "", as.character(y))) %>% 
  lapply(function(z) as.numeric(z))


at_0$turnout <- at_0$Abgegebene/at_0$Wahlberechtigte*100
at_0$t <- 0


# T1 - Wiederholungswahl

at_1 <- read.csv2("Endgueltiges_Gesamtergebnis_BPW16_2WG_WH.csv")
at_1 <- at_1[grep(pattern = "[1-9]00$", x=as.character(at_1$GKZ)),]

## Löschen von Tausendertrennzeichen
at_1[,c(3:7,9)] <- at_1 %>% 
  select(Wahlberechtigte,Abgegebene,Ungültige,Gültige,Hofer,Van.der.Bellen) %>% 
  lapply(function(y) gsub("\\.", "", as.character(y))) %>% 
  lapply(function(z) as.numeric(z))


at_1$turnout <- at_1$Abgegebene/at_1$Wahlberechtigte*100
at_1$t <- 1


## gemeinsamer Datensatz

at_df <- rbind(at_0,at_1)
at_df <- at_df[order(at_df$GKZ),]
rownames(at_df) <- 1:dim(at_df)[1]

colnames(at_df)[c(8,10)] <- c("p_Hofer","p_vdBellen")

at_df <- at_df %>% arrange(GKZ, t) %>% group_by(GKZ) %>% 
  mutate(diff_turnout = turnout-lag(turnout), diff_hofer = p_Hofer - lag(p_Hofer))

rm(at_0,at_1)
