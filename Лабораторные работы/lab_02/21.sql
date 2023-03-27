-- Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE

-- Удаление из таблицы игроков тех игроков, средний рейтинг которых ниже среднего
delete from players where players.id in (
    select players.id from players where players.mmr <
        (select avg(players.mmr) from players));