###---Libraries---###
library(tidyverse)
library(skimr)
library(cluster)
library(factoextra)

###---input---###
data <- read_csv('data/Electronic_sales_Sep2023-Sep2024.csv')

###---Data Exploration---###

# Get overview of variables
glimpse(data)

# Check number of individual consumers
n_distinct(data$`Customer ID`)

# Get an overview of descriptive statistics per variable
skim(data)

###---Data Cleaning---###

# Select only necessary variables
data_cleaned <- data %>% 
  select(
    `Customer ID`,
    `Purchase Date`,
    `Total Price`,
    Age,
    Gender,
    `Loyalty Member`,
    `Product Type`,
    `Add-on Total`,
    `Payment Method`,
    `Shipping Type`,
    Rating,
    `Order Status`
  ) %>% 
  filter(`Order Status` != 'Cancelled')

# Check distinct consumers
n_distinct(data_cleaned$`Customer ID`)

###---RFM analysis---###

# Create customers rfm dataframe
reference_date <- max(data_cleaned$`Purchase Date`)

customers_rfm <- data_cleaned %>% 
  group_by(`Customer ID`) %>% 
  summarise(
    recency = as.numeric(reference_date - max(`Purchase Date`)),
    frequency = n(),
    monetary = sum(`Total Price`)
  )

# scale rfm dataframe
customers_rfm_scaled <- customers_rfm %>% 
  mutate(
    across(c(recency, frequency, monetary), scale)
  )


###---Clustering---###


###---Output---###