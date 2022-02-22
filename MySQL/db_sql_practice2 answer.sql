select * from user;

select * from userhistory;

# we need the user name, phone number and last login date for every person who logged in in the last 3 months
set @now = '2019-03-12';
select user.name, user.phone_num, max(uh.date) as last_logon
from userhistory as uh
join user
using (user_id)
where action = 'logged_on' 
and datediff (@now, date) < 30
group by user.name;

SELECT DATE_SUB("2017-06-15", INTERVAL 10 DAY);
select curdate();
select curtime();
select current_user();
select current_timestamp();

select adddate(curdate(), interval 10 month);
select adddate(current_timestamp(), interval 10 minute);
SELECT time("2017-06-15 09:34:21");
SELECT DATE_FORMAT("2017-06-15", "%Y %M %D %W %U %r %s %i %j");
select dayname(curdate());

set @now = '2019-03-12';
select user.name, user.phone_num, max(uh.date) as last_logon
from userhistory as uh
join user
using (user_id)
group by user.name
having datediff(@now, last_logon)>30;

select user.user_id, user.name
from user
left join userhistory as uh 
using(user_id)
where uh.user_id is null;

 