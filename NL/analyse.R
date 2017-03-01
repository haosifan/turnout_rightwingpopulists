#############################################
##### Grafiken NL ###########################
#############################################

source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)

corr_df <- nl_df[nl_df$t==1,]
corr_nl1 <- round(cor(corr_df$turnout,corr_df$PVV),2)

p_nl1 <- ggplot(nl_df[nl_df$t==1,], aes(x = turnout, y = PVV)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_nl1)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Wahlbeteiligung (%)') + ylab('PVV-Stimmanteil (%)') 
  #ggtitle('European Election NL')
ggsave("../zgfx/NL_EP2014_wb.tif", dpi = 300, device = "tiff")

corr_nl2 <- round(cor(corr_df$diff_turnout,corr_df$diff_pvv),2)

p_nl2 <- ggplot(nl_df, aes(x = diff_turnout, y = diff_pvv)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_nl2)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() +
  scale_y_continuous(limits = c(-13,8)) +
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz PVV-Stimmanteil (%)') 
  #ggtitle('European Election NL')
ggsave("../zgfx/NL_EP2014_diff.tif", dpi = 300, device = "tiff")