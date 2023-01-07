CREATE database DB_Employee;
use DB_Employee;

create table Tbl_Employee(
	employee_name varchar(255) primary key,
    street varchar(255),
    city varchar(255)
);

create table Tbl_Works(
	employee_name varchar(255) primary key,
    company_name varchar(255),
    salary int
);

create table Tbl_manages(
	employee_name varchar(255) primary key,
    manager_name varchar(255)
);

create table Tbl_company(
	company_name varchar(255) primary key,
    city varchar(255)
);


alter table Tbl_Works
add foreign key(employee_name) references Tbl_Employee(employee_name),
add foreign key(company_name) references Tbl_company(company_name);

alter table Tbl_manages
add foreign key(employee_name) references Tbl_employee(employee_name);


SET FOREIGN_KEY_CHECKS=1;

SET FOREIGN_KEY_CHECKS = 0;


# Adding the data into the created tables
INSERT INTO Tbl_employee (employee_name, street, city)
VALUES 
      ('Jones', '123  St', 'Kathmandu'),
       ('Karki', '456  St', 'Lalitpur'),
       ('Rahul', '789 St', 'Los Angeles'),
       ('Manager Jones', '123 St' , 'Kathmandu'),
       ('Manager Karki', '123 St',' Kathmandu'),
       ('Manager Rahul','789 St', 'Los Angeles');

INSERT INTO Tbl_works (employee_name, company_name, salary)
VALUES  ('Jones', 'Small Bank Corporation', 750000),
       ('Karki', 'First Bank Corporation', 100000),
       ('Rahul', 'Large Bank Corparation', 9500),
		('Manager Jones', 'Small Bank Corporation' , '8038990'),
       ('Manager Karki', 'First Bank Corporation','3434342'),
       ('Manager Rahul','Large Bank Corporation', '1200030');
       
       
INSERT INTO Tbl_company (company_name, city)
VALUES  ('Small Bank Corporation', 'Ktm'),
       ('First Bank Corporation', 'Lalitpur'),
       ('Large Bank Corporation', 'Los Angeles');
       
INSERT INTO Tbl_manages (employee_name, manager_name)
VALUES ('Jones', 'Manager Jones'),
		('Karki', 'Manager Karki'),
        ('Rahul','Manager Rahul');
       
       
# Q 2 a
# let the First bank coorporation be 'XYZ'

Select employee_name from Tbl_works where company_name='First Bank Corporation';

# Q2b

Select employee_name, city from Tbl_employee natural join Tbl_works where company_name = 'First Bank Corporation';


# 2c

Select * from tbl_employee where employee_name IN
(select employee_name from tbl_works where company_name = 'First Bank Corporation' AND salary > 10000); 


# 2d
SELECT *
FROM Tbl_employee e
WHERE e.city = (SELECT city FROM Tbl_company c WHERE c.company_name = 
(SELECT company_name FROM Tbl_works w WHERE w.employee_name = e.employee_name));

# 2e
select t.employee_name from
(select employee_name, manager_name,tbl_employee.city from tbl_manages NATURAL join tbl_employee) t
 join tbl_employee on t.manager_name = tbl_employee.employee_name WHERE t.city = tbl_employee.city;
  
# 2f
SELECT employee_name from Tbl_works WHERE company_name != 'First Bank Corporation';

# 2g

select employee_name from tbl_works where salary >
(select max(salary) from tbl_works natural join tbl_company  Where company_name = 'Small Bank Corporation');

# 2h

select company_name from Tbl_company where city in (select city  from Tbl_company where company_name = 'Small Bank Corporation');

# 2i
SELECT employee_name from tbl_works 
where salary > (select avg(salary) from tbl_works w2 where w2.company_name = tbl_works.company_name);

# 2j
select company_name from tbl_works
group by company_name
having count(distinct employee_name) >= all
	(select count(distinct employee_name) from tbl_works group by company_name);
    
    
# 2 k
select company_name from tbl_works
group by company_name
having sum(salary) <= all (select sum(salary) from tbl_works group by company_name);

# 2 l
select company_name from tbl_works
group by company_name
having avg(salary) > ( select avg (salary) from tbl_works where company_name='First Bank Corporation');


# 3

select employee_name, city from Tbl_employee;


# 3 a
update TBL_Employee
set city= "Netwon" where employee_name='Jones';


# 3 b
select * from tbl_works;
update tbl_works
set salary = salary *1.1 where company_name='First Bank Corporation';


# 3 c
update tbl_works 
set salary = salary * 1.1
where employee_name in (select manager_name from tbl_manages) and company_name = 'First Bank Corporation';

# 3 d
UPDATE Tbl_works
SET salary =
    CASE
        WHEN salary < 100000 THEN salary * 1.1
        ELSE salary * 1.03
    END
WHERE Tbl_works.employee_name IN (
    SELECT tbl_manages.employee_name
    FROM tbl_manages
    WHERE tbl_manages.manager_name = tbl_works.employee_name AND tbl_works.company_name = 'XYZ'
);


# 3 e

DELETE FROM works
WHERE company_name = 'Small Bank Corporation';

select * from tbl_employee;
