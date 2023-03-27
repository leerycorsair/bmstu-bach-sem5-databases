-- Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM

-- Получить минимальное значение депозита среди 10 самых крупных спонсоров турниров 
select min(deposit) from (
    select tournament_id, company_id, deposit from companies_tournaments order by deposit desc limit 10
) as top10_sponsors;