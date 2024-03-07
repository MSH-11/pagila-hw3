/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

SELECT * from (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name as name,
        sum(p.amount) as total_payment,
        NTILE(100) OVER (ORDER BY sum(p.amount)) AS percentile
    FROM customer c
    JOIN payment p USING (customer_id)
    GROUP BY c.customer_id) AS subq
WHERE percentile > 89
ORDER BY name;
