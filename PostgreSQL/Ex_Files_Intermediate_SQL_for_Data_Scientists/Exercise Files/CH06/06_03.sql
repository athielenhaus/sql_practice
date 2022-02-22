SET search_path = data_sci, "$user", public;

select * from company_regions;

select * from employees;

select department_id, sum(salary) as sum from employees
group by department_id
order by sum desc;

select 
   department_id, 
   round(avg(salary)) as average, 
   round(var_pop(salary), 2) as variance, 
   round(stddev_pop(salary)) as st_dev
from 
   employees
group by 
   department_id
having 
   stddev_pop(salary) > 30000;



select 
   e.last_name, 
   e.email, 
   cd.department_name
from 
   employees e
join 
   company_departments cd
on
  e.department_id = cd.id
where
   salary > 120000;
   
   
   
select 
  upper(department_name)
from
 company_departments;
 
select initcap(department_name) from company_departments;

select rtrim('Kelly ') = 'Kelly';

-- double bars are risky - if even only one column contains a NULL value, NULL will be returned
select last_name || ', ' || job_title from employees;

-- better to use CONCAT
select concat(last_name, ', ', job_title) from employees;

select concat_ws(', ', 'jamaica', 'bermuda', 'bahama');

-- SUBSTRINGS
select substring('hi, my name is', 1, 3);

--alternative to above
select substring('hi, my name is' from 1 for 3);
select substring('hi, my name is' from 5);

-- INSERT BOOLEAN
select * from employees where job_title like '%assistant%';

select job_title, (job_title like '%assistant%') is_assistant from employees;

-- MULTIPLE LIKE / ORS
select job_title from employees where job_title similar to ('%vp%|%assistant%|web%');

-- REGEX
select distinct job_title from employees where job_title like 'vp_a%';
select distinct job_title from employees where job_title like 'vp a__o%';
select distinct job_title from employees where job_title like 'vp%o%m%';

select distinct job_title from employees where job_title similar to 'vp_(m|a)%';

-- TRUNCATE VS ROUND VS CEILING
select trunc(avg(salary)), round(avg(salary), 2), ceil(avg(salary)) from employees;


-- FUZZY MATCHES
create extension if not exists fuzzystrmatch;

-- SOUNDEX
select
  soundex('Postgres'),
  soundex('Postgresss'),
  'Postgres' = 'Postgresss',
  soundex('Postgres') = soundex('Postgresss');
  
-- DIFFERENCE (a returned value of '4' indicates a perfect soundex match and '1' no match at all. The scale is 1-4)
select difference('Postgres', 'Postgresss'); -- 4
select difference ('apples', 'bananas'); -- 1
select difference ('arne', 'anne'); -- 2
select difference ('table', 'tables'); -- 3

-- LEVENSHTEIN (counts the number of operatiions required on the second string to get the first)
select levenshtein ('Postgres', 'Postgresss');
select levenshtein ('apples', 'bananas');  
select levenshtein ('abc', 'cab');


select 
  count(last_name)
from
  employees
group by
  department_id;
  
-- SUBQUERIES
select
  e.last_name,
  e.salary,
  e.department_id,
  (select round(avg(e2.salary), 2) 
     from employees e2 
     where e.department_id = e2.department_id
  )
from
  employees e;


-- SUBQUERIES IN FROM CLAUSE
select 
  round(avg(salary),2)
from
  (select * from employees where salary > 100000) e1;
-- SOMETIMES more readable... but not always. No gains in efficiency


-- SUBQUERIES IN WHERE CLAUSE
select e1.department_id
from employees e1
where (select max(salary) from employees e2) = e1.salary;


-- ROLLUP
select cr.country_name, cr.region_name, count(e.*)
from employees e
join company_regions cr
on e.region_id = cr.id
group by 
  rollup(cr.country_name, cr.region_name)
order by
  cr.country_name, cr.region_name;


-- CUBE
select 
  cr.country_name, 
  cr.region_name, 
  cd.department_name,
  count(e.*)
from employees e
join 
  company_regions cr
on 
  e.region_id = cr.id
join
  company_departments cd
on
  e.department_id = cd.id
group by 
  cube(cr.country_name, 
       cr.region_name, 
       cd.department_name)
order by
  cr.country_name, 
  cr.region_name, 
  cd.department_name;
  
  
Select 
  cd.department_name,
  count(e.*),
  sum(e.salary)
from employees e
join company_departments cd
on e.department_id = cd.id
group by cd.department_name
having sum(salary) > 5000000
order by sum(salary) desc;

-- WINDOW FUNCTIONS

--FIRST VALUE
select 
  department_id,
  last_name,
  salary,
  first_value(salary) over (partition by department_id order by salary desc)
from employees;

-- WINDOW FUNCTIONS AVERAGE
select
  department_id,
  last_name,
  salary,
  -- notice that round needs to enclose entire window statement
  round(avg(salary) over (partition by department_id), 2)
from employees;

-- WINDOWS FUNCTIONS NTILE
select
  department_id,
  last_name,
  salary,
  ntile(4) over (partition by department_id order by salary desc) as quartile
from employees;

-- WINDOWS FUNCTIONS NTH_VALUE
-- find the 5th highest salary in each department
select
  department_id,
  last_name,
  salary,
  nth_value(salary, 5) over (partition by department_id order by salary desc)
from employees;

-- WINDOWS FUNCTION RANK
select
  department_id,
  last_name,
  salary,
  rank() over (partition by department_id order by salary desc)
from
  employees;
  
-- WINDOWS FUNCTION RANK (over whole table)
select
  department_id,
  last_name,
  salary,
  rank() over (order by salary desc)
from
  employees;

-- WINDOWS FUNCTION LEAD
select   
  department_id,
  last_name,
  salary,
  lead(salary, 1) over (partition by department_id order by salary desc)
from
  employees;

select   
  department_id,
  last_name,
  salary,
  lag(salary, 2) over (partition by department_id order by salary desc)
from
  employees;
  
  
-- WINDOWS FUNCTION WIDTH_BUCKET
select   
  department_id,
  last_name,
  salary,
  width_bucket(salary, 0, 150000, 10)
from
  employees;
  
-- WINDOWS FUNCTION CUME_DIST
/*CUME_DIST calculates the relative position of a specified value in a group of 
values. Assuming ascending ordering, the CUME_DIST of a value in row r is defined 
as the number of rows with values less than or equal to that value in row r, 
divided by the number of rows evaluated in the partition or query result set.*/
select   
  department_id,
  last_name,
  salary,
  -- NOTE: round function only takes numeric, therefore format must be cast to numeric with '::'
  round((cume_dist() over (order by salary desc) * 100)::numeric, 2)
from
  employees;


select 
  department_id,
  last_name,
  salary,
  sum(salary) over (partition by department_id)
from
  employees;


-- COMMON TABLE EXPRESSIONS (CTEs)
with region_salaries as
 (select region_id, sum(salary) region_salary
 from employees
 group by region_id),
 top_region_salaries as 
 (select region_id 
  from region_salaries
  where region_salary > (select avg(region_salary) from region_salaries))
select
  *
from
  region_salaries
where
  region_id in (select region_id from top_region_salaries);

--RECURSIVE
select * from org_structure;

with recursive report_structure (id, department_name, parent_department_id) as
  (select id, department_name, parent_department_id
  from org_structure where id = 5
  union
  select os.id, os.department_name, os.parent_department_id
  from org_structure os
  join report_structure rs
  on rs.parent_department_id = os.id)
select
  *
from
  report_structure;


with temp_table as
  (select id from company_regions cr
  where region_name like '%east%')
select
  sum(salary),
  round(avg(salary), 2)
from 
  employees e
where
  e.region_id in (select id from temp_table);
