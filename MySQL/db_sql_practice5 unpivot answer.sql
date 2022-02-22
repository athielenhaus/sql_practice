use practice;

select * from course_grade_pivoted;

select * from (
select 'CS106B' as course_name
UNION ALL
select 'CS229'
UNION ALL
select 'CS224N') aux; 

select * from course_grade_pivoted,
(
select 'CS106B' as course
UNION ALL
select 'CS229'
UNION ALL
select 'CS224N') aux;

select name,
aux.course,
(case aux.course 
when 'CS106B' then CS106B
when 'CS229' then CS229
when 'CS224N' then CS224N
end) as grade
from course_grade_pivoted,
(
select 'CS106B' as course
UNION ALL
select 'CS229'
UNION ALL
select 'CS224N') aux;

select family.name from
(select 'Arne' as name
union all
select 'Imme'
union all 
select 'Peter') family;

select * from course_grade_pivoted;

select 'CS106B' as name
union all
select 'CS229'
union all
select 'CS224N';

select * from course_grade_pivoted, 
(select 'CS106B' as name
union all
select 'CS229'
union all
select 'CS224N') aux;

select name, 
aux.course,
(case aux.course
when 'CS106B' then CS106B
when 'CS229' then CS229
when 'CS224N' then CS224N end)
as grade
from course_grade_pivoted, 
(select 'CS106B' as course
union all
select 'CS229'
union all
select 'CS224N') aux;

use grocery;
select * from expenses_pivoted;

select category,
aux.month,
Case aux.month
when 'Jan' then Jan
when 'Feb' then Feb
when 'Mar' then Mar
when 'Apr' then Apr
when 'May' then May
when 'Jun' then Jun
when 'Jul' then Jul
when 'Aug' then Aug
when 'Sep' then Sep
when 'Oct' then Oct
when 'Nov' then Nov
when 'Dec' then Dec_
end as expenses
from expenses_pivoted, 
(select 'Jan' as month
union all
select 'Feb'
union all
select 'Mar'
union all
select 'Apr'
union all
select 'May'
union all
select 'Jun'
union all
select 'Jul'
union all
select 'Aug'
union all
select 'Sep'
union all
select 'Oct'
union all
select 'Nov'
union all
select 'Dec') aux;
