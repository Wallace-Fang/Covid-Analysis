
--Total Cases vs. Total Deaths
--Shows likelihood of dying from covid contraction in US
Select location, date,total_cases, total_deaths, ROUND((total_deaths/total_cases)*100, 3) as DeathPercentage
From [Covid19-Data-Analysis]..covid_deaths
WHERE location like '%states%'
order by 1, 2

--Total Cases vs. Population
--Shows countries highest population infected with covid

Select location, population, MAX(total_cases) as HighestInfected, ROUND(MAX(total_cases)/population*100, 3) as InfectedPercentage
From [Covid19-Data-Analysis]..covid_deaths
--WHERE location like '%states%'
Group by location, population
order by 4 desc

