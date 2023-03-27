-- Инструкция SELECT, использующая предикат сравнения с квантором

-- Получить из таблицы игроков список игроков, рейтинг которых выше чем у всех игроков из Китая и которые играют на керри
select * from players where players.mmr > all
(select players.mmr from players where players.country = 'China')
and players.role = 'Carry';