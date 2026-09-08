CREATE DATABASE employee_cte_db;
CREATE TABLE employees (employee_id INT PRIMARY KEY, employee_name VARCHAR(50), department VARCHAR(30), salary NUMERIC(10,2),
manager_id INT, hire_date DATE);
INSERT INTO employees VALUES 
(1,'John','Management',120000,NULL,'2015-01-10'),(2,'Sarah','HR',90000,1,'2017-03-15'),
(3,'Priya','IT',95000,1,'2018-06-20'),(4,'Arun','IT',80000,3,'2020-02-10'),
(5,'Kavin','IT',70000,3,'2021-05-12'),(6,'Divya','IT',60000,3,'2022-07-18'),
(7,'Rahul','HR',75000,2,'2021-01-20'),(8,'Meena','HR',65000,2,'2022-04-15'),
(9,'Vijay','Finance',85000,1,'2019-08-25'),(10,'Anitha','Finance',70000,9,'2020-11-10'),
(11,'Suresh','Finance',60000,9,'2022-02-14'),(12,'Karthik','Sales',80000,1,'2018-09-12'),
(13,'Nisha','Sales',70000,12,'2021-06-01'),(14,'Ravi','Sales',60000,12,'2022-10-05'),
(15,'Lakshmi','Sales',50000,12,'2023-01-15'),(16,'Manoj','IT',80000,4,'2023-03-20'),
(17,'Swathi','HR',55000,2,'2023-06-10'),(18,'Gokul','Finance',65000,9,'2023-08-12'),
(19,'Pooja','IT',70000,4,'2024-01-10'),(20,'Hari','Sales',55000,13,'2024-04-15');
Select * From Employees;
With high_salary AS (SELECT * FROM employees WHERE salary > 70000) SELECT * FROM high_salary;
With it_employees AS (SELECT * FROM employees WHERE department = 'IT') SELECT * FROM it_employees;
With bonus_cte AS (SELECT employee_id,employee_name,salary,salary*0.10 AS bonus,salary+(salary*0.10) AS total_salary FROM employees)
SELECT * FROM bonus_cte;
With salary_cte AS (SELECT * FROM employees WHERE salary > 60000) SELECT * FROM salary_cte WHERE department = 'IT';
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department) SELECT * FROM dept_avg;
With dept_stats AS (SELECT department,MAX(salary) AS maximum_salary,MIN(salary) AS minimum_salary,AVG(salary) 
AS average_salary,SUM(salary) AS total_salary FROM employees GROUP BY department)SELECT * FROM dept_stats;
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department) SELECT * FROM dept_avg
WHERE average_salary > 70000;
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department) SELECT * FROM dept_avg 
ORDER BY average_salary DESC LIMIT 1;
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department) SELECT * FROM dept_avg
ORDER BY average_salary ASC LIMIT 1;
With dept_count AS (SELECT department,COUNT(*) AS employee_count FROM employees GROUP BY department) SELECT * FROM dept_count 
WHERE employee_count > 2;
With dept_avg AS (SELECT department,AVG(salary) AS department_average_salary FROM employees GROUP BY department) 
SELECT e.employee_name,e.department,e.salary,d.department_average_salary FROM employees e 
JOIN dept_avg d ON e.department=d.department;
With dept_avg AS (SELECT department,AVG(salary) AS department_average FROM employees GROUP BY department)
SELECT e.employee_name,e.department,e.salary,d.department_average FROM employees e JOIN dept_avg d ON 
e.department=d.department WHERE e.salary>d.department_average;
With dept_max AS (SELECT department,MAX(salary) AS max_salary FROM employees GROUP BY department)
SELECT e.* FROM employees e JOIN dept_max d ON e.department=d.department AND e.salary=d.max_salary;
With dept_min AS (SELECT department,MIN(salary) AS min_salary FROM employees GROUP BY department)
SELECT e.* FROM employees e JOIN dept_min d ON e.department=d.department AND e.salary=d.min_salary;
With dept_avg AS (SELECT department,AVG(salary) AS department_average FROM employees GROUP BY department)
SELECT e.employee_name,e.department,e.salary,d.department_average,e.salary-d.department_average AS salary_difference 
FROM employees e JOIN dept_avg d ON e.department=d.department;
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department),above_avg AS 
(SELECT e.* FROM employees e JOIN dept_avg d ON e.department=d.department WHERE e.salary>d.average_salary) SELECT * FROM above_avg;
With dept_stats AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department),high_dept AS 
(SELECT department FROM dept_stats WHERE average_salary>70000) SELECT e.* FROM employees e JOIN high_dept h
ON e.department=h.department;
With dept_count AS (SELECT department,COUNT(*) AS employee_count FROM employees GROUP BY department),dept_avg AS 
(SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department),combined AS 
(SELECT c.department,c.employee_count,a.average_salary FROM dept_count c JOIN dept_avg a ON c.department=a.department)
SELECT * FROM combined;
With recent_employees AS (SELECT * FROM employees WHERE hire_date>'2020-01-01'),high_salary AS 
(SELECT * FROM employees WHERE salary>65000) SELECT r.* FROM recent_employees r JOIN high_salary h ON r.employee_id=h.employee_id;
With it_employees AS (SELECT * FROM employees WHERE department='IT'),it_high_salary AS (SELECT * FROM it_employees 
WHERE salary>60000),it_average AS(SELECT AVG(salary) AS average_salary FROM it_high_salary) SELECT * FROM it_average;
With ranked AS (SELECT employee_name,department,salary,RANK() OVER(PARTITION BY department ORDER BY salary DESC)
AS salary_rank FROM employees) SELECT * FROM ranked WHERE salary_rank=1;
With ranked AS (SELECT employee_name,department,salary,ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC)
AS row_number FROM employees) SELECT * FROM ranked;
With ranked AS (SELECT employee_name,department,salary,DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC)
AS salary_rank FROM employees) SELECT * FROM ranked WHERE salary_rank<=2;
With ranked AS (SELECT employee_name,department,salary,RANK() OVER(PARTITION BY department ORDER BY salary DESC)
AS salary_rank FROM employees) SELECT * FROM ranked WHERE salary_rank=2;
With salary_data AS (SELECT employee_name,department,salary,AVG(salary) OVER(PARTITION BY department)
AS department_average FROM employees) SELECT employee_name,department,salary,department_average,salary-department_average 
AS salary_difference FROM salary_data;
With company_avg AS (SELECT AVG(salary) AS average_salary FROM employees) SELECT e.* FROM employees e CROSS JOIN company_avg c 
WHERE e.salary>c.average_salary;
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department) SELECT e.* FROM employees e 
JOIN dept_avg d ON e.department=d.department WHERE e.salary>d.average_salary;
With dept_total AS (SELECT department,SUM(salary) AS total_salary FROM employees GROUP BY department) SELECT * FROM dept_total 
ORDER BY total_salary DESC LIMIT 1;
With dept_avg AS (SELECT department,AVG(salary) AS average_salary FROM employees GROUP BY department) SELECT * FROM dept_avg 
ORDER BY average_salary DESC LIMIT 1;
With highest_salary AS (SELECT MAX(salary) AS max_salary FROM employees) SELECT e.* FROM employees e JOIN highest_salary h 
ON e.salary=h.max_salary;
With Recursive employee_hierarchy AS (SELECT employee_id,employee_name,department,salary,manager_id,1 AS level FROM employees 
WHERE manager_id IS NULL UNION ALL SELECT e.employee_id,e.employee_name,e.department,e.salary,e.manager_id,h.level+1 
FROM employees e JOIN employee_hierarchy h ON e.manager_id=h.employee_id) SELECT * FROM employee_hierarchy ORDER BY level,
employee_id;
With Recursive hierarchy AS (SELECT employee_id,employee_name,manager_id,employee_name::TEXT AS hierarchy_path FROM 
employees WHERE manager_id IS NULL UNION ALL SELECT e.employee_id,e.employee_name,e.manager_id,h.hierarchy_path||' -> '||e.employee_name 
FROM employees e JOIN hierarchy h ON e.manager_id=h.employee_id) SELECT * FROM hierarchy;
With Recursive hierarchy AS (SELECT employee_id,employee_name,manager_id,1 AS hierarchy_level FROM employees 
WHERE manager_id IS NULL UNION ALL SELECT e.employee_id,e.employee_name,e.manager_id,h.hierarchy_level+1 FROM 
employees e JOIN hierarchy h ON e.manager_id=h.employee_id) SELECT * FROM hierarchy ORDER BY hierarchy_level;
With Recursive john_team AS (SELECT employee_id,employee_name,manager_id FROM employees WHERE employee_name='John' 
UNION ALL SELECT e.employee_id,e.employee_name,e.manager_id FROM employees e JOIN john_team j ON e.manager_id=j.employee_id)
SELECT * FROM john_team WHERE employee_name<>'John';
With Recursive sarah_team AS (SELECT employee_id,employee_name,manager_id FROM employees WHERE employee_name='Sarah'
UNION ALL SELECT e.employee_id,e.employee_name,e.manager_id FROM employees e JOIN sarah_team s ON e.manager_id=s.employee_id)
SELECT * FROM sarah_team WHERE employee_name<>'Sarah';
With Recursive priya_team AS (SELECT employee_id,employee_name,manager_id FROM employees WHERE employee_name='Priya'
UNION ALL SELECT e.employee_id,e.employee_name,e.manager_id FROM employees e JOIN priya_team p ON e.manager_id=p.employee_id)
SELECT * FROM priya_team WHERE employee_name<>'Priya';
With Recursive manager_team AS (SELECT employee_id AS manager_id,employee_id AS employee_id FROM employees
UNION ALL SELECT m.manager_id,e.employee_id FROM manager_team m JOIN employees e ON e.manager_id=m.employee_id)
SELECT manager_id,COUNT(*)-1 AS employee_count FROM manager_team GROUP BY manager_id;
With Recursive manager_team AS (SELECT employee_id AS manager_id,employee_id AS employee_id FROM employees 
UNION ALL SELECT m.manager_id,e.employee_id FROM manager_team m JOIN employees e ON e.manager_id=m.employee_id),team_count AS 
(SELECT manager_id,COUNT(*)-1 AS team_size FROM manager_team GROUP BY manager_id) SELECT e.employee_name,t.team_size
FROM team_count t JOIN employees e ON t.manager_id=e.employee_id ORDER BY t.team_size DESC LIMIT 1;
With managers AS (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL) 
SELECT * FROM employees WHERE employee_id NOT IN (SELECT manager_id FROM managers);
With top_managers AS (SELECT * FROM employees WHERE manager_id IS NULL) SELECT * FROM top_managers;
With Recursive numbers AS (SELECT 1 AS num UNION ALL SELECT num+1 FROM numbers WHERE num<10) SELECT * FROM numbers;
With Recursive numbers AS (SELECT 1 AS num UNION ALL SELECT num+1 FROM numbers WHERE num<100) SELECT * FROM numbers;
With Recursive odd_numbers AS (SELECT 1 AS num UNION ALL SELECT num+2 FROM odd_numbers WHERE num<99) SELECT * FROM odd_numbers;
With Recursive dates AS (SELECT DATE '2026-01-01' AS date_value UNION ALL SELECT date_value+1 FROM dates 
WHERE date_value<DATE '2026-01-10') SELECT * FROM dates;
With Recursive january_dates AS (SELECT DATE '2026-01-01' AS date_value UNION ALL SELECT date_value+1 FROM 
january_dates WHERE date_value<DATE '2026-01-31') SELECT * FROM january_dates;
With Recursive date_range AS (SELECT DATE '2026-01-01' AS date_value UNION ALL SELECT date_value+1 FROM 
date_range WHERE date_value<DATE '2026-01-15') SELECT * FROM date_range;




















