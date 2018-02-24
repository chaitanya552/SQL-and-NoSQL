/*Write a SQL query for a report that provides the following information for each person in the Person table,
 regardless if there is an address for each of those people:
 */
select FirstName, LastName, City, State
from Person left join Address
on Person.PersonId = Address.PersonId
;


/*
natural join advantage is that the common column is only selected once
*/
select *
from Person natural join Address;

/*Write a SQL query to get the second highest salary from the Employee table.
*/
CREATE VIEW temp AS

select max(Salary)
from employee
where Salary not in (
select max(Salary)
from employee);

DROP VIEW V;

select salary
from employee;

SELECT DISTINCT
    Salary AS SecondHighestSalary
FROM
    Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

/*
However, this solution will be judged as 'Wrong Answer' if there is no such second highest salary since there might be only one record in this table. To overcome this issue, we can take this as a temp table.

MySQL


;
*/
SELECT 
    (SELECT DISTINCT
            Salary
        FROM
            Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET 1) AS SecondHighestSalary;
     
     
   
   
/*
*/
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN

set N = N - 1;
  RETURN (
      # Write your MySQL query statement below.
      select distinct Salary from Employee order by Salary Desc limit 1 offset N
  );
END


/*
rankings
*/
# Write your MySQL query statement below

SET @rank := 0;
SELECT
    *,
    @rank := @rank + 1 AS rank
FROM scores
ORDER BY Score DESC;


SET @prev_score := NULL;
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
ORDER BY Score DESC;

/*
HERE  it checks the numbers of scores >=the current iteration score =>rank 
*/

select 
	s.Score, 
	(select count(distinct Score) from Scores where Score >= s.Score) Rank
from Scores s
order by s.Score Desc;


#top 3 salaries
select e1.Name as 'Employee', e1.Salary
from Employee e1
where 3>
(
    select count(distinct e2.Salary)
    from Employee e2
    where e2.Salary > e1.Salary
)
;


#employee salary > manager salary
select e1.Name Employee 
from Employee e1, Employee e2
where e1.ManagerId = e2.Id and e1.Salary > e2.Salary;

select email
from person
group by email
having count(email)>1;

# department name n employee salary
#top 3 department salary
SELECT
    d.Name AS 'Department', e1.Name AS 'Employee', e1.Salary
FROM
    Employee e1
        JOIN
    Department d ON e1.DepartmentId = d.Id
WHERE
    3 > (SELECT
            COUNT(DISTINCT e2.Salary)
        FROM
            Employee e2
        WHERE
            e2.Salary > e1.Salary
                AND e1.DepartmentId = e2.DepartmentId
        )
;


