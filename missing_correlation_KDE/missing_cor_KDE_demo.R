# Demo scripts to demonstrate following things
# Descriptive stats
# Missing data summary
# Theming
# Title, subtitle, foot note etc
# Test for normality
# Density plot
# Robust correlations

# Load libraries
library(dplyr)
library(ggplot2)
library(psych)
library(naniar)
library(ggpubr)
library(car)
library(WRS2)
library(ggtext)
library(see)
library(naniar)

library(palmerpenguins)
library(gt)

# Load data
data <- read.csv("sample_data.csv")

# Descriptive stats
describe(data) #Risky if categorical variables are there

# Find the missing data
# https://cran.microsoft.com/snapshot/2017-12-15/web/packages/naniar/vignettes/naniar-visualisation.html

gg_miss_var(data) + 
  labs(y = "Look at all the missing ones") + 
  theme_radar()

vis_miss(data)
vis_miss(airquality)

gg_miss_var(airquality) + labs(y = "Look at all the missing ones")

gg_miss_var(airquality,
            facet = Month)

gg_miss_case(airquality)

data %>% miss_var_summary()

# Check normality and homogeneity of variation
# Basic qqplot
ggqqplot(data$bill_length_mm, color = "steelblue")
ggqqplot(data$bill_depth_mm, color = "steelblue")

# Shapiro-Wilk's method
# If the p-value 0.05, we can assume the normality
shapiro.test(data$bill_length_mm)
shapiro.test(data$bill_depth_mm)

# Pick Levene or Bartlett test based on normality
bartlett.test(weight ~ group, data = PlantGrowth)
leveneTest(weight ~ group, data = PlantGrowth)
fligner.test(weight ~ group, data = PlantGrowth)

# Setup a theme
theme_update(
  axis.ticks = element_line(color = "grey92"),
  axis.ticks.length = unit(1, "lines"),
  panel.grid.minor = element_blank(),
  legend.title = element_text(size = 12),
  legend.text = element_text(color = "grey30"),
  axis.text.x = element_text(color = "grey20", size = 12),
  axis.text.y = element_text(color = "grey20", size = 12),
  plot.title = element_text(size = 18, face = "bold"),
  plot.subtitle = element_text(size = 12, color = "grey30"),
  plot.caption = element_text(size = 9, margin = margin(t = 15))
)

# Basic density plots
# https://jakevdp.github.io/PythonDataScienceHandbook/05.13-kernel-density-estimation.html
ggplot(data, aes(x = bill_length_mm)) + 
  geom_density(fill = "lightblue") + 
  geom_vline(aes(xintercept = mean(bill_length_mm)),
             color = "red", linetype = "dashed", size = 0.5) + 
  annotate("text", label = "Mean",
           x = mean(data$bill_length_mm) - 0.5, y =  0.02, color = "red") + 
  geom_vline(aes(xintercept = median(bill_length_mm)),
             color = "darkblue", linetype = "dashed", size = 0.5) + 
  annotate("text", label = "Median",
             x = median(data$bill_length_mm) + 0.7, y =  0.02, color = "darkblue") + 
  theme_gray() + 
  
  # custom labels
  labs(
    title = '<b style="color:#0A9B9C;">Kernel Density Estimate</b>',
    # Use i above for italics
    subtitle = 'Write a small subtitle here',
    caption = 'Data: Scholar | PhD work',
    x = 'Write x-axis title here ', 
    y = 'KDE (Probability density function)'
  ) + 
  
  theme(
    plot.title = ggtext::element_markdown(),
    plot.caption = ggtext::element_markdown(),
    axis.title.x = ggtext::element_markdown(),
    axis.title.y = ggtext::element_markdown()
  )

ggsave("KDE.jpeg",width = 8, height = 6, dpi = 300)

# Robust correlations with scatter plot with annotation
# Compute percent bend correlation
cor_values <- pbcor(data$bill_length_mm, data$bill_depth_mm,
                    beta = 0.1, ci = TRUE, nboot = 5000)
# Get the texts ready
corr_value = paste('r value  ',as.character(round(cor_values[[1]],digits=2)))
p_value = paste('p value  ',as.character(round(cor_values[[3]], digits=2)))
ci_cor = paste('95% CI ',paste(as.character(round(cor_values[[5]], digits = 4)),
                               collapse = " - "))
to_be_pasted_as_title = paste(corr_value, p_value, ci_cor, sep="\n")

# Viz
ggplot(data, aes(x=bill_length_mm, y=bill_depth_mm)) +
  geom_point(color="steelblue") +
  geom_rug(color = "indianred") + 
  geom_smooth(method=lm,
              color = "grey70",
              fill = "grey80") + 
  ggtitle(to_be_pasted_as_title) + 
  labs(
    subtitle = 'Write a small sumamry here',
    caption = 'Data: Scholar | PhD work',
    x = 'Write x-axis title here ', 
    y = 'Write y-axis title here)'
  )

ggsave("correlation_plot_new.jpeg",width = 6, height = 6, dpi = 300)

# Get a cool summary table ------------------------------------------------

gt_plt_summary(penguins)
