-- =========================================================
-- РАБОТА С ПОДЗАПРОСАМИ (SUBQUERIES)
-- =========================================================

-- Задача 1: Поиск адресов и почтовых индексов в конкретном городе (London)
-- Демонстрирует умение связывать таблицы без использования JOIN, через оператор IN
SELECT address, postal_code 
FROM address 
WHERE city_id IN (
    SELECT city_id 
    FROM city 
    WHERE city = 'London'
);
-- =========================================================

Задача 2 : Найти клиентов, которые ни разу не арендовали фильмы с участием EMILY DEE.
-- NOT EXISTS часто эффективнее NOT IN и лучше обрабатывает пустые значения (NULL).
-- Этот кейс демонстрирует умение проверять отсутствие связей между данными.

SELECT c.last_name, c.first_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_actor fa ON i.film_id = fa.film_id
    JOIN actor a ON fa.actor_id = a.actor_id
    WHERE r.customer_id = c.customer_id 
      AND a.first_name = 'EMILY' 
      AND a.last_name = 'DEE'
)
ORDER BY c.last_name ASC;

-- =========================================================

-- Задача 3 : Найти все фильмы с максимально возможной стоимостью замены (replacement_cost).
-- Показывает умение динамически находить эталонное значение (MAX) и фильтровать по нему.

SELECT film_id, title, replacement_cost
FROM film
WHERE replacement_cost = (
    SELECT MAX(replacement_cost) 
    FROM film
)
ORDER BY film_id ASC;
-- =========================================================

-- Задача 4 : Найти фильмы, стоимость проката которых выше средней по всей базе.
-- Демонстрирует использование подзапроса для вычисления динамического порога фильтрации.

SELECT film_id, title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate) 
    FROM film
)
ORDER BY rental_rate DESC;

