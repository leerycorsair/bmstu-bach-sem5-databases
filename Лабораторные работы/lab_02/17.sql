-- Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса

insert into teams_players(team_id, player_id, contract_date, contract_time)
select 1000, players.id, now(), 36 
from players where players.nickname = 'vlados';