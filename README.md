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
- Country-wise energy consumption and production  
- GDP and economic growth patterns  
- CO₂ emissions and sustainability metrics  

This project demonstrates strong SQL concepts such as **data modeling, joins, aggregations, window functions, and trend analysis**, helping derive real-world insights for **sustainable decision-making**.

---

## 🎯 Objective

To build a comprehensive analytical database that:

- Analyzes global energy consumption and production trends  
- Compares GDP growth with energy usage and emissions  
- Calculates per capita and ratio-based metrics  
- Identifies high-performing and environmentally efficient countries  
- Supports data-driven insights for sustainability  

---

## 🧠 ER Diagram Overview

### 📊 Entities:
- Country  
- Population  
- GDP  
- Consumption  
- Production  
- Emission  

### 🔗 Relationships:
- Country → Population (One-to-Many)  
- Country → GDP (One-to-Many)  
- Country → Consumption (One-to-Many)  
- Country → Production (One-to-Many)  
- Country → Emission (One-to-Many)  

---

## 🧩 Database Design

| Table        | Primary Key     | Foreign Key   | Key Attributes |
|-------------|----------------|--------------|----------------|
| Country     | country_id     | —            | country_name |
| Population  | population_id  | country_id   | year, population_value |
| GDP         | gdp_id         | country_id   | year, gdp_value |
| Consumption | consumption_id | country_id   | year, energy_type, consumption |
| Production  | production_id  | country_id   | year, energy_type, production |
| Emission    | emission_id    | country_id   | year, energy_type, emission |

---

## ⚙️ Tech Stack

- **Database:** MySQL  
- **Language:** SQL  

### Concepts Used:
- Joins  
- Subqueries  
- CTEs (WITH clause)  
- Window Functions  
- Aggregations  
- Data Modeling (Star Schema)  

---

## 🚀 Project Setup

### 1️⃣ Create Database
```sql
CREATE DATABASE energy_consumption_analysis;
USE energy_consumption_analysis;
