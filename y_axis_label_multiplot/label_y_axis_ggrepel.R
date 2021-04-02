# Author @ Rahul Venugopal

# loading libraries
library(dplyr)
library(ggplot2)
library(ggpubr)
library(patchwork)
library(grid)
library(ggrepel)

# Load data
data <- read.csv('demo.csv',check.names = FALSE)
data$Product <- as.factor(data$Product)
data$Month <- factor(data$Month, levels = c("Jan", "Feb", "Mar"))

# Generating a sample plot to extract labels and keep
temporary <- ggplot(data,
                    aes(x= Month, y=Tickets, color=Product, group = Product)) + geom_point() + geom_line() + 
  scale_y_continuous(breaks = seq(0, 20, by = 1),
                     limits = c(0,20)) + 
  theme_pubclean() 

# Extract legend
leg <- get_legend(temporary)
legend_plot <- as_ggplot(leg)

# Side by side plots
p1 <- ggplot(data,
             aes(x= Month, y=Tickets, color=Product, group = Product)) + geom_point() + geom_line() + 
  scale_y_continuous(breaks = seq(0, 20, by = 1),
                     limits = c(0,20)) + 
  theme_pubclean() + theme(legend.position = "none") 


p2 <- ggplot(data,
             aes(x= Month, y=Resolved, color=Product, group = Product)) + geom_point() + geom_line() + 
  scale_y_continuous(breaks = seq(0, 20, by = 1),
                     limits = c(0,20)) + 
  theme_pubclean() + theme(legend.position = "none") 

p1+p2-legend_plot + plot_layout(ncol=1)

ggsave("all_in_one.jpeg",width = 9, height = 6, dpi = 600)

# https://patchwork.data-imaginist.com/articles/guides/layout.html
# https://www.datanovia.com/en/blog/ggplot-multiple-plots-made-ridiculuous-simple-using-patchwork-r-package/


# Plotting two graphs from different dataset in same panel
# Visually not so pleasing
data_subset <- data %>% filter(Month == "Mar")
p5 <- ggplot() + 
  geom_line(data,mapping=aes(x= Month, y=Tickets, color=Product, group = Product)) +  
  geom_point(data,mapping=aes(x = Month, y = Resolved, color = Product, group = Product), size = 3) + 
  
  geom_text(data_subset,mapping = aes(label = Product, colour = Product, x = Inf, y = Tickets), hjust = -.1) +
  scale_colour_discrete(guide = 'none')  +    
  theme(plot.margin = unit(c(1,12,1,1), "lines")) +
  
  scale_y_continuous(breaks = seq(0, 20, by = 1),
                     limits = c(0,20))

gt <- ggplotGrob(p5)
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)


ggsave("ggtext_plot.jpeg",width = 8, height = 6, dpi = 600)

# Better method for above plot
data_subset <- data %>% filter(Month == "Mar")
data_subset <- data_subset %>% mutate(label = as.character(Product), NA_character_)
p6 <- ggplot() + 
  geom_line(data,mapping=aes(x= Month, y=Tickets, color=Product, group = Product)) +
  scale_y_continuous(breaks = seq(0, 20, by = 1),
                     limits = c(0,20)) + 
  
  geom_label_repel(data_subset, mapping = aes(x = Month, y = Tickets, label=label, color=Product),
                   nudge_x = 0.15,
                   na.rm = TRUE) +
  theme_pubclean()

ggsave("ggtext_plot.jpeg",width = 8, height = 6, dpi = 600)
# https://stackoverflow.com/questions/29357612/plot-labels-at-ends-of-lines

# A cleaned version where labels can be shown at the end of y value
data_subset <- data %>% filter(Month == "Mar")
data_subset <- data_subset %>% mutate(label = as.character(Product), NA_character_)
p7 <- ggplot(data,
             aes(x= Month, y=Tickets, color=Product, group = Product)) + geom_point() + geom_line() + 
  scale_y_continuous(breaks = seq(0, 20, by = 1),
                     limits = c(0,20)) + 
  theme_pubclean() + theme(legend.position = "none") + 
  geom_label_repel(data_subset, mapping = aes(x = Month, y = Tickets, label=label, color=Product),
                   nudge_x = 0.1,
                   na.rm = TRUE) +
  theme(plot.margin = margin(t = 25, r = 25, b = 10, l = 25)) + 
  # custom labels
  labs(title = 'Number of tickets reported from different 
       <i style="color:#D33534;">**countries**</i> across <i style="color:#D33534;">**three months**</i>') +
  theme(plot.title = ggtext::element_markdown()) + 
  theme(plot.title.position = "plot")

ggsave("ggtext_plot_single.jpeg",width = 12, height = 8, dpi = 600)
