# 🌍 Energy Consumption Analysis (SQL Project)

![Made With](https://img.shields.io/badge/Made%20With-MySQL-blue)
![Project](https://img.shields.io/badge/Project-SQL%20Analytics-black)
![Type](https://img.shields.io/badge/Type-Database-green)
![Open Source](https://img.shields.io/badge/Open%20Source-Yes-orange)

> A SQL-based data analysis project that examines global energy consumption, production, GDP, population, and CO₂ emissions to derive meaningful insights using relational databases and advanced SQL queries.

---

## 📌 Overview

The **Energy Consumption Analysis System** is a structured SQL-based project designed to analyze global trends in energy usage and environmental impact.

It enables efficient analysis of:

* Country-wise energy consumption and production
* GDP and economic growth patterns
* CO₂ emissions and sustainability metrics

This project demonstrates strong SQL concepts such as **data modeling, joins, aggregations, window functions, and trend analysis**, helping derive real-world insights for **sustainable decision-making**.

---

## 🎯 Objective

To build a comprehensive analytical database that:

* Analyze global energy consumption and production trends
* Compare GDP growth with energy usage and emissions
* Calculate per capita and ratio-based metrics
* Identify high-performing and environmentally efficient countries
* Support data-driven insights for sustainability

---

## 🧠 ER Diagram

<p align="center">
  <img src="images/Energy%20Consumption%20Analysis%20Schema.png" alt="ER Diagram" width="800"/>
</p>

---

## 🧩 Database Design

| Table       | Primary Key    | Foreign Key | Key Attributes                 |
| ----------- | -------------- | ----------- | ------------------------------ |
| Country     | country_id     | —           | country_name                   |
| Population  | population_id  | country_id  | year, population_value         |
| GDP         | gdp_id         | country_id  | year, gdp_value                |
| Consumption | consumption_id | country_id  | year, energy_type, consumption |
| Production  | production_id  | country_id  | year, energy_type, production  |
| Emission    | emission_id    | country_id  | year, energy_type, emission    |

---

## ⚙️ Tech Stack

* **Database:** MySQL
* **Language:** SQL

### Concepts Used:

* Joins
* Subqueries
* CTEs (WITH clause)
* Window Functions
* Aggregations
* Data Modeling (Star Schema)

---

## 📂 Dataset

You can use publicly available datasets such as:

* 🌐 https://www.kaggle.com/datasets
* 🌐 https://ourworldindata.org/energy
* 🌐 https://data.worldbank.org

> Includes data on energy consumption, GDP, emissions, and population across countries.

---

## 🚀 Project Setup

### 1️⃣ Create Database

```sql
CREATE DATABASE energy_consumption_analysis;
USE energy_consumption_analysis;
```

---

### 2️⃣ Create Tables (Example)

```sql
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
```

---

### 3️⃣ Insert Sample Data

```sql
INSERT INTO Country (country_name)
VALUES ('India'), ('USA'), ('China');
```

---

## 💡 Key SQL Queries & Insights

### 🌍 General & Comparative Analysis

```sql
SELECT country, SUM(emission) AS total_emission
FROM emission
GROUP BY country;
```

**Insight:** Identifies countries with the highest emissions globally.

---

### 📈 Trend Analysis

```sql
SELECT year, SUM(emission) AS global_emission
FROM emission
GROUP BY year;
```

**Insight:** Tracks global emission growth over time.

---

### ⚖️ Per Capita Analysis

```sql
SELECT e.country,
       SUM(e.emission) / p.value AS emission_per_capita
FROM emission e
JOIN population p 
ON e.country = p.countries AND e.year = p.year
GROUP BY e.country, p.value;
```

**Insight:** Helps compare environmental efficiency across countries.

---

### 💰 GDP vs Energy Consumption

```sql
SELECT g.country,
       SUM(c.consumption) / SUM(g.value) AS consumption_to_gdp_ratio
FROM consumption c
JOIN gdp g 
ON c.country = g.country AND c.year = g.year
GROUP BY g.country;
```

**Insight:** Measures energy dependency of economies.

---

### 🔥 Advanced Analysis (Trend Improvement)

```sql
WITH trend AS (
  SELECT e.country, e.year,
         SUM(e.emission) / p.value AS per_capita
  FROM emission e
  JOIN population p 
  ON e.country = p.countries AND e.year = p.year
  GROUP BY e.country, e.year, p.value
)
SELECT * FROM trend;
```

**Insight:** Identifies sustainable and improving countries.

---

## 🧰 Challenges Faced

* Handling inconsistent column naming (`country` vs `countries`)
* Managing large datasets across multiple years
* Writing complex joins across multiple tables
* Ensuring correct time-based comparisons
* Avoiding duplicate and incorrect aggregations

---

## ✅ Outcomes

* Built a **fully normalized analytical database**
* Performed **real-world data analysis using SQL**
* Derived **insightful trends on energy & emissions**
* Strengthened understanding of **data relationships and metrics**
* Created a **portfolio-ready data analytics project**

---

## 🚀 Future Enhancements

* Integrate with **Power BI / Tableau dashboards**
* Add **machine learning models** for emission prediction
* Build a **Streamlit dashboard**
* Deploy database on **AWS RDS / Azure SQL**

---

## 🏷️ Tags

SQL • MySQL • Data Analysis • Energy Analytics • Sustainability • GDP Analysis • CO2 Emissions • Data Science • Relational Database • Portfolio Project

---

## 📜 License

This project is for **educational and portfolio purposes only**.

---

## 🙌 Acknowledgments

Special thanks to **Innomatics Research Labs** for their mentorship and guidance throughout this project.
