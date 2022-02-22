use practice;

select * from coursegrade;

with tmp as(
select * from coursegrade where name in ('Alice', 'Bob'))
select * from tmp as t1, tmp as t2, tmp as t3
where t1.name = t2.name
and t2.name = t3.name
and t1.course = 'CS106B'
AND t2.course = 'CS229'
AND t3.course = 'CS224N';

with tmp as(
select * from coursegrade where name in ('Alice', 'Bob'))

select t1.name, 
t1.grade as 'CS106B',
t2.grade as  'CS229',
t3.grade as 'CS224N'
 from tmp as t1, tmp as t2, tmp as t3
where t1.name = t2.name
and t2.name = t3.name
and t1.course = 'CS106B'
AND t2.course = 'CS229'
AND t3.course = 'CS224N';


select t1.name, 
t1.grade as 'CS106B',
t2.grade as 'CS229',
t3.grade as 'CS224N' 
from coursegrade as t1, coursegrade as t2, coursegrade as t3
where t1.name = t2.name
and t2.name = t3.name
and t1.course = 'CS106B'
AND t2.course = 'CS229'
AND t3.course = 'CS224N';

Select t1.name,
t1.grade AS 'CS106B'
,t2.grade AS 'CS229'
,t3.grade AS 'CS224N'
from coursegrade as t1
join coursegrade as t2
on t1.course = 'CS106B'
and t2.course = 'CS229'
and t1.name = t2.name
join coursegrade as t3
on t3.course = 'CS224N'
and t2.name = t3.name;


select * from coursegrade;

select * from coursegrade where name in ('Alice', 'Bob');

with tmp as(select * from coursegrade where name in ('Alice', 'Bob'))

select 
t1.name,
t1.grade as 'CS224N',
t2.grade as 'CS229',
t3.grade as 'CS106B'
from tmp as t1, tmp as t2, tmp as t3
where t1.course = 'CS224N'
and t2.course = 'CS229'
and t3.course = 'CS106B'
and t1.name = t2.name
and t2.name = t3.name;

select 
t1.name,
t1.grade as 'CS224N',
t2.grade as 'CS229',
t3.grade as 'CS106B'
from coursegrade as t1, coursegrade as t2, coursegrade as t3
where t1.course = 'CS224N'
and t2.course = 'CS229'
and t3.course = 'CS106B'
and t1.name = t2.name
and t2.name = t3.name;