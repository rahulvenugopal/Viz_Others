# Script template from raincloud plot from Micah Allen and Team

# Loading libraries
library("plyr")
library("lattice")
library("ggplot2")
library("dplyr")
library("readr")
library("rmarkdown")
library("Rmisc")
library("devtools")
library("gghalves")
library(tidyverse)
library(see)
library(ggtext)

# Theming
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

# width and height variables for saved plots
w = 6
h = 4
# Define limits of y-axis
y_lim_min = 4
y_lim_max = 7.5

################### data goes here ###################
before = iris$Sepal.Length[1:50]
after = iris$Sepal.Length[51:100]
n <- length(before)
data <- data.frame(y = c(before, after),
                x = rep(c(1,2), each=n),
                id = factor(rep(1:n,2)))

# summary stats
score_mean_1 <- mean(data$y[1:50])
score_mean_2 <- mean(data$y[51:100])
score_median1 <- median(data$y[1:50])
score_median2 <- median(data$y[51:100])
score_sd_1 <- sd(data$y[1:50])
score_sd_2 <- sd(data$y[51:100])
score_se_1 <- score_sd_1/sqrt(n) #-> adjust your n
score_se_2 <- score_sd_2/sqrt(n) #-> adjust your n
score_ci_1 <- CI(data$y[1:50], ci = 0.95)
score_ci_2 <- CI(data$y[51:100], ci = 0.95)
#Create data frame with 2 rows and 7 columns containing the descriptives
group <- c("x", "z")

################### Change N number here ###################
N <- c(50, 50)

score_mean <- c(score_mean_1, score_mean_2)
score_median <- c(score_median1, score_median2)
sd <- c(score_sd_1, score_sd_2)
se <- c(score_se_1, score_se_2)
ci <- c((score_ci_1[1] - score_ci_1[3]), (score_ci_2[1] - score_ci_2[3]))
#Create the dataframe
summary_df <- data.frame(group, N, score_mean, score_median, sd, se, ci)

set.seed(321)
data$xj <- jitter(data$x, amount=.09)

# dataviz

################### custom set ###################
x_tick_means <- c(.87, 2.13)

f7 <- ggplot(data = data, aes(y = y)) +
  
  #Add geom_() objects
  geom_point(data = data %>% filter(x =="1"), aes(x = xj), color = 'dodgerblue', size = 1.5, 
             alpha = .6) +
  geom_point(data = data %>% filter(x =="2"), aes(x = xj), color = 'darkorange', size = 1.5, 
             alpha = .6) +
  geom_line(aes(x = xj, group = id), color = 'lightgray', alpha = .8) +
  
  geom_half_boxplot(
    data = data %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.28), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'dodgerblue') +
  
  geom_half_boxplot(
    data = data %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = .18), 
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2, 
    fill = 'darkorange') +
  
  geom_half_violin(
    data = data %>% filter(x=="1"),aes(x = x, y = y), position = position_nudge(x = -.3), 
    side = "l", fill = 'dodgerblue') +
  
  geom_half_violin(
    data = data %>% filter(x=="2"),aes(x = x, y = y), position = position_nudge(x = .3), 
    side = "r", fill = "darkorange") +
  
  geom_point(data = data %>% filter(x=="1"), aes(x = x, y = score_mean[1]), 
             position = position_nudge(x = -.13), color = "dodgerblue", alpha = .6, size = 1.5) +
  
  geom_errorbar(data = data %>% filter(x=="1"), aes(x = x, y = score_mean[1], 
                                                 ymin = score_mean[1]-ci[1], ymax = score_mean[1]+ci[1]), 
                position = position_nudge(-.13), 
                color = "dodgerblue", width = 0.05, size = 0.4, alpha = .6) + 
  
  geom_point(data = data %>% filter(x=="2"), aes(x = x, y = score_mean[2]), 
             position = position_nudge(x = .13), color = "darkorange", alpha = .6, size = 1.5)+ 
  
  geom_errorbar(data = data %>% filter(x=="2"), aes(x = x, y = score_mean[2], 
                                                 ymin = score_mean[2]-ci[2], 
                                                 ymax = score_mean[2]+ci[2]), position = position_nudge(.13), color = "darkorange", 
                width = 0.05, size = 0.4, alpha = .6) +
  
  #Add a line connecting the two means
  geom_line(data = summary_df, aes(x = x_tick_means, y = score_mean), color = 'darkblue', 
            size = 1) +
  
  #Define additional settings
  scale_x_continuous(breaks=c(1,2), labels=c("Before", "After"), limits=c(0, 3)) +
  xlab("Condition") + ylab("Value") +
  ggtitle('Figure 7: Repeated measures with box- and violin plots and means + ci ') +
  theme_classic()+
  coord_cartesian(ylim=c(y_lim_min, y_lim_max))

f8 <- f7 + 

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
data_plot_2 <- f8 +
  labs(title = 'Perceived stress scales between <i style="color:#BE3639;">Controls</i>')

# Alignments, white space around borders
data_plot_3 <- data_plot_2 + 
  theme(plot.title.position = "plot") + 
  theme(plot.margin = margin(t = 25, r = 25, b = 10, l = 25))

ggsave("Perceived_stress.jpeg", width = 9, height = 8, dpi = 300)
