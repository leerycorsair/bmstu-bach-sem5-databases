-- Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов

-- Получить из таблицы команд среднее значение полного заработка команд для каждого из регионов  
select
    (select avg(teams.total_earnings) 
    from teams 
    where teams.region = 'Europe') as "Europe AVG",

    (select avg(teams.total_earnings) 
    from teams 
    where teams.region = 'SE Asia') as "SE Asia AVG",

    (select avg(teams.total_earnings) 
    from teams 
    where teams.region = 'South Africa') as "South Africa AVG",

    (select avg(teams.total_earnings) 
    from teams 
    where teams.region = 'South America') as "South America AVG",

    (select avg(teams.total_earnings) 
    from teams 
    where teams.region = 'CIS') as "CIS AVG",

    (select avg(teams.total_earnings) 
    from teams 
    where teams.region = 'North America') as "North America AVG",

    (select avg(teams.total_earnings)
    from teams 
    where teams.region = 'Australia') as "Australia AVG",

    (select avg(teams.total_earnings)
    from teams 
    where teams.region = 'China') as "China AVG";

