/*1. Actores que tienen de primer nombre ‘Scarlett’.*/

select *
from sakila.actor
where sakila.actor.first_name = 'Scarlett';

/*2. Actores que tienen de apellido ‘Johansson’.*/

select *
from sakila.actor
where sakila.actor.last_name = 'Johansson';

/*3. Actores que contengan una ‘O’ en su nombre.*/

select *
from sakila.actor
where sakila.actor.first_name like '%O%';

/*4. Actores que contengan una ‘O’ en su nombre y en una ‘A’ en su apellido.*/

select *
from sakila.actor
where sakila.actor.first_name like '%O%' and sakila.actor.last_name like '%A%';

/*5. Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido.*/

select *
from sakila.actor
where sakila.actor.first_name like '%O%O%' and sakila.actor.last_name like '%A%';

/*6. Actores donde su tercera letra sea ‘B’.*/

select *
from sakila.actor
where sakila.actor.first_name regexp ".{2}B";

select *
from sakila.actor
where sakila.actor.first_name like "__B%";

/*7. Ciudades que empiezan por ‘a’.*/

SELECT *
FROM world.city
where world.city.Name like 'A%';

/*8. Ciudades que acaban por ‘s’.*/

SELECT *
FROM world.city
where world.city.Name like '%S';

/*9. Ciudades del country 61.*/

select *
from sakila.city
where sakila.city.country_id = 61;

/*10. Ciudades del country ‘Spain’.*/

SELECT *
FROM world.city
where world.city.CountryCode = 'ESP';

select 
	sakila.city.city,
    sakila.country.country
from sakila.city
	left join sakila.country on sakila.country.country_id = sakila.city.country_id
where sakila.country.country = "Spain";

/*11. Ciudades con nombres compuestos.*/

SELECT *
FROM world.city
where world.city.Name like '% %';

/*12. Películas con una duración entre 80 y 100.*/

select *
from sakila.film
where sakila.film.length > 80 and sakila.film.length < 100;

select *
from sakila.film
where sakila.film.length between 80 and 100;

/*13. Películas con un rental_rate entre 1 y 3.*/

select *
from sakila.film
where sakila.film.rental_rate > 1 and sakila.film.rental_rate < 3;

select *
from sakila.film
where sakila.film.rental_rate between 1 and 3;

/*14. Películas con un título de más de 12 letras.*/

select
	*
from sakila.film
where length(sakila.film.title) > 12;

/*15. Películas con un rating de PG o G.*/

select *
from sakila.film
where sakila.film.rating = 'PG' or sakila.film.rating = 'G';

select *
from sakila.film
where sakila.film.rating in ('PG','G');

/*16. Películas que no tengan un rating de NC-17.*/

select *
from sakila.film
where sakila.film.rating <> 'NC-17';

select *
from sakila.film
where sakila.film.rating not in ('NC-17');

/*17. Películas con un rating PG y duración de más de 120.*/

select *
from sakila.film
where sakila.film.rating = 'PG' AND sakila.film.length > 120;

select *
from sakila.film
where sakila.film.rating in ('PG') AND sakila.film.length > 120;

/*18. ¿Cuántos actores hay?*/

select
	count(sakila.actor.actor_id) as NumActores
from sakila.actor;

/*19. ¿Cuántas ciudades tiene el country ‘Spain’?*/

SELECT count(sakila.city.city_id) as NumCiudadesEspañolas
FROM sakila.city
where sakila.city.country_id = (
	select sakila.country.country_id
	from sakila.country
	where sakila.country.country = 'Spain');
    
SELECT count(sakila.city.city_id) as NumCiudadesEspañolas
FROM sakila.city
	left join sakila.country on sakila.city.country_id = sakila.country.country_id
where sakila.country.country = "Spain";

/*20. ¿Cuántos countries hay que empiezan por ‘a’?*/

select count(sakila.country.country_id) as PaisesA
from sakila.country
where sakila.country.country like 'A%';

/*21. Media de duración de Películas con PG.*/

select avg(sakila.film.length) as Duracion
from sakila.film
where sakila.film.rating = 'PG';

/*22. Suma de rental_rate de todas las Películas.*/

select sum(sakila.film.rental_rate)
from sakila.film;

/*23. Película con mayor duración.*/

select *
from sakila.film
where sakila.film.length = (
	select max(sakila.film.length)
	from sakila.film);

/*24. Película con menor duración.*/

select *
from sakila.film
where sakila.film.length = (
	select min(sakila.film.length)
	from sakila.film);

/*25. Mostrar las ciudades del country Spain.*/

SELECT *
FROM sakila.city
where sakila.city.country_id = (
	select sakila.country.country_id
	from sakila.country
	where sakila.country.country = 'Spain');
    
select sakila.city.city, sakila.country.country
from sakila.city
	inner join sakila.country on sakila.city.country_id = sakila.country.country_id
where sakila.country.country = 'Spain';

/*26. Mostrar el nombre de la película y el nombre de los actores.*/

select 
	concat(sakila.actor.first_name," ",sakila.actor.last_name) as NombreActor,
    sakila.film.title
from sakila.film
	inner join sakila.film_actor on sakila.film.film_id = sakila.film_actor.film_id
    inner join sakila.actor on sakila.film_actor.actor_id = sakila.actor.actor_id;

/*27. Mostrar el nombre de la película y el de sus categorías. !!!!!!!!!!!*/

select 
    sakila.film.title,
	sakila.category.name
from sakila.film
	inner join sakila.film_category on sakila.film.film_id = sakila.film_category.film_id
    inner join sakila.category on sakila.film_category.category_id = sakila.category.category_id;
	
/*28. Mostrar el country, la ciudad y dirección de cada miembro del staff.*/

select
	concat(sakila.staff.first_name," ",sakila.staff.last_name) as NombreStaff,
    sakila.address.address as Dirección,
    sakila.city.city as Ciudad,
	sakila.country.country as Pais
from sakila.staff
	inner join sakila.address
		on sakila.staff.address_id = sakila.address.address_id
    inner join sakila.city
		on sakila.address.city_id = sakila.city.city_id
    inner join sakila.country
		on sakila.city.country_id = sakila.country.country_id;
        
select
	concat(sakila.staff.first_name," ",sakila.staff.last_name) as NombreStaff,
    sakila.address.address as Dirección,
    sakila.city.city as Ciudad,
	sakila.country.country as Pais
from sakila.staff
	inner join sakila.address
		using(address_id)
    inner join sakila.city
		using(city_id)
    inner join sakila.country
		using(country_id);