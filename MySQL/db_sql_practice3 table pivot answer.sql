select * from expenses;

with tmp as (
select * from expenses
where time between "2018-12-01" and "2018-12-02"
or time between "2018-11-01" and "2018-11-03")

select category
, sum(case when month (time) = 12
then cost
else 0 end)
as "Dec"
, sum(case when month (time) = 11
then cost 
else 0 end)
as "Nov"
from tmp
group by category
order by category;


select category,
sum(case when month(time) = 1 then cost else 0 end) as 'Jan',
sum(case when month(time) = 2 then cost else 0 end) as 'Feb',
sum(case when month(time) = 3 then cost else 0 end) as 'Mar',
sum(case when month(time) = 4 then cost else 0 end) as 'Apr',
sum(case when month(time) = 5 then cost else 0 end) as 'May',
sum(case when month(time) = 6 then cost else 0 end) as 'Jun',
sum(case when month(time) = 7 then cost else 0 end) as 'Jul',
sum(case when month(time) = 8 then cost else 0 end) as 'Aug',
sum(case when month(time) = 9 then cost else 0 end) as 'Sep',
sum(case when month(time) = 10 then cost else 0 end) as 'Oct',
sum(case when month(time) = 11 then cost else 0 end) as 'Nov',
sum(case when month(time) = 12 then cost else 0 end) as 'Dec' from
expenses
group by category
order by category;