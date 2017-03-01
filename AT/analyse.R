#############################################
##### Grafiken AT ###########################
#############################################


source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)

cor_df <- at_df[at_df$t==1,] 
corr_at1 <- round(cor(cor_df$p_Hofer,cor_df$turnout),2)

p_at1 <- ggplot(at_df[at_df$t==1,], aes(x = turnout, y = p_Hofer)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_at1)),
            x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  theme(legend.position="bottom") +
  xlab('Wahlbeteiligung (%)') + ylab('Hofer-Stimmanteil (%)') 
  #ggtitle('European Elections 2014 AT')
ggsave("../zgfx/AT_EP2014_wb.tif", dpi = 300, device = "tiff")

corr_at2 <- round(cor(cor_df$diff_turnout,cor_df$diff_hofer),2)

p_at2 <- ggplot(at_df, aes(x = diff_turnout, y = diff_hofer)) +
  geom_point(alpha = 0.7, size=2, color="gray25") +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed") +
  geom_text(aes(label=paste("Pearson R: ", corr_at2)),
            x=-Inf, y=Inf, hjust=-0.2, vjust=1.2) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung (%)') + ylab('Differenz Hofer-Stimmanteil (%)') 
  #ggtitle('European Elections 2014 AT')
ggsave("../zgfx/AT_EP2014_diff.tif", dpi = 300, device = "tiff")

