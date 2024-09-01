-- BUILT-IN FUNCTION: cac ham xu ly data cua SQL

-- 1. Chuyen doi kieu xu ly du lieu khi can thiet
-- CAST (column AS new_data_type)

-- 2. Ghep Chuoi
-- Chuyen doi INT --> VARCHAR, sau do moi ghep chuoi dc 
SELECT CustomerID
    , LastName
    , Cast (CustomerID As varchar) + ':' + LastName As New Name,
FROM [SalesLT].[Customer]

-- 3. Su dung ham CONCAST de ghep chuoi
-- CONCAT (Column 1, column_2, string_1,..) - Khong phan biet dinh dang data type
-- CONCAT_WS(separator, argument 1, argument 2)
SELECT CustomerID
    , LastName
    , CAST(CustomerID As varchar) + ' ' + LastName As New_name
    , CONCAT(CustomerID, ':', LastName) As New_name_1
    , CONCAT_WS(';', CustomerID, LastName, MiddleName, FirstName) As New_name_2   
FROM [SalesLT].[Customer]

-- 4. Handle NULL values
    /*The result of any expression containing a NULL value is NULL
     10 + NULL = NULL
     'String' + NULL = NULL */

--- NULL: Khong ton tai gia tri, du lieu bi thieu
--- IS NULL (column, 'new_value')
SELECT CustomerID
    , FirstName
    , MiddleName
    , LastName
    , FirstName + ISNULL(MiddleName, '-') + LastName As full_name
FROM [SalesLT].[Customer]

--- COALESCE (Column_1, Column2, Column3,..) tim gia tri khong NULL tu trai sang phai
SELECT CustomerID
    , FirstName
    , MiddleName
    , LastName
    , FirstName + ISNULL(MiddleName, '-') + LastName As full_name
    , COALESCE (MiddleName, NULL, LastName)
FROM [SalesLT].[Customer]

-- 5. Introducing string data processing commands - xu ly chuoi 

SELECT CustomerID
    , CompanyName
    , LEN(CompanyName) As length
    , TRIM(CompanyName) As remove_space
    , LEFT(CompanyName, 6) As left_6
    , RIGHT(CompanyName, 6) As right_6
FROM [SalesLT].[Customer]

--- CHARINDEX (string, letter, [staring point]) --> tra ve vi tri cua ki tu can tim. 
SELECT CustomerID
    , CompanyName
    , CHARINDEX('b',CompanyName) As first_b_position
FROM [SalesLT].[Customer]
 
 -- Tim vi tri cua chu 'b' thu hai 
SELECT CustomerID
    , CompanyName
    , CHARINDEX('b',CompanyName, CHARINDEX('b',CompanyName) + 1) As second_b_position
FROM [SalesLT].[Customer];

-- SUBSTRING (string, vi tri bat dau cat, so luong ki tu can lay)
SELECT CustomerID
    , CompanyName
    , SUBSTRING( CompanyName, 3,4) As new_string
    , REVERSE (CompanyName) As dao_nguoc
FROM[SalesLT].[Customer]

-- REPLACE(string, 'a', 'b')
SELECT CustomerID
    , CompanyName
    , REPLACE (CompanyName, 'bike', 'car') As new_name
FROM [SalesLT].[Customer];

-- Bai Tap 1: Hay tach ra ten cua nguoi ban hang trong cot SalesPerson
SELECT CustomerID
    , SalesPerson
    , SUBSTRING (SalesPerson,CHARINDEX ('\',SalesPerson)+1,CHARINDEX ('\',SalesPerson)) As Sales_Name_1
    , REPLACE (SalesPerson, 'adventure-works\', '') As Sales_name_2
    , RIGHT(SalesPerson, LEN(SalesPerson) - CHARINDEX('\', SalesPerson)) AS Sales_Name_3
FROM [SalesLT].[Customer]


--- 6. Ham xu ly thoi gian

SELECT ProductID
    , SellStartDate
    , YEAR (SellStartDate) As [Year]
    , MONTH (SellStartDate) As [Month]
    , DAY (SellStartDate) As [Day]
    , DATEPART (week, SellStartDate) As week_number
    , CURRENT_TIMESTAMP As [current_time]
    , DATEADD (hour, 7, CURRENT_TIMESTAMP) As vn_time
    , DATEDIFF (year, SellStartDate, CURRENT_TIMESTAMP) As year_different
FROM [SalesLT].[Product];

--- FORMAT thoi gian: tra ve data dang chuoi
SELECT ProductID
    , SellStartDate 
    , FORMAT (SellStartDate, 'yyyy.MM.dd') As [formated_time] -- day la data type STRING
FROM SalesLT.Product
