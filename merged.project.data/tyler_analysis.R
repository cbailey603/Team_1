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

citySales <- data.frame(cities %>%
  filter(Table.Name == "project.sales.cities.csv") %>%
  group_by(city)%>%
  summarize(sum(sale.dollars)))

View(dataFrame2)

cityPopulation <- cities %>%
  filter(Table.Name == "project.acs.cities.csv") %>%
  group_by(city) %>%
  summarize(population)

view(population)

print(nrow(population))
print(nrow(dataFrame2))

salesPopulation <-
  citySales %>% right_join(cityPopulation)

percapitaSales <- salesPopulation %>%
  mutate(perCapitaSales = sum.sale.dollars./population)

View(percapitaSales)
str(dataFrame4)

write.csv(percapitaSales, "C:/Users/rtyle/OneDrive/Documents/GitHub/Team_1/merged.project.data/cities_percapita_sales.csv")

# county data

counties <- read.csv("project.counties.csv")
