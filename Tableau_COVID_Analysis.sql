--Calculates the fatality rate by summing up the total cases and totals deaths and then dividing them to calculate percentage
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as death_percentage
From [Covid19-Data-Analysis]..covid_deaths
Where continent is not null
Order by 1,2


--Calculates the total number of deaths in each continent, removes locations to keep only continents 
Select location, SUM(cast(new_deaths as int)) as total_death_count
From [Covid19-Data-Analysis]..covid_deaths
Where continent is null
and location not in ('World', 'European Union', 'International')
Group by location
Order by total_death_count desc


--Calculates the infected percentage of each country, get the highest case number from each country (aka most current infected number) and divided by
--the population of the country to get the percentage
Select location, population, MAX(total_cases) as highest_infection_count, MAX(total_cases/population)*100 as percent_population_infected
From [Covid19-Data-Analysis]..covid_deaths
Group by location, population
Order by percent_population_infected desc



--Calculate the infected rate by each country over a period of time, sorted from highest to lowest infectioned
Select location, population, date, MAX(total_cases) as highest_infection_count, MAX(total_cases/population)*100 as percent_population_infected
From [Covid19-Data-Analysis]..covid_deaths
Group by location, population, date
Order by percent_population_infected desc