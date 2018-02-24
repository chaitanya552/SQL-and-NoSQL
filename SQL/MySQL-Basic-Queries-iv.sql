select sex, count(ssn) as 'Number of Employees', sum(salary) as 'Total Salary',avg(salary) as 'Average Salary' 
from EMPLOYEE
group by sex;

create view WORKSTAMP as
select works_on.essn,employee.Fname,employee.lname,hours
from employee join works_on
on essn=ssn;

select essn,sum(hours) as 'Total Hours Worked',Fname,lname
from WORKSTAMP 
group by essn,Fname,lname having sum(hours) is not null;






select case when  relationship='Son' then 'Son'
when relationship='Daughter' then 'Daughter'
when relationship='Spouse' and sex='M' then 'Male Spouse'
when relationship='Spouse' and sex='F' then 'Female Spouse'
end as relationship,count(relationship) as 'Total Dependents'
from dependent
group by relationship,sex;


SELECT *
FROM EMPLOYEE Join DEPARTMENT
on Dno =Dnumber; 


SELECT *
FROM EMPLOYEE inner join DEPARTMENT;

select upper(fname) from employee;

select distinct fname from employee;

select substring(FNAME,1,3) from employee;

Select LOCATE('d',Fname) from employee where fname='ahmad';


select year(bdate),month(bdate), DAY(bdate) from EMPLOYEE;

Select * from employee order by salary desc, fname asc;


Select * from EMPLOYEE where fname='John' or fname='Joyce';

Select * from EMPLOYEE where Salary between 30000 and 40000;

Select * from EMPLOYEE where Salary>= 30000 and salary<=40000;


select now();




Select * from EMPLOYEE where fNAME like 'J%';




select * from employee order by salary desc limit 2;
select salary from employee order by salary desc limit N;

select * from employee order by salary desc limit 2 offset 1;
#offset skips 1 element here

select salary from (select * from employee order by salary desc limit 2) as custom 
order by salary asc limit 1;


select 
	s.Score, 
	(select count(distinct score) from Scores where score >=s.score) Rank
from Scores s
order by s.Score Desc;


select count(distinct Score) from Scores where Score >= 3.65;


SET @rank := 0;
SELECT
    *,
    @rank := @rank + 1 AS rank
FROM scores
ORDER BY Score DESC;


SET @prev_score = NULL;
SET @rank := 0;
SELECT
    *,
    CASE
        WHEN @prev_score = score THEN @rank 
        #i.e when previous score and current score are equal continue with rank
        -- Note that the assignment here will always be true
        WHEN @prev_score := score THEN @rank := @rank + 1
    END AS rank
FROM scores
ORDER BY score desc;

/*
+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
EMP SALARY > MANAGER SALARY
*/
select A.id,A.name,A.Salary, B.name,B.id,B.salary
from employee A, employee B
where A.ManagerId= B.Id and A.salary>B.Salary;


select Customers.Name Customers
from Customers
left join Orders
	on Customers.Id = Orders.CustomerId
where orders.CustomerId is null;

#highest salary in deparrtment

SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
    )
;