-- Найти игрока у которого роль "Support", и команда которого имеет самый большой заработок за все время
select * from players p 
join teams_players tp on p.id = tp.player_id where tp.team_id = 
    (select id from teams order by total_earnings desc limit 1) 
    and p.role = 'Support';