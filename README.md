# Customer Segmentation with RFM and k-means

## Project Overview
This project applies Recency–Frequency–Monetary (RFM) analysis and k-means clustering to customer transaction data from an electronics retailer. The goal is to identify distinct customer segments and generate actionable insights for personalized marketing, retention strategies, and customer lifetime value optimization.

By segmenting customers into groups such as high-value loyal customers, at-risk buyers, and dormant mid-value customers, businesses can allocate resources more effectively and design targeted campaigns.

## Dataset
The dataset contains one year (2023-2024) of electronic sales transactions, including:
- `Customer-ID`: Unique customer identifyer
- `Purchase Date`: Date of transaction
- `Total Price`: Total spend on purchase
- `Product Type `, `Add-on Total`, `Payment Method`, `Shipping Type`, `Rating`
- Demographics such as `Age`, `Gender`, and `Loyalty Member`
  or this project only relevant variables variables were selected for the RFM analysis.

## Methodology
1. Data Cleaning
   - Removing Cancelled orders
   - Selecting relevant transaction fields
2. Feature Engineering
   - Recency: Days since last purchase
   - Frequency: Number of purchases
   - Monetary: Total spend per customer
3. Scaling
  - Standardized RFM features to ensure comparibility
4. Clustering
  - Determining optimal k using elbow method and silhouette analysis
5. Cluster profiling
  - Interpret clusters based on RFM values
  - Transalte into business recommendations

## Results
Three customer clusters were identified:
- Cluster 1: Dormant, Mid-Value Customers. Moderate spenders, infrequent purcchases, recent inactivity
- Cluster 2: At-risk or Lost Customers. Long recency, lowest spend, mostly one-time buyers
- Cluster 3: High-Value Loyal Customers. Frequent purchases, high spend, engaged and valuable

## Business Recommendations
- Cluster 1: Reactivation campagins (seasonal promotions, personalized discount codes, recommendations)
- Cluster 2: Low ROI on marketing, test win-back campaign cautiously
- Cluster 3: Focus on retention (VIP programs, loyalty rewards, free add-ons, referral incentives)
