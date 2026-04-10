
-- 1. Расчет средней продолжительности фильма
SELECT AVG(length) AS avg_film_length 
FROM film;
-- 2. Определение границ стоимости проката (Min/Max)
SELECT MIN(replacement_cost) AS minimal_replacement_cost, 
       MAX(replacement_cost) AS maximal_replacement_cost
FROM film;
-- 3.Среднее время аренды фильма
SELECT ROUND(AVG(DATEDIFF(return_date, rental_date))) AS average_rental_time
FROM rental;
-- 4. Найти количество сотрудников 
SELECT 
    D.DEPARTMENT, 
    COUNT(E.EMP_NO) AS EMP_COUNT
FROM 
    DEPARTMENT D
LEFT JOIN 
    EMPLOYEE E ON D.DEPT_NO = E.DEPT_NO
GROUP BY 
    D.DEPARTMENT
ORDER BY 
    2 DESC, 
    1 ASC;
-- 5. Количество фильмов в каждой категории
SELECT 
    c.name AS category, 
    AVG(f.rental_rate) AS average_rental_rate
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_rental_rate DESC;
