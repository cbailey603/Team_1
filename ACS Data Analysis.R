# Wipe the environment clean
  rm(list = ls())
# Clean the console (in RStudio you can do the same by pressing Ctrl+L)
  cat("\f") 
  
# install tidyverse packages
  install.packages("tidyverse")
  install.packages("readxl")
  
  
  library(readxl)
  library(tidyverse)
  
  dir()
  getwd()
  list.files()
  # load data
  cities <- read_csv("project.acs.cities.csv")
  counties <- read_csv("project.acs.counties.csv")
  zipCodes <- read_csv("project.acs.zipcodes.csv")  
  

# function to determine what % of the total population a certain demographic is
percentOftotalPop <- function(x){
  demographic <- c(x)
  totalPop <- sum(cities$population, counties$population, zipCodes$population)
  totalDemoPop <- sum(cities[x], counties[x], zipCodes[x])
  return(totalDemoPop/totalPop)
}

# vector of all demographics
demographics <- (c("pop.white", "pop.black", "pop.indian", "pop.asian", "pop.hawai", "pop.other", "pop.multi"))

# function that calls percentOftotalPop for each demographic and stores results in a matrix
demographicPercentofTotal <- function(x){
  matrix <- matrix(ncol = 2, nrow = 7)
  
  for(i in 1:length(x)){
    matrix[i,2] = percentOftotalPop(x[i])
    matrix[i,1] = toupper(substring(x[i], 5))
  }
  return(matrix)
}

# create dataframe with demographic percentages
demographicDataFrame <- data.frame(demographicPercentofTotal(demographics))

# rename columns and convert to numeric
dataFrameColumnNames <- c("Race/Ethnicity", "Percent of Population" )
colnames(demographicDataFrame) = dataFrameColumnNames

# change percent of population colum to numeric
demographicDataFrame <- demographicDataFrame %>%
  mutate_at(c("Percent of Population"), as.numeric)  %>%
  mutate_if(is.numeric, round, 3) 
  #mutate_at(c("Percent of Population") * 100)

str(demographicDataFrame)
# plot pie chart

ggplot(demographicDataFrame, aes(x = "", y = `Percent of Population`, fill = `Race/Ethnicity`)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(x = NULL, y = NULL, fill = NULL)



# visualize distribution of income across counties

incomeByCounty <- counties %>%
  summarize(county, income)

ggplot(incomeByCounty, aes(x = income)) +
  geom_histogram()


# analysis on percent of population with at least a HS diploma or at least bachelors
educatedPopulation <- cities %>%
  summarize(high.school, bachelor, population) %>%
  mutate(popHS = ((high.school / 100)*population), popBach = ((bachelor / 100)*population)) %>%
  summarize(percentPopHS = (sum(popHS, na.rm = TRUE)/(sum(population))*100), percentPopBach = (sum(popBach, na.rm = TRUE)/sum(population))*100)
educatedPopulation


