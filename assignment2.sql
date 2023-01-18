create database DB_uni;
use DB_uni;

CREATE TABLE tbl_teaches(
    instructor_id INT NOT NULL,
    course_id VARCHAR(255) NOT NULL,
    sec_id INT NOT NULL,
    semester VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES tbl_instructor(instructor_id)
);

INSERT INTO tbl_teaches(instructor_id, course_id, sec_id, semester, year)
VALUES (10101,'CS-101',1,'Fall',2009),
        (10101,'CS-315',1,'Spring',2010),
        (10101,'CS-347',1,'Fall',2009),
        (12121,'FIN-201',1,'Spring',2010),
        (145236,'HIS-351',1,'Spring',2010),
        (45565,'CS-101',1,'Spring',2010),
        (45565, 'CS-319', 1,'Spring', 2010),
        (76766, 'BIO-101', 1, 'Summer', 2009),
        (76766, 'BIO-301', 1, 'Summer', 2010);
        

CREATE TABLE tbl_instructor(
    instructor_id INT PRIMARY KEY NOT NULL,
    instructor_name VARCHAR(255) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (dept_name) REFERENCES tbl_department(dept_name)
);

INSERT INTO tbl_instructor(instructor_id, instructor_name, dept_name, salary)
VALUES (10101,'Srinivasan','Computer Science',65000),
        (12121,'Wu','Finance',90000),
        (15151,'Mozart','Music',40000),
        (22222,'Einstein','Physics',95000),
        (32343,'El Said','History',60000),
        (33456,'Gold','Physics',87000),
        (45565,'Katz','Computer Science',75000),
        (145236,'Califeri','History',62000),
        (76766, 'Crick', 'Biology', 72000);

create table tbl_department(
	dept_name VARCHAR(255) PRIMARY KEY, 
    building VARCHAR(255), 
    budget INT
);

INSERT INTO tbl_department(dept_name, building, budget)
VALUES ('Biology','Watson',90000),
        ('Computer Science','Taylor',10000),
        ('Electrical Engineering','Taylor',85000),
        ('Finance','Painter',120000),
        ('History','Painter',50000),
        ('Music','Packard',80000),
        ('Physics','Watson',70000);


CREATE TABLE tbl_section(
    course_id varchar(255) NOT NULL,
    sec_id INT NOT NULL,
    semester VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    building VARCHAR(255) NOT NULL,
    room_number INT NOT NULL,
    time_slot_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES tbl_course(course_id)
);

INSERT INTO tbl_section(course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES ('BIO-101',1,'Summer',2009,'Painter',514,'B'),
        ('BIO-301',1,'Summer',2010,'Painter',514,'A'),
        ('CS-101',1,'Fall',2009,'Packard',101,'H'),
        ('CS-190',1,'Spring',2010,'Packard',101,'F'),
        ('CS-315',2,'Spring',2009,'Taylor',3128,'E'),
        ('CS-319',1,'Spring',2010,'Taylor',3128,'A'),
        ('CS-319',1,'Spring',2010,'Watson',120,'D'),
        ('CS-347',2,'Spring',2010,'Watson',100,'B');


CREATE TABLE tbl_course(
    course_id VARCHAR(255) PRIMARY KEY NOT NULL,
    course_title VARCHAR(255) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL,
    FOREIGN KEY (dept_name) REFERENCES tbl_department(dept_name)
);

INSERT INTO tbl_course(course_id, course_title, dept_name, credits)
VALUES ('BIO-101','Intro to Biology','Biology',4),
        ('BIO-301','Genetics','Biology',4),
        ('BIO-399','Computation Biology','Biology',3),
        ('CS-101','Intro to Computer Science','Computer Science',4),
        ('CS-190','Game Design','Computer Science',4),
        ('CS-315','Robotics','Computer Science',3),
        ('CS-319','Image Processing','Computer Science',3),
        ('CS-347','Database system concepts','Computer Science',3),
        ('EE-181','Intro to Digital Systems','Electrical Engineering',3),
        ('FIN-201','Investment Banking','Finance',3),
        ('HIS-351','World History','History',3);


CREATE TABLE tbl_student(
    student_id INT PRIMARY KEY NOT NULL,
    student_name VARCHAR(255) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    total_cred INT NOT NULL,
    FOREIGN KEY (dept_name) REFERENCES tbl_department(dept_name)
);

INSERT INTO tbl_student(student_id, student_name, dept_name, total_cred)
VALUES (128,'Zhang','Computer Science',102),
        (12345,'Shankar','Computer Science',32),
        (19991,'Brandt','History',80),
        (23121, 'Chavez', 'Finance', 110),
        (44553, 'Peltier','Physics', 56),
        (54321, 'Williams', 'Computer Science', 54),
        (98765, 'Bourikas', 'Elec. Eng', 60),
        (98988, 'Tanaka','Biology',120);
        
CREATE TABLE tbl_advisor(
 s_id INT NOT NULL PRIMARY KEY,
 i_id INT,
 FOREIGN KEY (s_id) REFERENCES tbl_student(student_id),
 FOREIGN KEY (i_id) REFERENCES tbl_instructor(instructor_id)
 );

SET FOREIGN_KEY_CHECKS=1;

INSERT INTO tbl_advisor(s_id, i_id)
VALUES (128, 10101),
		(12345, 10101);

        

-- Question 1
SELECT instructor_name FROM tbl_instructor where dept_name = "History";


-- Question 2
SELECT instructor_name, dept_name from tbl_department natural join tbl_instructor where budget > 95000; 


-- Question 3
SELECT instructor_name, course_title FROM tbl_instructor NATURAL JOIN tbl_teaches 
NATURAL JOIN tbl_course WHERE dept_name = "computer Science"; 

-- Question 5
SELECT dept_name, max(salary) FROM tbl_instructor GROUP BY dept_name;

-- Question 6
SELECT dept_name, salary from tbl_instructor
WHERE dept_name in (SELECT dept_name from tbl_instructor GROUP BY dept_name) ORDER BY salary LIMIT 1;

-- Question 7
SELECT * from tbl_student WHERE student_id NOT IN (SELECT s_id FROM tbl_advisor)


