# learn and do Empirical Cumulative Density Function plots
# author @ Rahul Venugopal on 20.12.2022

# Create a dummy dataset
set.seed(1234)
wdata = data.frame(
  sex = factor(rep(c("F", "M"), each=200)),
  weight = c(rnorm(200, 55), rnorm(200, 58))
)

# Load the libraries
library(ggtext)
library(tidyverse)

# Custom theming
# change global theme settings (for all following plots)
theme_set(theme_minimal(base_size = 12, base_family = "Open Sans"))

# modify plot elements globally (for all following plots)
theme_update(
  axis.ticks = element_line(color = "grey92"),
  axis.ticks.length = unit(0.25, "cm"),
  #legend.title = element_text(size = 10, face ="bold"),
  #legend.text = element_text(color = "grey30"),
  axis.text.x = element_text(color = "grey20", size = 8, face ="bold"),
  axis.text.y = element_text(color = "grey20", size = 8, face ="bold"),
  axis.title = element_text(color = "grey20", size = 12, face ="bold"),
  plot.title = ggtext::element_markdown(size = 12),
  plot.title.position = "plot",
  legend.position="none",
  plot.margin = margin(t = 25, r = 25, b = 25, l = 25))

# label the 50% value onto the plot
g1_50 <- wdata %>% filter(sex == 'F')
g2_50 <- wdata %>% filter(sex == 'M')

mid_g1 <- round(median(g1_50$weight),2)
mid_g2 <- round(median(g2_50$weight),2)

# Viz
ggplot(wdata, aes(x = weight, color = sex, group = sex)) +
  
  stat_ecdf(geom = "line", size = 0.75) +
  
  geom_hline(yintercept=0.5, linetype="dashed",
             size = 0.5, color = "steelblue", alpha = 1) + 
  
  scale_color_manual(values=c("#5B8070", "#C3663D")) +
  
  geom_label(aes(x = mid_g1, y = 0.5), label.size = 0.25,
             label = mid_g1, color = alpha("#5B8070", 0.50)) +
  
  geom_label(aes(x = mid_g2, y = 0.5), label.size = 0.25,
             label = mid_g2,color = alpha("#C3663D", 0.50)) +
  
  labs(y = " ",
       x = "Weight in kg",
       title = 'Weight distribution <i style="color:#C3663D;">Males</i> and <i style="color:#5B8070;">Females</i> groups')

# Saving the Viz
ggsave("ECDF.jpg",
       width = 8, height = 6,
       bg = 'white',
       dpi = 600)