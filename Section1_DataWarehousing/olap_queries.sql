-- olap_queries.sql
-- OLAP Queries for African Retail Data Warehouse

-- 1. ROLL-UP: Total Sales by Country and Quarter
SELECT 
    c.Country,
    t.Quarter,
    SUM(s.TotalSales) AS TotalSales
FROM SalesFact s
JOIN CustomerDim c ON s.CustomerKey = c.CustomerKey
JOIN TimeDim t ON s.TimeKey = t.TimeKey
GROUP BY c.Country, t.Quarter
ORDER BY c.Country, t.Quarter;

-- 2. DRILL-DOWN: Monthly Sales for Nigeria (example country)
SELECT 
    t.Year,
    t.Month,
    SUM(s.TotalSales) AS MonthlySales
FROM SalesFact s
JOIN CustomerDim c ON s.CustomerKey = c.CustomerKey
JOIN TimeDim t ON s.TimeKey = t.TimeKey
WHERE c.Country = 'Nigeria'
GROUP BY t.Year, t.Month
ORDER BY t.Year, t.Month;

-- 3. SLICE: Total Sales for Electronics Category
SELECT 
    SUM(s.TotalSales) AS ElectronicsSales
FROM SalesFact s
JOIN ProductDim p ON s.ProductKey = p.ProductKey
WHERE p.Category = 'Electronics';