select release_year from film;

select title from film where title like '%ARMAGEDDON%';

SELECT title from film where title like '%APOLLO';

select title, length from film
order by length desc
limit 10;

select count(distinct film_id) from film where special_features like '%Behind the Scenes%';

alter table staff
drop picture;

select * from customer where last_name like "sanders" and first_name like "tammy";

select * from staff;

insert into staff (staff_id, first_name, last_name, address_id, email, store_id, active, username)
values (3, 'Tammy', 'Sanders', 79, 'tammy.sanders@sakilacustomer.org', 2, 1, 'Tammy');


# 8
select * from film where title like 'ACADEMY DINOSAUR';
select * from inventory where film_id = 1;

select * from rental;

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id)
values (20050524, 5, 130, 20050528, 3);

select * from rental
order by rental_id desc;

# 9 
create table customer_backup 
select * from customer where active <> 1;

select * from customer_backup;

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;
delete from customer where active <> 1;
SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS=1;