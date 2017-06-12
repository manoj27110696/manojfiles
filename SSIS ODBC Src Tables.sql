CREATE DATABASE DB_SOURCE

USE DB_SOURCE

CREATE TABLE [dbo].[Employees](
        [EmployeeID] [bigint] NOT NULL PRIMARY KEY,
        [FirstName] [varchar](20) NULL,
        [Title] [varchar](50) NULL,
        [BirthDate] [datetime] NULL,
        [Salary] [money] NULL
)
 
CREATE TABLE [dbo].[Customers](
        [CustomerID] [int] NOT NULL PRIMARY KEY,
        [CustomerName] [varchar](50) NULL
		)
 
CREATE TABLE [dbo].[EmployeesCustomers](
        [EmployeeID] [int] NOT NULL,
        [CustomerID] [int] NOT NULL,
CONSTRAINT [PK_EmployeesCustomers] PRIMARY KEY CLUSTERED
(
        [EmployeeID] ASC,
        [CustomerID] ASC
))
 
INSERT INTO Employees VALUES (1,'Abraham','Team Leader'   ,'1947-11-25', 100.00)
INSERT INTO Employees VALUES (2,'Sarah'  ,'HR Manager'    ,'1967-04-20', 100.00)
INSERT INTO Employees VALUES (3,'Hagar'  ,'Office Cleaner','1978-08-03', 10.00)
INSERT INTO Employees VALUES (4,'Ishmael','Mail Deliverer','1989-12-01', 20.00)
INSERT INTO Employees VALUES (5,'Isaac'  ,'Developer'     ,'1995-01-01', 50.00)
INSERT INTO Employees VALUES (6,'Rebekah','QA Person'     ,'1995-05-13', 50.00)
 
INSERT INTO Customers VALUES (1,'Serena Williams')
INSERT INTO Customers VALUES (2,'Pat Robertson')
INSERT INTO Customers VALUES (3,'Paris Hilton')
INSERT INTO Customers VALUES (4,'Barak Obama')
INSERT INTO Customers VALUES (5,'Arnold Schwarzenegger')
INSERT INTO Customers VALUES (6,'Oprah Winfrey')
INSERT INTO Customers VALUES (7,'Prince El Saudi')
  
INSERT INTO EmployeesCustomers VALUES (1,5)
INSERT INTO EmployeesCustomers VALUES (1,6)
INSERT INTO EmployeesCustomers VALUES (1,7)
INSERT INTO EmployeesCustomers VALUES (2,1)
INSERT INTO EmployeesCustomers VALUES (2,2)
INSERT INTO EmployeesCustomers VALUES (3,3)
INSERT INTO EmployeesCustomers VALUES (3,4)







SELECT (
  SELECT TOP 1 NULL as N,
    (SELECT Employee.EmployeeId as Id, Employee.FirstName as Name,
      (SELECT TOP 1 NULL as N,
        (SELECT Customer.CustomerID as Id, CustomerName as Name
         FROM EmployeesCustomers INNER JOIN Customers Customer
         ON EmployeesCustomers.CustomerID = Customer.CustomerID
         WHERE EmployeesCustomers.EmployeeId = Employee.EmployeeId
         ORDER BY Customer.CustomerID
         FOR XML AUTO, TYPE)
       FROM Customers
       FOR XML AUTO, TYPE)
     FROM EmployeesCustomers INNER JOIN Employees Employee
     ON EmployeesCustomers.EmployeeID = Employee.EmployeeID
     GROUP BY Employee.EmployeeId, Employee.FirstName
     ORDER BY Employee.EmployeeId
     FOR XML AUTO, TYPE)
  FROM Employees
  FOR XML AUTO, ROOT('Company')
) AS COL_XML   


SELECT * FROM [dbo].[sysssislog]