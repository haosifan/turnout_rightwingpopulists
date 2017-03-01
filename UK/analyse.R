#############################################
##### Grafiken UK ###########################
#############################################

source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)

corr_df <- uk_df[uk_df$Election.Year==2015,]
corr_uk1 <- round(cor(corr_df$turnout,corr_df$UKIP, use = "complete.obs"),2)


p_uk1 <- ggplot(uk_df[uk_df$Election.Year==2015,], aes(x = turnout, y = UKIP)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_uk1)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Wahlbeteiligung (%)') + ylab('UKIP-Stimmanteil (%)') 
  #ggtitle('General Election UK')
ggsave("../zgfx/UK_GE2015_wb.tif", dpi = 300, device = "tiff")

corr_uk2 <- round(cor(corr_df$diff_turnout,corr_df$diff_ukip, use = "complete.obs"),2)

p_uk2 <- ggplot(uk_df, aes(x = diff_turnout, y = diff_ukip)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_uk2)),x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz UKIP-Stimmanteil (%)') 
  #ggtitle('General Election UK')
ggsave("../zgfx/UK_GE2015_diff.tif", dpi = 300, device = "tiff")