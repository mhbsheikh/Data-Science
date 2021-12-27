use covid;

select *
from CovidDeath
order by 2, 3;

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeath
where continent is not null
order by location, date;



-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, round((total_deaths/total_cases)*100, 2) as death_pct
from CovidDeath
where location like '%desh' and continent is not null
order by date desc;



-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
select location, date, population, total_cases, round((total_cases/population)*100, 2) as cases_pct
from CovidDeath
where continent is not null
order by date desc;



-- Countries with Highest Infection Rate compared to Population
select 
	location, population,
	max(total_cases) as HighestInfectionCount,
	max(round((total_cases/population)*100, 2)) as PctPopulationInfected
from CovidDeath
group by location, population
order by PctPopulationInfected desc;



-- Countries with Highest Death Count per Population
select	
	location, max(convert(bigint, total_deaths)) as total_death_count
from CovidDeath
where continent is not null
group by location
order by total_death_count desc;



-- contintents with the highest death count per population
select 
	continent, 
	max(convert(bigint, total_deaths)) as total_death_count
from CovidDeath
where continent is not null
group by continent
order by total_death_count desc;



-- global statistics
select 
	sum(new_cases) as total_cases,
	sum(convert(int, new_deaths)) as total_deaths,
	round((sum(convert(int, new_deaths)) / sum(new_cases))*100, 2) as death_pct
from CovidDeath
where continent is not null;



-- country wise statistics
select 
	max(convert(bigint, population)) as population_count,
	sum(new_cases) as total_cases,
	sum(convert(int, new_deaths)) as total_deaths,
	round((sum(convert(int, new_deaths)) / sum(new_cases))*100, 2) as death_pct
from CovidDeath
where continent is not null and location like '%desh'



-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
select	
	c.continent, c.location, c.date, c.population, v.new_vaccinations,
	sum(convert(bigint, v.new_vaccinations)) over (partition by c.location order by c.location, c.date) as RollingPeopleVaccinated
from CovidDeath c
join Vaccination v
	on c.location = v.location and c.date = v.date
where c.continent is not null
order by c.location, c.date;



-- Using CTE to perform Calculation on Partition By in previous query
with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
	Select 
		dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
		SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
	From CovidDeath dea
	Join Vaccination vac
		On dea.location = vac.location and dea.date = vac.date
	where dea.continent is not null 
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated;

Create Table #PercentPopulationVaccinated
(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select 
	d.continent, d.location, d.date, d.population, v.new_vaccinations,
	sum(convert(bigint, v.new_vaccinations)) over (partition by d.location order by d.location, d.date) as RollingPeopleVaccinated
from CovidDeath d
inner join Vaccination v
	on d.location = v.location and d.date = v.date
where d.continent is not null

select * from #PercentPopulationVaccinated;



-- Creating View to store data for later visualizations
drop view if exists PercentPopulationVaccinated;

create view PercentPopulationVaccinated 
as
select 
	d.continent, d.location, d.date, d.population, v.new_vaccinations,
	sum(convert(bigint, v.new_vaccinations)) over (partition by d.location order by d.location, d.date) as RollingPeopleVaccinated
from CovidDeath d
inner join Vaccination v
	on d.location = v.location and d.date = v.date
where d.continent is not null

select * from PercentPopulationVaccinated;
