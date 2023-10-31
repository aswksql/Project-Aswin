-- Create a database named sales_data
CREATE DATABASE sales_data;

-- Create a table called sales_sample with columns
CREATE TABLE sales_sample (
    product_id INT PRIMARY KEY,
    region TEXT NOT NULL, CHECK (region IN ('East', 'West', 'North', 'South')),
    sale_date DATE NOT NULL,
    sales_amount INT NOT NULL
);

-- Insert 10 sample records into the table (Tamil Nadu specific)
INSERT INTO sales_sample (product_id, region, sale_date, sales_amount)
VALUES
    (101, 'East', '2023-10-21', 5000),
    (102, 'South', '2023-10-21', 7500),
    (103, 'West', '2023-10-21', 6000),
    (104, 'North', '2023-10-22', 4500),
    (105, 'East', '2023-10-22', 5500),
    (106, 'South', '2023-10-23', 7000),
    (107, 'West', '2023-10-23', 8000),
    (108, 'North', '2023-10-24', 4000),
    (109, 'East', '2023-10-25', 5200),
    (110, 'South', '2023-10-25', 7800);

-- Drill down query from region to product level
SELECT region, product_id, SUM(sales_amount) AS total_sales
FROM sales_sample
GROUP BY region, product_id
ORDER BY region, product_id;

-- Roll up query from product to region level
SELECT product_id,region, SUM(sales_amount) AS total_sales
FROM sales_sample
GROUP BY Rollup (product_id,region) --Roll up Operation
Order BY product_id,region;

--Cube query to explore sales data from different perspectives 
SELECT product_id, region, sale_date, Sum(sales_amount)
FROM sales_sample
Group BY Cube (product_id, region, sale_date) --Cube Operation
ORDER BY product_id, region, sale_date;

-- Slice query to view sales for a specific region or date range
SELECT product_id, region, sale_date, sales_amount
FROM sales_sample
WHERE region = 'East' --Replace 'East' as desired
AND sale_date BETWEEN '2023-10-21' AND '2023-10-23' --Replace date range as desired
ORDER BY product_id, region, sale_date;

-- Dice Query to view sales for specific combinations of product, region, and date
SELECT product_id, region, sale_date, sales_amount
FROM sales_sample
WHERE (region = 'South' AND sale_date = '2023-10-21')
   OR (region = 'North' AND sale_date = '2023-10-24')
ORDER BY product_id, region, sale_date;