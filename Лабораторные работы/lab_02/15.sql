-- Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING

-- Получить из таблицы игроков среднее значение MMR для стран, в которых средний рейтинг игроков выше среднего в мире
select players.country, avg(players.mmr) as "Average MMR" from players group by players.country
having avg(players.mmr) > (select avg(players.mmr) from players);