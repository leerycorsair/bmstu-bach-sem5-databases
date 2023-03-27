-- Инструкция SELECT, использующая предикат IN с вложенным подзапросом

-- Получить из таблицы команд команды из Азии, которые выигрывали турниры
select * from teams 
where teams.id in
    (select tournaments_teams.team_id 
    from tournaments_teams 
    where tournaments_teams.is_winner = True)
and teams.region like '%Asia%';