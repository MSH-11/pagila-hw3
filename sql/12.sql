/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN LATERAL (
  SELECT *
  FROM rental
  WHERE customer_id = c.customer_id
  ORDER BY rental_date DESC
  LIMIT 5
) r ON true
JOIN inventory i ON (r.inventory_id = i.inventory_id)
JOIN film f ON (i.film_id = f.film_id)
JOIN film_category fc ON (f.film_id = fc.film_id)
JOIN category ct ON (fc.category_id = ct.category_id)
WHERE ct.name = 'Action'
GROUP BY c.customer_id
HAVING count(c.customer_id) > 3
ORDER BY c.customer_id;
