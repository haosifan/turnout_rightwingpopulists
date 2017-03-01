#setwd("")
require(dplyr)
require(ggplot2)
require(reshape2)
require(ggthemes)

w.bw <- read.csv2("Baden-Württemberg 2016.csv")
rownames(w.bw) <- w.bw$von.nach
w.bw <- w.bw[,-1]

w.be <- read.csv2("Berlin 2016.csv")
rownames(w.be) <- w.be$von.nach
w.be <- w.be[,-1]

w.mv <- read.csv2("Mecklenburg-Vorpommern 2016.csv")
rownames(w.mv) <- w.mv$von.nach
w.mv <- w.mv[,-1]

w.rp <- read.csv2("Rheinland-Pfalz 2016.csv")
rownames(w.rp) <- w.rp$von.nach
w.rp <- w.rp[,-1]

w.st <- read.csv2("Sachsen-Anhalt 2016.csv")
rownames(w.st) <- w.st$von.nach
w.st <- w.st[,-1]


### Funktion um den Anteil der Wanderungen zu berechnen
totalstorows <- function(df) {
  df[df<=0] <- NA
  df <- df %>% lapply(function(x) round(x/rowSums(df, na.rm = T),2))
  return(as.data.frame(df))
} 

### Aufruf der Funktion ergibt eine Liste aus data.frames aller Objekte die
### w.xx heißen
df <- lapply(mget(ls(pattern = "w.[a-z][a-z]")), totalstorows)

###Split der Liste in die ursprünglichen Objekte
list2env(df, envir = .GlobalEnv)

### Plot-Vorbereitung
c <- rbind(w.bw %>% select(SPD,CDU,Grüne,Linke,AfD,Nichtwähler,Andere),
      w.be %>% select(SPD,CDU,Grüne,Linke,AfD,Nichtwähler,Andere),
      w.mv %>% select(SPD,CDU,Grüne,Linke,AfD,Nichtwähler,Andere),
      w.rp %>% select(SPD,CDU,Grüne,Linke,AfD,Nichtwähler,Andere),
      w.st %>% select(SPD,CDU,Grüne,Linke,AfD,Nichtwähler,Andere))

afd_gains <- c[grep("AfD", rownames(c)),c(1:4,6,7)]
rownames(afd_gains) <- c("bw","be","mv","rp","st")
afd_gains$group <- rownames(afd_gains)
colnames(afd_gains)[5] <- "Nichtwahl"

## SPD-Vergleich
spd_gains <- c[grep("SPD", rownames(c)), c(2:7)]
rownames(spd_gains) <- c("bw","be","mv","rp","st")
spd_gains$group <- rownames(spd_gains)
colnames(spd_gains)[5] <- "Nichtwahl"

### Reshape in Long-Format
x_plot <- melt(afd_gains, id.vars = "group")

# colorblind-palette
cbPalette <- c("#0072B2","#009E73", "#E69F00", "#56B4E9",  "#F0E442", "#D55E00", "#CC79A7")

ggplot(x_plot,aes(x=variable,y=value, fill = factor(group)))+
  geom_bar(stat="identity",position="dodge", colour="black")+
  theme_minimal() + scale_fill_manual(values=cbPalette,
                                      name="Bundesland",
                                      labels=c("BW","BE","MV","RP","ST")) +
  #scale_fill_grey(name="Bundesland",
  #                labels=c("BW","BE","MV","RP","ST"),
  #                start = 0.8,
  #                end = 0) +
  scale_y_continuous(limits = c(0,0.5),
                     labels = c("0.0" = "0 %", "0.1" = "10 %", "0.2" = "20 %", 
                                "0.3" = "30 %", "0.4" = "40 %", "0.5" = "50 %"))+
  xlab("Wählerabgebende Partei")+ylab("Anteil am gesamten Gewinn der AfD")+
  ggtitle("anteiliger Stimmengewinn der AfD durch andere Parteien")+
  theme(axis.title = element_text(face = "bold",size = rel(1)),
        plot.title = element_text(face = "bold",
                                  size = rel(1.2), hjust = 0.5),
        legend.title = element_text(face="italic"),
        legend.key = element_rect(colour = NA),
        legend.position = "right",
        legend.direction = "vertical",
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(margin=margin(-2,5,10,5,"pt")))
ggsave(filename = "../zgfx/voter_shift.tiff", dpi = 300, width = 12, height = 8)
