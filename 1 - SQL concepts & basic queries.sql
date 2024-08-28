1.5 Primary key & foreign keys
  
- Primary key is a column or set of columns in a relational database table that has a unique value for each record
- A foreign key is a column or set of columns in a table, usually a column related to the primary key of another table. 
    / Foreign keys define a relationship between two data tables. It indidcates taht value in foreign key column correspond 
      to the values in the primary key column of the reference table. 
    / Foreign Keys help build relationship between different data table, allowing you to query and join data from multiple tables
      to ger related information. 

1.6 SQL commnad types

- DDL (data definition language): Create, drop, alter, truncate
- DML (data manipulation language): Insert, update, delete
- DCL (data control language): grant, revoke
- DQL (date query language): select

1.7 Show your data 
-- Ghi chu, take note 
-- 1. Hien thi ket qua: SELECT 
SELECT 'Toi ten la Fihocdata'

-- 2. Hien thi du lieu tu 1 bang: SELECT..FROM ..
SELECT * - Hien thi tat cac cot
FROM [SalesLT].[Customer] -- lay data tu bang nao; 

SELECT CustomerID, 
     Title
     , MiddleName
     , Lastname
From [SalesLT].[Customer]; 

1.8 Order your data (ORDER BY)
-- Thay doi ten goi hien thi cua column
-- naming convention: 
   -- snake: ma_khach_hang
   -- camel: maKhachHang
   -- pascal: MaKhachHang
SELECT CustomerID As ma_khach_hang, 
     Title
     , MiddleName
     , Lastname
From [SalesLT].[Customer] 
Order By LastName ASC, CustomerID DESC

--- Note: 1. SQL khong phan viet viet hoa hay viet thuong 
           2. SQL khong phan biet xuong dong hay cung mot dong --
           3. Thu tu thuc hien cac cau lenh: FROM --> SELECT ---> ORDER BY.

1.9 Filter your data (WHERE..IN..)
-- Chon loc data theo dieu kien: WHERE 
SELECT CustomerID As ma_khach_hang, 
     Title
     , MiddleName
     , Lastname
From [SalesLT].[Customer] 
WHERE Title = 'Mr.' AND CustomerID < 1000
Order By LastName ASC, CustomerID DESC

-- Bai tap 1: lay ra tat ca san pham co mau den hoac mau do hoac mau trang voi IN 

SELECT * 
FROM [SalesLT].[Product]
WHERE color In ('Black', 'Red', 'White')

-- Bai tap 2: So sanh voi BETWEEN ... AND: khi so sanh voi 1 khoang (thoi gian, so). 
Lay ra tat ca san pham co mau den va co gia tri tien niem yet tu 100 den 1000 dong. 
 
 SELECT * 
 FROM [SalesLT].[Product]
 WHERE ListPrice Between 100 And 1000
    AND Color = 'Black'

-- Bai Tap 3: So sanh voi gia tri NULL. 
SELECT * 
 FROM [SalesLT].[Product]
 WHERE Color = 'Black'
    AND Size IS NULL

2. Filter Data (WHERE ..LIKE..)
-- So sanh voi LIKLE: so sanh gan giong
-- Bai tap 1: Hay lay ra tat cac san pham co ten chua chu 'Road'
SELECT * 
FROM [SalesLT].[Product]
WHERE [Name] LIKE '%Road%'

-- Bai tap 2: Hay lay ra tat ca san pham co ten bat dau la chu 'Road'
SELECT * 
FROM [SalesLT].[Product]
WHERE [Name] LIKE 'Road%'

-- Bai tap 3: Hay lay ra tat ca san pham co ten bat dau la chu 'Road'. ki tu thu 6 khac so 1
SELECT * 
FROM [SalesLT].[Product]
WHERE [Name] LIKE 'Road_[^1]%';

-- Bai tap 3: Hay lay ra tat ca san pham co ten bat dau la chu 'Road'. ki tu thu 6 khong phai la so. 
SELECT * 
FROM [SalesLT].[Product]
WHERE [Name] LIKE 'Road_[^0-9]%';

/* NOTE: %: represent zero or more characters
          _: represent exactly one CHARACTER
          []: restrict a list or rang of character 
          ^: Include the caret (^) symbol to list character or the RANGE of character 
            that you don't want to use as replacement.*/
            
SELECT TOP 3 
    SalesOrderID 
    , OrderQty
    , UnitPrice
FROM [SalesLT].[SalesOrderDetail]
WHERE UnitPrice < 1000
    AND OrderQty >=3
ORDER BY UnitPrice DESC

