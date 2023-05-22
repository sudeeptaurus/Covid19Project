Select *
From Covid19Project..CovidDeaths
order by 3,4

Select *
From Covid19Project..CovidDeaths
Where continent is not null
order by 3,4

--Select *
--From Covid19Project..CovidVaccinations
--order by 3,4

-- Select data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From Covid19Project..CovidDeaths
Where continent is not null
order by 1, 2

-- Looking at Total Cases vs Total Deaths

-- Shows likelyhood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)
From Covid19Project..CovidDeaths
Where continent is not null
order by 1, 2

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
Where continent is not null
Order by 1, 2

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
where location like '%states%'
and continent is not null
Order by 1, 2

-- Looking at Total Cases Vs Population
-- Shows what percentage of population got Covid

Select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Order by 1, 2

-- Looking at countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by location, population
Order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population

Select location, MAX(total_deaths) as TotalDeathCount
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by location
Order by TotalDeathCount desc

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by location
Order by TotalDeathCount desc

-- Lets break things down by continent

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is null
Group by location
Order by TotalDeathCount desc

-- Showing continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc

-- Global Numbers

Select date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Order by 1, 2

Select date, SUM(new_cases) --, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by date
Order by 1, 2

Select date, SUM(new_cases), SUM(cast(new_deaths as int)) --, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by date
Order by 1, 2

Select date, SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by date
Order by 1, 2

-- Per Day toal cases, total deaths and Death Percentage

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
Group by date
Order by 1, 2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Covid19Project..CovidDeaths
-- where location like '%states%'
Where continent is not null
-- Group by date
Order by 1, 2

-- Join both the Tables

Select * 
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
order by 1, 2

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 1, 2, 3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location)
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location)
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as RollingPeopleVaccinated
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3

-- USE CTE

With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
-- order by 2, 3
)
-- Select *
-- From PopvsVac
Select *, (RollingPeopleVaccinated/population)*100
From PopvsVac


-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
-- Where dea.continent is not null
-- order by 2, 3

Select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From Covid19Project..CovidDeaths dea
Join Covid19Project..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
-- order by 2, 3

Select *
From PercentPopulationVaccinated