-------------------------------------------------------------------------------
-- Триггер AFTER
-- Получить оценку скилла игрока при добавлении
create or replace function get_player_skill()
returns trigger
as $$
begin 
    if new.mmr > 9000 then 
        raise notice '% is a pro-player', new.nickname;
    end if;
    if new.mmr > 6000 and new.mmr < 9000 then
        raise notice '% is a good player', new.nickname;
    end if;
    if new.mmr > 2000 and new.mmr < 6000 then
        raise notice '% is an average player', new.nickname;
    end if;
    if new.mmr < 2000 then
        raise notice '% is a bad player', new.nickname;
    end if;
    return new;
end;
$$ language plpgsql;

create or replace trigger player_analisys after insert on players
for row execute procedure get_player_skill();

insert into players (nickname, realname, birthdate, country, mmr, role, signature_hero)
values ('rofler228', 'Petr Lomov', now(), 'Russia', 1, 'Carry', 'Pudge');

delete from players where nickname = 'rofler228';
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Триггер INSTEAD OF
-- Вставка информации об игроке, только если он имеет рейтинг выше 6000
create or replace function get_player_skill()
returns trigger
as $$
begin 
    if new.mmr > 9000 then 
        raise notice '% is a pro-player', new.nickname;
    end if;
    if new.mmr > 6000 and new.mmr < 9000 then
        raise notice '% is a good player', new.nickname;
    else 
        raise notice '% is a trash player', new.nickname;
        return null;
    end if;
    return new;
end;
$$ language plpgsql;

create view players_view as 
select * from players;

create or replace trigger player_analisys instead of insert on players_view
for row execute procedure get_player_skill();

insert into players (nickname, realname, birthdate, country, mmr, role, signature_hero)
values ('rofler228', 'Petr Lomov', now(), 'Russia', 1, 'Carry', 'Pudge');

delete from players where nickname = 'rofler228';

insert into players (nickname, realname, birthdate, country, mmr, role, signature_hero)
values ('Arthas', 'Vitaliy Tsal', '1990-11-19', 'Ukraine', 9999, 'Carry', 'Wraith King');

delete from players where nickname = 'Arthas';
-------------------------------------------------------------------------------