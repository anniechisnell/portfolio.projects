SELECT * FROM `adroit-sol-347622.covid.covid_deaths` Order By 3,4;

-- Select the data that I will use.

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM `adroit-sol-347622.covid.covid_deaths`
Order By 1,2;

--Calculation to examine death rate per country.

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS death_percentage
FROM `adroit-sol-347622.covid.covid_deaths`
WHERE location = "United States"
Order By 1, 2;

-- Calculation to examine percentage of population that has contracted covid.

SELECT location, date, population, total_cases, (total_cases/population) * 100 AS covid_positive_percent
FROM `adroit-sol-347622.covid.covid_deaths`
WHERE location = "United States"
Order By 1, 2;

--Examining countries with highest infection rate compared to population.
SELECT location, population, MAX(total_cases), MAX(total_cases/population) * 100 AS covid_positive_percent
FROM `adroit-sol-347622.covid.covid_deaths`
Group By location, population
Order By covid_positive_percent desc;

--Examining highest death count per population
SELECT location, MAX(total_deaths) AS total_death_count
FROM `adroit-sol-347622.covid.covid_deaths`
WHERE continent IS NOT NULL AND location NOT like '%income%' AND location <> "European Union"
Group By location
Order By total_death_count desc;

--Examining highest death count per continent
SELECT location, MAX(total_deaths) AS total_death_count
FROM `adroit-sol-347622.covid.covid_deaths`
WHERE continent IS NULL AND location  NOT LIKE '%income%' AND location NOT LIKE '%Union%'
Group By location
Order By total_death_count desc;

--Examining Global Numbers for death percentage rate per day
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentages
FROM `adroit-sol-347622.covid.covid_deaths`
WHERE continent IS NOT NULL AND new_cases <> 0
GROUP BY date
ORDER BY 1, 2;

-- Death Rate per infection world wide.
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as death_percentages
FROM `adroit-sol-347622.covid.covid_deaths`
WHERE continent IS NOT NULL AND new_cases <> 0
ORDER BY 1, 2;

--Examining Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM `adroit-sol-347622.covid.covid_deaths` dea JOIN `adroit-sol-347622.covid.covid_vaccinations` vac ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3;
