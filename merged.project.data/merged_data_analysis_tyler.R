# Wipe the environment clean
rm(list = ls())
# Clean the console (in RStudio you can do the same by pressing Ctrl+L)
cat("\f") 

# install tidyverse packages
install.packages("tidyverse")
install.packages("readxl")

library(tidyverse)
library(readxl)

list.files()

cities <- vroom("project.zipcodes.csv", col_names = TRUE)
