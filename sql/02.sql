/*
 * Compute the country with the most customers in it. 
 */

select cr.country
from customer c
join address a using (address_id)
join city ct using (city_id)
join country cr using (country_id)
group by cr.country
order by count(*) DESC limit 1;
