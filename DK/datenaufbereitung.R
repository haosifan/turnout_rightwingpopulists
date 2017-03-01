####################################################
#### Datenaufbereitung DK ##########################
####################################################
# Dieses Skript erstellt einen Datensatz mit den Wahldaten
# der Dänischen Parlamentswahlen 2015 und 2011 auf der Ebene
# der Wahlkreise. Darüber hinaus wird die Differenz der Wahlbeteiligung
# und des Ergebnisses der Dänischen Volkspartei (DF) berechnet
#####################################################
# Quellen: 
# https://www.dst.dk/valg/SE_FV2011.pdf
# http://dst.dk/Valg/Valg1487635/other/2015-Folketingsvalg.pdf
#####################################################

library(dplyr)

dk_15 <- read.csv2("DK_2015_Folketingsvalg.csv")
dk_11 <- read.csv2("DK_2011_Folketingsvalg.csv")

dk_15_1 <- dk_15[dk_15$ebene==4,]
dk_11_1 <- dk_11[dk_11$ebene==4,]

dk_15_1$t <- rep(1, dim(dk_15_1)[1])
dk_11_1$t <- rep(0, dim(dk_11_1)[1])
dk_15_1$nr <- 1:dim(dk_15_1)[1]
dk_11_1$nr <- 1:dim(dk_11_1)[1]


dk_15_1 <- dk_15_1 %>% select(nr,ebene:name,t,wb,Socialdemokraterna:Venstre,Gesamt)
dk_11_1 <- dk_11_1 %>% select(nr,ebene:name,t,wb,Socialdemokraterna:Venstre,Gesamt)

# Umrechnung absolute Wähler in Prozent

dk_15_1[6:13] <- dk_15_1 %>% select(Socialdemokraterna:Venstre) %>% lapply(function(x) x/dk_15_1$Gesamt*100)
dk_11_1[6:13] <- dk_11_1 %>% select(Socialdemokraterna:Venstre) %>% lapply(function(x) x/dk_11_1$Gesamt*100)

# Append und Berechnung der Differenzen

dk_df <- rbind(dk_15_1,dk_11_1) %>% arrange(nr, t) %>% group_by(nr) %>%
  mutate(diff_turnout = wb - lag(wb), diff_DF = DanskFolkeparti - lag(DanskFolkeparti))

