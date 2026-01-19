/* ====================================================
   Restaurant SQL Analysis
   Description:
   SQL queries to analyze restaurant data across
   countries, cities, ratings, pricing, and services.
   ==================================================== */

-------------------------------------------------------
-- 1) Restaurants based on Countries
-------------------------------------------------------
SELECT 
    COUNT(DISTINCT CountryName) AS total_country
FROM country;


-------------------------------------------------------
-- 2) Restaurants based on Cities
-------------------------------------------------------
SELECT 
    COUNT(DISTINCT City) AS Total_Cities
FROM restaurantdetail;


-------------------------------------------------------
-- 3) Total Restaurants
-------------------------------------------------------
SELECT 
    COUNT(*) AS total_restaurants
FROM restaurantdetail;


-------------------------------------------------------
-- 4) Total Votes
-------------------------------------------------------
SELECT 
    SUM(Votes) AS Total_Votes
FROM restaurantdetail;


-------------------------------------------------------
-- 5) Average Restaurant Rating
-------------------------------------------------------
SELECT 
    ROUND(AVG(Rating), 2) AS Avg_Rating
FROM restaurantdetail;


-------------------------------------------------------
-- 6) Restaurants Opening by Year
-------------------------------------------------------
SELECT 
    Year_Opening AS Year,
    COUNT(*) AS Total_Restaurants
FROM restaurantdetail
GROUP BY Year_Opening
ORDER BY Year_Opening;


-------------------------------------------------------
-- Restaurants Opening by Month
-------------------------------------------------------
SELECT 
    Month_Opening AS Month,
    COUNT(*) AS Total_Restaurants
FROM restaurantdetail
GROUP BY Month_Opening
ORDER BY Month_Opening;


-------------------------------------------------------
-- Restaurants Opening by Quarter
-------------------------------------------------------
SELECT 
    CASE 
        WHEN Month_Opening IN (1, 2, 3) THEN 'Q1'
        WHEN Month_Opening IN (4, 5, 6) THEN 'Q2'
        WHEN Month_Opening IN (7, 8, 9) THEN 'Q3'
        WHEN Month_Opening IN (10, 11, 12) THEN 'Q4'
    END AS Quarter,
    COUNT(*) AS Total_Restaurants
FROM restaurantdetail
GROUP BY 
    CASE 
        WHEN Month_Opening IN (1, 2, 3) THEN 'Q1'
        WHEN Month_Opening IN (4, 5, 6) THEN 'Q2'
        WHEN Month_Opening IN (7, 8, 9) THEN 'Q3'
        WHEN Month_Opening IN (10, 11, 12) THEN 'Q4'
    END
ORDER BY Quarter;


-------------------------------------------------------
-- 7) Number of Restaurants by City
-------------------------------------------------------
SELECT 
    City,
    COUNT(RestaurantID) AS Total_Restaurants
FROM restaurantdetail
GROUP BY City
ORDER BY Total_Restaurants DESC;


-------------------------------------------------------
-- 8) Number of Restaurants by Country
-------------------------------------------------------
SELECT 
    c.CountryName,
    COUNT(r.RestaurantID) AS Total_Restaurants
FROM restaurantdetail r
JOIN country c 
    ON r.CountryCode = c.CountryCode
GROUP BY c.CountryName
ORDER BY Total_Restaurants DESC;


-------------------------------------------------------
-- 9) Restaurant Percentage by Online Delivery
-------------------------------------------------------
SELECT 
    Has_Online_Delivery,
    COUNT(*) AS Total_Restaurants,
    FLOOR(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurantdetail)
    ) AS Percentage
FROM restaurantdetail
GROUP BY Has_Online_Delivery;


-------------------------------------------------------
-- 10) Restaurant Percentage by Table Booking
-------------------------------------------------------
SELECT 
    Has_Table_Booking,
    COUNT(*) AS Total_Restaurants,
    FLOOR(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurantdetail)
    ) AS Percentage
FROM restaurantdetail
GROUP BY Has_Table_Booking;


-------------------------------------------------------
-- 11) Restaurants by Price Bucket (INR)
-------------------------------------------------------
SELECT 
    CASE 
        WHEN Indian_Rupees_Cost <= 500 THEN '0-500'
        WHEN Indian_Rupees_Cost <= 1000 THEN '501-1000'
        WHEN Indian_Rupees_Cost <= 2000 THEN '1001-2000'
        WHEN Indian_Rupees_Cost <= 3000 THEN '2001-3000'
        WHEN Indian_Rupees_Cost <= 4000 THEN '3001-4000'
        ELSE '4001+'
    END AS Price_Bucket,
    COUNT(*) AS Total_Restaurants
FROM restaurantdetail
GROUP BY 
    CASE 
        WHEN Indian_Rupees_Cost <= 500 THEN '0-500'
        WHEN Indian_Rupees_Cost <= 1000 THEN '501-1000'
        WHEN Indian_Rupees_Cost <= 2000 THEN '1001-2000'
        WHEN Indian_Rupees_Cost <= 3000 THEN '2001-3000'
        WHEN Indian_Rupees_Cost <= 4000 THEN '3001-4000'
        ELSE '4001+'
    END
ORDER BY Price_Bucket;
--
