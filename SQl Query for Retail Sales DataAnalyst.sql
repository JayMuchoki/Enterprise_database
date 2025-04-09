create database Maina_Enterprise;
Use Maina_Enterprise;


Create table Customers (
	CustomerId int identity(100,1) primary key,
	CustomerName varchar(60) not null,
	EmailAddress varchar(50) unique not null,
	TelephoneNo varchar(50) unique not null,
	RegistrationDate date not null
	);

INSERT INTO Customers values
('Juma Mwinyi', 'juma.mwinyi@example.com', '0790153441', '2024-01-10'),
('Asha Mrembo', 'asha.mrembo@example.com', '0790253442', '2024-01-12'),
('Baraka Chuma', 'baraka.chuma@example.com', '0790353443', '2024-02-05'),
('Neema Furaha', 'neema.furaha@example.com', '0790453444', '2024-02-20'),
('Hassan Kiboko', 'hassan.kiboko@example.com', '0790553445', '2024-03-02'),
('Zahara Nuru', 'zahara.nuru@example.com', '0790653446', '2024-03-15'),
('Faraji Mambo', 'faraji.mambo@example.com', '0790753447', '2024-04-01'),
('Saida Jema', 'saida.jema@example.com', '0790853448', '2024-04-18'),
('Omari Simba', 'omari.simba@example.com', '0790953449', '2024-05-05'),
('Halima Upendo', 'halima.upendo@example.com', '0791053450', '2024-05-20'),
('Bakari Safari', 'bakari.safari@example.com', '0791153451', '2024-06-01'),
('Fatuma Raha', 'fatuma.raha@example.com', '0791253452', '2024-06-15'),
('Ramadhani Kheri', 'ramadhani.kheri@example.com', '0791353453', '2024-07-02'),
('Subira Tumaini', 'subira.tumaini@example.com', '0791453454', '2024-07-12'),
('Mwanaisha Shani', 'mwanaisha.shani@example.com', '0791553455', '2024-08-03'),
('Sharifu Jafari', 'sharifu.jafari@example.com', '0791653456', '2024-08-20'),
('Dotto Mzuri', 'dotto.mzuri@example.com', '0791753457', '2024-09-05'),
('Zainabu Jalia', 'zainabu.jalia@example.com', '0791853458', '2024-09-18'),
('Yusuf Ndovu', 'yusuf.ndovu@example.com', '0791953459', '2024-10-01'),
('Nasra Jina', 'nasra.jina@example.com', '0792053460', '2024-10-10');





--adding Foreign key to table Products
Alter table Products
Add  constraint fk_supplier_id foreign key (SupplierId) references Suppliers(SupplierId)


select * from Products

Create table Suppliers (
	SupplierId int identity(301,1) primary key,
	SupplierName Varchar(50) unique not null,
	Supplier_TelNo int unique not null,
	Supplier_Email varchar(50) unique not null,
);

insert into Suppliers values
('Tech Haven', 0722987654, 'tech.haven@example.com' ),
('Gadget World', 0733567890, 'gadget.world@example.com'),
('Home Essentials Ltd', 0745345678, 'home.essentials@example.com'),
('Smart Solutions', 0756234567, 'smart.solutions@example.com'),
('Mega Electronics', 0779998877, 'mega.electronics@example.com'),
('Furniture Plus',0799999888, 'furniture.plus@example.com');


create Table Employees(
Employee_id int identity(401,1) primary key,
Employee_name Varchar(50) unique not null,
Employee_Tel int unique not null,
Employee_Email Varchar(50) unique not null,
Employee_Role varchar(50)  not null,
Employee_Salary int check (Employee_Salary >0) not null,
HireDate Date
);


select *from employees



insert into Employees values 
('John Mwangi', 0701234567, 'john.mwangi@example.com', 'Marketing Manager', 150000, '2019-02-01'),
('Jane Wanjiku', 0702345678, 'jane.wanjiku@example.com', 'Sales Executive', 100000, '2020-03-05'),
('Kevin Kiprotich', 0705678901, 'kevin.kiprotich@example.com', 'Brand Manager', 120000, '2017-06-20'),
('Nancy Atieno', 0706789012, 'nancy.atieno@example.com', 'Social Media Manager', 80000, '2022-07-25'),
('Peter Njoroge', 0707890123, 'peter.njoroge@example.com', 'IT Support Specialist', 75000, '2023-08-30'),
('Linet Chebet', 0708901234, 'linet.chebet@example.com', 'Financial Analyst', 90000, '2016-09-05'),
('Brian Ochieng', 0709012345, 'brian.ochieng@example.com', 'Market Research Analyst', 88000, '2015-10-10'),
('Catherine Nduta', 0709123456, 'catherine.nduta@example.com', 'Public Relations Officer', 85000, '2014-11-15'),
('Elijah Kariuki', 0709234567, 'elijah.kariuki@example.com', 'Content Strategist', 78000, '2022-01-10'),
('Diana Nyambura', 0709345678, 'diana.nyambura@example.com', 'Sales Executive', 105000, '2021-06-15');

--ading Foreign keys to table orders
Alter table Orders
Add  constraint fk_CustomerId foreign key (CustomerId) references Customers(CustomerId)

Alter table Orders
Add  constraint fk_productId foreign key (productId) references Products(productId)
--- adding primary key  in the OrderId
ALTER TABLE Orders
ADD CONSTRAINT PK_Order PRIMARY KEY (OrderId);

select * from Orders

--Creation and insertion in sales table
Create Table Sales(
SaleId int identity(600,1) primary Key,
Employee_Id int,
OrderId int,
Sale_date date,
foreign key (Employee_Id) References Employees(Employee_Id),
foreign key (OrderId) References Orders(OrderId)
)

INSERT INTO Sales (Employee_Id, OrderID, Sale_date)
	SELECT 
	   (401 + ABS(CHECKSUM(NEWID())) % 10) AS EmployeeID ,-- Random EmployeeID from available employees
		OrderId, 
		OrderDate AS SaleDate
	FROM Orders
	WHERE OrderStatus = 'Delivered';

---- Selected tables
select * from Customers;
select * from Products;
select * from Suppliers;
Select * from Employees
Select * from Orders;
select * from sales;

--- Calculating the commission calculations.
--- will start by finding the orderamount,salesamount,then the commission


--using a where condition where statu was Delivered 

select 
o.customerId ,
o.OrderId,
o.Quantity,
p.price,
(o.Quantity * p.price) as Orderamount ,
((o.Quantity * p.price)+ o.ShippingFee) as Salesamount,
cast(((o.Quantity * p.price)+ o.ShippingFee)*0.5 as int) as Commission
From Orders o
Join Products p
on o.ProductId=p.ProductId
where o.OrderStatus='Delivered' 



--using  case when  then end  clause to show us the if case is true and false
with Orderdetails as(
select 
o.customerId ,
o.OrderId,
o.Quantity,
p.price,
(o.Quantity * p.price) as Orderamount ,
case when o.OrderStatus= 'Delivered' then ((o.Quantity * p.price)+ o.ShippingFee) else null end as Salesamount,
case when o.OrderStatus= 'Delivered' then cast(((o.Quantity * p.price)+ o.ShippingFee)*0.05 as int ) else null end  as Commission
From Orders o
Join Products p
on o.ProductId=p.ProductId
),
Sales_details as (
Select 
s.SaleId,
s.Employee_id,
e.Employee_name,
o.commission
from Orderdetails o
Join Sales s
on o.OrderId=s.OrderId
join Employees e
on s.Employee_Id=e.Employee_id)

select * from Sales_details


--indexes Indexes help optimize query performance by reducing the number of rows scanned and speeding up data retrieval

-- Foreign Key Indexes
CREATE INDEX idx_orders_customer_id ON Orders(CustomerId);
CREATE INDEX idx_orders_product_id ON Orders(ProductId);
CREATE INDEX idx_sales_employee_id ON Sales(Employee_Id);
CREATE INDEX idx_sales_order_id ON Sales(OrderId);

-- WHERE Clause Indexes
CREATE INDEX idx_orders_status ON Orders(OrderStatus);
CREATE INDEX idx_orders_customer ON Orders(CustomerId);
CREATE INDEX idx_sales_employee ON Sales(Employee_Id);


-----------------------Temp Tables -------------------------------------------------------------------------------
-----People who are top spenders
select 
		o.customerId ,
		o.OrderId,
		o.Quantity,
		p.price,
		(o.Quantity * p.price) as Orderamount ,
		((o.Quantity * p.price)+ o.ShippingFee) as Salesamount,
		cast(((o.Quantity * p.price)+ o.ShippingFee)*0.5 as int) as Commission
into #OrderDetails
from Orders o
join Products p
On o.ProductId=p.ProductId;

select * from #OrderDetails

----------------------------------------People who are top spenders---------------------------------------------------------------------

select Top 3 
	c.customerName,
	od.customerid,
	sum(od.salesamount) as Totalspent,
	count (od.orderid) as TotalOrders
	from Customers c
	Join #orderDetails od
	on c.customerid=od.customerid
group by c.customerName, od.customerid
order by Totalspent desc

----------------------------------Frequent Buyers-------------------------------------------------------------
with Orderdetails as(
select 
o.customerId ,
o.OrderId,
o.Quantity,
p.price,
(o.Quantity * p.price) as Orderamount ,
case when o.OrderStatus= 'Delivered' then ((o.Quantity * p.price)+ o.ShippingFee) else null end as Salesamount,
case when o.OrderStatus= 'Delivered' then cast(((o.Quantity * p.price)+ o.ShippingFee)*0.05 as int ) else null end  as Commission
From Orders o
Join Products p
on o.ProductId=p.ProductId
), Frequent_buyers as(
select 
	c.customerName,
	od.customerid,
	sum(od.salesamount) as Totalspent,
	count (od.orderid) as TotalOrders
	from Customers c
	Join orderDetails od
	on c.customerid=od.customerid
group by c.customerName, od.customerid
)
select *  from Frequent_buyers
order by TotalOrders desc
----------------------------------------------Best selling Product------------------------------------------------------

select
s.orderId,
p.productid,
p.productname,
sum(o.Quantity) as TotalSoldUnits
From Products p
join Orders o
on p.ProductId=o.ProductId
Join Sales s
on o.OrderId=s.OrderId
group by s.orderId,p.productid,p.productname
Order by TotalSoldUnits Desc


-----------------------------------------------------------Invetory Levels-----------------------------------------------------------------

with soldProducts as(
 select 
	 p.productid,
	 p.productname ,
	 sum(o.Quantity) as SoldQuantity
	 from Sales s 
	 join Orders o
	 on s.OrderId=o.OrderId
	 join Products p
	 on o.ProductId=p.ProductId 
	 group by  p.productid,p.productname
	 
 ),
 remainingstock as (
 Select
  p.productid,
  p.productname ,
  p.Product_Quantity - 
        CASE 
            WHEN s.SoldQuantity IS NULL THEN 0 
            ELSE s.SoldQuantity 
        END AS Remainingstock
 from Products p
 Left Join soldProducts s
 on p.ProductId=s.ProductId
)

select *  from remainingstock  ;

------------------------------------------------------------monthly sales trends-------------------------------------------------------
with monthly_sales_trends as(
select 
FORMAT(s.Sale_date,'yyyy-MM') as Sales_month,
SUM(od.Salesamount) as TotalSales_amount
from Sales s
join #OrderDetails od
on s.OrderId=od.OrderId
Group by FORMAT(s.Sale_date,'yyyy-MM')

 )

select * from monthly_sales_trends
Order by Sales_month


--------------------------------------------employee sales performance--------------------------------------------------------------------
 with Orderdetails as(
select 
o.customerId ,
o.OrderId,
o.Quantity,
p.price,
(o.Quantity * p.price) as Orderamount ,
case when o.OrderStatus= 'Delivered' then ((o.Quantity * p.price)+ o.ShippingFee) else null end as Salesamount,
case when o.OrderStatus= 'Delivered' then cast(((o.Quantity * p.price)+ o.ShippingFee)*0.05 as int ) else null end  as Commission
From Orders o
Join Products p
on o.ProductId=p.ProductId
),Employee_sales_performance as (
 Select
 e.employee_name,
 e.employee_id,
 count(s.orderId) as TotalOrders,
 sum(od.orderamount) as Total_revenue,
 sum(od.Commission) as Total_commission
 From Employees e
 Join Sales s
 on e.Employee_id=s.Employee_Id
 join orderDetails od
 on s.OrderId=od.OrderId
 group by e.employee_name, e.employee_id

 )
 select 
 * from Employee_sales_performance
 order by Total_revenue desc