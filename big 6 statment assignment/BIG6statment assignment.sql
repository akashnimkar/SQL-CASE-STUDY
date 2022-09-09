-- First step is to see the data that are present in your tables and 
-- understand their relation with each other.


-- List down table;

show tables;

-- actor
-- actor_award
-- actor_info
-- address
-- advisor
-- category
-- city
-- country
-- customer
-- customer_list
-- film
-- film_actor
-- film_category
-- film_list
-- film_text
-- inventory
-- investor
-- language
-- payment
-- rental
-- sales_by_film_category
-- sales_by_store
-- staff
-- staff_list
-- store


/*
In our database we have 16 related tables, which contains information about :
1. Customer (name, address etc.)
	All data corresponding to customer  4 tables
		a. customer
        b. address
        c. city
        d. country
        
2. Business (Staff, Rentals etc.) 4 tables + 2 table
		a. staff
        b. store
        c. payment
        d. rental
        
        advisor
        investor
	
3. Inventory (Films, Categories etc.) 8 tables +1 table
		a. inventory
		b1. film
        b2. film_text
        c. film_category
        d. category
		e. langauge
        f. actor
        g. film_actor
        
        actor_award
        
*/

-- 1. We will need a list of all staff members, including their first and last names, email addresses, 
-- and the store identification number where they work.
select first_name,
last_name,
email,
store_id
 from staff;

-- 2. We will need separate counts of inventory items held at each of your two stores.
select 
store_id,
count(inventory_id) as inentory_count
 from inventory
 group by store_id;
 -- there are 2270 inventory items from store 1
 -- there are 2311 inventory items from store 2
 
 select * from inventory;
 -- total inventory item in both store is 4581. 
 
 
-- 3.We will need a count of active customers for each of your stores. Separately, please. 
select store_id,
count(customer_id) as count_of_customer
 from customer
 where active=1
 group by store_id;

 -- THERE ARE 318 CUSTOMER ARE ACTIVE IN STORE 1 AND 266 CUSTOMER ARE ACTIVE IN STORE 2. 
 
 select count(customer_id) as non_active_customer 
from customer
where active=0 
group by store_id;
-- THERE ARE 8 CUSTOMER ARE NOT ACTIVE IN STORE 1 , AND 7 CUSTOMER ARE NOT ACTIVE IN STORE 2. 

 -- 4 In order to assess the liability of a data breach, we will need you to provide a count of all customer email addresses stored in the database.
 select	count(email) as mail_id
 from customer;
 -- there 599 customer mails are stored in database. 
 
 /* 5.	We are interested in how diverse your film offering is as a means of understanding how likely 
you are to keep customers engaged in the future. Please provide a count of unique film titles 
you have in inventory at each store and then provide a count of the unique categories of films you provide.  
 */
 
 select store_id,
 count(distinct film_id) as unique_film
 from inventory
 group by store_id;
 -- there are 759 unique film in store 1 ,and 762 uniquw film are in store 2. 
 
 /*
6.	We would like to understand the replacement cost of your films. 
Please provide the replacement cost for the film that is least expensive to replace, 
the most expensive to replace, and the average of all films you carry. ``	
*/
select film_id,
min(replacement_cost) as cheapest_cost,
max(replacement_cost) as costly_film,
avg(replacement_cost) as avg_cost 
from film
;
-- 9.99 , 29.99 and 19.98 respectivly. 

/*
7.	We are interested in having you put payment monitoring systems and maximum payment 
processing restrictions in place in order to minimize the future risk of fraud by your staff. 
Please provide the average payment you process, as well as the maximum payment you have processed.
*/
select avg(amount) as average_payment,
max(amount) as maximum_payment 
 from payment;

/*
8.	We would like to better understand what your customer base looks like. 
Please provide a list of all customer identification values, with a count of rentals 
they have made all-time, with your highest volume customers at the top of the list.
*/
select customer_id,
count(rental_id) as rental_count
 from rental
 group by customer_id
 order by rental_count desc;
 
 