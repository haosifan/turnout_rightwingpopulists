#############################################
##### Grafiken DK ###########################
#############################################


source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)

corr_df <- dk_df[dk_df$t==1,]
corr_dk1 <- round(cor(corr_df$wb,corr_df$DanskFolkeparti),2)

p_dk1 <- ggplot(dk_df[dk_df$t==1,], aes(x = wb, y = DanskFolkeparti)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_dk1)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  theme(legend.position="bottom") +
  xlab('Wahlbeteiligung (%)') + ylab('DF-Stimmanteil (%)') 
  #ggtitle('Folketingswahl 2015 - Dänemark')
ggsave("../zgfx/DK_Folketing_wb.tif", dpi = 300, device = "tiff")

corr_dk2 <- round(cor(corr_df$diff_turnout,corr_df$diff_DF),2)

p_dk2 <- ggplot(dk_df, aes(x = diff_turnout, y = diff_DF)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_dk2)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz DF-Stimmanteil (%)') 
  #ggtitle('Folketingswahl 2015 - Dänemark')
ggsave("../zgfx/DK_Folketing_diff.tif", dpi = 300, device = "tiff")

