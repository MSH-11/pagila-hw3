/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

select cr.country, sum(p.amount) as total_payments
from customer c
join address a using (address_id)
join city ct using (city_id)
join country cr using (country_id)
join payment p on c.customer_id = p.customer_id
group by cr.country
order by total_payments DESC, cr.country;
