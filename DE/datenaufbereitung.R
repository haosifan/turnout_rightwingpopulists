library(dplyr)

de_ep <- read.csv("ep14.csv", encoding = "UTF-8")
de_ep <- de_ep %>% select(nr, gebiet, gehört.zu, t,wahlberechtigte,wähler, wahlbeteiligung,cdu,spd,die_linke,grüne,afd)

de_ep <- de_ep %>% arrange(nr, t) %>% group_by(nr) %>% 
  mutate(diff_turnout = wahlbeteiligung-lag(wahlbeteiligung), diff_afd = afd-lag(afd))

de_bt <- read.csv("btw13.csv", encoding = "UTF-8")
de_bt <- de_bt %>% select(gkz, gebiet, t,wahlberechtigte,waehler,wahlbeteiligung,cdu,spd,die_linke,gruene,afd)

de_bt <- de_bt %>% arrange(gkz, t) %>% group_by(gkz) %>% 
  mutate(diff_turnout = wahlbeteiligung-lag(wahlbeteiligung))
