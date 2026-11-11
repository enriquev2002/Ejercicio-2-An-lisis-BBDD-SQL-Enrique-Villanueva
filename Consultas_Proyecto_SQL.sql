--2. Muestra los nombres de todas las películas con una clasificación por edades de 'R'.--
SELECT title AS pelicula
FROM film
WHERE rating = 'R'
ORDER BY title;

--3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40.--
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40
ORDER BY actor_id;

--4. Obtén las películas cuyo idioma coincide con el idioma original.--
SELECT film_id, title, language_id, original_language_id
FROM film
WHERE language_id = original_language_id;

--5. Ordena las películas por duración de forma ascendente.--
SELECT film_id, title, length AS duracion_min
FROM film
ORDER BY length ASC;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.--
SELECT first_name, last_name
FROM actor
WHERE UPPER(last_name) LIKE '%ALLEN%'
ORDER BY last_name, first_name;

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.--
SELECT rating AS clasificacion, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
ORDER BY total_peliculas DESC;

--8.Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.--
SELECT title, rating, length AS duracion_min
FROM film
WHERE rating = 'PG-13' OR length > 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.--
SELECT
    ROUND(VARIANCE(replacement_cost), 4) AS varianza_coste_reemplazo,
    ROUND(STDDEV(replacement_cost), 4)   AS desviacion_tipica_coste_reemplazo
FROM film;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.--
SELECT MAX(length) AS mayor_duracion_min, MIN(length) AS menor_duracion_min
FROM film;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.--
SELECT r.rental_id, r.rental_date, SUM(p.amount) AS coste_alquiler
FROM rental r
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY r.rental_id, r.rental_date
ORDER BY r.rental_date DESC, r.rental_id DESC
OFFSET 2 LIMIT 1;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación
SELECT title, rating
FROM film
WHERE rating NOT IN ('NC-17', 'G')
ORDER BY title;

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.--
SELECT rating AS clasificacion, ROUND(AVG(length), 2) AS promedio_duracion_min
FROM film
GROUP BY rating
ORDER BY promedio_duracion_min DESC;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.--
SELECT title, length AS duracion_min
FROM film
WHERE length > 180
ORDER BY length DESC, title;

--15. ¿Cuánto dinero ha generado en total la empresa?--
SELECT SUM(amount) AS ingresos_totales
FROM payment;

--16. Muestra los 10 clientes con mayor valor de id.--
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’--
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE UPPER(f.title) = UPPER('Egg Igby')
ORDER BY a.last_name, a.first_name;

--18. Selecciona todos los nombres de las películas únicos.--
SELECT DISTINCT title
FROM film
ORDER BY title;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.--
SELECT f.title, f.length AS duracion_min
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Comedy' AND f.length > 180
ORDER BY f.title;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.--
SELECT c.name AS categoria, ROUND(AVG(f.length), 2) AS promedio_duracion_min
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
HAVING AVG(f.length) > 110
ORDER BY promedio_duracion_min ASC;

--21. ¿Cuál es la media de duración del alquiler de las películas?--
select
	AVG(return_date - rental_date)AS duracion_media_alquiler,
	ROUND(AVG(EXTRACT(EPOCH FROM (return_date - rental_date)) / 86400)::numeric, 2) AS duracion_media_dias
FROM rental
WHERE return_date IS NOT NULL;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices--
SELECT actor_id, CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM actor
ORDER BY actor_id;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.--
SELECT rental_date::date AS dia, COUNT(*) AS num_alquileres
FROM rental
GROUP BY rental_date::date
ORDER BY num_alquileres DESC, dia;

--24. Encuentra las películas con una duración superior al promedio.--
SELECT title, length AS duracion_min
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length ASC, title;

--25. Averigua el número de alquileres registrados por mes.--
SELECT TO_CHAR(rental_date, 'MM-YYYY') AS mes, COUNT(*) AS num_alquileres
FROM rental
GROUP BY TO_CHAR(rental_date,'MM-YYYY')
ORDER BY mes;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado--
SELECT
    ROUND(AVG(amount), 4)      AS promedio_pagado,
    ROUND(STDDEV(amount), 4)   AS desviacion_estandar,
    ROUND(VARIANCE(amount), 4) AS varianza
FROM payment;

--27. ¿Qué películas se alquilan por encima del precio medio?--
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate ASC, title;

--28. Muestra el id de los actores que hayan participado en más de 40 películas.--
SELECT actor_id, COUNT(*) AS num_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(*) > 40
ORDER BY num_peliculas DESC, actor_id;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.--
SELECT
    f.film_id, f.title,
    COUNT(i.inventory_id) AS copias_inventario,
    COUNT(i.inventory_id) FILTER (WHERE r.rental_id IS NULL) AS copias_disponibles
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r    ON r.inventory_id = i.inventory_id AND r.return_date IS NULL
GROUP BY f.film_id, f.title
ORDER BY f.title;

--30. Obtener los actores y el número de películas en las que ha actuado.--
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY num_peliculas DESC, a.last_name, a.first_name;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.--
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON fa.film_id = f.film_id
LEFT JOIN actor a       ON a.actor_id = fa.actor_id
ORDER BY f.title, a.last_name, a.first_name;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.--
SELECT a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id
ORDER BY a.last_name, a.first_name, f.title;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.--
SELECT f.film_id, f.title, i.inventory_id, r.rental_id, r.rental_date, r.return_date, r.customer_id
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
ORDER BY f.title, r.rental_date;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.--
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gastado DESC
LIMIT 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.--
SELECT actor_id, first_name, last_name
FROM actor
WHERE UPPER(first_name) = UPPER('Johnny')
ORDER BY last_name;

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.--
SELECT first_name AS "Nombre", last_name AS "Apellido"
FROM actor;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor--
SELECT MIN(actor_id) AS id_actor_mas_bajo, MAX(actor_id) AS id_actor_mas_alto
FROM actor;

--38. Cuenta cuántos actores hay en la tabla “actor”.--
SELECT COUNT(*) AS total_actores
FROM actor;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente--
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY first_name ASC;

--40.  Selecciona las primeras 5 películas de la tabla “film”.--
SELECT film_id, title
FROM film
ORDER BY film_id
LIMIT 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?--
SELECT first_name AS nombre, COUNT(*) AS num_actores
FROM actor
GROUP BY first_name
ORDER BY num_actores DESC, first_name; 
--Respuesta: Hay un empate, siendo los nombres más reptidos hasta en 4 ocasiones: Julia, Kenneth y Penelope--

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.--
SELECT r.rental_id, r.rental_date, c.customer_id, c.first_name, c.last_name
FROM rental r
JOIN customer c ON c.customer_id = r.customer_id
ORDER BY r.rental_date;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres--
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
ORDER BY c.customer_id, r.rental_date;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT f.film_id, f.title, c.category_id, c.name AS categoria
FROM film f
CROSS JOIN category c
ORDER BY f.film_id, c.category_id;
--Respuesta: No aporta ningún valor esta consulta, ya que solo nos lleva a error porque esta devolviendo que una misma película pertenece a muchas categorías, siendo muchas de ellas contradictorias, por ejemplo drama y comedia.--

--45. Encuentra los actores que han participado en películas de la categoría 'Action'--
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action'
ORDER BY a.last_name, a.first_name;

--46. Encuentra todos los actores que no han participado en películas.--
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE NOT EXISTS (SELECT 1 FROM film_actor fa WHERE fa.actor_id = a.actor_id);
--Respuesta: Debido a que en nuestra base de datos todos los actores que aparecen están vinculados a, como mínimo una película, esta consulta me ha devuelto 0 filas--

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.--
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad_peliculas DESC, a.last_name, a.first_name;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.--
CREATE OR REPLACE VIEW actor_num_peliculas AS
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS num_peliculas
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;
-- Comprobacion:--
SELECT * FROM actor_num_peliculas ORDER BY num_peliculas DESC, last_name, first_name;

--49. Calcula el número total de alquileres realizados por cada cliente.--
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alquileres DESC, c.customer_id;

--50. Calcula la duración total de las películas en la categoría 'Action'--
SELECT SUM(f.length) AS duracion_total_min
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.--
DROP TABLE IF EXISTS pg_temp.cliente_rentas_temporal;
CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
-- Prueba--
SELECT * FROM cliente_rentas_temporal ORDER BY total_alquileres DESC, customer_id;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.--
DROP TABLE IF EXISTS pg_temp.peliculas_alquiladas;
CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS veces_alquilada
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r    ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;
--Prueba--
SELECT * FROM peliculas_alquiladas ORDER BY veces_alquilada ASC, title;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.--
SELECT f.title
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
WHERE UPPER(c.first_name) = UPPER('Tammy')
  AND UPPER(c.last_name)  = UPPER('Sanders')
  AND r.return_date IS NULL
ORDER BY f.title;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.--
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name ASC;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.--
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN inventory i ON i.film_id = fa.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
        SELECT MIN(r2.rental_date)
        FROM rental r2
        JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
        JOIN film f2      ON f2.film_id = i2.film_id
        WHERE UPPER(f2.title) = UPPER('Spartacus Cheaper')
      )
ORDER BY a.last_name ASC;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.--
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor fa
    JOIN film_category fc ON fc.film_id = fa.film_id
    JOIN category c       ON c.category_id = fc.category_id
    WHERE fa.actor_id = a.actor_id AND c.name = 'Music'
)

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.--
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.return_date - r.rental_date > INTERVAL '8 days'
ORDER BY f.title ASC;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.--
SELECT f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Animation'
ORDER BY f.title;

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película--
SELECT title, length AS duracion_min
FROM film
WHERE length = (SELECT length FROM film WHERE UPPER(title) = UPPER('Dancing Fever'))
  AND UPPER(title) <> UPPER('Dancing Fever')
ORDER BY title;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.--
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT i.film_id) AS peliculas_distintas
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name ASC;

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.--
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.name
ORDER BY total_alquileres DESC;

--62. Encuentra el número de películas por categoría estrenadas en 2006.--
SELECT c.name AS categoria, COUNT(f.film_id) AS num_peliculas
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
WHERE f.release_year = 2006
GROUP BY c.name
ORDER BY num_peliculas DESC, c.name;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.--
SELECT s.staff_id, s.first_name, s.last_name, st.store_id
FROM staff s
CROSS JOIN store st
ORDER BY s.staff_id, st.store_id;

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.--
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS cantidad_peliculas_alquiladas
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;





 

 



