-- Однострочная инструкция INSERT, выполняющая вставку в таблицу одной строки значений

-- Добавление в таблицу игроков новой записи 
insert into players (nickname, realname, birthdate, country, mmr, role, signature_hero)
values ('vlados', 'Vladislav Leonov', cast('2002-03-21' as date), 'Russia', 9999, 'Carry', 'Slark');