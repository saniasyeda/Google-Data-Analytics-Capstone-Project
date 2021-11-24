library(tidyverse)
library(janitor)
library(lubridate)
library(scales)
rm(list = ls())
dir("Data", full.names = T)
#Combined 12 data.frames in to (1) data.frame
df1 <- read.csv("~/Case Study/Capstone Project/Data/202004-divvy-tripdata.csv")
df2 <- read.csv("~/Case Study/Capstone Project/Data/202005-divvy-tripdata.csv")
df3 <- read.csv("~/Case Study/Capstone Project/Data/202006-divvy-tripdata.csv")
df4 <- read.csv("~/Case Study/Capstone Project/Data/202007-divvy-tripdata.csv")
df5 <- read.csv("~/Case Study/Capstone Project/Data/202008-divvy-tripdata.csv")
df6 <- read.csv("~/Case Study/Capstone Project/Data/202009-divvy-tripdata.csv")
df7 <- read.csv("~/Case Study/Capstone Project/Data/202010-divvy-tripdata.csv")
df8 <- read.csv("~/Case Study/Capstone Project/Data/202011-divvy-tripdata.csv")
df9 <- read.csv("~/Case Study/Capstone Project/Data/202012-divvy-tripdata.csv")
df10 <- read.csv("~/Case Study/Capstone Project/Data/202101-divvy-tripdata.csv")
df11 <- read.csv("~/Case Study/Capstone Project/Data/202102-divvy-tripdata.csv")
df12 <- read.csv("~/Case Study/Capstone Project/Data/202103-divvy-tripdata.csv")
# Converted Data/ Time stamp to Date/ Time
bike_rides <- rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12)
dim(bike_rides) # gives total available rows 
bike_rides <- janitor::remove_empty(bike_rides, which = c("cols")) # Removes blank space in Columns
bike_rides <- janitor::remove_empty(bike_rides, which = c("rows")) # Removes blank space in Rows
# Some data was in character format so it was changes to Time 
bike_rides$started_at <-lubridate::ymd_hms(bike_rides$started_at)
bike_rides$ended_at <- lubridate::ymd_hms(bike_rides$ended_at) 
bike_rides$start_hour <-lubridate::hour(bike_rides$started_at)  # Was created started Hour field
bike_rides$end_hour <-lubridate::hour(bike_rides$ended_at)      # Was created End Hour field
bike_rides$start_hour <- as.Date(bike_rides$started_at)
bike_rides$end_date <- as.Date(bike_rides$ended_at)

bike_rides %>% count(start_hour, sort = T) %>%      
  ggplot() + geom_line(aes(x = start_hour, y = n),linetype = "solid", color = "black") +
  scale_y_continuous(labels =  comma) +
  labs(title = "Count of bikes ride by hour: Previous 12 Months ", x= "Start Hour of Rides", y = "Count of Rides" )

