--Select *
--From [Covid19-Data-Analysis]..covid_deaths
--Where continent is not null
--order by 3, 4

--Total Cases vs. Total Deaths
--Shows likelihood of dying from covid contraction in US
--Select location, date,total_cases, total_deaths, ROUND((total_deaths/total_cases)*100, 3) as DeathPercentage
--From [Covid19-Data-Analysis]..covid_deaths
--WHERE location like '%states%'
--order by 1, 2

--Total Cases vs. Population
--Shows countries highest population infected with covid

--Breakdown by Continent
Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Covid19-Data-Analysis]..covid_deaths
--WHERE location like '%states%'
Where continent is null
Group by location
order by TotalDeathCount desc

--Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
--From [Covid19-Data-Analysis]..covid_deaths
----WHERE location like '%states%'
--Where continent is not null
--Group by location
--order by TotalDeathCount desc

