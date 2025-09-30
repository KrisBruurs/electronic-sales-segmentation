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
set.seed(123)

# Elbow method for optimal k
fviz_nbclust(customers_rfm_scaled[, c("recency", "frequency", "monetary")], 
             kmeans, 
             method = "wss") +
  labs(title = "Elbow Method for Optimal k")

# Silhouette method for optimal k
fviz_nbclust(customers_rfm_scaled[, c("recency", "frequency", "monetary")], 
             kmeans, 
             method = "silhouette") +
  labs(title = "Silhouette Method for Optimal k")

# Run k-means with k = 3
km_res <- kmeans(customers_rfm_scaled[, c("recency", "frequency", "monetary")], 
                 centers = 3, nstart = 25)

# Add cluster labels back to your customers_rfm
customers_rfm$cluster <- km_res$cluster

# Get mean values of all clusters
customers_rfm %>% 
  group_by(cluster) %>% 
  summarise(n = n(),
            avg_frequency = mean(frequency),
            avg_recency = mean(recency),
            avg_monetary = mean(monetary))

# Visualize clusters
fviz_cluster(km_res, 
             data = customers_rfm_scaled[, c("recency", "frequency", "monetary")],
             geom = "point",
             ellipse.type = "convex",
             ggtheme = theme_minimal())

