CREATE DATABASE CompanyDB  
ON							  
(
	NAME = 'CompanyDB',				
	FILENAME = 'D:\CompanyDB.mdf',		
	SIZE = 10MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB				
)
LOG ON						
( 
	NAME = 'LogCompanyDB',				   
	FILENAME = 'D:\ShopDB.ldf',        
	SIZE = 5MB,                        
	MAXSIZE = 50MB,                    
	FILEGROWTH = 5MB                   
)               

USE CompanyDB


CREATE TABLE Empl
(
	ID smallint IDENTITY NOT NULL,
	FirstName Varchar(20) NOT NULL,
	LastName Varchar(20) NULL,
	Salary SmallMoney NULL,
	DeptId int  NOT NULL  FOREIGN KEY REFERENCES Dept(ID)
)
GO 

CREATE TABLE Dept
(
	ID  int IDENTITY NOT NULL PRIMARY KEY,
	City Varchar(20) NOT NULL
)
GO 

INSERT INTO Empl
(FirstName,LastName,Salary,DeptId) 
VALUES 
('Max', 'Petrov', '1256', '1'),
('Alex', 'Vare', '2563', '3'),
('Sergei', 'Smolnikov', '1954', '2'),
('Petr', 'Vitiushkin', '1654', '1'),
('Dmitiy', 'Gordon', '254', '3'),
('Stepan', 'Vilichkin', '600', '1'),
('Nikolay', 'Marchenko', '800', '1'),
('Marat', 'Shved', '900', '1'),
('Petr', 'Nikitchrnko', '310', '2'),
('Vladimer', 'Hondoshko', '800', '1'),
('Anna', 'Vitiushkina', '1000', '2'),
('Nataly', 'Savinska', '550', '1'),
('Sveta', 'Fedosiyeva', '880', '3'),
('Nataly', 'Smolnikova', '100', '1')

GO

INSERT INTO Dept
(City) 
VALUES
('Lvov'),
('Vinnitsa'),
('Kiev')
Go 


/*1. ������� ������ ����������, �������� ������� ���� 300 $ � ������� �������� �� ������.*/
SELECT FirstName + ' ' + LastName as Name, Salary,City
FROM Empl    
JOIN Dept 
ON Empl.DeptId = Dept.ID
WHERE Salary < '300'AND Dept.ID ='1'

/*2. ������� ������ ���� ���������� (��� ��������, ���������� �� ��������). */
SELECT distinct FirstName  as Name
FROM Empl
ORDER BY FirstName 
GO

/*3. ��������� ������� ���������� � ��������.*/
Select COUNT(FirstName) from Empl
GO

/*4  �������� ������ ���������� ���������� � ������������� � 5. */
Select COUNT(FirstName) AS 'the number of employees' from Empl
WHERE DeptId = '2'
GO

/*5. �������� ������ ���������� ���������� � ������ �������������.  */
Select COUNT(FirstName) as Persons from Empl
GROUP BY DeptId
GO


/*6. �������� ������ �������, ���������� ����� '�' � ������ �����. */
SELECT FirstName + ' ' + LastName as Name,City
FROM Empl
JOIN Dept 
ON Empl.DeptId = Dept.ID
where FirstName LIKE 'P%';



/*7. �������� ������ ���� �������, ���������� ����� '�' � �������� ����� � ���������� ���������� ����� 20. */
SELECT City ,COUNT(City) as Persons
FROM Dept   
JOIN Empl 
ON Empl.DeptId = Dept.ID
group by City 
HAVING COUNT(FirstName) > 3 and Dept.City LIKE '%i%';

/*8. �������� ������ �����, ������� �������������. */
SELECT  LastName
FROM Empl   
GROUP BY LastName
HAVING (COUNT(*) > 1)

/*9. �������� ������ �����, ������� ��������� ������ ���������� ����� � �������, �������, � ���� ��, ��������  � ������ '�����'. */
SELECT  FirstName,LastName
FROM Empl   
GROUP BY FirstName,LastName
HAVING (COUNT(*) > 1)


/*10. �������� ������ ������� � ����������� ���������� � ������ '����' ����� 10.*/
SELECT  FirstName,City, count(City)
FROM Empl   
JOIN Dept 
ON Empl.DeptId = Dept.ID
GROUP BY FirstName,City
HAVING FirstName Like  'Petr' and count(City) >2

/*11. �������� ������ ���������� � ��������, ������������ �� ����� �.*/
SELECT FirstName + ' ' + LastName as Name,City
FROM Empl
JOIN Dept 
ON Empl.DeptId = Dept.ID
where LastName LIKE 'V%';


/*12. �������� ������ ���������� � ���������� ������ ���� 400 $.*/
SELECT FirstName + ' ' + LastName as Name,Salary,City
FROM Empl
JOIN Dept 
ON Empl.DeptId = Dept.ID
where Salary > '600';


/*13. �������� ������� ������ ���������� ����� �� �����.*/
SELECT AVG(Salary) as 'The average salary'
FROM Empl



/*14. �������� ������ �����������, ���������� ���������� ����� � ��������� �� 300 �� 1500 $.*/
SELECT FirstName + ' ' + LastName as Name, Salary
FROM Empl   
JOIN Dept 
ON Empl.DeptId = Dept.ID
WHERE   Salary < '1500' and Salary > '300' 



/*15. . ������� �id� �������������, � ������� ���������� �������� ������������ ���������� �����. */
SELECT  Dept.ID, MAX( Empl.Salary)
FROM Empl   
JOIN Dept 
ON Empl.DeptId = Dept.ID
GROUP BY Dept.ID




