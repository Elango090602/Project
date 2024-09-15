Global Job Layoffs Analysis (2020-2023)
Project Overview
This project explores global job layoffs between 2020 and 2023. The dataset, sourced from Kaggle, contains detailed information about layoffs across various companies, industries, and locations. The objective of this analysis was to clean and process the dataset, then conduct exploratory data analysis (EDA) to uncover trends in layoffs, and analyze how different industries and regions were affected during this period.

Tools Used: MySQL (for data cleaning, transformation, and analysis), Advanced SQL (Joins, CTEs, Window Functions)

Table of Contents
1.Dataset
2.Methodology
3.Analysis Process
4.Results and Insights
5.Technologies Used
6.How to Use the Code
7.Conclusion


Dataset
Source: Kaggle Dataset - "Layoffs"

Columns:

1.Company: Name of the company laying off employees
2.Location: Specifies the location of the company
3.Industry: Type of industry (e.g., Transport, Healthcare, Marketing, Crypto, etc.)
4.Total_Laid_Off: The total number of employees laid off on a given date
5.Percentage_Laid_Off: The percentage of employees laid off, relative to the total workforce in that company
6.Date: The date when the layoffs occurred
7.Stage: The funding stage of the company (e.g., Series A, Series B, Series E, etc.)
8.Country: The country where the company is located
9.Funds_Raised_in_Millions: The total amount of funds raised by the company in millions

Dataset Size: The dataset contains thousands of records covering layoffs in multiple sectors and regions worldwide.

Methodology


1. Data Cleaning
Duplicate Removal: Ensured the data was free from duplicate records.
Handling Missing Data: Addressed missing or incomplete values in columns like Percentage_Laid_Off, Funds_Raised_in_Millions, and others.
Normalization and Standardization: Applied transformations to numerical data for consistency across the dataset.
2. Exploratory Data Analysis (EDA)
Advanced SQL Queries:
CTEs: Used Common Table Expressions (CTEs) to simplify complex queries and provide temporary result sets for better data management.
Joins: Combined various tables to provide comprehensive insights from different angles (e.g., industry and region).
Window Functions: Applied window functions to calculate rankings and cumulative values across different subsets of the data (e.g., industry-wise or country-wise analysis).
Analysis Process
The analysis involved a structured process of cleaning, transforming, and analyzing the dataset to generate meaningful insights.

Understanding the Dataset: Familiarized myself with the dataset by inspecting the columns and types of data provided. This helped shape questions for analysis, such as:

Which industries were hit hardest by layoffs?
What regions experienced the highest number of layoffs?
How did layoffs evolve over time?
Data Cleaning: Addressed duplicate, missing, and inconsistent values. Standardized numerical fields like Funds_Raised_in_Millions to ensure consistency.

SQL-Based Exploratory Data Analysis:

Temporal Trends: Investigated how layoffs fluctuated across different years, quarters, and months between 2020 and 2023.
Industry Impact: Identified industries (e.g., Tech, Finance, Healthcare) most affected by layoffs.
Regional Analysis: Analyzed the geographic distribution of layoffs, highlighting countries and regions with the highest layoffs.
Stage Analysis: Explored the correlation between company stage (Series A, Series B, etc.) and layoffs, providing insight into the financial health of companies.
Advanced SQL Techniques:

Joins: Merged datasets to compare layoffs across industries and regions effectively.
CTEs: Used CTEs to simplify multi-step queries that involved filtering, grouping, and ordering.
Window Functions: Applied window functions to compute trends and moving averages to understand how layoffs changed over time.
Results and Insights
Key Insights:
Pandemic-Driven Layoffs:

The dataset shows a significant rise in layoffs in 2020, with the highest impact in Q2 and Q3 due to the global COVID-19 pandemic.
Industries like Tech, Transportation, and Retail were among the most impacted.
Country-Specific Analysis:

Layoffs were predominantly reported in North America and Europe, with countries like the USA, UK, and Germany having the highest numbers.
Asian countries showed varying effects, with some recovering quicker by 2022.
Industry Trends:

The Technology sector had the highest number of layoffs, driven by reduced demand during the pandemic.
Industries like Healthcare saw fewer layoffs as the demand for health services remained stable.
Company Stage:

Companies in later funding stages (e.g., Series D and Series E) had more layoffs, likely due to higher operational costs and capital allocation challenges.


Technologies Used
MySQL:
For database querying, data cleaning, and data analysis.
Advanced SQL functions for EDA, including joins, window functions, and CTEs.
Kaggle Dataset: Sourced the dataset from Kaggle for analysis.

Conclusion

This project sheds light on the global impact of layoffs from 2020 to 2023. The analysis provided valuable insights into the industries and regions that were hit hardest, as well as trends over time. By leveraging advanced SQL queries and data-cleaning techniques, we gained a deeper understanding of the economic effects caused by the pandemic.
