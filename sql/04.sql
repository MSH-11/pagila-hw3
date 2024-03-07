/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

select * from (
    select a.first_name, a.last_name
    from actor a
    join film_actor fa using (actor_id)
    where fa.film_id in (
        select fc.film_id
        from film_category fc
        join category c using (category_id)
        where c.name = 'Children'
    )
    EXCEPT
    select  a.first_name, a.last_name
    from actor a
    join film_actor fa using (actor_id)
    where fa.film_id in (
        select fc.film_id
        from film_category fc
        join category c using (category_id)
        where c.name = 'Horror'
    )
) as Subquery
order by last_name, first_name;
