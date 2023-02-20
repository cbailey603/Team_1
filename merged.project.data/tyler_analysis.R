rm(list = ls()) # Clear environment
gc()            # Clear memory
cat("\f")       # Clear console

install.packages("tidyverse")
install.packages("readxl")

library(tidyverse)
library(readxl)
library(dplyr)

getwd()
list.files()

cities <- read.csv("project.cities.csv")


# trying to combine population data and sales data. they have different number of rows and i have to filter by table name

dataFrame2 <- data.frame(cities %>%
  filter(Table.Name == "project.sales.cities.csv") %>%
  group_by(city)%>%
  summarize(sum(sale.dollars)))

View(dataFrame2)

population <- cities %>%
  filter(Table.Name == "project.acs.cities.csv") %>%
  group_by(city) %>%
  summarize(population)

view(population)

print(nrow(population))
print(nrow(dataFrame2))

dataFrame3 <-
  dataFrame2 %>% right_join(population)

dataFrame4 <- dataFrame3 %>%
  mutate(perCapitaSales = sum.sale.dollars./population)

View(dataFrame4)

