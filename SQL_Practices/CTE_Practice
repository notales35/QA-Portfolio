-- =========================================================
-- РЕКУРСИВНЫЕ ОБЩИЕ ТАБЛИЧНЫЕ ВЫРАЖЕНИЯ (RECURSIVE CTE)
-- =========================================================

-- ЗАДАЧА: Сгенерировать список всех дат за июль 2005 года.
-- QA КЕЙС: Используется для создания тестового календаря или поиска "пропусков" в данных (например, когда в отчете за месяц не хватает записей за конкретные дни).

WITH RECURSIVE dates AS (
  SELECT CAST('2005-07-01' AS DATE) AS date  -- Точка старта (якорная часть)
  UNION ALL
  SELECT date + INTERVAL 1 DAY              -- Рекурсивный шаг (добавляем по одному дню)
  FROM dates
  WHERE date < '2005-07-31'                 -- Условие остановки
)
SELECT * FROM dates;

-- ЗАДАЧА: Подсчитать количество выходных (сб и вс) в июле 2005 года.
-- QA КЕЙС: Проверка бизнес-логики, связанной с рабочими графиками (например, расчет срока доставки или начисление пенни только по рабочим дням).

WITH RECURSIVE dates AS (
  SELECT CAST('2005-07-01' AS DATE) AS date
  UNION ALL
  SELECT date + INTERVAL 1 DAY
  FROM dates
  WHERE date < '2005-07-31'
)
SELECT COUNT(*) AS weekend_days
FROM dates
WHERE DAYOFWEEK(date) IN (1, 7); 

-- =========================================================
-- ВЫЧИСЛЕНИЕ ФАКТОРИАЛА (МАТЕМАТИЧЕСКАЯ РЕКУРСИЯ)
-- =========================================================

-- ЗАДАЧА: Сгенерировать таблицу факториалов для чисел от 0 до 10.
-- QA КЕЙС: Проверка вычислительных мощностей БД и корректности обработки больших чисел (BigInt).

WITH RECURSIVE factorials AS (
  SELECT 0 AS n, 1 AS f
  UNION ALL
  SELECT n + 1, f * (n + 1)
  FROM factorials
  WHERE n < 10
)
SELECT n, f FROM factorials;

-- =========================================================
-- КУМУЛЯТИВНЫЙ АНАЛИЗ (НАРАСТАЮЩИЙ ИТОГ)
-- =========================================================

-- ЗАДАЧА: Ежедневный анализ платежей за июль 2005 года с расчетом кумулятивной суммы и количества.
-- QA КЕЙС: Проверка корректности финансовых отчетов и графиков динамики продаж. Позволяет выявить расхождения между ежедневными транзакциями и итоговым балансом.

WITH RECURSIVE calendar AS (
    SELECT CAST('2005-07-01' AS DATE) AS dt
    UNION ALL
    SELECT dt + INTERVAL 1 DAY FROM calendar WHERE dt < '2005-07-31'
),
daily_stats AS (
    SELECT 
        CAST(payment_date AS DATE) AS p_date,
        COUNT(*) AS daily_count,
        SUM(amount) AS daily_sum
    FROM payment
    GROUP BY p_date
)
SELECT 
    c.dt AS date,
    SUM(COALESCE(ds.daily_count, 0)) OVER (ORDER BY c.dt) AS payments_rolling_count,
    SUM(COALESCE(ds.daily_sum, 0)) OVER (ORDER BY c.dt) AS payments_rolling_amount
FROM calendar c
LEFT JOIN daily_stats ds ON c.dt = ds.p_date
WHERE c.dt BETWEEN '2005-07-01' AND '2005-07-31'
ORDER BY date;

-- =========================================================
-- РАНЖИРОВАНИЕ С УЧЕТОМ ДУБЛИКАТОВ (DENSE_RANK)
-- =========================================================

-- ЗАДАЧА: Найти клиентов, занимающих первые 3 места по количеству арендованных фильмов.
-- QA КЕЙС: Тестирование списков лидеров (Leaderboards) и корректности работы фильтров "Топ-N". Позволяет проверить, не теряются ли данные при совпадении значений.

WITH customer_counts AS (
    SELECT 
        c.last_name, 
        c.first_name, 
        COUNT(r.rental_id) AS cnt
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
ranked_customers AS (
    SELECT 
        last_name, 
        first_name, 
        cnt,
        DENSE_RANK() OVER (ORDER BY cnt DESC) AS rnk
    FROM customer_counts
)
SELECT last_name, first_name, cnt
FROM ranked_customers
WHERE rnk <= 3
ORDER BY cnt DESC, last_name ASC;

