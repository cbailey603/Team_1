rm(list = ls()) # Clear environment
gc()            # Clear memory
cat("\f")       # Clear console

install.packages("tidyverse")
install.packages("readxl")

library(tidyverse)
library(readxl)

getwd()
list.files()

cities <- read.csv("project.cities.csv")
str(cities)
cities$category

View(cities)

Altoona <- cities %>%
  filter(city == "Altoona")

View(Altoona)


perCapitaSales <- function(x, y , z){
  dataFrame <- data.frame(matrix(ncol = 3, nrow = length(x)))
  
  cities %>%
    filter(Table.Name == "project.sales.cities.csv") %>%
    group_by(x)%>%
    summarize(sum(sale.dollars))
  
  for (i in length(x)) {
    
    dataFrame[, 1] <- x
    dataFrame[, 2] <- z
    
      
  }
  
}
perCapitaSales(cities$city, cities$sale.dollars, cities$population)

# trying to combine population data and sales data. they have different number of rows and i have to filter by table name

dataFrame2 <- data.frame(cities %>%
  filter(Table.Name == "project.sales.cities.csv" | Table.Name == "project.acs.cities.csv") %>%
  group_by(city)%>%
  summarize(sum(sale.dollars)))

View(dataFrame2)

population <- cities %>%
  filter(Table.Name == "project.acs.cities.csv") %>%
  group_by(city) %>%
  summarize(population)

print(nrow(population))
print(nrow(dataFrame2))

dataFrame2 %>%
  mutate(population)
