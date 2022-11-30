use sakila;

-- Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
from store s
join address a using(address_id)
join city c using(city_id)
join country co using(country_id);

-- Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as total_payment
from store s
left join staff st using(store_id)
left join payment p using(staff_id)
group by s.store_id; 

select s.store_id, sum(p.amount) as total_payment
from store s
left join customer c using(store_id)
left join payment p using(customer_id)
group by s.store_id; 

-- What is the average running time of films by category?
select c.name, round(avg(f.length), 2) as average_movie_length
from film f 
join film_category fc using(film_id)
join category c using(category_id)
group by c.name;

-- Which film categories are longest?
select c.name, round(max(f.length), 2) as average_movie_length
from film f 
join film_category fc using(film_id)
join category c using(category_id)
group by c.name
order by average_movie_length desc;

-- Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as total_rents
from film f 
join inventory i using(film_id)
join rental r using(inventory_id)
group by f.title
order by total_rents desc;

-- List the top five genres in gross revenue in descending order.
select c.name, round(sum(p.amount), 2) as gross_revenue
from category c 
join film_category fc using(category_id)
join film f using(film_id)
join inventory i using(film_id)
join rental r using(inventory_id)
join payment p using(rental_id)
group by c.name
order by gross_revenue desc
limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
select f.title, i.store_id, r.rental_date, r.return_date
from film f 
join inventory i using(film_id)
join rental r using(inventory_id)
where f.title = "Academy Dinosaur" and i.store_id = 1;
    -- Yes, the movie is available for rent.

