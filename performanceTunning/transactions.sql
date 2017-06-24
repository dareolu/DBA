Create Database BarclaysBank

Use BarclaysBank;


Create table customers
( customer_id int identity primary key,
  name nvarchar(50),
  )

create table accounts
(account_id int identity primary key,
 customer_id int foreign key references customers (customer_id),
 account_type varchar(10),
 amount money,
 date_modified datetime2 default getdate()
 )


Insert into customers (name)
values ('dare'), ('tony')

insert into accounts (customer_id, account_type, amount)
values (1, 'savings', 5000), (1, 'current', 2000),
	   (2, 'savings', 300), (2, 'current', 100)


select c.customer_id, c.name, a.account_type, a.amount  from customers  c  
join accounts  a
on a.customer_id = c.customer_id


--Phase 1
update accounts
set amount = amount + 200
where customer_id = 2

update accounts
set amount = amount - 200
where customer_id = 1


/*
Phase 2
create Proc transfer_funds (@from varchar, @to varchar, @account_type varchar(10), @amount money)
AS
BEGIN
	update accounts
	set amount = amount - @amount
	where customer_id = @from
	and account_type = @account_type

	update accounts
	set amount = amount + @amount
	where customer_id = @to
	and account_type = @account_type

END

*/


--Phase 3
--Demonstrate Transaction
BEGIN TRANSACTION
update accounts
set amount = amount + 200
where customer_id = 2
and account_type = 'savings'

--Check the Open transaction count
select * from sys.dm_exec_sessions
where session_id = 60

ROLLBACK TRANSACTION
COMMIT TRANSACTION


select c.customer_id, c.name, a.account_type, a.amount  from customers  c  
join accounts  a
on a.customer_id = c.customer_id



-- Propr Transaction in a banking system
--Without Error Handling
BEGIN TRANSACTION
update accounts
set amount = amount + 200
where customer_id = 2
and account_type = 'savings'

update accounts
set amount = amount - 200
where customer_id = 1
and account_type = 'savings'

--With Error Handling

BEGIN TRY
	BEGIN TRANSACTION
update accounts
set amount = amount + 200
where customer_id = 2
and account_type = 'savings'

update accounts
set amount = amount - '200m'
where customer_id = 2
and account_type = 'savings'
	COMMIT TRANSACTION
	Print 'Transaction Committed'
END TRY

BEGIN CATCH
	ROLLBACK TRANSACTION
	Print 'Transaction Rollback'
END CATCH


select c.customer_id, c.name, a.account_type, a.amount  from customers  c  
join accounts  a
on a.customer_id = c.customer_id
where a.account_type = 'savings'

















