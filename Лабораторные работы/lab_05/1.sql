-- Из таблиц базы данных, созданной в первой лабораторной работе, извлечь
-- данные в XML (MSSQL) или JSON(Oracle, Postgres). Для выгрузки в XML
-- проверить все режимы конструкции FOR XML.

\copy (select to_json(tournaments) from tournaments) to 'C:/jsondata/tournaments.json';

\copy (select to_json(tournaments_teams) from tournaments_teams) to 'C:/jsondata/tournaments_teams.json';

\copy (select to_json(companies_tournaments) from companies_tournaments) to 'C:/jsondata/companies_tournaments.json';

\copy (select to_json(teams) from teams) to 'C:/jsondata/teams.json';

\copy (select to_json(companies) from companies) to 'C:/jsondata/companies.json';

\copy (select to_json(teams_players) from teams_players) to 'C:/jsondata/teams_players.json';

\copy (select to_json(companies_teams) from companies_teams) to 'C:/jsondata/companies_teams.json';

\copy (select to_json(players) from players) to 'C:/jsondata/players.json';
