#SQL Joins on multiple tables

USE Sakila;

#1. Write a query to display for each store its store ID, city, and country.

SELECT S.store_id, A.city_id, C.city, CO.country FROM store AS S
JOIN address AS A
USING (address_id)
JOIN city AS C
USING (city_id)
JOIN country AS CO
USING (country_id);

#2. Write a query to display how much business, in dollars, each store brought in.

SELECT S.store_id, SUM(P.amount) AS total_payment FROM store AS s
JOIN Staff AS ST
USING (store_id)
JOIN payment AS P
USING (staff_id)
GROUP BY S.store_id;

#3. What is the average running time of films by category?

SELECT FC.category_id, C.name, AVG(F.length) AS AVG_length FROM film AS F
JOIN film_category AS FC 
USING (film_id)
JOIN category AS C
USING (category_id)
GROUP BY FC.category_id,C.name;

#4.Which film categories are longest?

CREATE TEMPORARY TABLE sakila.category_length
SELECT FC.category_id, C.name, AVG(F.length) AS AVG_length FROM film AS F
JOIN film_category AS FC 
USING (film_id)
JOIN category AS C
USING (category_id)
GROUP BY FC.category_id,C.name;

SELECT * FROM category_length ORDER BY AVG_length DESC LIMIT 3;

#5. Display the most frequently rented movies in descending order.
SELECT F.title, COUNT(R.rental_id) AS rental_frequency
FROM film AS F
JOIN inventory AS I
USING (film_id)
JOIN rental AS R
USING (inventory_id)
GROUP BY F.title
ORDER BY rental_frequency DESC;

#6. List the top five genres in gross revenue in descending order.
SELECT C.name, SUM(P.amount) AS gross_revenue FROM category AS C
JOIN film_category AS FC
USING (category_id)
JOIN inventory AS I
USING (film_id)
JOIN rental AS R
USING (inventory_id)
JOIN payment AS P
USING (rental_id)
GROUP BY C.name
ORDER BY gross_revenue DESC
LIMIT 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT F.title, R.return_date FROM film AS F
JOIN inventory AS I
USING (film_id)
JOIN rental AS R
USING (inventory_id)
JOIN store AS S
USING (store_id)
WHERE title LIKE 'Academy Dinosaur' AND store_id=1;
# it is available because the return date is in the past