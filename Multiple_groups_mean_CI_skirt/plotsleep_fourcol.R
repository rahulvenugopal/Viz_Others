# This script is to visualise Group vs Intervention effects on sleep
# Normal control is NC
# Ventral Subicular Lesion is VSL
# NPR and SPR are two treatment variations of photoperiods
# Two timelines of recording periods - Baseline and post-exposure
# Zeitgeber_Time is 24 hours as factors
# Author @ Rahul Venugopal

# Loading libraries
library(tidyverse)
library(patchwork)
library(ggtext)

# Loading data
data <- read.csv('sleepdata.csv')
head(data)

# Converting all columns as factors except the Sleep variable
data[, 1:5] <- lapply(data[, 1:5], as.factor)
str(data)

# Creating 4 plots capturing four conditions
# VC vs VSL coded by BLUE vs RED respectively
# NPR vs SPR coded by Dark vs Light Shades respectively
# BL vs PE coded by Continuous vs Dotted line respectively

# These are picked up based on alphabetical order of factors
# In linetype, straight is picked up first followed by dotted
# Refer legends if confused

# p1 - VC-NPR BL vs PE - Top Left quadrant
# p2 - VC-SPR BL vs PE - Top Right quadrant
# p3 - VSL-NPR BL vs PE - Bottom Left quadrant
# p4 - VSL-SPR BL vs PE - Bottom Right quadrant 

# Initialising a list to catch plots from loop
plot_list = list()

# Creating annotations to be used later to add text onto plot
text2annottate <- c("VC - NPR", "VC - SPR", "VSL - NPR", "VSL - SPR")

# Let the plot unfold!
for (loop in 1:4){ 
  
  plotname <- paste("plot_",loop, sep = "") 
  
  # Setting color palette - BLUE and its shade, RED and its shade
  color_select <- c('#0047ab',"#99ccff", "#ff3232","indianred")
  
  # Filtering data to plot each condition
  if (loop == 1) { 
    data_plot <- data %>% filter(Group == 'VC' & Intervention == 'NPR')
  } else if (loop == 2) {
    data_plot <- data %>% filter(Group == 'VC' & Intervention == 'SPR')
  } else if (loop == 3) {
    data_plot <- data %>% filter(Group == 'VSL' & Intervention == 'NPR')
  } else if (loop == 4){
    data_plot <- data %>% filter(Group == 'VSL' & Intervention == 'SPR')
  }
  
  # ggplot2 and family
  plotname <- ggplot(data_plot, aes(x = Zeitgeber_Time, y = Sleep,
                                    group = Recording_Time_Point)) + 
    
    # Setting ylim based on max value of all
    ylim(0,4000) + 

    # Line plot connecting 24 means
    stat_summary(geom = "line", fun = mean, aes(linetype = Recording_Time_Point),
                 size = 1,
                 color = color_select[loop]) +
    
    # Adding a dot at each of those 24 points
    stat_summary(geom = "point", fun = mean, size = 1) +
    
    # Changing name of legend since Recording_time_Point is too long a word
    labs(linetype = "Timeline",
         x = "Zeitgeber Time (hrs)",
         y = "Sleep (units)") + 
    
    # Custom theme settings
    theme(legend.position = c(1,1), #Legend on top right inside plot
          legend.justification = c(1, 1),
          
          # Coloring axis labels based on group color
          axis.title = element_text(color = color_select[loop]),
          legend.direction = "horizontal") + # Legend in a single row

    # Adding a shadow skirt around mean which captures standard error
    stat_summary(geom ="ribbon", fun.data = mean_cl_normal, 
                 fun.args = list(conf.int = 0.68), #change conf.int to reflect CI/SD
                 alpha = 0.2, # Controls the shadowness of skirt
                 show.legend = FALSE) + # Masking the second legend
    
    # Adding text to plot
    geom_text(aes(x = -Inf,
                  y = Inf,
                  hjust = -0.1, # Tweak this to control horizontal alignment
                  vjust = 1.3), # Tweak this to control vertical alignment
                  label = text2annottate[loop], # Pick label from initial list
                  color = color_select[loop], # Pick color based on group
              show.legend = FALSE, # Hide geom_text label
              size = 5, # Control size of text
              fontface = "bold") # Control type of fontface
    
  # Saving the plot object to list
  plot_list[[loop]] = plotname
}

# Patchwork to weave plots together
all_four <- plot_list[[1]] + plot_list[[2]] + plot_list[[3]] + plot_list[[4]]

# Saving the plot image
ggsave("all_four.jpg", dpi = 300,type = "cairo",
       height = 6, width = 10, units = "in")