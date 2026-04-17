/*
asasa

asas

asaas

*/

---BRIGHT COFFEE SHOP CASE STUDY

---Performing EDA to understand the dataset in detail and add some columns where is necessary

SELECT * 
FROM `workspace`.`default`.`bright_coffee_shop_analys` limit 100;

---Combining functions to get a clean enhased dataset
SELECT
      transaction_id,
      transaction_time,
      transaction_date,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail, 
---Adding columns to enhance the table for better insights
---Added new column 1.
    Dayname(transaction_date) AS Day_name,
---Added new column 2.
    Monthname(transaction_date) AS Month_name,
---Added new column 3.
    Dayofmonth(transaction_date) AS day_of_month, 
---Column 4 added to determine Satuday/Sunday
CASE 
    WHEN  Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weeked' 
    ELSE 'Weekday'
END AS Day_classification,
---Added New column 5. Time-Buckets
CASE 
    WHEN  date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN '1. Rush hour'
    WHEN  date_format(transaction_time, 'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '2.Mid_morning'
    WHEN  date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN '3. Afternoon'
    WHEN  date_format(transaction_time, 'HH:mm:ss') BETWEEN '16:00:00' AND '18:59:59' THEN '04. Rush hour'
    ELSE '05. Night'
END AS time_classification,
---Added new column 6
CASE
    WHEN (transaction_qty*unit_price) <=50 Then '01.low_spend'
    WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02.Medium Spend'
    WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03.Malotse'
     ELSE ('04.Mathipa')
END AS Spend_bucket,
---Added new column 7 Revenue
transaction_qty * unit_price AS Revenue
FROM `workspace`.`default`.`bright_coffee_shop_analys`
