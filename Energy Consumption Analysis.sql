CREATE DATABASE energy_consumption_analysis;
USE energy_consumption_analysis;

--TABLE 1: Country (Parent Table)
CREATE TABLE Country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) UNIQUE
);

--TABLE 3: Population
CREATE TABLE Population (
    population_id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    year INT,
    value BIGINT,
    
    CONSTRAINT fk_population_country 
    FOREIGN KEY (country_id)
    REFERENCES Country(country_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

--TABLE 3: GDP
CREATE TABLE GDP (
    gdp_id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    year INT,
    value DECIMAL(15,2),
    
    CONSTRAINT fk_gdp_country 
    FOREIGN KEY (country_id)
    REFERENCES Country(country_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

--TABLE 4: Energy Consumption
CREATE TABLE Consumption (
    consumption_id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    year INT,
    energy_type VARCHAR(50),
    consumption DECIMAL(15,2),
    
    CONSTRAINT fk_consumption_country 
    FOREIGN KEY (country_id)
    REFERENCES Country(country_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


--TABLE 5: Energy Production
CREATE TABLE Production (
    production_id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    year INT,
    energy_type VARCHAR(50),
    production DECIMAL(15,2),
    
    CONSTRAINT fk_production_country 
    FOREIGN KEY (country_id)
    REFERENCES Country(country_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

--TABLE 6: Emissions
CREATE TABLE Emission (
    emission_id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    year INT,
    energy_type VARCHAR(50),
    emission DECIMAL(15,2),
    
    CONSTRAINT fk_emission_country 
    FOREIGN KEY (country_id)
    REFERENCES Country(country_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

show tables;
select * from consumption;



--General & Comparative Analysis

-- What is the total emission per country for the most recent year available?
SELECT country,year,SUM(emission) AS total_emission 
FROM emission
WHERE year = (SELECT MAX(year) FROM emission)
GROUP BY country, year
order by country asc;

-- What are the top 5 countries by GDP in the most recent year?
select country,year,value as gdp_values 
from gdp
where year=(select max(year) from gdp)
order by gdp_values desc
limit 5;
select * from gdp;

-- Compare energy production and consumption by country and year. 
SELECT p.country, p.year,
       SUM(p.production) AS total_production,
       SUM(c.consumption) AS total_consumption
FROM production p
LEFT JOIN consumption c 
  ON p.country = c.country AND p.year = c.year
GROUP BY p.country, p.year;


-- Which energy types contribute most to emissions across all countries?
SELECT energy_type, SUM(emission) AS total_emission
FROM emission
GROUP BY energy_type
ORDER BY total_emission DESC;


 #Trend Analysis Over Time


-- How have global emissions changed year over year?
SELECT year, SUM(emission) AS global_emission
FROM emission
GROUP BY year
ORDER BY year;

-- What is the trend in GDP for each country over the given years?
select country,year,value as gdp
from gdp
order by country,year;

-- How has population growth affected total emissions in each country?
SELECT e.country, e.year, sum(e.emission) as total_emission,
p.Value AS population,sum( e.emission) / p.Value AS emission_per_capita
FROM emission e
JOIN population p 
  ON e.country = p.countries AND e.year = p.year
group BY e.country, e.year,p.value
order by e.country,e.year;

-- Has energy consumption increased or decreased over the years for major economies?
with top_gdp as (
select country
from gdp
where year=(select max(year) from gdp)
order by value desc
limit 5
)
select c.country, c.year, sum(c.consumption) as total_consumption
from consumption as c
where c.country in (select country from top_gdp)
group by c.country,c.year
order by c.country,c.year;
select  * from gdp;

-- What is the average yearly change in emissions per capita for each country?
SELECT e.country, e.year,
       SUM(e.emission) / p.value AS emission_per_capita
FROM emission e
JOIN population p
ON e.country = p.country AND e.year = p.year
GROUP BY e.country, e.year, p.value;	


--Ratio & Per Capita Analysis


-- What is the emission-to-GDP ratio for each country by year?
SELECT e.country, e.year,
SUM(e.emission) / SUM(g.Value) AS emission_to_GDP_ratio
FROM emission e
JOIN gdp g 
ON e.country = g.Country AND e.year = g.year
GROUP BY e.country, e.year
ORDER BY country asc;

-- What is the energy consumption per capita for each country over the last decade?
SELECT p.countries,sum(c.consumption)/sum(p.value) as energy_consumption_per_capita
from population p
join consumption c
on p.country=c.country
group by p.countries;

-- How does energy production per capita vary across countries?
SELECT p.country, p.year, SUM(p.production) / pop.Value AS production_per_capita
FROM production p
JOIN population pop
  ON p.country = pop.countries AND p.year = pop.year
GROUP BY p.country, p.year,pop.value
ORDER BY p.country,p.year;

-- Which countries have the highest energy consumption relative to GDP?
SELECT g.Country,g.year,
SUM(c.consumption) / g.Value AS consumption_to_gdp_ratio
FROM gdp AS g
JOIN consumption AS c 
ON g.Country = c.country AND g.year = c.year
GROUP BY g.Country, g.year, g.Value
ORDER BY consumption_to_gdp_ratio DESC;

-- What is the correlation between GDP growth and energy production growth?
select p.country,p.year,sum(p.production) as total_production,sum(g.value) as gdp
from production as p
join gdp as g
on p.country=g.country and p.year=g.year
group by p.country,p.year;


 -- Global Comparisons


-- What are the top 10 countries by population and how do their emissions compare?
select p.countries as country,
max(p.value) as population,
sum(e.emission) as total_emission 
from population as p
join emission as e
on p.countries=e.country 
group by p.countries
order by population desc
limit 10;

-- Which countries have improved (reduced) their per capita emissions the most over the last decade?
WITH per_capita AS (
    SELECT 
        e.country,
        e.year,
        SUM(e.emission) / p.value AS per_capita_emission
    FROM emission e
    JOIN population p
        ON e.country = p.countries 
        AND e.year = p.year
    GROUP BY e.country, e.year, p.value
),

latest_year AS (
    SELECT MAX(year) AS max_year FROM per_capita
),

decade_data AS (
    SELECT 
        pc.country,
        pc.year,
        pc.per_capita_emission
    FROM per_capita pc
    WHERE pc.year >= (SELECT max_year - 10 FROM latest_year)
),

comparison AS (
    SELECT 
        country,
        MAX(CASE WHEN year = (SELECT max_year FROM latest_year) 
                 THEN per_capita_emission END) AS latest_value,
        MAX(CASE WHEN year = (SELECT max_year - 10 FROM latest_year) 
                 THEN per_capita_emission END) AS old_value
    FROM decade_data
    GROUP BY country
)

SELECT 
    country,
    old_value,
    latest_value,
    (old_value - latest_value) AS reduction
FROM comparison
WHERE latest_value < old_value   -- only improved countries
ORDER BY reduction DESC;

-- What is the global share (%) of emissions by country?
with total as (
select  sum(emission) as total_emission
from emission
)
select country,sum(emission) as country_emission,
(sum(emission)/(select total_emission from total))*100 as share_percent
from emission
group by country
order by share_percent desc;

-- What is the global average GDP, emission, and population by year?
select g.year,
round(avg(g.value),2) as avg_gdp,
round(avg(e.emission),2) as avg_emission,
round(avg(p.value),2) as avg_population
from gdp as g
join emission as e
on g.country=e.country and g.year=e.year
join population as p
on g.country=p.countries and g.year=p.year
group by g.year
order by g.year;
