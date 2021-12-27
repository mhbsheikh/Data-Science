use covid;

select * from CovidDeath;


-- change the datatype of columns
alter table CovidDeath alter column population bigint;


-- population - total cases - total deaths

-- in a country
select 
	location, 
	max(convert(bigint, population)) as total_population, 
	max(convert(bigint, total_cases)) as total_cases_count, 
	max(convert(int,total_deaths)) as total_death_count
from CovidDeath
where continent is not null
group by location
order by total_death_count desc;


-- in a continent
select 
	continent, 
	max(convert(bigint, population)) as total_population, 
	max(convert(bigint, total_cases)) as total_cases_count, 
	max(convert(int,total_deaths)) as total_death_count
from CovidDeath
where continent is not null
group by continent
order by total_death_count desc;


-- add death range tag based on deaths_per_million_count
select 
	continent, 
	max(convert(bigint, population)) as total_population, 
	max(convert(bigint, total_cases)) as total_cases_count, 
	max(convert(int,total_deaths)) as total_death_count,
	max(convert(float,total_deaths_per_million)) as deaths_per_million_count,
	case 
		when max(convert(float,total_deaths_per_million)) > 4500 then 'high'
		when max(convert(float,total_deaths_per_million)) between 3000 and 4500 then 'mid'
		when max(convert(float,total_deaths_per_million)) between 2000 and 3000 then 'moderate'
		else 'low'
	end death_range
from CovidDeath
where continent is not null
group by continent
order by total_death_count desc;


-- store the values in a temptable

-- drop the temp table if exists
drop table if  exists #temp_table;

-- create a temp table
create table #temp_table (
	continent varchar(20),
	total_population bigint,
	total_cases_count bigint,
	total_death_count int,
	deaths_per_million_count float,
	death_range varchar(20)
);

-- insert values to the temp table
insert into #temp_table
select 
	continent, 
	max(convert(bigint, population)) as total_population, 
	max(convert(bigint, total_cases)) as total_cases_count, 
	max(convert(int,total_deaths)) as total_death_count,
	max(convert(float,total_deaths_per_million)) as deaths_per_million_count,
	case 
		when max(convert(float,total_deaths_per_million)) > 4500 then 'high'
		when max(convert(float,total_deaths_per_million)) between 3000 and 4500 then 'mid'
		when max(convert(float,total_deaths_per_million)) between 2000 and 3000 then 'moderate'
		else 'low'
	end death_range
from CovidDeath
where continent is not null
group by continent
order by total_death_count desc;

-- show instances from the tamp table
select * from #temp_table;


-- toatl population, cases, deaths and tests in Bangladesh
select 
	max(convert(bigint, population)) as population_count,
	sum(convert(bigint, total_cases)) as cases_count,
	max(convert(bigint, total_deaths)) as death_count,
	max(convert(bigint, total_tests)) as test_count
from CovidDeath
where location like '%desh';


-- groupby and having
select 
	location, 
	max(convert(bigint, people_fully_vaccinated)) as vaccinated_sofar
from Vaccination
where continent is not null
group by location
having location like '%desh';


-- join two tables
select 
	c.continent, c.location, c.date, c.population, c.total_cases, c.total_deaths,
	v.people_fully_vaccinated, v.total_boosters_per_hundred, v.life_expectancy
from CovidDeath c
inner join Vaccination v
on c.location = v.location and c.date = v.date;


-- jon two tables and create views
create view temp_view
as
select 
	c.continent, c.location, c.date, c.population, c.total_cases, c.total_deaths,
	v.people_fully_vaccinated, v.total_boosters_per_hundred, v.life_expectancy
from CovidDeath c
inner join Vaccination v
on c.location = v.location and c.date = v.date;

select * from temp_view;


-- select necessary columns from view
select 
	distinct(location), 
	max(convert(bigint, population)) as total_population,
	max(convert(bigint, people_fully_vaccinated)) as pfv,
	max(convert(bigint, life_expectancy)) as max_life_expectancy
from temp_view
where continent is not null
group by location
order by pfv desc;


-- window function
