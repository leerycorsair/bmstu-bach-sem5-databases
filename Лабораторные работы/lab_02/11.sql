-- Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT

-- Создать и поместить во временную таблицу id команды и количество спонсоров у нее
create temp table CompTeams as
select companies_teams.team_id, count (*) from companies_teams group by companies_teams.team_id;

-- Получить из временной таблицы все записи
select * from CompTeams order by team_id;