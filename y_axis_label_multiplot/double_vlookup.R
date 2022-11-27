# Two column V lookup in R
# author @ Rahul Venugopal on 14th November 2022
# Script will take a 3 column csv called lookup and
# match first two columns against to_fill.csv and fill up
# the DTOrderID column value to to_fill.csv

# Update
# Add NA if no match
# Will work even if there are more than one matches

# Load libraries
library(tidyverse)

# load data
lookup <- read.csv("lookup.csv", header = TRUE)
filler <- read_csv('to_fill.csv')

# initialise a new vector
outputter <- c()

# Let us iterate through each rows of filler
for (rows in 1:nrow(filler))
{
  to_add <- lookup %>% filter(Asset == filler$Asset[rows]) %>%
    filter(Side == filler$Side[rows]) %>%
      select(DTOrderID)
  
  if (nrow(to_add) == 0) {
    outputter <- c(outputter, 'NA')
  } else {
    outputter <- c(outputter, to_add[[1]][1])
  }

}

filler$output <- outputter

write_csv(filler, "results.csv")
