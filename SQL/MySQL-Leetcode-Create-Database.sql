# drop database leetcode;
create database leetcode;
use leetcode;
###############################################
# 175. Combine Two Tables
# 182. Duplicate Emails
CREATE TABLE Person(
	Id int NOT NULL,
	PersonId int NOT NULL,
	FirstName varchar(255),
	LastName varchar(255),
	Email varchar(255),
	PRIMARY KEY (Id)
);

INSERT INTO Person
    (Id, PersonId, FirstName, LastName, Email)
VALUES
    (1, 1, "john", "Marsh" , "john@example.com"),
    (2, 2, "Yida", "Yin", "yida@example.com"),
    (3, 3, "john", "Campbell", "john@example.com");

###############################################
# 175. Combine Two Tables
CREATE TABLE Address(
	AddressId int NOT NULL,
	PersonId int,
	City varchar(255),
	State varchar(255),
	PRIMARY KEY (AddressId)
);

INSERT INTO Address
    (AddressId, PersonId, City, State)
VALUES
    (1, 1, "New York", "New York"),
    (2, 2, "Shanghai", "Shanghai"),
    (3, 2, "Madison", "Wisconsin");

###############################################
# 176. Second Highest Salary  
# 184. Department Highest Salary
CREATE TABLE Employee(
	Id int NOT NULL,
	Name varchar(255),
	Salary int,
	ManagerId int,
	DepartmentId int,
	PRIMARY KEY (Id)
);

INSERT INTO Employee
    (Id, Name, Salary, ManagerId, DepartmentId)
VALUES
    (1, "Joe", 70000, 3, 1),
    (2, "Henry", 80000, 4, 2),
    (3, "Sam", 60000, null, 2),
    (4, "Max", 90000, null, 1),
    (5, "Janet", 69000, null, 1),
    (6, "Randy", 85000, null, 1),
    (7, "Cade", 90000, null, 1);

###############################################
# 184. Department Highest Salary
CREATE TABLE Department(
	Id int NOT NULL,
	Name varchar(255),
	PRIMARY KEY (Id)
);

INSERT INTO Department
    (Id, Name)
VALUES
    (1, "IT"),
    (2, "Sales");
###############################################
# 183. Customers Who Never Order
CREATE TABLE Customers(
	Id int NOT NULL,
	Name varchar(255),
	PRIMARY KEY (Id)
);

INSERT INTO Customers
    (Id, Name)
VALUES
    (1, "Joe"),
    (2, "Henry"),
    (3, "Sam"),
    (4, "Max");
###############################################
# 183. Customers Who Never Order
CREATE TABLE Orders(
	Id int NOT NULL,
	CustomerId varchar(255),
	PRIMARY KEY (Id)
);

INSERT INTO Orders
    (Id, CustomerId)
VALUES
    (1, 3),
    (2, 1);
###############################################
CREATE TABLE Weather(
	Id int NOT NULL,
	Date date,
	Temperature int,
	PRIMARY KEY (Id)
);

INSERT INTO Weather
    (Id, Date, Temperature)
VALUES
    (1, date("2015-01-01"), 10),
    (2, date("2015-01-02"), 25),
    (3, date("2015-01-03"), 20),
    (4, date("2015-01-04"), 30);
###############################################
# 178. Rank Scores
CREATE TABLE Scores(
	Id int NOT NULL,
	Score float,
	PRIMARY KEY (Id)
);

INSERT INTO Scores
    (Id, Score)
VALUES
    (1, 3.50),
    (2, 3.65),
    (3, 4.00),
    (4, 3.85),
    (5, 4.00),
    (6, 3.65);

###############################################  
# 180. Consecutive Numbers
CREATE TABLE Logs(
	Id int NOT NULL,
	Num int,
	PRIMARY KEY (Id)
);

INSERT INTO Logs
    (Id, Num)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 1),
    (6, 2),
    (7, 2);

###############################################
CREATE TABLE Users(
    Users_Id int NOT NULL,
    Banned ENUM('Yes', 'No'),
    Role ENUM('client', 'driver', 'partner'),
    PRIMARY KEY (Users_Id)
);

INSERT INTO Users
    (Users_Id, Banned, Role)
VALUES
    (1, "No", "client"),
    (2, "Yes", "client"),
    (3, "No", "client"),
    (4, "No", "client"),
    (10, "No", "driver"),
    (11, "No", "driver"),
    (12, "No", "driver"),
    (13, "No", "driver");

CREATE TABLE Trips(
	Id int NOT NULL,
	Client_Id int,
	Driver_Id int,
	City_Id int,
	Status ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'),
	Request_at date,
	PRIMARY KEY (Id),
    FOREIGN KEY (Client_Id) REFERENCES Users(Users_Id),
    FOREIGN KEY (Driver_Id) REFERENCES Users(Users_Id)
);


INSERT INTO Trips
    (Id, Client_Id, Driver_Id, City_Id, Status, Request_at)
VALUES
    (1, 1, 10, 1, "completed", date("2013-10-01")),
    (2, 2, 11, 1, "cancelled_by_driver", date("2013-10-01")),
    (3, 3, 12, 6, "completed", date("2013-10-01")),
    (4, 4, 13, 6, "cancelled_by_client", date("2013-10-01")),
    (5, 1, 10, 1, "completed", date("2013-10-02")),
    (6, 2, 11, 6, "completed", date("2013-10-02")),
    (7, 3, 12, 6, "completed", date("2013-10-02")),
    (8, 2, 12, 12, "completed", date("2013-10-03")),
    (9, 3, 10, 12, "completed", date("2013-10-03")),
    (10, 4, 13, 12, "cancelled_by_driver", date("2013-10-03"));

