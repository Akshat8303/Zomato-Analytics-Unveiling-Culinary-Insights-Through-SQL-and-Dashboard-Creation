CREATE DATABASE Zomato;

use Zomato;

show tables;

select * from restaurants;

select count(res_id) from restaurants;

-- Top 10 highest-rated restaurants in India
SELECT distinct name, city, aggregate_rating
FROM restaurants
ORDER BY aggregate_rating DESC
LIMIT 10;

-- Top 5 most popular cuisines among highly-rated restaurants
SELECT cuisines, COUNT(*) AS restaurant_count
FROM restaurants
WHERE aggregate_rating >= 4.0
GROUP BY cuisines
ORDER BY restaurant_count DESC
LIMIT 5;

-- Most popular cuisine in each Indian state
SELECT city, cuisines, COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY city, cuisines
ORDER BY restaurant_count DESC;

-- Relationship between cuisine type and restaurant rating
SELECT cuisines, AVG(aggregate_rating) AS average_rating
FROM restaurants
GROUP BY cuisines
ORDER BY average_rating DESC;

-- Cities with the highest concentration of restaurants
SELECT city, COUNT(*) AS restaurant_count
FROM restaurants
GROUP BY city
ORDER BY restaurant_count DESC;

-- Percentage of restaurants in India that offer online ordering
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurants)) AS percentage_online_ordering
FROM restaurants
WHERE delivery = 1 OR takeaway = 1;

-- Factors that influence a restaurant's decision to offer online ordering
SELECT delivery, takeaway, cuisines, city,
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurants)) AS percentage_online_ordering
FROM restaurants
GROUP BY delivery, takeaway, cuisines, city
ORDER BY percentage_online_ordering DESC;

-- Find establishments with a high number of votes and low average cost for two
SELECT name, establishment, votes, average_cost_for_two
FROM restaurants
WHERE votes > 500 AND average_cost_for_two < 300;

-- Calculate the percentage of establishments offering takeaway in each city
SELECT city, (SUM(takeaway) / COUNT(*)) * 100 AS takeaway_percentage
FROM restaurants
GROUP BY city;

-- Calculate the total votes and photo count for establishments in each city
SELECT city, SUM(votes) AS total_votes, SUM(photo_count) AS total_photos
FROM restaurants
GROUP BY city;

-- Retrieve establishments with the highest and lowest price range in each city
SELECT city, MAX(price_range) AS max_price_range, MIN(price_range) AS min_price_range
FROM restaurants
GROUP BY city;

-- Find the top-rated cuisines in terms of average aggregate rating
SELECT cuisines, AVG(aggregate_rating) AS avg_rating
FROM restaurants
GROUP BY cuisines
ORDER BY avg_rating DESC
LIMIT 5;

-- Count the number of establishments offering delivery in each city
SELECT
    city,
    SUM(delivery = 1) AS delivery_count
FROM
    restaurants
GROUP BY
    city;
    
-- Calculate the average aggregate rating for establishments with and without opentable support
SELECT opentable_support, AVG(aggregate_rating) AS avg_rating
FROM restaurants
GROUP BY opentable_support;

-- Count the number of establishments in each price range in a specific city
SELECT city, price_range, COUNT(*) AS establishments_count
FROM restaurants
GROUP BY city, price_range;

