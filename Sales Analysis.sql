/*
asasa

asas

asaas

*/


---BRIGHT COFFEE SHOP CASE STUDY

---Performing EDA to understand the dataset in detail
SELECT * 
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 10;


---Exploring a total number of Stores
SELECT COUNT(DISTINCT store_id)
FROM `workspace`.`default`.`bright_coffee_shop_analys`;


---Total number of revenue from sales
SELECT SUM(transaction_qty * unit_price)
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 10;


---Searching for the cheapest product from the dataset
SELECT MIN(unit_price) AS cheapest_price
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 10;


----Searching for the most expensive product from the dataset
SELECT MAX(unit_price) AS expensive_price
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 10

---Examining a total daily sales made
SELECT transaction_date,
SUM(transaction_qty * unit_price) AS daily_sales
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GROUP BY transaction_date
ORDER BY transaction_date;


---Total ales per month
SELECT DATE_FORMAT(transaction_date, 'yyyy-MM') AS month,
SUM(transaction_qty * unit_price) AS monthly_sales
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GRoUP BY month;


---Top 5 selling lines
SELECT product_detail,
SUM(transaction_qty * unit_price) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GROUP BY product_detail
ORDER BY total_revenue DESC
LIMIT 5;


--- Worse performing stores
SELECT
    store_location,
    SUM(transaction_qty * unit_price) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GROUP BY store_location
ORDER BY total_revenue ASC
LIMIT 5;


---Store by store sales comparison
SELECT store_location,
SUM(transaction_qty * unit_price) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GROUP BY store_location
ORDER BY total_revenue DESC;

---Revealing number of stores,number of rows,number of product sold and number of sales made
SELECT COUNT(*) AS number_of_rows,
       COUNT(DISTINCT transaction_id) AS number_of_sales,
       COUNT(DISTINCT product_id) AS number_of_products,
       COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`bright_coffee_shop_analys`
