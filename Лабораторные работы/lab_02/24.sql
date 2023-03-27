-- Оконные функции. Использование конструкций MIN/MAX/AVG OVER()

-- Получить из таблицы турниров название, кол-во DPC поинтов, место проведения турнира и среднее значение призового фонда за данный год
select tournaments.name, tournaments.dpc_points, tournaments.location, 
    avg(tournaments.prize_pool) over (partition by date_part('year', tournaments.date_start)) as avg_prize_by_year
    from tournaments;