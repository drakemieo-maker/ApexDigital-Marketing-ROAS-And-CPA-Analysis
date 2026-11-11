USE ApexDigital_Marketing;

SELECT 
    c.Platform,
    SUM(a.Clicks) AS Total_Clicks,
    SUM(a.Conversions) AS Total_Conversions,
    SUM(a.Ad_Spend_USD) AS Total_Spend_USD,
    SUM(a.Revenue_Generated_USD) AS Total_Revenue_USD,
    ROUND(SUM(a.Revenue_Generated_USD) / SUM(a.Ad_Spend_USD), 2) AS ROAS_Multiplier,
    ROUND(SUM(a.Ad_Spend_USD) / SUM(a.Conversions), 2) AS CPA_Cost_Per_Customer_USD
FROM Ad_Performance_Logs a
INNER JOIN Campaigns_Info c ON a.Campaign_ID = c.Campaign_ID
GROUP BY c.Platform
ORDER BY ROAS_Multiplier DESC;


SELECT 
    c.Campaign_Name,
    c.Platform,
    c.Target_Region,
    SUM(a.Clicks) AS Total_Clicks,
    SUM(a.Ad_Spend_USD) AS Total_Spend_USD,
    SUM(a.Revenue_Generated_USD) AS Total_Revenue_USD,
    SUM(a.Revenue_Generated_USD - a.Ad_Spend_USD) AS Net_Ad_Profit_USD,
    ROUND(SUM(a.Revenue_Generated_USD) / SUM(a.Ad_Spend_USD), 2) AS ROAS,
    CASE 
        WHEN SUM(a.Revenue_Generated_USD) / SUM(a.Ad_Spend_USD) >= 4.0 THEN 'SCALE BUDGET (High ROI)'
        WHEN SUM(a.Revenue_Generated_USD) / SUM(a.Ad_Spend_USD) >= 1.5 THEN 'OPTIMIZE (Moderate ROI)'
        ELSE 'PAUSE IMMEDIATELY (Burning Cash)'
    END AS Budget_Recommendation
FROM Ad_Performance_Logs a
INNER JOIN Campaigns_Info c ON a.Campaign_ID = c.Campaign_ID
GROUP BY c.Campaign_Name, c.Platform, c.Target_Region
ORDER BY Net_Ad_Profit_USD DESC;

