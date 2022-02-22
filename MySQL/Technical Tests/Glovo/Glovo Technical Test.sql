create database GLOVO1;

use glovo1;

create table users (
id INT,
first_order_id INT,
registration_date datetime);

create table orders(
id INT,
customer_id INT,
activation_time_local datetime);

INSERT INTO orders
VALUES (985, 596, "2015-03-15 22:10:30.000000");

select * from orders;

/* Out of the users who signed up in Week N,
how many did their first order in week N+1, N+2?

It is assumed that the first_order_id in "users¨ table
DOES correspond to the order_id in "orders" table. 
It is assumed that id in the "users" table DOES NOT correspond to
customer_id in "orders" table.


*/

SET @N = 1;

# get users who did first order in week N+1
SELECT u.id,
CASE 
WHEN (
(
(week(u.registration_date) + 1 = week(o.activation_time_local))
AND (year(u.registration_date) = year(o.activation_time_local))
)
OR (
(day(u.registration_date) between 360 and 365) 
AND (week(o.activation_time_local) = 1)
AND (year(u.registration_date) + 1 = year(o.activation_time_local))
)
) then cohort_N1 
else nothing
end
FROM users as u
JOIN orders as o
ON u.first_order_id = o.id;



WHERE (
(week(u.registration_date) + 1 = week(o.activation_time_local))
AND (year(u.registration_date) = year(o.activation_time_local))
)
OR (
(day(u.registration_date) between 360 and 365) 
AND (week(o.activation_time_local) = 1)
AND (year(u.registration_date) + 1 = year(o.activation_time_local))
)

 
