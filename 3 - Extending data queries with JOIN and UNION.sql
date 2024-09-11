B1: Dua vao related column de ghep bang
B2: Nhan cheo cac dong cua 2 bang 
-- JOIN: Ghep Bang
-- 1. Co 4 phep JOIN chinh la: INNER JOIN - LEFT JOIN - RIGHT JOIN - FULL JOIN 

-- Bai tap 1: Hay lay ra thong tin cua khach hang va ma dia chi cua ho (chi lay nhung KH co dia chi)
 
 -- b1: xac dinh nhung bang du lieu can 
SELECT TOP 2 FROM [SalesLT].[Customer] -- 847 khach hang
SELECT TOP 2 FROM [SalesLT].[CustomerAddress] -- co 417 khach hang

-- b2: xac dinh related column: CustomerID
-- b3: xac dinh phep JOIN: INNER JOIN

SELECT * 
FROM [SalesLT].[Customer] AS a   -- xuat phat 847 khach hang
    INNER JOIN [SalesLT].[CustomerAddress] AS b -- 417 dong
    ON a.CustomerID = b.CustomerID
--- KQ: 417 dong --- tat ca CustomerID trong bang customer_address deu thuoc bang Customer, or customer moi KH chi co 1 dong

--- Bai tap 2: hay lay ra thong tin cua tat ca khach hanmg va ma dia chi cua ho (neu co)
SELECT a.CustomerID
    , b.CustomerID
    , LastName
    , AddressID
    , AddressType
FROM [SalesLT].[Customer] AS a   -- xuat phat 847 khach hang
    LEFT JOIN [SalesLT].[CustomerAddress] AS b -- 417 dong
    ON a.CustomerID = b.CustomerID
--- 857 dong --> co nhung khach hang co nhieu hon 1 dia chi (>= 2 dia chi)

-- Bai Tap 3: hay ra thong tin cua tat ca khach hang va don hang. Sau do loai di nhung khach hang khong co dat hang 
----- va don hang khong tin duoc nguoi mua 

--- b1: xac dinh tables: 
SELECT * FROM [SalesLT].[Customer] -- 847 khach hang
SELECT * FROM [SalesLT].[SalesOrderHeader] -- co 32 dong 

-- b2: CustomerID 
-- b3: FULL JOIN
SELECT a.CustomerID
    , b.SalesOrderID
FROM [SalesLT].[Customer] AS a 
    FULL JOIN [SalesLT].[SalesOrderHeader] AS b 
    ON a.CustomerID = b.CustomerID 
WHERE b.CustomerID IS NOT NULL
    AND b.SalesOrderID IS NOT NULL

----> FRON ---> JOIN --> WHERE --> SELECT ---> ORDER BY

--- 2. JOIN nhieu bang: 

--- Chuy phap: 
SELECT FROM table a 
JOIN table b 
ON
JOIN table c 
ON ....

-- Bai Tap 4: Hay lay ra tat ca don hang, sau do bo sung them thong tin ve khach hang 
-- (LastName, CompanyName) va thong tin ve san pham (ten san pham, gia tien)

---B1: xac dinh tables: Customer, Product , [SalesLT].[SalesOrderHeader], [SalesLT].[SalesOrderDetail]
SELECT TOP 2 * FROM [SalesLT].[SalesOrderDetail] -- 542 khach hang
SELECT TOP 2 *  FROM [SalesLT].[Customer] --- co 847 don hang
SELECT TOP 2 *  FROM [SalesLT].[Product] --- co 295  san pham 
SELECT TOP 2 *  FROM [SalesLT].[SalesOrderHeader] -- 32 dong

-- b2: su lien giu  4 table: 
SELECT * 
FROM [SalesLT].[SalesOrderDetail] AS a 
    JOIN [SalesLT].[SalesOrderHeader] AS b ON a.SalesOrderID = b.SalesOrderID
    JOIN 
