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


--- 7. Logical Function 
CASE 
    WHEN TH1 THEN value_1
    WHEN TH2 THEN value_2 
    ...
ELSE value_cuoi _cung - day la truong hop cuoi 

-- Hay phan loai gia tien cua san pham 

SELECT ProductID
    , ListPrice 
    , CASE WHEN ListPrice < 100 Then 'thap'
        WHEN ListPrice < 1000 THEN 'trung binh'
        ELSE 'cao'
        END AS price_segment
FROM [SalesLT].[Product]

--- IIF (menh de, tra ve gia tri o day neu menh de dung, neu menh de sai )
SELECT ProductID
    , ListPrice 
    , CASE WHEN ListPrice < 100 Then 'thap'
        WHEN ListPrice < 1000 THEN 'trung binh'
        ELSE 'cao'
        END AS price_segment
    , IIF(ListPrice < 100, 'thap', 'cao') price_segment_2
FROM [SalesLT].[Product]

--- Bai tap 2: Khoang cach tu ngay bat dau ban hang cho den ngay ket thuc ban la bao nhieu nam 
              -- Neu khong co ngay ket thuc ban hang thi tinh toi thoi diem hien tai. 

SELECT productID
    , SellStartDate
    , SellEndDate
    , CASE WHEN SellEndDate IS NULL THEN DATEDIFF( year, SellStartDate, CURRENT_TIMESTAMP)
        ELSE DATEDIFF(year, SellStartDate, SellEndDate)
        END number_years
    , 
FROM SalesLT.Product

/* Bai 1: Tu thong tin trong bang SalesLT.Customer, tao rao mot ma khach hang moi co chua CustomerID 
       and CompanyName. */
SELECT CustomerID
    , CompanyName
    , CONCAT(CustomerID, ':', CompanyName) As New_customer_ID
FROM [SalesLT].[Customer];


/* Bài tập 2:
Với dữ liệu trong bảng SalesLT.Product, hãy dựa vào cột khối lượng của sản phẩm để chia thành 4 phân khúc, 
đặt tên là “weight_segment”.
- Nếu không có giá trị thì xếp vào nhóm "None"
- Nếu khối lượng < 100 thì xếp vào nhóm "Type 1"
- Nếu khối lượng >= 100 và < 500 thì xếp vào nhóm "Type 2" - Nếu khối lượng >= 500 thì xếp vào nhóm "Type 3" */

SELECT ProductID
    , Weight
    , CASE 
        WHEN Weight IS NULL THEN 'None'
        WHEN Weight < 100 THEN 'Type 1'
        WHEN weight >= 100 AND Weight < 500 THEN 'Type 2'
        ELSE 'Type 3' END AS 'weight_segment'
FROM [SalesLT].[Product];

/* Bài tập 3:
Với dữ liệu trong bảng SalesLT.SalesOrderHeader, hãy lấy ra các thông tin:
- Mã đơn hàng
- Thời gian đặt hàng biểu diễn theo định dạng: yyyy.MM.dd - Tuần đặt hàng là tuần mấy trong năm ? */

SELECT SalesOrderID
    , FORMAT( OrderDate, 'yyyy.MM.dd') As New_OrderDate
    , DATEPART(week, OrderDate) As week_number
FROM [SalesLT].[SalesOrderHeader];

/* 4. Từ kết quả của bài 3, hãy xử lý thêm để có được thông tin ngày đặt hàng nhưng trình 
bày dưới dạng các thứ trong tuần. Ví dụ là Monday, Tuesday, Wednesday, ... */
SELECT SalesOrderID
    , FORMAT( OrderDate, 'yyyy.MM.dd') As New_OrderDate
    , DATEPART(week, OrderDate) As week_number
    , DATEPART(weekday, OrderDate) As week_day
    , CASE 
        WHEN DATEPART(weekday, OrderDate) = 1 THEN 'Sunday'
        WHEN DATEPART(weekday, OrderDate) = 2 THEN 'Monday'
        WHEN DATEPART(weekday, OrderDate) = 3 THEN 'Tuesday'
        WHEN DATEPART(weekday, OrderDate) = 4 THEN 'Wednesday'
        WHEN DATEPART(weekday, OrderDate) = 5 THEN 'Thursday'
        WHEN DATEPART(weekday, OrderDate) = 6 THEN 'Friday'
        ELSE 'Saturday'END AS week_day
    , OrderDate
FROM [SalesLT].[SalesOrderHeader];


/* 5. Với dữ liệu trong bảng SalesLT.SalesOrderDetails, 
hãy tính ra doanh thu của từng sản phẩm bằng công thức:
doanh thu = volume x ( unit price - unit price discount ) Làm tròn đến 2 chữ số thập phân. */

SELECT SalesOrderID
    , OrderQty
    , UnitPrice
    , Round(OrderQty * (Unitprice - UnitPriceDiscount), 2) As Revenue 
    , revenue = CAST (OrderQty * (UnitPrice - UnitPriceDiscount) AS DECIMAL (10,2))
FROM [SalesLT].[SalesOrderDetail]

/* 6. Từ thông tin CompanyName ở bảng SalesLT.Customer, 
hãy thực hiện thao tác cắt chuỗi để lấy ra từ thứ hai trong CompanyName.
(giả định mỗi từ được ngăn cách bởi 1 khoảng trắng) */

SELECT CustomerID, 
    CompanyName
    , CASE 
        WHEN LEN(CompanyName) -LEN(REPLACE(CompanyName, ' ','')) = 0 THEN NULL
        WHEN LEN(CompanyName) - LEN(REPLACE(CompanyName, ' ','')) = 1 
            THEN RIGHT(CompanyName, LEN(CompanyName) - CHARINDEX(' ', CompanyName))
        ELSE SUBSTRING(CompanyName, CHARINDEX(' ', CompanyName)+1, CHARINDEX(' ', CompanyName, CHARINDEX(' ', CompanyName)+1 ) - CHARINDEX(' ', CompanyName))
        END
FROM [SalesLT].[Customer]
