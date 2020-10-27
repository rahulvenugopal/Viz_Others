# Loading libraries
library(tidyverse)

# Loading data
data <- read_csv("data.csv")
# Quick summary
str(data)
# Columns names
colnames(data)

# Converting some columns into factors
data[, 1:6] <- lapply(data[, 1:6], as.factor)

# Visualisation
ggplot(data, aes (x = Zeitgeber_Time, y = Sleep,
                  colour=interaction(Group,Intervention,Recording_Time_Point,Phase, sep="-",lex.order=TRUE))) + 
  facet_wrap(~Phase) + 
  geom_point() + 
  labs(colour="Groups") + 
  scale_color_brewer(palette="Set2")

# Trying shadow skirt
ggplot(data, aes(x = Zeitgeber_Time, y = Sleep,
                 group = 1)) + 
  stat_summary(geom="ribbon", fun.data=mean_cl_normal, 
               fun.args=list(conf.int = 0.68), fill = "lightblue", alpha = 0.3) +
  stat_summary(geom = "line", fun = mean, linetype = "dashed") +
  stat_summary(geom = "point", fun = mean, color = "red")
###############################################################################
geom_rect(data=NULL,aes(xmin=0.25, xmax=7.25, ymin=-Inf, ymax=Inf),
          fill="lightgreen") +
  geom_rect(data=NULL,aes(xmin=7.25, xmax=8.75, ymin=-Inf, ymax=Inf),
            fill="darkgreen")


# Visualisation
ggplot(data, aes (x = Zeitgeber_Time, y = Sleep,
                  colour=interaction(Group,Intervention,Recording_Time_Point,Phase, sep="-",lex.order=TRUE))) + 
  geom_point() + 
  labs(colour="Groups") +

  theme_light()