use Xpoint
Go

create table SalesOrderHeader

(SalesOrderID int,
 CustomerID int,
 RevisionNumber int,  
 BillToAddressID int, 
 ShipToAddressID int,
 ShipMethod varchar(30),
 SubTotal int, 
 TaxAmt int, 
 Freight int, 
 OrderDate datetime2,)
