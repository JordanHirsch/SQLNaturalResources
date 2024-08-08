-- Basis for entire Query
SELECT * 
FROM NaturalResources.`gas_resources(in)`
Order by 1,2;

-- Does the amount of gas imported reflected by the population 
Select Gas_imports, Gas_imports_per_capita, Gas_net_imports_per_capita, Gas_net_imports, Country, Population
From NaturalResources.`gas_resources(in)`
Where Gas_imports > 0
Group by Country, Gas_imports, Gas_imports_per_capita, Gas_net_imports_per_capita, Gas_net_imports, Population
Order by 6 desc;
-- No, the net imports all vary based on population size

-- Which of the countries are imported for usage and which are imported for economic reasons
Select Country, Gas_net_imports_per_capita, Year, Gas_consumption_per_capita, SUM(Gas_net_imports_per_capita-Gas_consumption_per_capita) as Difference
From NaturalResources.`gas_resources(in)`
Where Gas_net_imports_per_capita > 0
Group by Country, Gas_net_imports_per_capita, Gas_consumption_per_capita, Year
Order by 5 desc;
-- If the difference is greater than 0, then the country imports for economic reasons, since they export more than they use. If it is lower than 0, then more is consumed than imported, so they use what they have and what is imported.alter

-- Which country generates the most export value
SELECT Country, Export_Difference, Gas_production
FROM (
    SELECT Country, SUM(Gas_exports - Gas_imports) AS Export_Difference, Gas_production
    FROM NaturalResources.`gas_resources(in)`
    GROUP BY Country, Gas_production
) AS subquery
WHERE Export_Difference <> 0
ORDER BY Export_Difference DESC;
-- Showing countries that show a positive and negative value for export differences and those who produce gas.

-- Average Gas consumption per person vs Gas consumption, showing how the popualtion could skew the data
Select AVG(Gas_consumption_per_capita), Gas_consumption, Country, Population
    FROM NaturalResources.`gas_resources(in)`
    Group By Country, Gas_consumption, Population
    Order by 1 desc;
-- This shows that population does not skew results of gas consumption since the population for Luxembourg is lower than many countries yet its consumption is amongst the highest total and per capita.