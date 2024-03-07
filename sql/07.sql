/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

select distinct (a2.first_name || ' ' || a2.last_name) as "Actor Name"
from actor a1
join film_actor fa1 ON (a1.actor_id = fa1.actor_id)
join film_actor fa2 ON (fa1.film_id = fa2.film_id)
join actor a2 ON (fa2.actor_id = a2.actor_id)

where a1.actor_id in (
    select distinct a2.actor_id
    from actor a1
    join film_actor fa1 ON (a1.actor_id = fa1.actor_id)
    join film_actor fa2 ON (fa1.film_id = fa2.film_id)
    join actor a2 ON (fa2.actor_id = a2.actor_id)
    where (a1.first_name || ' ' || a1.last_name) = 'RUSSELL BACALL' and (a2.first_name || ' ' || a2.last_name) != 'RUSSELL BACALL'
    )

AND a2.actor_id not in (
    select distinct a2.actor_id
    from actor a1
    join film_actor fa1 ON (a1.actor_id = fa1.actor_id)
    join film_actor fa2 ON (fa1.film_id = fa2.film_id)
    join actor a2 ON (fa2.actor_id = a2.actor_id)
    where (a1.first_name || ' ' || a1.last_name) = 'RUSSELL BACALL'
)
order by "Actor Name";
