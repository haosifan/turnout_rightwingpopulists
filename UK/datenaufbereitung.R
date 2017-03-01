#### Datenaufbereitung Englische Wahlergebnisse 2015 & 2010 ####
####  Veränderung der Wahlbeteiligung und UKIP-Ergebnisse   ####
#### http://www.electoralcommission.org.uk/our-work/our-research/electoral-data

library(dplyr)

##2015
uk <- read.csv("2015-UK-general-election-data-results-WEB/RESULTS FOR ANALYSIS.csv", header = T, dec = ".")
uk$Electorate <- as.numeric(gsub(",","",x = uk$Electorate))
uk$Total.number.of.valid.votes.counted <- as.numeric(gsub(",","",x = uk$Total.number.of.valid.votes.counted))

uk <- uk[1:(dim(uk)[1]-2),]
uk <- uk[,c(1:3,7:9,27,53,69,71,117,131)]
uk$turnout <- uk$Total.number.of.valid.votes.counted/uk$Electorate*100
uk <- uk %>% select(Press.Association.ID.Number:Total.number.of.valid.votes.counted, turnout,C:LD,UKIP)
uk[,8:12] <- uk %>% select(C:UKIP) %>% lapply(FUN = function(x) x/uk$Total.number.of.valid.votes.counted*100)

##2010
uk2010 <- read.csv2("GE2010-results-flatfile-website.csv", header = T, dec = ".")

uk2010 <- uk2010[1:650,]
uk2010$turnout <- uk2010$Votes/uk2010$Electorate*100
uk2010 <- uk2010 %>% select(Press.Association.Reference:Votes,turnout,Con,Grn,Lab,LD,UKIP)

uk2010[,8:12] <- uk2010 %>% select(Con:UKIP) %>% lapply(FUN = function(x) x/uk2010$Votes*100)

##gemeinsamer Datensatz
colnames(uk2010) <- colnames(uk)
uk_df <- rbind(uk,uk2010)

uk_df <- uk_df[order(uk_df$Press.Association.ID.Number),]
rownames(uk_df) <- 1:1300

uk_df <- uk_df %>% arrange(Constituency.Name, Election.Year) %>% group_by(Constituency.Name) %>%
  mutate(diff_turnout = turnout - lag(turnout), diff_ukip = UKIP - lag(UKIP))

rm(uk,uk2010)
