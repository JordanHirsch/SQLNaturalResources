-- Basis for queries
SELECT * 
FROM NaturalResources.`oil_resources(in)`
ORDER BY 1;

-- Countries who are most reliant on oil
SELECT SUM(Oil_consumption + Oil_imports + Oil_production + Oil_exports) AS Oil_Totals, Country
FROM NaturalResources.`oil_resources(in)`
GROUP BY Country
ORDER BY Oil_Totals DESC;
-- This shows Japan as the most reliant on oil for economy in imports, exports, and consumptions and usage.

-- Top 10 oil producers worldwide
Select Country, SUM(Oil_production) AS Total_Production
FROM NaturalResources.`oil_resources(in)`
GROUP BY Country
ORDER BY Total_Production DESC 
LIMIT 10;
-- Norway has been the leading oil producer worldwide

-- Production Growth in countries in the last 5 years
SELECT Country, (MAX(Oil_production) - MIN(Oil_production)) AS Production_Growth 
FROM NaturalResources.`oil_resources(in)`
WHERE Year >= (YEAR(CURDATE()) - 5) 
GROUP BY Country 
ORDER BY Production_Growth DESC
Limit 20;
-- Norway has exponentially gapped the other countries listed, showing the importance of oil in their country

-- How long can countries continue producing oil at its current rate based on reserves
SELECT Country, MAX(Oil_reserves) / SUM(Oil_production) AS Reserve_Production_Ratio 
FROM NaturalResources.`oil_resources(in)`
GROUP BY Country 
ORDER BY Reserve_Production_Ratio DESC;
-- Jordan is proven to be the best country worldwide for its lasting reserves and production. On a geographical note, notice how the top 10 countries are majority Middle Eastern/African nations.

-- Oil trade balance by region
SELECT Country, SUM(Oil_exports - Oil_imports) as Trade_Balance
FROM NaturalResources.`oil_resources(in)`
GROUP BY Country
ORDER BY Trade_Balance DESC;
-- Other than Norway being an anomaly, the other countries are of warmer climates and closer to the equator.