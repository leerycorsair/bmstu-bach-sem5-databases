-- Инструкция SELECT, использующая предикат сравнения

-- Получить из таблицы игроков никнеймы, рейтинг и роли игроков, рейтинг которых выше 9950  
select players.nickname, players.mmr, players.role 
from players where mmr > 9950 order by players.mmr;