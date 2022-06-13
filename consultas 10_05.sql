/*Titulo pelicula que se alquilan por encima de la media*/

select
	sakila.film.title as Titulo,
    sakila.film.rental_rate as Alquiler
from
	sakila.film
where sakila.film.rental_rate > (
	select
		avg(sakila.film.rental_rate)
	from sakila.film)
order by Alquiler desc;

/*La cantidad de veces que se alquila cada pelicula*/
	/*Siempre que se utilice un count() en select sera necesario group by */

select
	sakila.film.title as Titulo,
    count(sakila.rental.rental_id) as NumRental
from sakila.film
	right join sakila.inventory on sakila.film.film_id = sakila.inventory.film_id
    left join sakila.rental on sakila.inventory.inventory_id = sakila.rental.inventory_id
group by sakila.inventory.film_id;

/*Media de número de veces que se alquilan las peliculas*/
	/*Subconsultas, de una consulta ya planteada se pueden hacer consultas*/

select avg(NumRental) as MediaRental
from (
	select
		sakila.film.title as Titulo,
		count(sakila.rental.rental_id) as NumRental
	from sakila.film
		right join sakila.inventory on sakila.film.film_id = sakila.inventory.film_id
		left join sakila.rental on sakila.inventory.inventory_id = sakila.rental.inventory_id
	group by sakila.inventory.film_id
) as tableNumRental;


/*Peliculas que se han alquilado por encima de la media*/


select
	sakila.film.title as Titulo,
	count(sakila.rental.rental_id) as NumRental
from sakila.film
	right join sakila.inventory on sakila.film.film_id = sakila.inventory.film_id
	left join sakila.rental on sakila.inventory.inventory_id = sakila.rental.inventory_id
group by sakila.inventory.film_id
having NumRental > (
	select avg(NumRental) as MediaRental
	from (
		select
			sakila.film.title as Titulo,
			count(sakila.rental.rental_id) as NumRental
		from sakila.film
			right join sakila.inventory on sakila.film.film_id = sakila.inventory.film_id
			left join sakila.rental on sakila.inventory.inventory_id = sakila.rental.inventory_id
		group by sakila.inventory.film_id
	) as tableNumRental
);                                                                                                                                                                                                                                            

/*Que actores tienen más peliculas que el actor de id=1*/
	/*Uso de SET @NombreDato :=(ConsultaSQL) esta variable solo puede guardar un dato, no tablas enteras*/

select
    count(sakila.film_actor.film_id)
from sakila.actor
	left join sakila.film_actor
		using(actor_id)
where sakila.actor.actor_id = 1
group by sakila.actor.actor_id;

SET @PeliculasActorId1 :=(
select
    count(sakila.film_actor.film_id)
from sakila.actor
	left join sakila.film_actor
		using(actor_id)
where sakila.actor.actor_id = 1
group by sakila.actor.actor_id);

select
	concat(sakila.actor.first_name," ",sakila.actor.last_name) as Actor,
    count(sakila.film_actor.film_id) as NumPeliculas
from sakila.film_actor
	left join sakila.actor using(actor_id)
group by sakila.film_actor.actor_id
having NumPeliculas > @PeliculasActorId1;

/*Actores que trabajan en peliculas con un ratin de R*/

select
	concat(sakila.actor.first_name," ",sakila.actor.last_name) as Actor,
    sakila.film.title as Pelicula,
    sakila.film.rating
from sakila.film
	left join sakila.film_actor using (film_id)
    left join sakila.actor using(actor_id)
where sakila.film.film_id in (
	select
		sakila.film.film_id
	from sakila.film
	where sakila.film.rating = "R");
    
/*Nombre Email de clientes que no hallan alquilado peliculas de rating R*/

select
	concat(sakila.customer.first_name," ",sakila.customer.last_name) as Cliente,
    sakila.customer.email as Correo
from sakila.customer
	left join sakila.rental using(customer_id)
    left join sakila.inventory using (inventory_id)
    right join sakila.film using (film_id)
where sakila.film.film_id not in (
	select
		sakila.film.film_id
	from sakila.film
	where sakila.film.rating = "R");
    
/*Cuantos clientes distintos han alquilado cada pelicula R*/
	/*using() para hacer join de dos tablas con una columna en comun*/

select
	sakila.film.title as Pelicula,
    sakila.film.rating as Pegi,
    count(sakila.customer.customer_id) as NumClientes
from sakila.film
	left join sakila.inventory using(film_id)
    left join sakila.rental using(inventory_id)
    left join sakila.customer using(customer_id)
where sakila.film.rating = "R"
group by sakila.film.film_id;

/*Cuantas peliculas ha alquilado cada cliente*/

select
	concat(sakila.customer.first_name," ",sakila.customer.last_name) as Cliente,
    count(sakila.film.film_id) as NumPelis
from sakila.customer
	left join sakila.rental using(customer_id)
    left join sakila.inventory using (inventory_id)
    right join sakila.film using (film_id)
group by sakila.customer.customer_id;

/*Cuantas peliculas de cada categoria ha alquilado cada cliente*/

select
	concat(sakila.customer.first_name," ",sakila.customer.last_name) as Cliente,
    sakila.category.name as Categoria,
    count(sakila.film.film_id) as NumPelis
from sakila.customer
	left join sakila.rental using(customer_id)
    left join sakila.inventory using (inventory_id)
    left join sakila.film using (film_id)
    left join sakila.film_category using (film_id)
    left join sakila.category using (category_id)
group by sakila.category.category_id;

/*Cuantos clientes solo alquilan peliculas R*/

select
	count(sakila.customer.customer_id) as NumClient
from sakila.customer
	left join sakila.rental using(customer_id)
    left join sakila.inventory using (inventory_id)
    left join sakila.film using (film_id);