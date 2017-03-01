#############################################
##### Grafiken Europa #######################
#############################################


library(ggplot2)
library(ggthemes)
library(gridExtra)
library(grid)
library(gdata)

### Daten und Plots einlesen
setwd("C:/Users/Stefan Haußner/ownCloud/Backup/Einsichten und Perspektiven/")

setwd("AT")
source("analyse.R")
setwd("../CH/")
source("analyse.R")
setwd("../DK/")
source("analyse.R")
setwd("../FR/")
source("analyse.R")
setwd("../NL/")
source("analyse.R")
setwd("../UK/")
source("analyse.R")

#keep(list = ls(pattern = "p_"), sure = T)


### GridArrange

p_at <- grid.arrange(p_at1,p_at2, ncol=2, 
                     top = textGrob("Bundespräsidentenwahl 2016 - Österreich", 
                                    gp = gpar(fontface="bold")))
p_ch <- grid.arrange(p_ch1,p_ch2, ncol=2, 
                     top = textGrob("Nationalratswahlen 2015 - Schweiz", 
                                    gp = gpar(fontface="bold")))
p_dk <- grid.arrange(p_dk1,p_dk2, ncol=2, 
                     top = textGrob("Folketingswahl 2015 - Dänemark", 
                                    gp = gpar(fontface="bold")))
p_fr <- grid.arrange(p_fr1,p_fr2, ncol=2, 
                     top = textGrob("Regionalwahl 2015 - Frankreich", 
                                    gp = gpar(fontface="bold")))
p_nl <- grid.arrange(p_nl1,p_nl2, ncol=2, 
                     top = textGrob("Europawahl 2014 - Niederlande", 
                                    gp = gpar(fontface="bold")))
p_uk <- grid.arrange(p_uk1,p_uk2, ncol=2, 
                     top = textGrob("Unterhauswahl 2015 - Großbritannien", 
                                    gp = gpar(fontface="bold")))


p_all <- grid.arrange(p_at,p_ch,p_dk,p_fr,p_nl,p_uk,
                      nrow=6)


ggsave(p_all, filename = "../zgfx/all_europe.tif", dpi = 300, device = "tiff", width = 15, height = 21)


