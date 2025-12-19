Create Database Zudio
Use Zudio

-- Data imported Successfully 
Select * from Sales
Select * from Product
Select * from Customer
Select * from Store

-- Checking inserted Row Counts
SELECT 'Sales' AS TableName, COUNT(*) AS Row_Count FROM Sales;
SELECT 'Store' AS TableName, COUNT(*) AS Row_Count FROM Store;
SELECT 'Product' AS TableName, COUNT(*) AS Row_Count FROM Product;
SELECT 'Customer' AS TableName, COUNT(*) AS Row_Count FROM Customer;

-- Distinct primary_id counts (to check duplicates)
SELECT 'Sales' AS TableName, COUNT(DISTINCT Order_ID) AS DistinctKeys FROM Sales;
SELECT 'Store' AS TableName, COUNT(DISTINCT Store_ID) AS DistinctKeys FROM Store;
SELECT 'Product' AS TableName, COUNT(DISTINCT Product_ID) AS DistinctKeys FROM Product;
SELECT 'Customer' AS TableName, COUNT(DISTINCT Customer_ID) AS DistinctKeys 
FROM Customer;

Select * from Sales
-- Rename column Name to Sales
SP_RENAME 'Sales.Amount','Sales','Column';
-- Sales table checking columns for null
SELECT 
  SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS OrderID_Null,
  SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS OrderDate_Null,
  SUM(CASE WHEN Store_ID IS NULL THEN 1 ELSE 0 END) AS StoreID_Null,
  SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS CustomerID_Null,
  SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS ProductID_Null,
  SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_Null,
  SUM(CASE WHEN Unit_Price IS NULL THEN 1 ELSE 0 END) AS UnitPrice_Null,
  SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_Null,
  SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Null
FROM Sales;

Select * from Customer
-- Customer table checking columns for null
SELECT
  SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS CustomerID_Null,
  SUM(CASE WHEN Customer_Name IS NULL THEN 1 ELSE 0 END) AS CustomerName_Null,
  SUM(CASE WHEN Customer_Age IS NULL THEN 1 ELSE 0 END) AS CustomerAge_Null,
  SUM(CASE WHEN Customer_Gender IS NULL THEN 1 ELSE 0 END) AS CustomerGender_Null,
  SUM(CASE WHEN Customer_Contact IS NULL THEN 1 ELSE 0 END) AS CustomerContact_Null
FROM Customer;

Select * from Product
-- Product table checking Columns for null
SELECT
  SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS ProductID_Null,
  SUM(CASE WHEN Product_Name IS NULL THEN 1 ELSE 0 END) AS ProductName_Null,
  SUM(CASE WHEN Product_Category IS NULL THEN 1 ELSE 0 END) AS ProductCategory_Null,
  SUM(CASE WHEN Product_Type IS NULL THEN 1 ELSE 0 END) AS ProductType_Null,
  SUM(CASE WHEN Unit_Cost IS NULL THEN 1 ELSE 0 END) AS UnitCost_Null,
  SUM(CASE WHEN Unit_Price IS NULL THEN 1 ELSE 0 END) AS UnitPrice_Null
FROM Product;

Select * from Store
-- Store table checking columns for NULL 
SELECT 
  SUM(CASE WHEN Store_ID IS NULL THEN 1 ELSE 0 END) AS StoreID_Null,
  SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_Null,
  SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null,
  SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Null,
  SUM(CASE WHEN Postal_Code IS NULL THEN 1 ELSE 0 END) AS PostalCode_Null,
  SUM(CASE WHEN Store_Address IS NULL THEN 1 ELSE 0 END) AS StoreAddress_Null,
  SUM(CASE WHEN Selling_Area_Size_sqft IS NULL THEN 1 ELSE 0 END) AS SellingAreaSizesqft_Null,
  SUM(CASE WHEN Store_Type IS NULL THEN 1 ELSE 0 END) AS StoreType_Null,
  SUM(CASE WHEN Operating_Start IS NULL THEN 1 ELSE 0 END) AS OperatingStart_Null,
  SUM(CASE WHEN Operating_End IS NULL THEN 1 ELSE 0 END) AS OperatingEnd_Null,
  SUM(CASE WHEN Store_Open_Date IS NULL THEN 1 ELSE 0 END) AS StoreOpenDate_Null,
  SUM(CASE WHEN Parking_Availability IS NULL THEN 1 ELSE 0 END) AS ParkingAvailability_Null,
  SUM(CASE WHEN Security_Features IS NULL THEN 1 ELSE 0 END) AS SecurityFeatures_Null,
  SUM(CASE WHEN Staff_Count IS NULL THEN 1 ELSE 0 END) AS StaffCount_Null,
  SUM(CASE WHEN Manager_ID IS NULL THEN 1 ELSE 0 END) AS ManagerID_Null,
  SUM(CASE WHEN Manager_Name IS NULL THEN 1 ELSE 0 END) AS ManagerName_Null
FROM Store;

--Setting Foreign Key to the Fact Table (Sales) 
ALTER TABLE Sales
ADD CONSTRAINT fk_Product
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID);

ALTER TABLE Sales
ADD CONSTRAINT fk_Customer
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID);

ALTER TABLE Sales
ADD CONSTRAINT fk_Store
FOREIGN KEY (Store_ID) REFERENCES Store(Store_ID);

-- Validation 
-- Total Sales
Select SUM(Sales) As Total_Sales from Sales
-- Total Profit 
Select Sum(Profit) As Total_Profit from Sales
-- Total Quantity sold
Select Sum(Quantity) As Total_QuantitySold from Sales
-- Total Orders 
Select Count(Order_ID) As Total_Orders from Sales
-- Total Customers who purchased in this year
Select Count(Distinct Customer_ID) As Total_Customers from Sales
-- Total No of Products
Select Count(Distinct Product_ID) As Total_Products from Sales
-- Total No of Stores
Select Count(Distinct Store_ID) As Total_Stores from Sales


-- A. Retail Sales Performance Overview 
-- 1. Which store perform the best and worst? 
-- Best performing Store 
SELECT TOP 1
    s.Store_ID,
    s.City,
    SUM(f.Sales) AS Total_Sales
FROM Sales f
JOIN Store s ON f.Store_ID = s.Store_ID
GROUP BY s.Store_ID, s.City
ORDER BY Total_Sales DESC;

-- Worst performing store inluding store with zero sales if have using left_join and Isnull
SELECT TOP 1
    s.Store_ID,
    s.City,
    ISNULL(SUM(f.Sales), 0) AS Total_Sales
FROM Store s
LEFT JOIN Sales f ON s.Store_ID = f.Store_ID
GROUP BY s.Store_ID, s.City
ORDER BY Total_Sales ASC;

-- Store Summary
SELECT 
    s.Store_ID,
    s.Store_Type,
    s.State,
    s.City,
    s.Store_Address,
    ISNULL(SUM(f.Sales), 0) AS Total_Sales,
    ISNULL(SUM(f.Profit), 0) AS Total_Profit,
    ISNULL(SUM(f.Quantity), 0) AS Total_Quantity
FROM Store s
LEFT JOIN Sales f ON s.Store_ID = f.Store_ID
GROUP BY 
    s.Store_ID, s.Store_Type, s.State, s.City, s.Store_Address
ORDER BY Total_Sales DESC;

-- 2. Month wise profit increasing or deacreasing? (Monthly Sales)
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Profit) AS Monthly_Profit
FROM Sales
GROUP BY 
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY 
    YEAR(Order_Date),
    MONTH(Order_Date);

-- 4. Which State/city generate highest revenue?
-- State revenue
SELECT s.State, SUM(f.Sales) AS State_Sales
FROM Sales f JOIN Store s ON f.Store_ID = s.Store_ID
GROUP BY s.State
ORDER BY State_Sales DESC;
-- City revenue
SELECT s.State, s.City, SUM(f.Sales) AS City_Sales
FROM Sales f JOIN Store s ON f.Store_ID = s.Store_ID
GROUP BY s.State, s.City
ORDER BY City_Sales DESC;

-- 5. Quarterly Sales and No of Orders
SELECT 
    YEAR(Order_Date) AS Sales_Year,
    DATEPART(QUARTER, Order_Date) AS Quarter_Number,
    SUM(Sales) AS Total_Sales,
    COUNT(DISTINCT Order_Id) AS Total_Orders
FROM Sales
GROUP BY 
    YEAR(Order_Date),
    DATEPART(QUARTER, Order_Date)
ORDER BY 
    YEAR(Order_Date),
    DATEPART(QUARTER, Order_Date);

-- B. Customer Behaviour Segmentation Problems
-- 1. Monthly Sales
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales
FROM Sales
GROUP BY 
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY 
    YEAR(Order_Date),
    MONTH(Order_Date);
-- Power BI steps 

-- 2. Who are high-value customers?
SELECT Top 5 c.Customer_ID, c.Customer_Name, COUNT(DISTINCT f.Order_ID) AS Orders,
       SUM(f.Sales) AS Total_Sales, SUM(f.Quantity) AS Total_Quantity
FROM Sales f
JOIN Customer c ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Sales DESC;

-- 3. How many customers are repeat vs one-time buyers?
SELECT
  CASE WHEN Orders = 1 THEN 'One-time' ELSE 'Repeat' END AS Buyer_Type,
  COUNT(*) AS Customer_Count
FROM (
  SELECT Customer_ID, COUNT(DISTINCT Order_ID) AS Orders
  FROM Sales
  GROUP BY Customer_ID
) t
GROUP BY CASE WHEN Orders = 1 THEN 'One-time' ELSE 'Repeat' END;

-- 4. Customers Volume by Region (distinct customers)
SELECT s.Region, COUNT(DISTINCT f.Customer_ID) AS Unique_Customers
FROM Sales f
JOIN Customer c ON f.Customer_ID = c.Customer_ID
JOIN Store s ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY Unique_Customers DESC;

-- 5. Sales by Payment Method
SELECT
    Payment_Method,
    SUM(Sales) AS Total_Sales,
    COUNT(DISTINCT Order_Id) AS Total_Orders
FROM Sales
GROUP BY Payment_Method
ORDER BY Total_Sales DESC;

-- 6. Sales by Age Group
-- Via Power BI

-- C. Product and Inventory Insights
-- 1. Which Product_Type sell the most?
SELECT Top 1 p.Product_Type, SUM(f.Quantity) AS Total_Quantity, SUM(f.Sales) AS Total_Sales
FROM Sales f JOIN Product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Type
ORDER BY Total_Quantity DESC;

-- 2. Which product category drive the highest sales?
SELECT Top 1 p.Product_Category, COUNT(DISTINCT f.Order_ID) AS Orders,
       SUM(f.Quantity) AS Total_Quantity, SUM(f.Sales) AS Total_Sales
FROM Sales f
JOIN Product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Total_Sales DESC;

-- 3. Which product trending the most?
SELECT Top 5 p.Product_Name, COUNT(DISTINCT f.Order_ID) AS Orders,
       SUM(f.Quantity) AS Total_Quantity, SUM(f.Sales) AS Total_Sales
FROM Sales f
JOIN Product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Total_Sales DESC;

-- 4. which product is most profitable?	
SELECT Top 5 p.Product_Name,SUM(f.Profit) AS Total_Profit
FROM Sales f JOIN Product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Total_Profit DESC;


-- 5. Which stores have low performance but large footfall potential?
-- High potential => 12
SELECT top 5
    s.Store_ID,
    s.Store_Type,
    s.Staff_Count,
    SUM(f.Sales) AS Total_Sales
FROM Store s
JOIN Sales f 
    ON s.Store_ID = f.Store_ID
Where s.Staff_Count >= 12
GROUP BY 
    s.Store_ID, 
    s.Store_Type, 
    s.Staff_Count
ORDER BY Total_Sales ASC;
-- Have some power bi steps to get result proper

-- 6. What is the correlation between store size & sales?
SELECT 
    St.Selling_Area_Size_sqft,
    SUM(S.Sales) AS TotalSales
FROM Sales S
JOIN Store St ON S.Store_ID = St.Store_ID
GROUP BY St.Selling_Area_Size_sqft;

-- D. Sales Forecasting Problems
-- 1. What will be the expected sales for next months?
SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales
FROM Sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;
-- Power Bi Steps

-- 2.	Which categories will grow in future?
-- Power BI

-- 3. Which stores need replenishment planning?
SELECT 
    st.Store_ID,
    st.Store_Type,
    SUM(fs.Quantity) AS Total_Quantity_Sold
FROM Sales fs
JOIN Store st
    ON fs.Store_ID = st.Store_ID
GROUP BY 
    st.Store_ID,
    st.Store_Type
ORDER BY Total_Quantity_Sold DESC;

-- 4. How will seasonality affect Zudio’s sales?
-- Power BI