-- Инструкция SELECT, использующая поисковое выражение CASE

-- Получить из таблицы игроков классификацию игроков по их возрасту
select *, case
    when date_part('year', players.birthdate) < 1995 then 'Too old'
    when date_part('year', players.birthdate) >= 1995 and  date_part('year', players.birthdate) < 2000 then 'Current'
    when date_part('year', players.birthdate) >= 2000 and  date_part('year', players.birthdate) < 2005 then 'Perspective'
    when date_part('year', players.birthdate) >= 2005 then 'Too young'
    end as "Status"
from players;
