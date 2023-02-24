rm(list = ls()) # Clear environment
gc()            # Clear memory
cat("\f")       # Clear console

install.packages("tidyverse")
install.packages("ggplot2")
install.packages("plotly")
install.packages("GGally")

library("tidyverse")
library("ggplot2")
library("plotly")
library("GGally")

cities.acs <- read.csv("project.acs.cities.csv")
cities.sales <- read.csv("project.sales.cities.csv")
cities <- merge(x=cities.acs, y=cities.sales, by="city")

counties.acs <- read.csv("project.acs.counties.csv")
counties.sales <- read.csv("project.sales.counties.csv")
counties <- merge(x=counties.acs, y=counties.sales, by="county")

zipcode.acs <- read.csv("project.acs.zipcodes.csv")
zipcode.sales <- read.csv("project.sales.zipcodes.csv")
zipcode <- merge(x=zipcode.acs, y=zipcode.sales, by="zipcode")

# Creating per capita variables for the datasets
cities$sale.dollars.capita <- cities$sale.dollars/cities$population
cities$sale.volume.capita <- cities$sale.volume/cities$population

counties$sale.dollars.capita <- counties$sale.dollars/counties$population
counties$sale.volume.capita <- counties$sale.volume/counties$population

zipcode$sale.dollars.capita <- zipcode$sale.dollars/zipcode$population
zipcode$sale.volume.capita <- zipcode$sale.volume/zipcode$population

write.csv(cities, "project.cities.merged.csv")
write.csv(counties, "project.countie.merged.csv")
write.csv(zipcode, "project.zipcode.merged.csv")
