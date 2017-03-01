#############################################
##### Grafiken FR ###########################
#############################################


source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)

## Auswahl der relvanten Wahlen 
## fr_df_2015a == Wahl 2015 erster und zweiter Wahlgang
## fr_df_2015b == Wahl 2015 erster Wahlgang im Vergleich zu erstem Wahlgang 2011
fr_df_2015a <- fr_df[fr_df$t == 1,]
fr_df_2015b <- fr_df[fr_df$t == 0,]

corr_fr1 <- round(cor(fr_df_2015a$turnout,fr_df_2015a$FN, use = "complete.obs"),2)

p_fr1 <- ggplot(fr_df_2015a, aes(x = turnout, y = FN)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_fr1)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Wahlbeteiligung (%)') + ylab('FN-Stimmanteil (%)') 
  #ggtitle('Regional Election FR 2015')
ggsave("../zgfx/FR_RE2015_wb.tif", dpi = 300, device = "tiff")

corr_fr2 <- round(cor(fr_df_2015a$diff_turnout,fr_df_2015a$diff_FN, use = "complete.obs"),2)

p_fr2 <- ggplot(fr_df_2015a, aes(x = diff_turnout, y = diff_FN)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_fr2)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz FN-Stimmanteil (%)') 
  #ggtitle('Regional Election FR 2015')
ggsave("../zgfx/FR_RE2015_diff.tif", dpi = 300, device = "tiff")

ggplot(fr_df_2015b, aes(x = diff_turnout, y = diff_FN)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_fr2)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz Front-National-Stimmanteil (%)') 
  #ggtitle('Regional Election FR 2015-2011')
ggsave("../zgfx/FR_RE2015_2011_diff.tif", dpi = 300, device = "tiff")


