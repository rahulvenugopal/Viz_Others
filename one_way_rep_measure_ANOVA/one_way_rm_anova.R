# One way repeated measure ANOVA
# Author @ Rahul Venugopal
# Code inspired from datanova tutorial

# Loading libraries
library(tidyverse)
library(ggpubr)
library(see)
library(ggtext)

# Test data load
data <- read_csv("One way ANOVA.csv")

# Converting character to factors
data$Time <- as.factor(data$Time)

# Renaming levels
levels(data$Time) <- c("PreRest","Chanting","PostRest")

# Summary stats
data %>%
  group_by(Time) %>%
  get_summary_stats(Mean_BPM, type = "mean_sd")

# Quick viz
boxing_plots <- ggboxplot(data, x = "Time", y = "Mean_BPM",
                 add = "point",
                 width = 0.3,
                 color = "Time",
                 xlab = " ",
                 ylab = "Time domain parameter",
                 palette =c("#00AFBB", "#E7B800", "#FC4E07"))

data_viz <- ggpar(boxing_plots, legend = "none", ylim = c(40,100))
# https://rpkgs.datanovia.com/ggpubr/reference/ggboxplot.html

# Outlier detection
data %>%
  group_by(Time) %>%
  identify_outliers(Mean_BPM)

# Check for normality
data %>%
  group_by(Time) %>%
  shapiro_test(Mean_BPM)
# Visual check for normality
ggqqplot(data, "Mean_BPM", facet.by = "Time")

one_way_rep_anova <- anova_test(data = data, dv = Mean_BPM, wid = id, within = Time)
get_anova_table(one_way_rep_anova)

# pairwise comparisons
# Read this paper - Why, When and How to Adjust Your P Values?
# Read this too - What is the proper way to apply the multiple comparison test?
pairwisetest <- data %>%
  pairwise_t_test(
    Mean_BPM ~ Time, paired = TRUE,
    p.adjust.method = "bonferroni"
  )
pairwisetest

# Visualization: box plots with p-values
pairwisetest <- pairwisetest %>% add_xy_position(x = "Time") %>% mutate(y.position = c(91, 98,94))

# Plot with stat stuff and colored texts
final_viz <- data_viz + 
  stat_pvalue_manual(pairwisetest, tip.length = 0.01) + # label = "p")
  labs(
    subtitle = get_test_label(one_way_rep_anova, detailed = TRUE),
    caption = get_pwc_label(pairwisetest)) + 
  
  theme(plot.title = ggtext::element_markdown()) + 
  # Courtesy Cedric Scherer Outlier conference
  theme(plot.title.position = 'plot') + 
  theme(plot.margin = margin(25, 25, 10, 25)) + 
  # Use <br> for line break
  # Adding image to title https://takehomessage.com/2019/12/18/r-package-ggtext/
  labs(title = 'Repeated measures of time domain parameter across
       <i/b style="color:#00AFBB;">**Pre Rest**</i> , <i style="color:#E7B800;">**Om Chanting**</i>
       and <i style="color:#FC4E07;">**Post Rest**</i>') 

ggsave("One way repeated ANOVA.jpeg",width = 9, height = 6, dpi = 600)

###############################################################################
# Resources and code which would be useful later
# https://www.datanovia.com/en/blog/how-to-add-p-values-onto-a-grouped-ggplot-using-the-ggpubr-r-package/
# https://rpkgs.datanovia.com/ggpubr/reference/stat_pvalue_manual.html
stat.test <- df %>%
  group_by(supp) %>%
  t_test(len ~ dose) %>%
  add_y_position() %>%
  add_x_position(x = "supp", dodge = 1)

# Plot
ggplot(df, aes(supp, len)) +
  geom_boxplot(aes(fill = dose), position = position_dodge(1)) + 
  theme_bw() + 
  stat_pvalue_manual(stat.test,   label = "p.adj.signif", tip.length = 0)
# https://github.com/kassambara/rstatix/issues/24