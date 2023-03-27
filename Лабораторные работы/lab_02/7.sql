-- Инструкция SELECT, использующая агрегатные функции в выражениях столбцов

-- Получить из таблицы команд среднее значение полного заработка тир-1 команд, которые из Европы  
select avg(teams.total_earnings) from teams where teams.region = 'Europe' and teams.tier = 1;