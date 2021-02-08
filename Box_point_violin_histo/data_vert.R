# Dataviz for continuous data
# Author @ Rahul Venugopal

# Loading libraries
library(tidyverse)
library(see)
library(ggtext)

# Reading data
data <- read.csv('8 feb 2021 Perceived_Stress.csv')

# Creating the four sub groups
data$all_combos <- interaction(data$Group, data$Order)

# Reordering the groups
data$all_combos <- factor(data$all_combos, levels = c("CG.pre","SG.pre","CG.post","SG.post"))

# change global theme settings (for all following plots)
theme_set(theme_minimal(base_size = 12, base_family = "Open Sans"))

# modify plot elements globally (for all following plots)
theme_update(
  axis.ticks = element_line(color = "grey92"),
  axis.ticks.length = unit(1, "lines"),
  panel.grid.minor = element_blank(),
  legend.title = element_text(size = 12),
  legend.text = element_text(color = "grey30"),
  axis.text.x = element_text(color = "grey20", size = 20),
  axis.text.y = element_text(color = "grey20", size = 20),
  plot.title = element_text(size = 18, face = "bold"),
  plot.subtitle = element_text(size = 12, color = "grey30"),
  plot.caption = element_text(size = 9, margin = margin(t = 15))
)

# dataviz
data_plot <- ggplot(data = data,
       aes(x= all_combos, y = Perceived_Stress_Scale, fill = all_combos)) + 
  
  geom_boxplot(width = 0.1,
               position = position_nudge(x = -0.3, y = 0),
               outlier.shape = 21,
               show.legend = FALSE) + 
  scale_fill_manual(values=c("#BE3639", "#0A9B9C", "#BE3639","#0A9B9C")) + 
  
  geom_violindot(size_dots = 8,
                 trim = FALSE,
                 show.legend = FALSE) +

# custom labels
  labs(
    title = 'Perceived stress scales between Control and Yoga group',
    subtitle = 'Data distribution, Median, Inter quartile range, Scatter plot',
    caption = 'Data: Scholar | PhD work',
    x = ' ', 
    y = 'Perceived Stress Scale'
  ) + 
  
  theme(
    plot.title = ggtext::element_markdown(),
    plot.caption = ggtext::element_markdown(),
    axis.title.x = ggtext::element_markdown(),
    axis.title.y = ggtext::element_markdown()
  )

# Adding color layer
data_plot_2 <- data_plot +
  labs(title = 'Perceived stress scales between <i style="color:#BE3639;">Controls</i> and <i style="color:#0A9B9C;">Yoga</i> group')

# Alignments, white space around borders
data_plot_3 <- data_plot_2 + 
  theme(plot.title.position = "plot") + 
  theme(plot.margin = margin(t = 25, r = 25, b = 10, l = 25))

ggsave("Perceived_stress.jpeg", width = 9, height = 8, dpi = 300)