-- Showing the year that countries started producing more coal than consuming (if applicable)
SELECT Country, Year, Coal_production, Coal_consumption
FROM NaturalResources.`coal_resources(in)`
Group by Country, Year, Coal_production, Coal_consumption
Order By 1;
-- This is used to find whether or not countries started producing more coal than consuming. Some countries are shown to use all of the coal they produce, meaning none is exported.

-- Does population affect coal consumption in all countries? 
SELECT Country, SUM(coal_consumption/population) as TotalConsumptionpercapita
FROM NaturalResources.`coal_resources(in)`
Group by Country
Order by TotalConsumptionpercapita DESC;
-- Based on these findings, coal consumption is not affected by population. We know that places like China, India, and Monaco are the most densly populated countries. Now whether they rely on coal is one thing but population does not directly tie into coal consumption.

-- Do countries export more coal than what they have in their reserves?
SELECT SUM(Coal_exports-Coal_reserves), Country
FROM NaturalResources.`coal_resources(in)` 
Group By Country
Order by 1;
-- This shows nations that export more coal for profit rather than hold onto and store for their nation. These countries more than likely view coal as an economic resource versus a natural resource.alter

-- Profitable countries by coal exports
SELECT (Coal_exports_per_capita-Coal_imports_per_capita) as Profit, Country, Year
FROM NaturalResources.`coal_resources(in)`
Order by Profit desc;
-- This value shows the nations exports per capita subtracted by the imports per capita to get the difference in profit versus loss in the trading of coal. Although the value does not represent the actual profit number, it is a value that skews based on positives or negatives for the question.

-- Countries annually who rely most reliant on coal for their economic stability
SELECT Country, Population, Year, MAX(Coal_production/population) as NationalImportance
FROM NaturalResources.`coal_resources(in)`
Group by Country, Population, Year
Order by NationalImportance DESC;
-- This value shows how focusued the country is on everything coal, whether for energy usage for the natives, or economic value in trade. Australia has consistently had the numbers showing how important the resource coal is for their nations stability.

-- Do Countries have enough reserves as per the population
Select Population, Country, Year, SUM(Coal_reserves) as Reserves, SUM(Population/(Coal_reserves)*(100)) as Units_Per_Population_Percantage
FROM NaturalResources.`coal_resources(in)`
Group by Population, Country, Year
Order by 5 desc;
-- ^ Countries with Null data are negative values (They have no positive value for the majority of the nation meaning that the nation cannot thrive off of the coal per person ratio.

--
