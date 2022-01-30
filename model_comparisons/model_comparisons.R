# Compare different regression models and pick the best
# Visualise the model parameters
# @author Rahul Venugopal on 30th january, 2022

# Loading libraries
library(see)
library(performance)
library(jtools)
library(palmerpenguins)
library(tidyverse)

# load data
data <- penguins

# create three models
lm1 <- lm(body_mass_g ~ species, data = data)
lm2 <- lm(body_mass_g ~ species + flipper_length_mm, data = data)
lm3 <- lm(body_mass_g ~ species * flipper_length_mm, data = data)

# rank models so that top one is first, check out the performance score
comparison <- compare_performance(lm1, lm2, lm3, rank = TRUE)
comparison

plot(comparison)
ggsave('model_comaprisons_radar.png',
       dpi=300,
       width=6,
       height=6,
       units="in",
       type = 'cairo')

# Visualise various models
# Refer https://cran.r-project.org/web/packages/jtools/vignettes/summ.html#plot_summs_and_plot_coefs
# for detailed explanations and more options
plot_summs(lm1,lm2,lm3,
           scale = TRUE,
           model.names = c("Model1", "Model2", "Model3"))

ggsave('model_comaprisons.png',
       dpi=300,
       width=8,
       height=6,
       units="in",
       type = 'cairo')