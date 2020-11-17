-- DELIVERABLE 1 -- DELIVERABLE 1 -- DELIVERABLE 1-- DELIVERABLE 1

-- Join employee and titles Tables
SELECT e.emp_no,
     e.first_name,
     e.last_name,
     e.birth_date,
     t.title,
     t.from_date,
     t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no;

SELECT * FROM retirement_titles;


-- Filter by BDate and btween 1952 & 1955
SELECT emp_no, 
     first_name, 
     last_name,
     birth_date, 
     title, 
     from_date,
     to_date
INTO retirement_titles1
FROM retirement_titles
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT emp_no,
     first_name,
     last_name,
	birth_date,
     from_date,
     to_date,
     title
INTO retirement_titles
FROM retirement_titles1
WHERE to_date = '9999-01-01'
ORDER BY to_date DESC;

SELECT * FROM retirement_titles;


-- Create a Unique Titles Table using the INTO clause
SELECT DISTINCT ON (emp_no)
     emp_no, 
     first_name, 
     last_name, 
     title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;


-- Retrieve TOTAL employee count by title from the Unique Titles Table
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;




-- DELIVERABLE 2 -- DELIVERABLE 2 -- DELIVERABLE 2 -- DELIVERABLE 2

-- Filter by BDate in 1965
SELECT emp_no, 
     first_name, 
     last_name,
	birth_date,
     title, 
     from_date,
     to_date
INTO current_emp
FROM retirement_titles
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM current_emp;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT emp_no,
     first_name,
     last_name,
	birth_date,
     from_date,
     to_date,
     title
INTO mentorship_eligibility
FROM current_emp
WHERE to_date = '9999-01-01'
ORDER BY to_date DESC;

SELECT * FROM mentorship_eligibility;


-- EXTRA | Created a mentorship Titles Table using the INTO clause
SELECT DISTINCT ON (emp_no)
     emp_no, 
     first_name, 
     last_name, 
     title
INTO mentorship_titles
FROM mentorship_eligibility2
ORDER BY emp_no ASC; 

SELECT * FROM mentorship_titles;


-- EXTRA | Retrieved TOTAL employee count by title from the mentorship titles Table
SELECT COUNT(emp_no), title
INTO mentorship_eligibility_titles
FROM mentorship_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM mentorship_eligibility_titles;




-- DELIVERABLE 3 -- DELIVERABLE 3 -- DELIVERABLE 3 -- DELIVERABLE 3
-- Q1
-- Total Number of Current Employees 
SELECT COUNT(first_name)
FROM mentorship_eligibility
-- OUPUT = 1549

--Total number of Retiring Employees
SELECT COUNT(first_name)
FROM unique_titles2
--OUTPUT = 72458

--Q2
--Create query for retiring employees vs current employees count by department

--Step 1 Current Emp -- JOIN departments and dept_emp tables 
SELECT de.emp_no,
	  de.from_date,
	  de.to_date,  
	  d.dept_name
INTO current_dept_emp_univ
FROM departments as d
INNER JOIN dept_emp as de
ON de.dept_no = d.dept_no
WHERE to_date='9999-01-01'

SELECT * FROM current_dept_emp_univ;


-- Step 2 Total of current employees by departments
SELECT COUNT(emp_no), dept_name
INTO current_dept
FROM current_dept_emp_univ
GROUP BY dept_name
ORDER BY count DESC;

SELECT * FROM current_dept;


-- Step 3 Join retirement and dept_emp tables
SELECT r.emp_no,
	  r.birth_date,
	  r.from_date,
	  r.to_date,  
	  de.dept_no
INTO retiring_dept_emp_univ
FROM retirement_titles as r
INNER JOIN dept_emp as de
ON r.emp_no = de.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');


-- Step 4 Join retirement_titles and departments table 
SELECT rt.emp_no,
	  rt.birth_date,
	  rt.from_date,
	  rt.to_date,  
	  d.dept_name
INTO retiring_dept_emp
FROM retiring_dept_emp_univ as rt
INNER JOIN departments as d
ON rt.dept_no = d.dept_no;

SELECT * FROM retiring_dept_emp;


-- Step 5 Total of retiring employees by departments
SELECT COUNT(emp_no), dept_name
INTO retiring_dept
FROM retiring_dept_emp
GROUP BY dept_name
ORDER BY count DESC;

SELECT * FROM retiring_dept;


