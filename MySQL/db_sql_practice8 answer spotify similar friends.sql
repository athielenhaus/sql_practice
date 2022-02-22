use spotifyfriend;

select * from song s1
join user u
on s1.user_id = u.user_id;

select * from song s1
join user u
on s1.user_id = u.friend_id;

select count(*)
from user u
join song s1
on u.user_id = s1.user_id
join song s2
on u.friend_id = s2.user_id;


select * from song as s1
join user as u
on u.user_id = s1.user_id
join song as s2
on u.friend_id = s2.user_id
where s1.ts = s2.ts
and s1.song = s2.song;

select distinct 
u.user_id,
u.friend_id
from user as u
join song as s1
on u.user_id = s1.user_id
join song as s2
on u.friend_id = s2.user_id
where s1.song = s2.song
and s1.ts = s2.ts
group by s1.ts, u.user_id, u.friend_id
having count(distinct s1.song)>=3;
