--Select CustomerName as [Customer Name] From KCC.dbo.Customers
--Select CustomerName as [Customer Name], Notes From KCC.dbo.Customers
--Select Distinct CustomerName From dbo.Customers
Select * from dbo.Customers
--Select top 3 * from dbo.Customers
--Select * from KCC.dbo.Customers where State = 'UT'
--Select * from KCC.dbo.Customers where State <> 'UT' -- "<>" the same "!="
--Select * from dbo.Customers where State = 'UT' or State = 'WI' or City = 'Mobile'
--##The IN operator is a shorthand for multiple OR conditions.
--Select * from dbo.Customers where State IN('WA', 'UT', 'WI') or City = 'Mobile' --IN # NOT IN
--Select * from dbo.Customers where State NOT IN('WA', 'UT', 'WI') or City = 'Mobile'
--Select * from dbo.Customers where State = 'WI' AND City = 'Green Bay'
/*Select * from dbo.Customers where State = 'WI' AND ( City = 'Green Bay' OR City = 'Mobile' ) 
--diffirent from 
Select * from dbo.Customers where State = 'WI' AND City = 'Green Bay' OR City = 'Mobile' */

--Select with condition "start with letter ..."
--Select * from dbo.Customers where CustomerName NOT LIKE 'A%'  --NOT LIKE # LIKE
Select top 1000 * from dbo.Orders Where OrderTotal between 1000 and 2000


