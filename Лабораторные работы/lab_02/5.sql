-- Инструкция SELECT, использующая предикат EXISTS с вложенным подзапросом 

-- Получить из таблицы турниров те, у которых есть спонсоры и среди них есть такие, которые сделали депозит более 990000$
select * from tournaments where exists (
    select companies_tournaments.id from companies_tournaments where tournaments.id = companies_tournaments.tournament_id and 
    companies_tournaments.deposit > 990000
) order by id;

