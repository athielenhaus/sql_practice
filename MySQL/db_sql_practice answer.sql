use spotify;

set @now = "2019-03-01 00:00:00" ;

drop table if exists daily_count;
create temporary table daily_count
select song_id, user_id, count(*) as tally from daily
where datediff(@now, time_stamp) = 0
group by song_id, user_id;

select * from daily_count;

set sql_safe_updates = 0;

update history as uh
join daily_count as dc
on dc.user_id = uh.user_id and 
dc.song_id = uh.song_id
set uh.tally = uh.tally + dc.tally;

select * from history;

# first select the data which the tables do not have in common

insert into history (user_id, song_id, tally)
select dc.user_id, dc.song_id, dc.tally 
from daily_count as dc
left join history as uh
on dc.song_id = uh.song_id
and dc.user_id = uh.user_id
where uh.tally is null;

select * from history;
