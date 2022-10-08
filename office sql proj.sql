----------creating dataset-----------
create database office


Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)


Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')


Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)


Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

/*add a table with white space*/
Insert into EmployeeDemographics VALUES
(1011, 'ggg', 'ooo', 26, 'Male '),
(1013, 'xxx', ' yyy ', NULL, 'Male')

--------------------------------------------------------------
/*clean the data
                 */

select distinct * from office.dbo.EmployeeDemographics

update office.dbo.EmployeeDemographics
set EmployeeID=1000
--set Age=32
--set Gender='Female'
where FirstName='Holly'

update office.dbo.EmployeeDemographics
set Age=32
where FirstName='Holly'

update office.dbo.EmployeeDemographics
set Gender='Female'
where FirstName='Holly'

update office.dbo.EmployeeDemographics
set Age=34
where FirstName='Darryl'

---cleaning wite space----
select * from office.dbo.EmployeeDemographics
WHERE
  TRIM(LastName)='yyy' and TRIM(Gender)='Male'

/*delet the sample*/
delete from office.dbo.EmployeeDemographics
WHERE FirstName in('ggg' , 'xxx')

select * from office.dbo.EmployeeSalary
select* from office.dbo.WareHouseEmployeeDemographics

update office.dbo.WareHouseEmployeeDemographics
set Age=34
where FirstName='Darryl'
------------------------------------------------------------------
/* analyzing the data and answer some questions */


/*
1- who is the best salesman ??
*/

/* Since the seller takes commission from his sales, 
this means that the best seller is the highest paid */

select JobTitle,FirstName ,avg(Salary)
from office.dbo.EmployeeDemographics d join office.dbo.EmployeeSalary s
on d.EmployeeID=s.EmployeeID
where JobTitle ='Salesman'
group by JobTitle,FirstName

/* according to my analysis it appears that Dwight 
is the best salesman and the highest who gets paid*/

/*
2-Michael is the regional manager for the firm he want to know between 
all the employees in the office who has the highest salary*/

select JobTitle,FirstName,LastName,Salary
from office.dbo.EmployeeDemographics d join office.dbo.EmployeeSalary s
on d.EmployeeID=s.EmployeeID
where FirstName <>'Michael'
order by Salary desc

/* Dwight is the highest employee get paid*/

/*
3- We want to reward the company's employees
   at the end of the year with a bonuses
     The salesman
      will receive ten percent bonus 
     and the rest will receive five percent bonus.
   */

select FirstName,JobTitle,Salary,
case
when JobTitle ='Salesman' then Salary +(Salary * 0.10)
else Salary +(Salary * 0.03)
end as salary_after_bounes
	
from office.dbo.EmployeeDemographics e join office.dbo.EmployeeSalary s
on e.EmployeeID=s.EmployeeID

----------------------------------------------------------------
-----------------------------------------------------------------