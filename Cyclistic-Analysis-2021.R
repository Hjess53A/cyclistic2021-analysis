# Install required packages
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data

#Data for 2021 Bike trips
jan_2021 <- read_csv("202101-divvy-tripdata.csv")
feb_2021 <- read_csv("202102-divvy-tripdata.csv")
mar_2021 <- read_csv("202103-divvy-tripdata.csv")
apr_2021 <- read_csv("202104-divvy-tripdata.csv")
may_2021 <- read_csv("202105-divvy-tripdata.csv")
jun_2021 <- read_csv("202106-divvy-tripdata.csv")
jul_2021 <- read_csv("202107-divvy-tripdata.csv")
aug_2021 <- read_csv("202108-divvy-tripdata.csv")
sep_2021 <- read_csv("202109-divvy-tripdata.csv")
oct_2021 <- read_csv("202110-divvy-tripdata.csv")
nov_2021 <- read_csv("202111-divvy-tripdata.csv")
dec_2021 <- read_csv("202112-divvy-tripdata.csv")

# Cleaning and Combining Data
# note:some cleaning have been done in excel
colnames(jan_2021)
colnames(feb_2021)
colnames(mar_2021)
colnames(apr_2021)
colnames(may_2021)
colnames(jun_2021)
colnames(jul_2021)
colnames(aug_2021)
colnames(sep_2021)
colnames(oct_2021)
colnames(nov_2021)
colnames(dec_2021)
# Columns are consistent throughout

# Inspecting the dataframes
str(jan_2021)
str(feb_2021)
str(mar_2021)
str(apr_2021)
str(may_2021)
str(jun_2021)
str(jul_2021)
str(aug_2021)
str(sep_2021)
str(oct_2021)
str(nov_2021)
str(dec_2021)


# Joining the Data frames
trips_2021 <- bind_rows(jan_2021, feb_2021, mar_2021, apr_2021, may_2021, jun_2021, jul_2021
                            , aug_2021, sep_2021, oct_2021, nov_2021, dec_2021)

#overview for trips_2021
summary(trips_2021)
colnames(trips_2021)
nrow(trips_2021)
dim(trips_2021)
head(trips_2021)
str(trips_2021)

# removing NAs
cleaned_trips_2021 <- drop_na(trips_2021)

# Analysis
# comparing ride length

#creating a column for ride length
cleaned_trips_2021$ride_length <- difftime(cleaned_trips_2021$ended_at,cleaned_trips_2021$started_at)

mean(cleaned_trips_2021$ride_length) #average ride length
median(cleaned_trips_2021$ride_length)
max(cleaned_trips_2021$ride_length) #longest ride
min(cleaned_trips_2021$ride_length) #shortest ride

# some entries had negative time length resulting to a negative minimum, perhaps due to refund/returns? 
# removing negative ride lengths
cleaned_trips_2021v2 <- cleaned_trips_2021[!(cleaned_trips_2021$ride_length<0),]

# rerun the analysis with the new data frame
mean(cleaned_trips_2021v2$ride_length) #average ride length
median(cleaned_trips_2021v2$ride_length)
max(cleaned_trips_2021v2$ride_length) #longest ride
min(cleaned_trips_2021v2$ride_length) #shortest ride
summary(cleaned_trips_2021v2$ride_length)

# comparing casual and member users
aggregate(cleaned_trips_2021v2$ride_length ~ cleaned_trips_2021v2$member_casual, FUN = mean)
aggregate(cleaned_trips_2021v2$ride_length ~ cleaned_trips_2021v2$member_casual, FUN = median)
aggregate(cleaned_trips_2021v2$ride_length ~ cleaned_trips_2021v2$member_casual, FUN = max)
aggregate(cleaned_trips_2021v2$ride_length ~ cleaned_trips_2021v2$member_casual, FUN = min)

# looking at the active days users use the service
# Separating day of the week, months and, day for easier comparison
cleaned_trips_2021v2$date <- as.Date(cleaned_trips_2021v2$started_at) 
cleaned_trips_2021v2$month <- format(as.Date(cleaned_trips_2021v2$date), "%m")
cleaned_trips_2021v2$day <- format(as.Date(cleaned_trips_2021v2$date), "%d")
cleaned_trips_2021v2$year <- format(as.Date(cleaned_trips_2021v2$date), "%Y")
cleaned_trips_2021v2$day_of_week <- format(as.Date(cleaned_trips_2021v2$date), "%A")

# Lunch break. Next steps - compare average ride time by day for each type of user

cleaned_trips_2021v2$day_of_week <- ordered(cleaned_trips_2021v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday"
                                                                                       , "Wednesday", "Thursday"
                                                                                       , "Friday", "Saturday"))

aggregate(cleaned_trips_2021v2$ride_length~cleaned_trips_2021v2$member_casual + cleaned_trips_2021v2$day_of_week
          , FUN = mean)

# Analyzing user type activity in a weekday

cleaned_trips_2021v2 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(num_of_rides = n()
            , average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)


# Data Visualizations

# Number of rides in a week by user type
cleaned_trips_2021v2 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(num_of_rides = n()
            , average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = num_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(casual = "#E2E69C", member = "#77E6BD"))

# average duration of trips by user type
cleaned_trips_2021v2 %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(num_of_rides = n()
            , average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(casual = "#E2E69C", member = "#77E6BD"))















