-- Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING

-- Получить из таблицы игроков среднее значение MMR для каждой из стран
select players.country, avg(players.mmr) as "Average MMR" from players group by players.country;

