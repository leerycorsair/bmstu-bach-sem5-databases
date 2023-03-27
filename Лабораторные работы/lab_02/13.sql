-- Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3


-- Получить список компаний, которые спонсируют команды, в которых есть игроки из Китая
select count(*) from companies where companies.id in 
(select companies_teams.company_id from companies_teams where companies_teams.team_id in 
    (select distinct teams_players.team_id from teams_players where teams_players.player_id in 
        (select players.id from players where players.country = 'China')));