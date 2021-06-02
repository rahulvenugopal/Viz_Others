# Draw connecting lines between paired points
# The lines are colored based on their slope
# A thicker line connects mean values
# Mean value, sample size are annotated
# Author @ Rahul Venugopal on 08.04.2021

# Loading libraries
library(tidyverse)
library(magrittr)
library(EnvStats)
library(ggtext)
library(patchwork)

# Load data
my_data <- read_csv("PSS_CG.csv")

# Creating a new variable called slope
my_data <- my_data %>%
  tidyr::spread(Condition, Perceived_Stress_Scale) %>%
  dplyr::mutate(slope = Post > Pre) %>%
  tidyr::gather("Condition", "Perceived_Stress_Scale", 2:3) 

my_data$Condition <- factor(my_data$Condition, levels = c("Pre","Post"))
# Calculating the mean of each group to annotate
mean_data <- my_data %>% group_by(Condition) %>%
  summarize(mean_cond = round(mean(Perceived_Stress_Scale),2)) %>% 
  .$mean_cond

# Visualisation
control_group <- ggplot(my_data,
       aes(x = Condition, y = Perceived_Stress_Scale)) + # Setup x and y axis
  
  geom_boxplot(width = 0.25) + # Draw default boxplot first
  
  geom_point(alpha = 1, size = 2) + # Adding points and coloring them
  
  geom_line(aes(group = Group_CG, col = slope), alpha = 0.8, linetype = 1) + 
  # Connection lines

  # Drawing two dots which are group means and a connection line  
  stat_summary(fun.y=mean, color = "#880000", geom="line",linetype = 1, aes(group=1), size = 2, alpha = 0.5) + 
  stat_summary(fun.y=mean, color = "#880000", geom="point", size = 2, alpha = 1, aes(group=1)) + 
  
  # Control dot colors and slope colors  
  # Group 1, Group 2 - dots and lines in that order
  scale_colour_manual(values = c("#407E93","#CD6F3B")) + 
  
  # Add n number above x axis
  stat_n_text(size= 4,
              color = "grey18",
              text.box = TRUE) + 
  
  # Labels
  labs(x = "Pre and Post Conditions", y = "Perceived Stress Scores") + 
  
  # Theming
  theme_wsj() + 
  
  theme(plot.title = ggtext::element_markdown(size=12)) + 
  
  labs(title = 'Perceived stress <i style="color:#CD6F3B;">increase</i> or <i style="color:#407E93;">decrease</i> in control group') + 
  
  # Annotate means. Control the location using x and y
  annotate("text", label = paste("Mean == ",mean_data[1]),
           size = 3, x = 0.65, y = mean_data[1], parse =TRUE) + 
  annotate("text", label = paste("Mean == ",mean_data[2]),
           size = 3, x = 2.35, y = mean_data[2], parse = TRUE) + 
  
  # Remove all legends for clean look
  theme(legend.position = "none") + 
  
  coord_cartesian(clip = "off") + 
  theme(plot.title.position = "plot") + 
  theme(plot.margin = margin(t = 25, r = 25, b = 10, l = 25))

################################################################################

# Load data
my_data <- read_csv("PSS_SG.csv")

# Creating a new variable called slope
my_data <- my_data %>%
  tidyr::spread(Condition, Perceived_Stress_Scale) %>%
  dplyr::mutate(slope = Post > Pre) %>%
  tidyr::gather("Condition", "Perceived_Stress_Scale", 2:3) 

my_data$Condition <- factor(my_data$Condition, levels = c("Pre","Post"))
# Calculating the mean of each group to annotate
mean_data <- my_data %>% group_by(Condition) %>%
  summarize(mean_cond = round(mean(Perceived_Stress_Scale),2)) %>% 
  .$mean_cond

# Visualisation
study_group <- ggplot(my_data,
                        aes(x = Condition, y = Perceived_Stress_Scale)) + # Setup x and y axis
  
  geom_boxplot(width = 0.25) + # Draw default boxplot first
  
  geom_point(alpha = 1, size = 2) + # Adding points and coloring them
  
  geom_line(aes(group = Group_SG, col = slope), alpha = 0.8, linetype = 1) + 
  # Connection lines
  
  # Drawing two dots which are group means and a connection line  
  stat_summary(fun.y=mean, color = "#880000", geom="line",linetype = 1, aes(group=1), size = 2, alpha = 0.5) + 
  stat_summary(fun.y=mean, color = "#880000", geom="point", size = 2, alpha = 1, aes(group=1)) + 
  
  # Control dot colors and slope colors  
  # Group 1, Group 2 - dots and lines in that order
  scale_colour_manual(values = c("#407E93","#CD6F3B")) + 
  
  # Add n number above x axis
  stat_n_text(size= 4,
              color = "grey18",
              text.box = TRUE) + 
  
  # Labels
  labs(x = "Pre and Post Conditions", y = "Perceived Stress Scores") + 
  
  # Theming
  theme_wsj() + 
  
  theme(plot.title = ggtext::element_markdown(size=12)) + 
  
  labs(title = 'Perceived stress <i style="color:#CD6F3B;">increase</i> or <i style="color:#407E93;">decrease</i> in study group') + 
  
  # Annotate means. Control the location using x and y
  annotate("text", label = paste("Mean == ",mean_data[1]),
           size = 3, x = 0.65, y = mean_data[1], parse =TRUE) + 
  annotate("text", label = paste("Mean == ",mean_data[2]),
           size = 3, x = 2.35, y = mean_data[2], parse = TRUE) + 
  
  # Remove all legends for clean look
  theme(legend.position = "none") + 
  
  coord_cartesian(clip = "off") + 
  theme(plot.title.position = "plot") + 
  theme(plot.margin = margin(t = 25, r = 25, b = 10, l = 25))

control_group + study_group
ggsave("paired_plot.jpeg", dpi = 300, width = 12, height = 6)
