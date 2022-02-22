use sakila;

select * from actor;
select * from actor where first_name = 'SCARLETT';

# How many films are available for rent
select * from inventory;
SELECT count(distinct film_id) from inventory;

# How many films have been rented
select * from rental;
select count(distinct rental_id) from rental;

# How many distinct films have been rented?
select count(distinct f.film_id) from rental r
join inventory i
using(inventory_id)
join film f
using (film_id);

# Shortest and longest movie duration
select max(length) as max_duration, min(length) as min_duration from film;

# What's the average movie duration expressed in format (hours, minutes)?
select length from film;
select length / 60 from film;
select concat(floor(length / 60), ':', mod(length, 60)) from film;

# how many distinc actors last names are there?
select * from actor;
select count(distinct last_name) from actor;

# Since how many days has the company been operating (check DATEDIFF() function)?
select * from rental;
select datediff(max(rental_date), min(rental_date)) from rental;

# Show rental info with additional columns month and weekday. Get 20 results
select *, month(rental_date), dayofweek(rental_date) from rental
limit 20;
select *, date_format(rental_date, '%a') as weekday,
date_format(rental_date, '%M') as Month from rental
limit 20;

# Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select *, date_format(rental_date, '%a') as weekday,
date_format(rental_date, '%M') as Month from rental
limit 20; 

select *, date_format(rental_date, '%a') as weekday, 
case when dayofweek(rental_date) between 2 and 6 then 'weekday'
else 'weekend' end as day_type,
date_format(rental_date, '%M') as month from rental;

# How many rentals were in the last month of activity?
select count(*) from rental 
where rental_date > (select (date_sub(max(rental_date), interval 1 month)) from rental);


select date_sub(max(rental_date), interval 1 month) as date from rental;

select count(*) from rental 
where rental_date > 
(select date_sub(max(rental_date), interval 1 month) as date from rental);

DELETE FROM rental WHERE rental_id=16050;

# Get release years
select release_year from film;

# Get all films with ARMAGEDDON in the title.
select * from film where title like '%ARMAGEDDON%';

# Get all films which title ends with APOLLO.
select * from film where title like '%APOLLO';

# Get the 10 longest films.
select * from film
order by length desc
limit 10;

# How many films include Behind the Scenes content?
select count(*) from film
where special_features like '%Behind the Scenes%';

# drop column picture from staff
select * from staff;
alter table staff
drop picture;

# add a customer to the staff table
select * from staff;
describe staff;
select * from customer;

insert into staff (first_name, last_name, address_id, email, store_id, active, username)
select  first_name, last_name, address_id, email, store_id, active, first_name
from customer
where customer_id in (7, 8);


select last_name, mid(first_name, 2, 5) from staff;

# Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
select * from film;
select * from inventory;
select * from rental;
select * from customer;

select f.film_id, i.inventory_id 
from inventory i
join film f
using (film_id) 
where f.title = 'ACADEMY DINOSAUR'
and i.store_id = 1;

insert into rental(rental_date, inventory_id, customer_id, return_date, staff_id)
select current_date(), 3,
(select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'), 
date_add(current_date(), interval 5 day), 1 ;

select Capitalize(first_name) from customer;
select first_name, mid(first_name, 2, length(first_name)) from customer;


select first_name, length(first_name) from customer;
