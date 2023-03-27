-- Оконные фнкции для устранения дублей

-- Получить из таблицы турниров место проведения, год, и средний призовой фонд
select Loc, Yearr, AvgPrize from (
        select tournaments.location as Loc, 
            date_part('year', tournaments.date_start) as Yearr,
            avg(tournaments.prize_pool) over (partition by date_part('year', tournaments.date_start)) as AvgPrize,
            row_number() over (partition by tournaments.location, date_part('year', tournaments.date_start)) as n
        from tournaments order by tournaments.location
) as Tmp where n = 1;