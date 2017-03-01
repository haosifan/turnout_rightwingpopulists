#### Datenaufbereitung Niederländische Europawahl 2014 & 2009 ####
####### Veränderung der Wahlbeteiligung und PVV-Ergebnisse #######
### http://www.nlverkiezingen.com/EP2009A.html ###################
### http://www.nlverkiezingen.com/EP2014A.html ###################
##################################################################

library(dplyr)

## 2014

nl14 <- read.csv2("NL_ep2014.csv")
nl14$turnout <- nl14$abgegeben/nl14$wahlberechtigte*100
nl14$t <- rep(1,dim(nl14)[1])

nl14[,8:26] <- nl14 %>% select(D66:IQ) %>% lapply(function(x) x/nl14$gültig*100)
nl14 <- nl14 %>% select(nr:gültig,t,turnout,PVV)


## 2009

nl09 <- read.csv2("NL_ep2009.csv")
nl09$turnout <- nl09$abgegeben/nl14$wahlberechtigte*100
nl09$t <- rep(0,dim(nl09)[1])

nl09[,8:24] <- nl09 %>% select(CDA:PEP) %>% lapply(function(x) x/nl09$gültig*100)
nl09 <- nl09 %>% select(nr:gültig,t,turnout,PVV)

## gemeinsamer Datensatz
nl_df <- rbind(nl14,nl09)

nl_df <- nl_df[order(nl_df$nr),]

nl_df <- nl_df %>% arrange(region, t) %>% group_by(region) %>% 
  mutate(diff_turnout = turnout - lag(turnout), diff_pvv = PVV - lag(PVV))

rm(nl09, nl14)

