#############################################
##### Grafiken CH ###########################
#############################################


source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)

corr_df <- ch_df[ch_df$t==1,]
corr_ch1 <- round(cor(corr_df$wb,corr_df$SVP, use = "complete.obs"),2)

p_ch1 <- ggplot(ch_df[ch_df$t==1,], aes(x = wb, y = SVP)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_ch1)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  theme(legend.position="bottom") +
  xlab('Wahlbeteiligung (%)') + ylab('SVP-Stimmanteil (%)') 
  #ggtitle('Nationalratswahlen 2015')
ggsave("../zgfx/AT_NAT_wb.tif", dpi = 300, device = "tiff")

corr_ch2 <- round(cor(corr_df$diff_turnout,corr_df$diff_svp, use = "complete.obs"),2)

p_ch2 <- ggplot(ch_df, aes(x = diff_turnout, y = diff_svp)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_ch2)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz SVP-Stimmanteil (%)') 
  #ggtitle('Nationalratswahlen 2015')
ggsave("../zgfx/CH_NAT_diff.tif", dpi = 300, device = "tiff")

