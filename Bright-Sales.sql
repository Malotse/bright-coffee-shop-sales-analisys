-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
---BRIGHT COFFEE SHOP CASE STUDY


select * from `workspace`.`default`.`bright_coffee_shop_analys` limit 10;

---Total number of Stores
SELECT COUNT(DISTINCT store_id)
FROM `workspace`.`default`.`bright_coffee_shop_analys`;

---Total number of revenue from sales
SELECT SUM(transaction_qty * unit_price)
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 10;

---Avarage order value
SELECT AVG(unit_price)
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 10;

---Daily sales
SELECT transaction_date,
SUM(transaction_qty * unit_price) AS daily_sales
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GROUP BY transaction_date
ORDER BY transaction_date;

---Sales per month
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

SELECT
transaction_date,
transaction_time,
Dayname(transaction_date) AS day_name,
Monthname(transaction_date) AS month_name,
date_format(transaction_time,'HH:mm:ss') AS time_formatted,
CASE
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '1.Morning'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
END AS time_of_day,
CASE 
   WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'weekend'
   ELSE 'weekday'
END AS day_type,
SUM(transaction_qty * unit_price) AS revenue_per_day,
CASE
WHEN SUM(transaction_qty * unit_price) <=50 THEN '01.Low Spend'
WHEN SUM(transaction_qty * unit_price) BETWEEN 51 AND 100 THEN '02.Medium Spend'
ELSE '03.High Spend'
END AS spend_bucket,
store_location,
product_category,
product_detail
FROM `workspace`.`default`.`bright_coffee_shop_analys`
GROUP BY transaction_date,
transaction_time,
Dayname(transaction_date),
Monthname(transaction_date),
store_location,
product_category,
product_detail,
date_format(transaction_time,'HH:mm:ss'),
CASE
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '1.Morning'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '17:00:00' AND '23:59:59' THEN '03.Evening'
END,
CASE 
   WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'weekend'
   ELSE 'weekday'
END;
