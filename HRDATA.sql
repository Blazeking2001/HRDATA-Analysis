-- SQL QUERY



-- Employee Counts:
SELECT sum(employee_count) as Employee_counts FROM hrdata;

-- Attrition Count:
SELECT sum(attrition) FROM hrdata 
WHERE attrition = ‘YES’;

-- Attrition Rate:
SELECT (SELECT count(attrition) FROM hrdata WHERE attrition = ‘YES’) / sum(employee_count) * 100 FROM hrdata;

-- Active Age:
SELECT round(avg(age), 0) FROM hrdata;

-- Attrition by Gender:
SELECT gender, count(attrition) WHERE attrition = ‘YES’
 GROUP BY gender
 order by count(attrition) desc;
 
 -- Attrition by department
select departmnet, count(attrition)from hrdata
where attrition = 'Yes'
group by departmnet
order by count(attrition) desc

-- attrition by department with percentage total  
select department, count(attrition),
((count(attrition) / (select count(attrition) from hrdata where attrition='Yes'))*100) as pct
from hrdata
where attrition = 'Yes'
group by departmnet
order by count(attrition) desc;

-- Attrition by education field
select education_field, count(attrition) from hrdata
where attrition='Yes' and department='Sales'
group by education_field
order by count(attrition) desc;

-- Attrition Rate by gender for different age group 
select age_band, gender, count(attrition)attrition,
(count(attrition) / (select count(attrition) from hrdata where attrition='Yes')) * 100
from hrdata
where attrition='Yes'
group by age_band, gender
order by age_band, gender

-- Job staisfaction
CREATE EXTENSION IF NOT EXISTS tablefunc;

select * from 
crosstab(
'select job_role, job_satisfaction, sum(employee_count)
from hrdata
group by job_role, job_satisfacttion
order by job_role, job_satisfaction'
) as ct (job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
order by job_role;