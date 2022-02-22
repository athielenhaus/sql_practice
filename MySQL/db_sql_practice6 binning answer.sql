/* One common task is to put rows into bins, meaning that there does not exist a conveninet column for us to GROUP BY. 
It contains a customers table. We will put customers into different class of credit limit.
0~50,000
50,001~100,000
over 100,000
 */ 
 
 select * from customers;
 
select customerName,
(case when creditlimit between 0 and 50001 then '0 ~ 50K'
when creditlimit between 50001 and 100000 then '50~100K'
else 'over 100K' end) 
as credit_range
from customers;

select 
(case when creditlimit between 0 and 50001 then '0 ~ 50K'
when creditlimit between 50001 and 100000 then '50~100K'
else 'over 100K' end) 
as credit_range, count(*) as customer_tally
from customers
group by credit_range;