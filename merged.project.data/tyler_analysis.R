rm(list = ls()) # Clear environment
gc()            # Clear memory
cat("\f")       # Clear console

install.packages("tidyverse")
install.packages("readxl")

library(tidyverse)
library(readxl)
library(dplyr)

# city data

cities <- read.csv("project.cities.csv")

citySales <- data.frame(cities %>%
  filter(Table.Name == "project.sales.cities.csv") %>%
  group_by(city)%>%
  summarize(sum(sale.dollars)))

cityPopulation <- cities %>%
  filter(Table.Name == "project.acs.cities.csv") %>%
  group_by(city) %>%
  summarize(population)


salesPopulation <-
  citySales %>% right_join(cityPopulation)

percapitaSales <- salesPopulation %>%
  mutate(perCapitaSales = sum.sale.dollars./population)

write.csv(percapitaSales, "C:/Users/rtyle/OneDrive/Documents/GitHub/Team_1/merged.project.data/cities_percapita_sales.csv")

# county data

counties <- read.csv("project.counties.csv")


countySales <- data.frame(counties %>%
                          filter(Table.Name == "project.sales.counties.csv") %>%
                          group_by(county)%>%
                          summarize(sum(sale.dollars)))


countyPopulation <- counties %>%
  filter(Table.Name == "project.acs.counties.csv") %>%
  group_by(county) %>%
  summarize(population)


countySalesPopulation <-
  countySales %>% right_join(countyPopulation)

countyPercapitaSales <- countySalesPopulation %>%
  mutate(perCapitaSales = sum.sale.dollars./population)

write.csv(countyPercapitaSales, "C:/Users/rtyle/OneDrive/Documents/GitHub/Team_1/merged.project.data/counties_percapita_sales.csv")


# zip code data

zipCodes <- read.csv("project.zipcodes.csv")


zipCodesales <- data.frame(zipCodes %>%
                            filter(Table.Name == "project.sales.zipcodes.csv") %>%
                            group_by(zipcode)%>%
                            summarize(sum(sale.dollars)))

zipCodePopulation <- zipCodes %>%
  filter(Table.Name == "project.acs.zipcodes.csv") %>%
  group_by(zipcode) %>%
  summarize(population)


zipCodeSalesPopulation <-
  zipCodesales %>% right_join(zipCodePopulation)

zipCodePercapitaSales <- zipCodeSalesPopulation %>%
  mutate(perCapitaSales = sum.sale.dollars./population)

write.csv(zipCodePercapitaSales, "C:/Users/rtyle/OneDrive/Documents/GitHub/Team_1/merged.project.data/zipcode_percapita_sales.csv")
