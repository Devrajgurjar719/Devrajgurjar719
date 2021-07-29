--1. We want to run an Email Campaigns for customers of Store 2 (First, Last name, and Email address of customers from Store 2)
select first_name, last_name, email from customer where store_id = 2;

--2. List of the movies with a rental rate of 0.99$
select title, rental_rate from film where rental_rate = 0.99;

--3. Your objective is to show the rental rate and how many movies are in each rental rate categories
select count(film_id) as movie_count , rental_rate from film group by rental_rate;

--4. Which rating do we have the most films in?
select count(film_id) as movie_count , rating from film group by rating order by count(film_id) desc limit 1;

--5. Which rating is most prevalent in each store?
select f.rating,count(f.rating), i.store_id from film f inner join inventory i on f.film_id = i.film_id group by i.store_id, f.rating order by f.rating;

--6. We want to mail the customers about the upcoming promotion
select distinct  email from customer;

--7. List of films by Film Name, Category, Language
select f.title as film_name , cat.name as category, l.name as language from film f inner join film_category c on f.film_id = c.film_id
inner join language l on f.language_id = l.language_id inner join category cat on cat.category_id = c.category_id;

--8. How many times each movie has been rented out?
select f.title , count(rental_id) as rent_count from film f inner join inventory i on f.film_id = i.film_id inner join rental r on r.inventory_id = i.inventory_id group by f.title;

--9. What is the Revenue per Movie?
select f.title , sum(p.amount) as revenue from film f inner join inventor
y i on f.film_id = i.film_id inner join rental r on i.inventory_id = r.inventory_id inner join payment p on r.rental_id = p.rental_id group by f.title;

--10.Most Spending Customer so that we can send him/her rewards or debate points
select c.first_name, c.last_name , sum(p.amount) from customer c inner join payment p on c.customer_id = p.customer_id group by c.first_name , 
c.last_name order by sum(p.amount) desc limit 1;

--11. What Store has historically brought the most revenue?
select s.store_id , sum(p.amount) from store s inner join customer c on s.store_id = c.store_id inner join payment p on c.customer_id = p.customer_id group by s.store_id;

--12.How many rentals do we have for each month?
select count(rental_id) rental_count, MONTH(rental_date) as month from re
ntal group by MONTH(rental_date);

--13.Rentals per Month (such Jan => How much, etc)
select count(rental_id) rental_count, MONTH(rental_date) as month from re
ntal group by MONTH(rental_date);

--14.Which date the first movie was rented out?
select rental_date as [Rental_Date_Of_FirstMovie] from rental order by rental_date limit 1;
OR
select min(rental_date) as Rental_Date_Of_FirstMovie from rental;

--15.Which date the last movie was rented out?
select rental_date as Rental_Date_Of_FirstMovie from rental order by rental_date desc limit 1;
OR
select max(rental_date) as Rental_Date_Of_FirstMovie from rental;

--16.For each movie, when was the first time and last time it was rented out?
select f.title as Film_Name, min(r.rental_date) as First_rental_date , max(r.rental_date) as Last_rental_date from film f inne
m_id = i.film_id inne
 f.title;

--17.What is the Last Rental Date of every customer?
with rental_cte as (select customer_id , max(rental_date) as last_rental_date from rental group by customer_id) select  c.first_name, c.last_name ,rc.last_rental_date from rental_cte rc inne
stomer_id;

--18.What is our Revenue Per Month?
select sum(amount) as revenue_per_month , MONTHNAME(payment_date) from payment group by MONTHNAME(payment_date);

--19.How many distinct Renters do we have per month?
select distinct count(rental_id) as total_renters , MONTHNAME(rental_date) from rental group by MONTHNAME(rental_date);

--20.Show the Number of Distinct Film Rented Each Month
select MONTHNAME(r.rental_date) as Month_Name  ,count(*) as rented_count
 from film f inner join inventory i on f.film_id = i.film_id inner join rental r
 on i.inventory_id = r.inventory_id group by MONTHNAME(r.rental_date);

--21.Number of Rentals in Comedy, Sports, and Family
select cat.name as category , count(r.rental_id) as rental_count from film f inner join film_category c on f.film_id = c.film_id inner
join category cat on cat.category_id = c.category_id inner join inventory i on i.film_id = f.film_id inner join rental r on r.inventory_id = i.inventory_id group by cat.name having cat.name in ('Family','Comedy','Sports');

--22.Users who have been rented at least 3 times
select c.first_name , c.last_name ,count(r.rental_id) as rental_count from customer c inner join rental r on 
c.customer_id = r.customer_id group by c.first_name, c.last_name having count(r.rental_id) > 3;

--23.How much revenue has one single store made over PG13 and R-rated films?
select i.store_id as store_id, sum(p.amount) as revenue__of_each_store from inventory i inner join film f on f.film_id = i.film_id inner join rental r 
on i.inventory_id = r.inventory_id inner join payment p on p.rental_id = r.rental_id where f.rating in 
('PG-13','R') group by
i.store_id;

--24.Active User where active = 1
select count(*) as Active_user_Count from customer where active = True ;

--25.Reward Users: who has rented at least 30 times
select c.first_name , c.last_name ,count(r.rental_id) as rental_count from customer c inner join rental r on 
c.customer_id = r.customer_id group by c.first_name, c.last_name having count(r.rental_id) >= 30;

--26.Reward Users who are also active
select count(*) as Active_user_Count from customer where active = True ;

--27.All Rewards Users with Phone
select c.first_name , c.last_name from customer c inner join address a on a.address_id = c.address_id where a.phone = "";