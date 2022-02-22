/*Write a query that identifies users who share similar tastes on music, 
e.g. listening to at least three songs on the same day, 
and recommend them to be connected as friends.

This question tests multiple concepts and numerous edge cases. Among those are:

Self-join.
De-duplication.
Exclusion.
Equi-join, non equi-join.
Aggregation. */

use spotifyfriend;

select * from song;
select * from user;

select * from song as s1
join song as s2
on s1.ts = s2.ts
and s1.song = s2.song
where s1.user_id = 'Cindy'
and s2.user_id = 'Cindy'
and s1.ts = '2019-03-14';

select 
s1.user_id,
s2.user_id,
s1.song,
s2.song,
s2.ts
from (select * from song where user_id in ('Cindy', 'Bill') and ts ='2019-03-14') AS s1
join (select * from song where user_id in ('Cindy', 'Bill') and ts ='2019-03-14') AS s2
on s1.user_id != s2.user_id
and s1.song = s2.song;

select 
s1.user_id,
s2.user_id,
count(distinct s2.song),
s2.ts
from (select * from song where user_id in ('Cindy', 'Bill') and ts ='2019-03-14') AS s1
join (select * from song where user_id in ('Cindy', 'Bill') and ts ='2019-03-14') AS s2
on s1.ts = s2.ts
and s1.song = s2.song
and s1.user_id != s2.user_id
group by s1.user_id, s2.user_id, s2.ts ;

select 
s1.user_id,
s2.user_id,
count(distinct s2.song) as common_song,
s2.ts
from song AS s1
join song AS s2
on s1.ts = s2.ts
and s1.song = s2.song
and s1.user_id != s2.user_id
group by s1.user_id, s2.user_id, s2.ts;

select 
s1.user_id,
s2.user_id,
count(distinct s2.song) as common_song,
s2.ts
from song AS s1
join song AS s2
on s1.ts = s2.ts
and s1.song = s2.song
and s1.user_id != s2.user_id
group by s1.user_id, s2.user_id, s2.ts
having common_song >2;

select 
s1.user_id,
s2.user_id as recommended
from song as s1
join song as s2
on s1.user_id != s2.user_id
and s1.song = s2.song
and s1.ts = s2.ts
where (s1.user_id, s2.user_id) not in 
(select user_id, friend_id from user
union
select friend_id, user_id from user)
group by s1.user_id, s2.user_id, s2.ts
having count(distinct s2.song) >=3;

# SECOND ATTEMPT

select * from song;

select * from song 
where user_id in ('Alex', 'Bill') and ts = '2019-03-17';

select
s1.user_id,
s2.user_id,
s1.song,
s2.song,
s2.ts
from (select * from song where user_id in ('Alex', 'Bill') and ts = '2019-03-17') as s1
join (select * from song where user_id in ('Alex', 'Bill') and ts = '2019-03-17') as s2
on s1.user_id != s2.user_id
and s1.song = s2.song;

select
s1.user_id,
s2.user_id,
count(distinct s2.song) as common_song,
s2.ts
from song as s1
join song as s2
on s1.user_id != s2.user_id
and s1.song = s2.song
and s1.ts = s2.ts
group by s1.user_id, s2.user_id, s2.ts
order by s2.ts;

select
s1.user_id,
s2.user_id,
count(distinct s2.song) as common_song,
s2.ts
from song as s1
join song as s2
on s1.user_id != s2.user_id
and s1.song = s2.song
and s1.ts = s2.ts
where (s1.user_id, s2.user_id) not in (
select user_id, friend_id from user
union
select friend_id, user_id from user)
group by s1.user_id, s2.user_id, s2.ts
having common_song>=3
order by s2.ts;