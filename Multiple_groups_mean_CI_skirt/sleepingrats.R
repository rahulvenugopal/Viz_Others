# Loading libraries
library(tidyverse)
library(Hmisc)
library(patchwork)

# Loading data
data <- read.csv('sleepdata.csv')

# Dropping first two columns
data <- select(data,-1,-2)

# Converting some columns into factors
data[, 1:5] <- lapply(data[, 1:5], as.factor)
str(data)

# Creating 4 plots capturing four conditions
# VS vs VSL coded by BLUE vs RED
# NPR vs SPR coded by Dark vs Light Shades
# p1 - VC-NPR BL vs PE
# p2 - VC-SPR BL vs PE
# p3 - VSL-NPR BL vs PE
# p4 - VSL-SPR BL vs PE

plot_list = list()

for (loop in 1:4){ 

  plotname <- paste("plot_",loop, sep = "") 
  color_select <- c("#264653", "#2A9D8F", "#E9C46A", "#E76F51")
  
  if (loop == 1) {
    data_plot <- data %>% filter(Group == 'VC' & Intervention == 'NPR')
    } else if (loop == 2) {
      data_plot <- data %>% filter(Group == 'VSL' & Intervention == 'NPR')
    } else if (loop == 3) {
      data_plot <- data %>% filter(Group == 'VC' & Intervention == 'SPR')
    } else if (loop == 4){
      data_plot <- data %>% filter(Group == 'VSL' & Intervention == 'SPR')
    }
  
  plotname <- ggplot(data_plot, aes(x = Zeitgeber_Time, y = Sleep,
                 group = Recording_Time_Point)) + 
  
  stat_summary(geom = "line", fun = mean, aes(linetype = Recording_Time_Point),
               color = color_select[loop]) +
  
  stat_summary(geom = "point", fun = mean, size = 0.5) +
  
  theme(legend.position = "none") +
  
  stat_summary(geom ="ribbon", fun.data = mean_cl_normal, 
               fun.args = list(conf.int = 0.68), aes(fill = Recording_Time_Point),
               alpha = 0.2)
  
  plot_list[[loop]] = plotname
}

all_four <- plot_list[[1]] + plot_list[[2]] + plot_list[[3]] + plot_list[[4]]

ggsave("all_four.jpg", dpi = 300,type = "cairo",
       height = 5, width = 10, units = "in")


# convert myGraphAsVector.pdf -density 300 myGraphAs300DpiBitmap.png
# https://github.com/robwschlegel/Intro_R_Workshop/blob/master/docs/08-mapping_style.md

