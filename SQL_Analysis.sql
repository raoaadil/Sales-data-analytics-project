USE project;
SELECT *
FROM mysql_analysis;

-- Total Sales (KPI)
SELECT
    ROUND(SUM(Sales),2) AS Total_Sales
FROM mysql_analysis;

-- Total Profit (KPI)
SELECT
    ROUND(SUM(Profit),2) AS Total_Profit
FROM mysql_analysis;

-- Total Orders (KPI)
SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM mysql_analysis;

-- Monthly Sales Trend
SELECT
    MONTH(Order_Date) AS Month_No,
    MONTHNAME(Order_Date) AS Month_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM mysql_analysis
GROUP BY
    MONTH(Order_Date),
    MONTHNAME(Order_Date)
ORDER BY Month_No;

-- Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM mysql_analysis
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Top 5 Products by Sales
SELECT
    Product,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM mysql_analysis
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 5;

-- Sales by City
SELECT
    City,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM mysql_analysis
GROUP BY City
ORDER BY Total_Sales DESC;

-- Payment Method Analysis
SELECT
    Payment_Method,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM mysql_analysis
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;

-- Top 10 Customers by Revenue
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales),2) AS Total_Revenue
FROM mysql_analysis
GROUP BY
    Customer_ID,
    Customer_Name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Return Rate by Category
SELECT
    Category,
    ROUND(
        SUM(CASE
            WHEN Returned = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),2
    ) AS Return_Rate
FROM mysql_analysis
GROUP BY Category
ORDER BY Return_Rate DESC;

-- Customer Retention Rate
SELECT 
	YEAR(this_month.Order_Date) AS month_date,
    COUNT(DISTINCT last_month.Customer_ID) AS Customers
FROM mysql_analysis this_month
LEFT JOIN mysql_analysis last_month
ON this_month.Customer_ID = last_month.Customer_ID and 
								TIMESTAMPDIFF(YEAR, last_month.Order_Date, this_month.Order_Date) = 1
GROUP BY YEAR(this_month.Order_Date);