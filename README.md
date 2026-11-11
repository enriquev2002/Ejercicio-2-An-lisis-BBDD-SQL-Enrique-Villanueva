# Ejercicio-2-An-lisis-BBDD-SQL-Enrique-Villanueva
Ejercicio 2: " Lógica. Consultas de SQL" para el curso de Data Analysht de "ThePower"
PROYECTO SQL-ENRIQUE VILLANUEVA VIAMONTE

PASOS DEL PROYECTO 
Para empezar lo que hacemos es acceder a la base de datos, a través del archivo SQL descargado, abriéndola con el programa DBeaver 26.2.0 conectándonos, en localhost, con Postgres.

Lo siguiente que hacemos, para entender bien de que se trata la base de datos, es generar el esquema en forma de diagrama y así conocer las tablas que la componen y su relación entre ellas. Siguiendo las indicaciones del trabajo también lo exportamos en archivo png. Además junto a lo anterior hacemos una exploración de los datos para ver si existe algún nulo, blanco o error.

Se genera un archivo SQL, donde haremos las consultas y las guardaremos, separando entre estas con el ";". Tras esto comienzo a generar las consultas, para explicarlo de una manera más ordenada las voy a resumir por bloques
	-Bloque de filtros y ordenación: los enunciados 2, 3, 5, 6, 8, 12, 14, 16, 18, 35, 36, 39 y 40 han consistido en esto usando técnicas como WHERE, BETWEEN, LIKE, IN, DISTINCT, LIMIT y "alias".
	-Bloque de agregaciones y cálculos: El siguiente bloque compuesto por los enunciados 7, 9, 10, 13, 15, 21, 23, 25, 26, 37, 38 y 41 han consistido en agregaciones, que para tal efecto he usado técnicas tales como COUNT, SUM, AVG, MIN/MAX, VARIANCE, STDDEV, GROUP BY y HAVING.
	-Bloque de subconsultas: el tercer bloque ha consistido en las consultas 11, 24, 27, 28, 46, 55, 56 y 59, usando para esto Subconsultas escalares, EXISTS/NOT EXISTS y OFFSET.
	Bloque sobre Join: Este es el más numeroso con los enunciados 17, 19, 20, 22, 29 al 34, 42, 43, 45, 47, 49, 50, 53, 54, 57, 58, 60 al 62 y 64, para estos he usado tablas encadenadas, INNER JOIN y LEFT JOIN.
	-Bloque sobre productos cartesianos: Usado solo para la 44 y 63 con el CROSS JOIN.
	-Y por último el bloque de creación y modificación de la BBDD: solo en las consultas que solo así lo indicaban, siendo estas la 48, 51 y 52 con los recursos CREATE VIEW y CREATE TEMPORARY TABLE AS.

ANÁLISIS DE LA BBDD

-En el catálogo cargado en esta base de datos la empresa tiene 1.000 películas con 200 actores, todos participan en al menos una película y varios trabajan en varias, repartidas en 16 categorías.
-Las clasificaciones están más o menos equilibradas: PG-13 (223), NC-17 (210), R (195), PG (194) y G (178). Cosa que sugiere que es accesible a todos los públicos. En cuanto a duración lás mas extensas, de media, son las de clasificación PG-13 y la de G la de menor.
-La duración tiene un intervalo de 46 a 185 minutos, con una media de 115,27 min; 489 películas superan esa media y 39 duran más de 180 min.
-Las categorías con mayor duración media son Sports (128,2 min), Games (127,8) y Foreign (121,7). Son 13 las categorías con media por encima de 110 min.
-Solo 2 actores superan las 40 películas, Gina Degeneres con 42 (ID 107) y Walter Torn (ID 102) con 41. Los nombres más repetidos entre los actores son Julia, Kenneth y Penélope, repitiéndose 4 veces cada uno. En la base de datos se encuentra que hay 3 películas en las que no figuran actores en el reparto, Drumline Cyclone, Flight Lies y Slacker Liaisons. Conviene revisarlo para subsanar ese posible problema.
-La empresa ha generado 67.416,51 en 16.049 operaciones, el pago medio es 4,20 y con una desviación de 2,36. Los datos de alquiler van de mayo de 2005 a febrero de 2006 en julio y agosto de 2005 concentran la mayor parte del negocio (6.709 y 5.686 alquileres), siendo el día más activo el 31 de julio, sería conveniente si en esa fecha se hizo algún tipo de campaña o cambio para repetirlo debido a su notorio exito. Febrero de 2006 solo tiene 182 porque los datos terminan el día 14.
-Un alquiler dura de media 5,03 días en los ya devueltos, y 183 alquileres siguen sin devolverse. Las categorías más alquiladas son Sports (1.179), Animation (1.166) y Action (1.112); las menos, Music (830) y Travel (837). Datos a tener en cuenta para conocer las demandas de los clientes para valorar la compra de futuros títulos. 876 películas se han alquilado alguna vez durante más de 8 días y 792 se han alquilado al menos 10 veces.
-En cuanto a las películas disponibles se puede apreciar que 42 títulos no tienen ejemplares en el inventario, a valorar por la empresa para determinar si se han perdido, no se han devuelto o se han retirado de stock.
-En cuanto a los clientes podemos determinar que tienen una clientela bastante afianzada, debido a que de los 599 clientes, todos han alquilado entre 12 y 46 películas, han visto al menos 7 películas distintas. Los 5 clientes que más han gastado son Karl Seal (221,55), Eleanor Hunt (216,54), Clara Shaw (195,58), y Rhonda Kennedy y Marion Snyder (194,61 cada una).

- En conclusión estos datos nos arrojan que dicha empresa tienen muy buen catálogo disponible que a sus clientes al parecer les gustan, prestando atención a aquellas películas no devueltas o roturas de stock, se nota que es un negocio que funciona con la sugerencia de estudiar que sucedió en los meses de más actividad para ver si se puede repetir la estrategia o fue fruto del azar, aunque al ser meses de verano es raro que la gente suela ver películas en casa.
