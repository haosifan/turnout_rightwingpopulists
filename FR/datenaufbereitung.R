############## Datenaufbereitung - Frankreich ##############
# Dieses Skript erstellt aus den Ergebnissen der Regionalwahlen in Frankreich 2015 und 2011
# einen gemeinsamen Datensatz, indem Wahlbeteiligung und die Ergebnisse der LUG, LUD und FN
# abgebildet sind.
# Jede Zeile entspricht einem Departement.
# t==-1 = 2011 (tour 1); t==0 = 2015 (tour 1); t==1 = 2015 (tour 2)
############################################################
# https://www.data.gouv.fr/fr/datasets/elections-departementales-2015-resultats-tour-1/
# https://www.data.gouv.fr/fr/datasets/elections-departementales-2015-resultats-tour-2-1/
# https://www.data.gouv.fr/fr/datasets/elections-cantonales-2011-resultats-572053/
############################################################

library(dplyr)

#url_t1 <- "https://www.data.gouv.fr/s/resources/elections-departementales-2015-resultats-tour-1/20150323-162800/Dep_15_Resultats_T1_c.xlsx"
#url_t2 <- "https://www.data.gouv.fr/s/resources/elections-departementales-2015-resultats-tour-2/community/20150511-110358/Dep_15_Resultats_T2_c.xlsx"

#download.file(url_t1, destfile = "FR_results_regional election 2015_tour 1.xlsx")
#download.file(url_t2, destfile = "FR_results_regional election 2015_tour 2.xlsx")

t0 <- read.csv2("list_export_2011_tour2.csv")
t1 <- read.csv2("list_export_tour1.csv")
t2 <- read.csv2("list_export_tour2.csv")

t0$turnout <- t0$Exprimés/t0$Inscrits*100
t1$turnout <- t1$Exprimés/t1$Inscrits*100
t2$turnout <- t2$Exprimés/t2$Inscrits*100

t1$Blancs.et.nuls <- t1$Blancs+t1$Nuls
t2$Blancs.et.nuls <- t2$Blancs+t2$Nuls

## Umrechnen in Prozent + Wahlbeteiligung

t0[8:10] <- t0 %>% select(FN:LUD) %>% lapply(FUN = function(x) x/t0$Exprimés*100)
t1[9:11] <- t1 %>% select(FN:LUD) %>% lapply(FUN = function(x) x/t1$Exprimés*100)
t2[9:11] <- t2 %>% select(FN:LUD) %>% lapply(FUN = function(x) x/t2$Exprimés*100)

t0$t <- rep(-1,dim(t1)[1])
t1$t <- rep(0,dim(t1)[1])
t2$t <- rep(1,dim(t2)[1])

t1 <- t1 %>% select(Code.du.département:Votants,Blancs.et.nuls,Exprimés:turnout,t)
t2 <- t2 %>% select(Code.du.département:Votants,Blancs.et.nuls,Exprimés:turnout,t)

## gemeinsamer Datensatz

fr_df <- rbind(t0,t1,t2)
fr_df <- fr_df %>% select(Code.du.département, Libellé.du.département, t, Inscrits:Exprimés,turnout,FN:LUD)
fr_df <- fr_df[order(fr_df$Code.du.département),]
rownames(fr_df) <- 1:dim(fr_df)[1]
colnames(fr_df)[1:2] <- c("id","region") 

fr_df <- fr_df %>% arrange(id, t) %>% group_by(id) %>%
  mutate(diff_turnout = turnout - lag(turnout), diff_FN = FN - lag(FN))

rm(t0,t1,t2)