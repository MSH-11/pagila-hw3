/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT
    name,
    title,
    "total rentals"
FROM (
    SELECT
        c.name,
        f.title,
        count(r.rental_id) as "total rentals",
        RANK() OVER(PARTITION BY c.category_id ORDER BY count (r.rental_id) DESC, f.title DESC) as rank
    FROM
        category c
    JOIN
        film_category fc USING (category_id)
    JOIN
        film f USING (film_id)
    JOIN
        inventory i USING (film_id)
    JOIN
        rental r USING (inventory_id)
    GROUP BY
        c.category_id,
        f.film_id
    ) as subq
WHERE
    subq.rank < 6
ORDER BY
    name,
    "total rentals" DESC,
    title
;
