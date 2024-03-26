create database E_Com;

-- Create Customers dimension table
CREATE TABLE Customers AS
SELECT DISTINCT
    CustomerID,
    Churn,
    PreferredLoginDevice,
    CityTier,
    WarehouseToHome,
    PreferredPaymentMode,
    Gender,
    HourSpendOnApp,
    NumberOfDeviceRegistered,
    PreferedOrderCat,
    SatisfactionScore,
    MaritalStatus,
    NumberOfAddress,
    Tenure,
    Complain
FROM cleaned_data;

ALTER TABLE Customers
ADD CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID);

-- Create the fact table
CREATE TABLE Orders AS
SELECT
    CustomerID,
    OrderAmountHikeFromlastYear,
    CouponUsed,
    OrderCount,
    DaySinceLastOrder,
    CashbackAmount
FROM cleaned_data;

-- Establish relationship between Orders and Customers
ALTER TABLE Orders
ADD FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);


-- Checking for duplicate rows

SELECT 
    CustomerID, COUNT(CustomerID) AS Count
FROM
    orders
GROUP BY CustomerID
HAVING COUNT(CustomerID) > 1;

-- Segregating the Churn column
ALTER TABLE customers
ADD CustomerStatus NVARCHAR(50);

UPDATE customers
SET CustomerStatus = 
CASE 
    WHEN Churn = 1 THEN 'Churned' 
    WHEN Churn = 0 THEN 'Not_Churned'
END;

