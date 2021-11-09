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

--Showing continent with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Covid19-Data-Analysis]..covid_deaths
where continent is not null
Group by continent
order by TotalDeathCount desc

-- Global numbers
Select date,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From [Covid19-Data-Analysis]..covid_deaths
where continent is not null
group by date
order by 1, 2

-- Looking at total population vs vaccinated

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
dea.Date) as RollingVaccinated
From [Covid19-Data-Analysis]..covid_deaths dea
Join [Covid19-Data-Analysis]..covid_vaccinations vac
 On dea.location = vac.location
 and dea.date = vac.date
where dea.continent is not null
order by 2,3;

--CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
dea.Date) as RollingVaccinated
From [Covid19-Data-Analysis]..covid_deaths dea
Join [Covid19-Data-Analysis]..covid_vaccinations vac
 On dea.location = vac.location
 and dea.date = vac.date
where dea.continent is not null
)

Select *, (RollingVaccinated/Population)*100
From PopvsVac

--Temp Table

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location,
dea.Date) as RollingVaccinated
From [Covid19-Data-Analysis]..covid_deaths dea
Join [Covid19-Data-Analysis]..covid_vaccinations vac
 On dea.location = vac.location
 and dea.date = vac.date
--where dea.continent is not null

Select*, (RollingVaccinated/Population)*100
From #PercentPopulationVaccinated

--Creating View to store data for visulization
Create View PercentPopulationVaccinated as