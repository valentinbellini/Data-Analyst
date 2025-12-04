# install.packages("tidyverse") # nolint
library(tidyverse)
library(ggplot2)

data(mtcars)

# Tidyverse handle the DF as inmutable so we assign to a new variable
# Add a column to km/L instead of mpg
mtcars_kml <- mutate(mtcars, kml = mpg * 0.425143707)
mtcars_tibble <- as_tibble(mtcars_kml)
