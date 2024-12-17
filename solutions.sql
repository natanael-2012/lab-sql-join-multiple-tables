-- Add you solution queries below:
USE SAKILA;

-- ***************************************************************************************************
-- 1. Write a query to display for each store its store ID, city, and country.
SELECT
	store_id,
	city,
	country
FROM
	store s
	inner join address a on s.address_id = a.address_id
	inner join city c on c.city_id = a.city_id
	inner join country on country.country_id = c.country_id;

-- ***************************************************************************************************
-- 2. Write a query to display how much business, in dollars, each store brought in.
select
	store.store_id,
	city,
	country,
	sum(p.amount) as total_sales
from
	payment p
	inner join staff s on p.staff_id = s.staff_id
	inner join store on s.store_id = store.store_id
	inner join address a on store.address_id = a.address_id
	inner join city on a.city_id = city.city_id
	inner join country on city.country_id = country.country_id
GROUP BY
	store.store_id,
	city.city,
	country.country;

-- ***************************************************************************************************
-- 3. What is the average running time of films by category?
SELECT
	category.category_id,
	category.name as Genre,
	avg(length)
FROM
	category
	inner join film_category fc on category.category_id = fc.category_id
	inner join film f on fc.film_id = f.film_id
GROUP BY
	category.category_id;

-- ***************************************************************************************************
-- 4. Which film categories are longest?
SELECT
	category.category_id,
	category.name as Genre,
	avg(length)
FROM
	category
	inner join film_category fc on category.category_id = fc.category_id
	inner join film f on fc.film_id = f.film_id
GROUP BY
	category.category_id
ORDER BY
	avg(length) desc
LIMIT
	5;

-- ***************************************************************************************************
-- 5. Display the most frequently rented movies in descending order.
SELECT
	title,
	count(rental.rental_id) AS RENT_COUNT
FROM
	film f
	inner join inventory i on f.film_id = i.film_id
	inner join rental on rental.inventory_id = i.inventory_id
group by
	title
order by
	count(rental.rental_id) desc;

-- ***************************************************************************************************
-- 6. List the top five genres in gross revenue in descending order.
SELECT
	c.name as GENRE,
	SUM(p.amount) as GROSS_REVENUE
FROM
	payment p
	inner join rental on p.rental_id = rental.rental_id
	inner join inventory i on rental.inventory_id = i.inventory_id
	inner join film_category fc on i.film_id = fc.film_id
	inner join category c on fc.category_id = c.category_id
GROUP BY
	c.category_id
ORDER BY
	sum(p.amount) desc
LIMIT
	5;

-- ***************************************************************************************************
-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select
	f.title,
	i.store_id,
	count(title) as "Titles available in store inventory"
FROM
	film f
	inner join inventory i on f.film_id = i.film_id
where
	i.store_id = 1
	and f.title = "Academy Dinosaur"
group by
	f.title,
	i.store_id;