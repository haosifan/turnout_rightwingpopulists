#############################################
##### Grafiken DE ###########################
#############################################


source("datenaufbereitung.R")
library(ggplot2)
library(ggthemes)
library(gridExtra)
library(grid)

ep_abs <- ggplot(de_ep, aes(x = wahlbeteiligung, y=afd)) +
  geom_point(alpha = 0.7, color = 'gray25', size=2) +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed", size=1) +
  scale_y_continuous(limits = c(0,15)) +
  theme_minimal() + scale_color_economist() + 
  xlab('Wahlbeteiligung (%)') + ylab('AfD-Stimmanteil (%)') +
  #ggtitle('Europawahl 2014')
ggsave("../zgfx/DE_EP2014_wb.tif", dpi = 300, device = "tiff")

ep_diff <- ggplot(de_ep, aes(x = diff_turnout, y=afd)) +
  geom_point(alpha = 0.7, color = 'gray25', size=2) +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed", size=1) +
  scale_y_continuous(limits = c(0,15)) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung zur Vorwahl (%)') + ylab('AfD-Stimmenanteil (%)') +
  #ggtitle('Europawahl 2014')
ggsave("../zgfx/DE_EP2014_diff.tif", dpi = 300, device = "tiff")


bt_abs <- ggplot(de_bt, aes(x = wahlbeteiligung, y=afd)) +
  geom_point(alpha = 0.7, color = 'gray25', size=2) +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed", size=1) +
  scale_y_continuous(limits = c(0,10)) +
  theme_minimal() + scale_color_economist() + 
  xlab('Wahlbeteiligung (%)') + ylab('AfD-Stimmanteil (%)') +
  #ggtitle('Bundestagswahl 2013')
ggsave("../zgfx/DE_BT2013_wb.tif", dpi = 300, device = "tiff")

bt_diff <- ggplot(de_bt, aes(x = diff_turnout, y=afd)) +
  geom_point(alpha = 0.7, color = 'gray25', size=2) +
  geom_smooth(method = 'lm', se = F, color = 'black', show.legend = F, linetype="dashed", size=1) +
  scale_y_continuous(limits = c(0,10)) +
  theme_minimal() + scale_color_economist() + 
  xlab('Differenz in der Wahlbeteiligung zur Vorwahl (%)') + ylab('AfD-Stimmenanteil (%)') +
  #ggtitle('Bundestagswahl 2013')
ggsave("../zgfx/DE_BT2013_diff.tif", dpi = 300, device = "tiff")


### GridArrange

p_ep <- grid.arrange(ep_abs,ep_diff, ncol=2, top = textGrob("Europawahl 2014", gp = gpar(fontface="bold")))
p_bt <- grid.arrange(bt_abs,bt_diff, ncol=2, top = textGrob("Bundestagswahl 2013", gp = gpar(fontface="bold")))
p_de <- grid.arrange(p_bt,p_ep,nrow=2)
ggsave(p_de, filename = "../zgfx/DE_pub.tif", dpi = 300, device = "tiff", width = 12, height = 9)


