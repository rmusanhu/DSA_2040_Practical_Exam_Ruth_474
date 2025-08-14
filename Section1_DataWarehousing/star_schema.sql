-- star_schema.sql
-- Star Schema for African Retail Data Warehouse

-- Time Dimension
CREATE TABLE TimeDim (
    TimeKey INTEGER PRIMARY KEY,
    Date DATE NOT NULL,
    Day INTEGER,
    Month INTEGER,
    Quarter TEXT,
    Year INTEGER
);

-- Customer Dimension
CREATE TABLE CustomerDim (
    CustomerKey INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID TEXT UNIQUE NOT NULL,
    Name TEXT,
    Country TEXT,
    Region TEXT
);

-- Product Dimension
CREATE TABLE ProductDim (
    ProductKey INTEGER PRIMARY KEY AUTOINCREMENT,
    StockCode TEXT UNIQUE NOT NULL,
    ProductName TEXT,
    Category TEXT
);

-- Fact Table: Sales
CREATE TABLE SalesFact (
    SalesID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerKey INTEGER,
    ProductKey INTEGER,
    TimeKey INTEGER,
    Quantity INTEGER,
    TotalSales REAL,
    FOREIGN KEY (CustomerKey) REFERENCES CustomerDim(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES ProductDim(ProductKey),
    FOREIGN KEY (TimeKey) REFERENCES TimeDim(TimeKey)
);