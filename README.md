# Google Data Analytics Capstone Project: Cyclistic Customer Analysis
Case study for the completion of Google Data Analyst specialization on Coursera

The Background
Cyclistic is a bike-sharing company with a fleet of 5,824 bicycles across a network of 692 stations in Chicago. Cyclistic’s current marketing strategy relied on building awareness and appealing to a broader audience. They appeal to these consumer segments with their flexible pricing plans: single-ride pass, full-day pass, and annual memberships.

Finance analysts have concluded they the annual members are much more profitable than casual riders. Moreno the director of marketing concludes that future success depends on maximizing annual memberships. She believes that there is a very good chance to convert casual riders to annual members since they are already aware of and use the service. Moreno and her team are interested in insights that could help design a new marketing strategy to convert casual riders to annual members.


## The Question

What is the task?
1. Provide insights that would help the marketing team design a new strategy that would convert casual riders to annual members.

Key questions to guide the future marketing strategy
1. How do annual members and casuall user use the service differently?
2. Why would casual riders buy Cyclistic annual membership?
3. How can Cyclistic use digital media tto convert casual riders to annual members?

## The Data

The Data used in this analysis is found [here](https://divvy-tripdata.s3.amazonaws.com/index.html) in csv format. The analysis uses data available from the last year (Jan-Dec 2021). The data used has fields for ride id, type of bike used, start and end datetime for usage, start and end station id and name, start and end longitude and latitude, and the user type. I started by loading the packages in Rstudio: tidyverse, lubricate, ggplot2. I then loaded the csv files for each month, and checked the consistency of the data structure between the csv files using str function. Thankfully the files were formatted consistently, which means I can now join them into one dataframe for ease.

## The Preparation






