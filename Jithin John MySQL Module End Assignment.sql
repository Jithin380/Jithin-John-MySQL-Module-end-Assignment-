USE ecomm;
SELECT
    COUNT(*) - COUNT(WarehouseToHome) AS Warehouse_Null,
    COUNT(*) - COUNT(HourSpendOnApp) AS AppHours_Null,
    COUNT(*) - COUNT(OrderAmountHikeFromlastYear) AS OrderHike_Null,
    COUNT(*) - COUNT(DaySinceLastOrder) AS LastOrder_Null,

    ROUND(AVG(WarehouseToHome)) AS Warehouse_Mean,
    ROUND(AVG(HourSpendOnApp)) AS AppHours_Mean,
    ROUND(AVG(OrderAmountHikeFromlastYear)) AS OrderHike_Mean,
    ROUND(AVG(DaySinceLastOrder)) AS LastOrder_Mean

FROM customer_churn;
UPDATE customer_churn
SET WarehouseToHome = 16
WHERE WarehouseToHome IS NULL;
USE ecomm;
UPDATE customer_churn
SET WarehouseToHome = 16
WHERE WarehouseToHome IS NULL;
UPDATE customer_churn
SET HourSpendOnApp = 3
WHERE HourSpendOnApp IS NULL;
UPDATE customer_churn
SET OrderAmountHikeFromlastYear = 16
WHERE OrderAmountHikeFromlastYear IS NULL;
UPDATE customer_churn
SET DaySinceLastOrder = 5
WHERE DaySinceLastOrder IS NULL;
SELECT
    Tenure,
    COUNT(*) AS Frequency
FROM customer_churn
WHERE Tenure IS NOT NULL
GROUP BY Tenure
ORDER BY Frequency DESC
LIMIT 1;
UPDATE customer_churn
SET Tenure = 1
WHERE Tenure IS NULL;
SELECT
    CouponUsed,
    COUNT(*) AS Frequency
FROM customer_churn
WHERE CouponUsed IS NOT NULL
GROUP BY CouponUsed
ORDER BY Frequency DESC
LIMIT 1;
UPDATE customer_churn
SET CouponUsed = 1
WHERE CouponUsed IS NULL;
SELECT
    OrderCount,
    COUNT(*) AS Frequency
FROM customer_churn
WHERE OrderCount IS NOT NULL
GROUP BY OrderCount
ORDER BY Frequency DESC
LIMIT 1;
UPDATE customer_churn
SET OrderCount = 2
WHERE OrderCount IS NULL;
SELECT
    COUNT(*) - COUNT(Tenure) AS Tenure_Null,
    COUNT(*) - COUNT(CouponUsed) AS CouponUsed_Null,
    COUNT(*) - COUNT(OrderCount) AS OrderCount_Null
FROM customer_churn;
SELECT COUNT(*) AS Outlier_Count
FROM customer_churn
WHERE WarehouseToHome > 100;
DELETE FROM customer_churn
WHERE WarehouseToHome > 100;
SELECT COUNT(*) AS Remaining_Outliers
FROM customer_churn
WHERE WarehouseToHome > 100;
SELECT COUNT(*) AS Total_Rows
FROM customer_churn;
SELECT
COUNT(*) - COUNT(WarehouseToHome) AS Warehouse_Null,
COUNT(*) - COUNT(HourSpendOnApp) AS AppHours_Null,
COUNT(*) - COUNT(OrderAmountHikeFromlastYear) AS OrderHike_Null,
COUNT(*) - COUNT(DaySinceLastOrder) AS LastOrder_Null,
COUNT(*) - COUNT(Tenure) AS Tenure_Null,
COUNT(*) - COUNT(CouponUsed) AS CouponUsed_Null,
COUNT(*) - COUNT(OrderCount) AS OrderCount_Null
FROM customer_churn;
USE ecomm;
UPDATE customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';
UPDATE customer_churn
SET PreferredOrderCat = 'Mobile Phone'
WHERE PreferredOrderCat = 'Mobile phone';
DESCRIBE customer_churn;
UPDATE customer_churn
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';
UPDATE customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';
SELECT
    SUM(PreferredLoginDevice = 'Phone') AS Old_Phone,
    SUM(PreferedOrderCat = 'Mobile') AS Old_Mobile,
    SUM(PreferredPaymentMode = 'COD') AS Old_COD,
    SUM(PreferredPaymentMode = 'CC') AS Old_CC
FROM customer_churn;
USE ecomm;
ALTER TABLE customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;
ALTER TABLE customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;
DESCRIBE customer_churn;
ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(3);
UPDATE customer_churn
SET ComplaintReceived =
CASE
    WHEN Complain = 1 THEN 'Yes'
    ELSE 'No'
END;
ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);
UPDATE customer_churn
SET ChurnStatus =
CASE
    WHEN Churn = 1 THEN 'Churned'
    ELSE 'Active'
END;
ALTER TABLE customer_churn
DROP COLUMN Churn,
DROP COLUMN Complain;
DESCRIBE customer_churn;
SELECT
    ComplaintReceived,
    COUNT(*) AS Frequency
FROM customer_churn
GROUP BY ComplaintReceived;
SELECT
    ChurnStatus,
    COUNT(*) AS Frequency
FROM customer_churn
GROUP BY ChurnStatus;
USE ecomm;
SELECT
    ChurnStatus,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY ChurnStatus;
SELECT
    ROUND(AVG(Tenure), 2) AS Average_Tenure,
    ROUND(SUM(CashbackAmount), 2) AS Total_Cashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';
SELECT
    ROUND(
        SUM(CASE
            WHEN ComplaintReceived = 'Yes' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*), 2
    ) AS Complaint_Percentage
FROM customer_churn
WHERE ChurnStatus = 'Churned';
SELECT
    CityTier,
    COUNT(*) AS Churned_Customers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
AND PreferedOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Customers DESC
LIMIT 1;
DESCRIBE customer_churn;
SELECT
    CityTier,
    COUNT(*) AS Churned_Customers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
AND [COLUMN_NAME] = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Customers DESC
LIMIT 1;
DESCRIBE customer_churn;
SELECT
    CityTier,
    COUNT(*) AS Churned_Customers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
AND PreferedOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Customers DESC
LIMIT 1;
SELECT
    CityTier,
    COUNT(*) AS Churned_Customers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Customers DESC
LIMIT 1;
USE ecomm;
SELECT
    PreferredPaymentMode,
    COUNT(*) AS Customer_Count
FROM customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY Customer_Count DESC
LIMIT 1;
SELECT
    SUM(OrderAmountHikeFromlastYear) AS Total_Order_Hike
FROM customer_churn
WHERE MaritalStatus = 'Single'
AND PreferredLoginDevice = 'Mobile Phone';
SELECT
    ROUND(AVG(DaySinceLastOrder), 2)
    AS Average_Devices
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';
SELECT
    ROUND(AVG(NumberOfDeviceRegistered), 2)
    AS Average_Devices
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';
SELECT
    CityTier,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY CityTier
ORDER BY Customer_Count DESC
LIMIT 1;
SELECT
    Gender,
    SUM(CouponUsed) AS Total_Coupons
FROM customer_churn
GROUP BY Gender
ORDER BY Total_Coupons DESC
LIMIT 1;
SELECT
    PreferredOrderCat,
    COUNT(*) AS Customer_Count,
    MAX(HourSpendOnApp) AS Max_Hours
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Customer_Count DESC;
SELECT
    PreferredOrderCat,
    COUNT(*) AS Customer_Count,
    MAX(HoursSpentOnApp) AS Max_Hours
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Customer_Count DESC;
SELECT
    SUM(OrderCount) AS Total_Order_Count
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
AND SatisfactionScore = (
    SELECT MAX(SatisfactionScore)
    FROM customer_churn
);
SELECT
    ROUND(AVG(SatisfactionScore), 2)
    AS Average_Satisfaction
FROM customer_churn
WHERE ComplaintReceived = 'Yes';
SELECT
    PreferredOrderCat,
    COUNT(*) AS Customer_Count
FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY Customer_Count DESC;
SELECT
    PreferredOrderCat,
    ROUND(AVG(CashbackAmount), 2) AS Average_Cashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Average_Cashback DESC
LIMIT 3;
SELECT DISTINCT
    PreferredPaymentMode
FROM customer_churn
WHERE Tenure = 10
AND OrderCount > 500;
SELECT
    MAX(Tenure) AS Max_Tenure,
    MAX(OrderCount) AS Max_OrderCount
FROM customer_churn;
SELECT DISTINCT
    PreferredPaymentMode
FROM customer_churn
WHERE Tenure = 10
AND OrderCount > 5;
SELECT
    CASE
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS Distance_Category,
    ChurnStatus,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Distance_Category, ChurnStatus
ORDER BY Distance_Category, ChurnStatus;
SELECT *
FROM customer_churn
WHERE MaritalStatus = 'Married'
AND CityTier = 1
AND OrderCount > (
    SELECT AVG(OrderCount)
    FROM customer_churn
);
USE ecomm;
CREATE TABLE customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount DECIMAL(10,2)
);
INSERT INTO customer_returns
(ReturnID, CustomerID, ReturnDate, RefundAmount)
VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);
SELECT * FROM customer_returns;
SELECT
    c.*,
    r.*
FROM customer_churn c
INNER JOIN customer_returns r
ON c.CustomerID = r.CustomerID
WHERE c.ChurnStatus = 'Churned'
AND c.ComplaintReceived = 'Yes';