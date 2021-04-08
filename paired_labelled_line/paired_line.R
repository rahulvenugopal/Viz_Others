# Draw connecting lines between paired points
# The lines are colored based on their slope
# A thicker line connects mean values
# Mean value, sample size are annotated
# Author @ Rahul Venugopal on 08.04.2021

# Loading libraries
library(tidyverse)
library(magrittr)
library(EnvStats)

# Simulating a dataset from normal distribution
set.seed(1)

my_data <- data.frame(
  Accuracy = rnorm(10),
  Condition = rep(c("condition1", "condition2"), each = 5),
  Patient = rep(paste0("P", 1:5), times = 2)
)

my_data

# Creating a new variable called slope
my_data <- my_data %>%
  tidyr::spread(Condition, Accuracy) %>%
  dplyr::mutate(slope = condition2 > condition1) %>%
  tidyr::gather("Condition", "Accuracy", 2:3) 

# Calculating the mean of each group to annotate
mean_data <- my_data %>% group_by(Condition) %>% summarize(mean_cond = round(mean(Accuracy),2)) %>% 
  .$mean_cond

# Visualisation
  ggplot(my_data,
         aes(x = Condition, y = Accuracy)) + # Setup x and y axis
    
  geom_boxplot(width = 0.25) + # Draw default boxplot first
    
  geom_point(aes(color = Condition), alpha = 0.8, size = 1) + # Adding points and coloring them
    
  geom_line(aes(group = Patient, col = slope), alpha = 0.8, linetype = 2) + # Connection lines
  
  # Drawing two dots which are group means and a connection line  
  stat_summary(fun.y=mean, color = "#880000", geom="line",linetype = 1, aes(group=1), size = 1, alpha = 0.5) + 
  stat_summary(fun.y=mean, color = "#880000", geom="point", size = 2, alpha = 1, aes(group=1)) + 
  
  # Control dot colors and slope colors  
  # Group 1, Group 2 - dots and lines in that order
  scale_colour_manual(values = c("#007020", "#bc7a00","#bb6688","black")) + 
  
  # Add n number above x axis
  stat_n_text(size= 2.5,
              color = "steelblue",
              text.box = TRUE) + 
    
  # Labels
  labs(x = "Pre and Post Conditions", y = "Score") + 
  
  # Theming
  theme_grey() + 
  
  # Annotate means. Control the location using x and y
  annotate("text", label = paste("mu == ",mean_data[1]),
           size = 2.25, x = 0.75, y = mean_data[1], parse =TRUE) + 
  annotate("text", label = paste("mu == ",mean_data[2]),
           size = 2.25, x = 2.25, y = mean_data[2], parse = TRUE) + 
  
  # Remove all legends for clean look
  theme(legend.position = "none")

ggsave("paired_plot.jpeg", dpi = 300)

# Resources
# To extract color hexes from websites - https://www.colorcombos.com/