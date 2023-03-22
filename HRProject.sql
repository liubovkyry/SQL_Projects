create schema stgng

create table if not exists hr
(EMP_ID varchar(128),
EMP_NM varchar(128),
EMAIL varchar(128),
HIRE_DT date,
JOB_TITLE varchar(128),
SALARY int,
DEPARTMENT varchar(128),
MANAGER	varchar(128),
START_DT date,
END_DT date,
location varchar(128),
ADDRESS varchar(128),
CITY varchar(128),
STATE varchar(128),
EDUCATION_LEVEL varchar(128)
);

COPY hr
FROM 'C:\Users\liubo\Desktop\DataArchitectHRDatabase-main\HRdataset.csv'
DELIMITER ','
csv HEADER;

select * from hr
limit 10;

create schema interm

create table salary
(salary_id SERIAL PRIMARY KEY,
SALARY int
);

create table job
(job_id serial PRIMARY key,
JOB_TITLE VARCHAR(128));

create table department
(department_id serial primary key,
DEPARTMENT varchar(128),
MANAGER	varchar(128));

drop table department

create table officeLocation
(location_id serial primary key,
location varchar(128),
ADDRESS varchar(128),
CITY varchar(128),
STATE varchar(128)
);


create table education
(education_id serial primary key,
EDUCATION_LEVEL varchar(128));

select * from education

create table employee
(EMP_ID varchar(128) primary key,
EMP_NM varchar(128),
EMAIL varchar(128),
HIRE_DT date,
education_id int references education(education_id));


drop table employee

create table jobmap
(employee_ID varchar references employee(EMP_ID),
START_DT date,
END_DT date,
location_id int references officeLocation(location_id),
department_id int references department(department_id),
job_id int references job(job_id),
salary_id int references salary(salary_id),
manager_id VARCHAR(128) REFERENCES Employee(EMP_ID),
PRIMARY KEY (employee_id, job_id));

INSERT INTO Education(education_level)
    SELECT DISTINCT education_lvl
    FROM proj_stg;

INSERT INTO Employee(EMP_ID, EMP_NM, email, education_id, HIRE_DT)
    SELECT DISTINCT s.EMP_ID, s.Emp_NM, s.Email, ed.education_id, to_date(s.hire_dt, 'DD/MM/YYYY')
    FROM proj_stg as s
    JOIN Education as ed
    ON s.education_lvl = ed.education_level;

INSERT INTO Job(job_title)
    SELECT DISTINCT job_title
    FROM proj_stg;

INSERT INTO Department(department)
    SELECT DISTINCT department
    FROM proj_stg;

INSERT INTO OfficeLocation(location, address,
        city, state)
    SELECT DISTINCT location_lvl, address, city, state
    FROM proj_stg;

INSERT INTO Salary(salary)
    SELECT DISTINCT salary
    FROM proj_stg;

INSERT INTO JobMap(employee_id, start_dt, end_dt, location_id, department_id, job_id, salary_id,  manager_id)
    SELECT e.Emp_ID, j.job_id, s.salary_id, d.department_id, 
            o.location_id, to_date(proj.start_dt, 'DD/MM/YYYY') as start_dt, to_date(proj.end_dt, 'DD/MM/YYYY') as end_dt,
           (SELECT Emp_ID from Employee WHERE emp_nm = proj.manager) AS manager_id
    FROM proj_stg as proj
    JOIN Employee as e ON proj.Emp_ID = e.Emp_ID
    JOIN Job as j ON proj.job_title = j.job_title
    JOIN Department as d ON proj.Department = d.department
    JOIN Salary as s ON proj.salary = s.salary
    JOIN OfficeLocation AS o ON proj.location_lvl = o.location;
   
   
   create table jobmap2 as (
    SELECT e.Emp_ID, j.job_id, s.salary_id, d.department_id, 
            o.location_id, to_date(proj.start_dt, 'DD/MM/YYYY') as start_dt, to_date(proj.end_dt, 'DD/MM/YYYY') as end_dt,
           (SELECT Emp_ID from Employee WHERE emp_nm = proj.manager) AS manager_id
    FROM proj_stg as proj
    JOIN Employee as e ON proj.Emp_ID = e.Emp_ID
    JOIN Job as j ON proj.job_title = j.job_title
    JOIN Department as d ON proj.Department = d.department
    JOIN Salary as s ON proj.salary = s.salary
    JOIN OfficeLocation AS o ON proj.location_lvl = o.location);
   
   -- Question 1: Return a list of employees with Job Titles and Department Names
SELECT e.emp_nm, j.job_title, d.department
FROM Employee e
JOIN JobMap2 m ON m.emp_id = e.emp_id
JOIN Job j ON j.job_id = m.job_id
JOIN Department d ON d.department_id = m.department_id;

-- Question 2: Insert Web Programmer as a new job title
INSERT INTO Job (job_title) VALUES ('Web Programmer');

-- Question 3: Correct the job title from web programmer to web developer
UPDATE Job
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

--Question 4: Delete the job title Web Developer from the database
DELETE FROM Job 
WHERE job_title = 'Web Developer';

-- Question 5: How many employees are in each department?
SELECT d.department, COUNT(DISTINCT e.emp_id)
FROM Employee e
JOIN JobMap2 m ON m.emp_id = e.emp_id
JOIN Department d ON d.department_id = m.department_id
GROUP BY d.department;

SELECT d.department, COUNT(e.emp_id)
FROM Employee e
JOIN JobMap2 m ON m.emp_id = e.emp_id
JOIN Department d ON d.department_id = m.department_id
WHERE m.end_dt > Now()
GROUP BY d.department;

-- Question 6: Write a query that returns current and past jobs (include employee name, job title, department, manager name, start and end date for position) for employee Toni Lembeck.
SELECT e.emp_nm, j.job_title, d.department, e2.emp_nm AS manager_name, m.start_dt, m.end_dt
FROM Employee e
JOIN JobMap2 m ON m.emp_id = e.emp_id
JOIN Job j ON j.job_id = m.job_id
JOIN Department d ON d.department_id = m.department_id
JOIN Employee e2 ON e2.emp_id = m.manager_id
WHERE e.emp_nm = 'Toni Lembeck';