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

-- b2: su lien giu  4 table: SalesOrderDetail - Header: SalesOderID, join bang Customer = CustomerID, join product = ProductID
-- b3 viet JOIN
SELECT a.SalesOrderDetailID
    , c.CustomerID
    , c.LastName
    , c.CompanyName
    , a.ProductID
    , p.Name As product_name
    , p.ListPrice
FROM [SalesLT].[SalesOrderDetail] AS a -- xuat phat tu 542 dong
    LEFT JOIN [SalesLT].[SalesOrderHeader] AS b --- tim thong tin CustomerID
        ON a.SalesOrderID = b.SalesOrderID
    LEFT JOIN [SalesLT].[Customer] AS c --- tim thong tin KH
        ON b.CustomerID = c.CustomerID 
    LEFT JOIN [SalesLT].[Product] AS p ---- tim thong tin ve san pham
        ON a.ProductID = p.ProductID

/* Bai tap 5: Hay lay ra tat ca thong tin giao dich duoc thuc hien thanh cong
            vao thang 5/2017 va duoc thanh toan bang the tin dung */
SELECT TOP 3 * 
FROM [dbo].[payment_history_17];

SELECT TOP 3 * 
FROM [dbo].[table_message];


SELECT TOP 3 * 
FROM [dbo].[paying_method];

SELECT * 
FROM [dbo].[payment_history_17] AS his_17 
     LEFT JOIN [dbo].[table_message] AS mess 
        ON his_17.message_id = mess.message_id 
    LEFT JOIN [dbo].[paying_method] AS method 
        ON his_17.payment_id = method_id 
WHERE DESCRIPTION = 'success' AND  name = 'credit card' AND MONTH(transaction_date)=5;


--- UNION METHOD ---
/* Bai tap 1: Hay lay ra tat ca ca giao dich cua thang 1/2017 va thang 5. Sau do join voi bang 
  de tim thin ve product_group cua nhung giao dich nay */

-- b1: UNION data theo yeu cau 
SELECT table_union.*
    , pro.product_group 
FROM 
(
    SELECT customer_id, order_id, product_id, transaction_date 
    FROM payment_history_17 
    WHERE MONTH (transaction_date) = 1 -- 6628 dong 
    UNION 
    SELECT customer_id, order_id, product_id, transaction_date
    FROM payment_history_18
    WHERE MONTH (transaction_date) = 5 --- 12846  dong
) AS table_union 
LEFT JOIN [dbo].[product] AS pro 
        ON table_union.product_id = pro.product_number 
WHERE product_group = 'payment';

/* Bài 1: Tạo báo cáo hóa đơn
Adventure Works Cycles bán hàng trực tiếp cho các nhà bán lẻ, những ai mua hàng phải được xuất hóa đơn 
cho đơn hàng của họ.
Bạn được giao nhiệm vụ viết một truy vấn để tạo ra một danh sách các hóa đơn được gửi cho khách hàng.
Hãy viết một truy vấn trả về tên công ty từ bảng SalesLT.Customer,
và ID đơn hàng bán hàng và tổng số tiền phải trả từ bảng SalesLT.SalesOrderHeader. */

SELECT * FROM [SalesLT].[Customer] --- danh sach KH -- 847 KH 
SELECT * FROM [SalesLT].[SalesOrderHeader] -- danh sach don hang, 32 don hang

SELECT cus.CustomerID,
    cus.CompanyName
    , header.SalesOrderID
    , header.TotalDue
FROM [SalesLT].[SalesOrderHeader] AS header 
    INNER JOIN [SalesLT].[Customer] AS cus 
        ON header.CustomerID = cus.CustomerID
    

/* Bài 2:
Truy xuất đơn hàng của khách hàng kèm theo địa chỉ:
Mở rộng truy vấn đơn hàng của khách hàng. Với các khách hàng có địa chỉ là 'Main Office', 
lấy ra các thông tin bao gồm: địa chỉ đường phố đầy đủ, thành phố, bang hoặc tỉnh,
mã bưu chính, và quốc gia hoặc khu vực. */

SELECT * FROM [SalesLT].[CustomerAddress] -- 417 dong
SELECT * FROM [SalesLT].[Address]--- 450 dong

SELECT header.CustomerID
    , SalesOrderID
    , City
    , StateProvince
    , CountryRegion
    , PostalCode
FROM [SalesLT].[SalesOrderHeader] AS header -- 32 don hang
    LEFT JOIN [SalesLT].[CustomerAddress] AS cus_add -- tim ma dia chi
        ON header.CustomerID = cus_add.CustomerID
    LEFT JOIN [SalesLT].[Address] AS ad -- tim full dia chi
        ON cus_add.AddressID = ad.AddressID
WHERE AddressType = 'Main Office'

/*
Bài 3:
Truy xuất danh sách sản phẩm
○ Một quản lý bán hàng cần một danh sách các sản phẩm đã được đặt hàng với thông tin chi tiết như sau: 
- Tên sản phẩm (được tạo ra từ chuỗi trước ký tự '-' (ví dụ: HL Road Frame), nếu không có ký tự '-', 
lấy tên sản phẩm là mặc định).
Các sản phẩm này phải thỏa điều kiện: Bắt đầu bán từ năm 2006, tên model sản phẩm chứa "Road", 
tên category chứa "Bikes" và giá ListPrice có phần nguyên bằng 2443. */

SELECT * FROM [SalesLT].[Product] -- 295 san pham 
SELECT * FROM [SalesLT].[SalesOrderDetail] -- 542 dong, san pham nao xuat hien trong bang Detail la sp da ban. 

----> Product: ten san pham 
---> Model va Category 

SELECT DISTINCT detail.ProductID
    , pro.Name As product_name
    , CASE WHEN CHARINDEX ('-', pro.Name) > 0 
        THEN LEFT(pro.Name, CHARINDEX('-', pro.Name)-1) 
        ELSE pro.Name END AS new_name
    , pro.SellStartDate
    , model.Name AS model_name
    , ListPrice
FROM [SalesLT].[SalesOrderDetail] AS detail -- xuat phat tu danh sach san pham da ban 
    LEFT JOIN SalesLT.Product AS pro 
        ON detail.ProductID = pro.ProductID 
    LEFT JOIN [SalesLT].[ProductCategory] AS cate 
        ON pro.ProductCategoryID = cate.ProductCategoryID
    LEFT JOIN [SalesLT].[ProductModel] AS model 
        ON pro.ProductModelID = model.ProductModelID
WHERE YEAR(SellStartDate) = 2006
    AND model.Name LIKE '%Road%'
    AND cate.Name LIKE '%BIKE%'
    AND CAST (ListPrice AS INT) = 2443

/* Bài 4:
Truy xuất một báo cáo bao gồm các thông tin sau: customer_id, order_id, product_id, product_group, 
sub_category, category.
Những đơn hàng này phải đáp ứng các điều kiện sau:
-- Phát sinh trong tháng 1 năm 2017
-- product_group không phải là 'payment' */

SELECT customer_id, order_id, 
    pay.product_id, product_group, 
    sub_category, category
FROM [dbo].[payment_history_17] AS pay 
    LEFT JOIN [dbo].[product] AS pro
        ON pay.product_id = pro.product_number
WHERE MONTH (transaction_date) = 1
    AND product_group <> 'payment'

/*
Bài 5: Truy xuất một báo cáo bao gồm các thông tin sau: customer_id, order_id, product_id,
 product_group, category, payment name.
Những đơn hàng này phải đáp ứng các điều kiện sau:
-- Phát sinh từ tháng 1 đến tháng 6 năm 2017
-- Có loại hạng mục là mua sắm
-- Được thanh toán qua Tài khoản Ngân hàng */

SELECT customer_id, order_id, 
    pay.product_id, product_group, 
    category, method.name AS payment_name
FROM [dbo].[payment_history_17] AS pay
    LEFT JOIN [dbo].[product] AS pro 
        ON pay.product_id = pro.product_number 
    LEFT JOIN [dbo].[paying_method] AS method
        ON pay.payment_id = method.method_id
WHERE MONTH(transaction_date) < 7
    AND category = 'shopping'
    AND method.name = 'banking account'
