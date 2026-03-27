🌍 Energy Consumption Analysis (SQL Project)

Made with MySQL | Data Analytics Project | Open Source

A SQL-based data analysis project that examines global energy consumption, production, GDP, population, and CO₂ emissions to derive meaningful insights using relational databases and advanced SQL queries.

📌 Overview

The Energy Consumption Analysis System is a structured SQL project designed to analyze global trends in energy usage and environmental impact.

It enables efficient analysis of:

Country-wise energy consumption and production
GDP and economic growth patterns
CO₂ emissions and sustainability metrics

This project demonstrates strong SQL concepts like data modeling, joins, aggregations, window functions, and trend analysis, helping derive real-world insights for sustainable decision-making.

🎯 Objective

To build a comprehensive analytical database that:

Analyzes global energy consumption and production trends
Compares GDP growth with energy usage and emissions
Calculates per capita and ratio-based metrics
Identifies high-performing and environmentally efficient countries
Supports data-driven insights for sustainability
🧠 ER Diagram Overview
📊 Entities:
Country
Population
GDP
Consumption
Production
Emission
🔗 Relationships:
Country → Population (One-to-Many)
Country → GDP (One-to-Many)
Country → Consumption (One-to-Many)
Country → Production (One-to-Many)
Country → Emission (One-to-Many)
🧩 Database Design
Table	Primary Key	Foreign Key	Key Attributes
Country	country_id	—	country_name
Population	population_id	country_id	year, population_value
GDP	gdp_id	country_id	year, gdp_value
Consumption	consumption_id	country_id	year, energy_type, consumption
Production	production_id	country_id	year, energy_type, production
Emission	emission_id	country_id	year, energy_type, emission
⚙️ Tech Stack
Database: MySQL
Language: SQL
Concepts Used:
Joins
Subqueries
CTEs (WITH clause)
Window Functions
Aggregations
Data Modeling (Star Schema)
🚀 Project Setup
1️⃣ Create Database
CREATE DATABASE energy_consumption_analysis;
USE energy_consumption_analysis;
2️⃣ Create Tables (Example)
CREATE TABLE Country (
  country_id INT PRIMARY KEY AUTO_INCREMENT,
  country_name VARCHAR(100) UNIQUE
);

CREATE TABLE GDP (
  gdp_id INT PRIMARY KEY AUTO_INCREMENT,
  country_id INT,
  year INT,
  value DECIMAL(15,2),
  FOREIGN KEY (country_id) REFERENCES Country(country_id)
);
3️⃣ Insert Sample Data
INSERT INTO Country (country_name)
VALUES ('India'), ('USA'), ('China');
💡 Key SQL Queries & Insights
🌍 General & Comparative Analysis
SELECT country, SUM(emission) AS total_emission
FROM emission
GROUP BY country;

Insight: Identifies countries with highest emissions globally.

📈 Trend Analysis
SELECT year, SUM(emission) AS global_emission
FROM emission
GROUP BY year;

Insight: Tracks global emission growth over time.

⚖️ Per Capita Analysis
SELECT country,
SUM(emission)/population AS emission_per_capita
FROM emission e
JOIN population p ON e.country = p.country;

Insight: Helps compare environmental efficiency across countries.

💰 GDP vs Energy Consumption
SELECT country,
SUM(consumption)/SUM(gdp) AS consumption_to_gdp_ratio
FROM consumption c
JOIN gdp g ON c.country = g.country;

Insight: Measures energy dependency of economies.

🔥 Advanced Analysis (Trend Improvement)
-- Countries reducing per capita emissions
WITH trend AS (
  SELECT country, year,
  SUM(emission)/population AS per_capita
  FROM emission e
  JOIN population p ON e.country = p.country
)
SELECT * FROM trend;

Insight: Identifies sustainable and improving countries.

🧰 Challenges Faced
Handling inconsistent column names (country vs countries)
Managing large datasets across multiple years
Writing complex joins across 5+ tables
Ensuring correct time-based comparisons
Avoiding data duplication and incorrect aggregations
✅ Outcomes
Built a fully normalized analytical database
Performed real-world data analysis using SQL
Derived insightful trends on energy & emissions
Developed strong understanding of data relationships and metrics
Created a portfolio-ready data analytics project
🚀 Future Enhancements
Integrate with Power BI / Tableau dashboards
Add predictive modeling (ML) for emission forecasting
Build a Streamlit dashboard for visualization
Deploy database on AWS RDS / Azure SQL
🏷️ Tags

SQL • MySQL • Data Analysis • Energy Analytics • Sustainability • GDP Analysis • CO2 Emissions • Data Science • Relational Database • Portfolio Project

📜 License

This project is for educational and portfolio purposes only. Unauthorized use or reproduction is not permitted without permission.

🙌 Acknowledgments

Special thanks to Innomatics Research Labs for guidance and support throughout this project.
