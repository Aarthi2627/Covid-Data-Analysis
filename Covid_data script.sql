USE covid_project;
SELECT * FROM covid_data;

-- 1. "What are the total COVID cases reported in each continent for the years 2020, 2021, and 2022?"

SELECT 
    continent, 
    YEAR(date) AS year,
    SUM(total_cases) AS total_cases
FROM 
    covid_data
WHERE 
    YEAR(date) IN (2020, 2021, 2022)
GROUP BY 
    continent, 
    YEAR(date)
ORDER BY 
    continent, 
    YEAR(date);

-- 2.  "What is the mortality rate (deaths per total cases) globally, and how does it differ across continents and countries?"

-- Global Mortality rate --
        
 SELECT 
	YEAR(date) AS year,
    (SUM(total_deaths) / SUM(total_cases)) * 100 AS global_mortality_rate
FROM 
    covid_data
WHERE 
    YEAR(date) IN (2020, 2021, 2022)
GROUP BY  
    YEAR(date)
ORDER BY 
    YEAR(date) ASC;  
    
-- Continental Mortality rate --

SELECT 
    continent,
    (SUM(total_deaths) / SUM(total_cases)) * 100 AS mortality_rate
FROM 
    covid_data
GROUP BY 
    continent;

-- Country wise mortality rate --
    
SELECT 
    location,
    (SUM(total_deaths) / SUM(total_cases)) * 100 AS mortality_rate
FROM 
    covid_data
WHERE 
    total_cases > 0 AND total_deaths > 0
GROUP BY 
    location;

-- 3. Top 10 countries which has more hospitalized patients

SELECT 
    location,
    SUM(hosp_patients) AS total_hospital_patients
FROM 
    covid_data
GROUP BY 
    location
ORDER BY
	total_hospital_patients DESC 
    limit 10;


-- 4. What is the total number of tests conducted in each continent?

SELECT 
    continent,
    SUM(total_tests) AS total_number_of_tests
FROM 
    covid_data
GROUP BY 
    continent;
    
-- Top 10 Countries with Highest Testing Rates
    
SELECT 
    location,
    SUM(total_tests) AS total_number_of_tests
FROM 
    covid_data
GROUP BY 
    location
ORDER BY
	total_number_of_tests DESC 
LIMIT 10;


-- 5. What is the total number of vaccinations administered globally and in each continent?

SELECT 
    'Global' AS location,
    SUM(total_vaccinations) AS total_vaccinations
FROM 
    covid_data
UNION
SELECT 
    continent,
    SUM(total_vaccinations) AS total_vaccinations
FROM 
    covid_data
GROUP BY 
    continent;


-- 6. What is the average age of individuals who contracted COVID-19 in each continent?

SELECT 
    continent,
    ROUND(AVG(median_age)) AS average_age
FROM 
    covid_data
WHERE 
    median_age IS NOT NULL
GROUP BY 
    continent;
    
    
-- 7. Total COVID-19 cases based on the population density

-- For High Population Density:

SELECT 
    location,
    SUM(total_cases) AS total_cases
FROM 
    covid_data
WHERE 
    population_density > (SELECT AVG(population_density) FROM covid_data) 
GROUP BY 
    location
ORDER BY
	total_cases DESC
    LIMIT 10;

-- For Low Population Density:

SELECT 
    location,
    SUM(total_cases) AS total_cases
FROM 
    covid_data
WHERE 
    population_density <= (SELECT AVG(population_density) FROM covid_data) 
GROUP BY 
    location
ORDER BY
	total_cases DESC
    LIMIT 10;

-- 8. What percentage of the population has received at least one dose, are fully vaccinated, or have received booster shots?

SELECT 
    continent,
    (SUM(people_vaccinated) / SUM(population)) * 100 AS percentage_at_least_one_dose,
    (SUM(people_fully_vaccinated) / SUM(population)) * 100 AS percentage_fully_vaccinated,
    (SUM(total_boosters) / SUM(population)) * 100 AS percentage_with_boosters
FROM 
    covid_data
WHERE 
    population > 0
GROUP BY 
    continent;

-- 9. What is the distribution of total cases and total deaths across different continents?

SELECT 
    continent,
    SUM(total_cases) AS total_cases,
    SUM(total_deaths) AS total_deaths
FROM 
    covid_data
GROUP BY 
    continent;


-- 10. How has the COVID-19 pandemic influenced life expectancy trends over the pandemic years 2020, 2021, 2022?

SELECT
    YEAR(date),
    AVG(life_expectancy) AS avg_life_expectancy
FROM
    covid_data
WHERE
    YEAR(date) BETWEEN 2020 AND 2022
GROUP BY
    YEAR(date);


