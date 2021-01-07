# Preliminary summary of Dream Survey

# Loading libraries
library(tidyverse)
library(likert)

# Loading data
data_original <- read.csv('Dream.csv')

# Participants from various countries
data <- select(data_original, 5)

# Rename column
names(data)[1] <- "Country"
# Making variable a factor
data$Country <- as.factor(data$Country)
# This is done to rename India. to India
levels(data$Country)[18] <- "India"

# visualisation as a barplot
ggplot(data,
       aes(y =Country, fill = Country)) + 
  geom_bar() + 
  theme_bw() +
  theme(legend.position = "none") + 
  geom_text(stat='count', aes(label = after_stat(count)), hjust=-0.2)

ggsave("country_part.tiff",
       width = 33, height = 18, units = c("cm"),
       device = "pdf", dpi = 300)