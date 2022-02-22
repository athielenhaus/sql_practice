describe login;

select * from login;

select distinct user_id, ts from login;

with tmp as (
select distinct user_id, ts from login)
select * from tmp as d0
join tmp as d1
on d0.user_id = d1.user_id
and datediff(d0.ts, d1.ts) = 1
join tmp as d2
on d1.user_id = d2.user_id 
and datediff(d0.ts, d2.ts) = 2;

set @now = '2019-02-14';

with tmp as (
select distinct user_id, ts from login)
select * 
from tmp as d0
join tmp as d1
on d0.ts = @now
and d0.user_id = d1.user_id
and datediff(d0.ts, d1.ts) = 1
join tmp as d2
on d2.user_id = d1.user_id 
and datediff(d0.ts, d2.ts) = 2;

# SECOND ATTEMPT

select * from login;

set @now = '2019-02-14';

with tmp as (
select user_id, ts from login)
select * from tmp as d1
join tmp as d2
on d1.user_id = d2.user_id
and datediff(d1.ts, d2.ts) = 1
and d1.ts = @now
join tmp as d3
on d2.user_id = d3.user_id
and datediff(d1.ts, d3.ts) = 2;
