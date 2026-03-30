# Netflix SQL Project

## Overview
This project focuses on analyzing Netflix movies and TV shows data using SQL. The goal is to extract meaningful insights related to content distribution, trends, and key contributors in the dataset.

## Objectives
- Analyze distribution of Movies vs TV Shows
- Identify most common ratings across content types
- Explore content trends over years
- Find top contributing countries, directors, and actors
- Perform data cleaning and transformation for accurate analysis

## Dataset
- Source: Netflix dataset (Kaggle)
- Contains information about movies and TV shows including title, director, cast, country, release year, rating, and more

## Data Cleaning and Preparation
- Before analysis, the dataset was preprocessed to ensure consistency and accuracy
- Replaced empty strings with NULL values in columns like director, country, and casts
- Converted date_added from text format to proper DATE type (date_added_clean)
- Extracted numeric values from duration into a new column (duration_int)
- Trimmed extra spaces from text columns to maintain uniformity
- Handled multi-value columns (like country and genres) using string functions for accurate analysis

## Exploratory Data Analysis
The following business questions were solved using SQL:

1. Count of Movies vs TV Shows
2. Most common rating by content type
3. Movies released in a specific year
4. Top 5 countries with most content
5. Longest movie
6. Content added in the last 5 years
7. Content by specific director
8. TV shows with more than 5 seasons
9. Content distribution by genre
10. Year-wise content release in India
11. Documentary movies
12. Content without director
13. Movies featuring a specific actor
14. Top actors in Indian content
15. Content categorization based on keywords

## Advanced Analysis
- Content Growth Over Time → Analyzed how Netflix content has increased over the years
- Top Countries by Year → Identified leading content-producing countries annually
- Most Active Directors → Found directors contributing the highest number of titles

## Key Insights
- Movies dominate the platform compared to TV Shows
- Content production has significantly increased after 2015
- Certain countries contribute a major portion of Netflix content
- A small number of directors and actors appear frequently
- Majority of content falls under general (non-violent) category

## Skills Demonstrated
- SQL querying (SELECT, GROUP BY, ORDER BY)
- Window functions (RANK())
- Data cleaning and preprocessing
- String manipulation (STRING_TO_ARRAY, UNNEST)
- Date handling and transformation
- Analytical thinking and problem solving

## Conclusion
This project demonstrates how SQL can be used to clean, analyze, and extract insights from real-world datasets. It highlights important trends in Netflix content and showcases practical data analysis skills.

## Author
Bhavya Bhat  
Aspiring Data Analyst
