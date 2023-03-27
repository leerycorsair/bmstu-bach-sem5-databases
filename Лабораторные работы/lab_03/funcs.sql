-------------------------------------------------------------------------------
-- Скалярная функция 
-- Получить конечную дату, зная продолжительность в месяцах
create or replace function date_finish(date_start date, months int)
returns date as $$
begin 
    return date_start + interval '1 month' * months;
end;
$$ language plpgsql;

-- Получить названия турниров, их начальную и конечную дату проведения
select name, date_start, date_finish(date_start, duration) from tournaments;
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Подставляемая табличная функция
-- Получить игроков по названию страны
create or replace function players_by_country(countryname varchar(50))
returns table(nickname varchar(50), mmr int, role varchar(50)) as $$
declare p record;
begin
    for p in (
        select players.nickname, players.mmr, players.role from players where players.country like '%'||countryname||'%'
    ) loop nickname := p.nickname;
        mmr := p.mmr;
        role := p.role;
        return next;
    end loop;
end;
$$ language plpgsql;

-- Получить игроков из Китая
select * from players_by_country('China');
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Многооператорная табличная функция
-- Получить турниры, по месту проведения и тиру
create or replace function tournaments_by_location_tier(locationname varchar(50), tierrank int)
returns table (name varchar(50), prize_pool int, location varchar(50), tier int) as $$
declare p record;
begin 
    drop table if exists tbl;
    create temp table tbl (name varchar(50), prize_pool int, location varchar(50), tier int);
    insert into tbl (name, prize_pool, location, tier)
    select tournaments.name, tournaments.prize_pool, tournaments.location, tournaments.tier from tournaments
    where tournaments.location like '%'||locationname||'%';
    return query
    select * from tbl where tbl.tier = tierrank;
end;
$$ language plpgsql;

-- Получить турниры 1 тира, в названии города которых есть слово 'New'
select * from tournaments_by_location_tier('New', 1);
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Рекурсивная функция или функция с рекурсивным ОТВ
-- Получить общий призовой фонд турниров
create or replace function prize_pool_sum(start_id int, end_id int)
returns int as $$
declare sm int;
begin 
    if start_id > end_id then return 0;
    end if;
    select prize_pool into sm from tournaments;
    return sm + prize_pool_sum(start_id + 1, end_id);
end;
$$ language plpgsql;

-- Получить общий призовой фонд турниров 1-3
select prize_pool_sum(1,3) as "SUM";
-------------------------------------------------------------------------------