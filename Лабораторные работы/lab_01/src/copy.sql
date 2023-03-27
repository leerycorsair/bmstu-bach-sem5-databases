copy players(nickname, realname, birthdate, country, mmr, role, signature_hero)
    from 'C:/gencsv/players.csv'
    NULL as ''
    csv;

copy teams(name, created_at, email, total_earnings, region, tier)
    from 'C:/gencsv/teams.csv'
    NULL as ''
    csv;

copy tournaments(name, tier, prize_pool, date_start, duration, dpc_points, location)
    from 'C:/gencsv/tournaments.csv'
    NULL as ''
    csv;

copy companies(name, country, website, revenue, industry)
    from 'C:/gencsv/companies.csv'
    NULL as ''
    csv;

copy teams_players(team_id, player_id, contract_date, contract_time)
    from 'C:/gencsv/teams_players.csv'
    NULL as ''
    csv;

copy companies_tournaments(company_id, tournament_id, deposit)
    from 'C:/gencsv/companies_tournaments.csv'
    NULL as ''
    csv;

copy companies_teams(company_id, team_id, contract_date, contract_time)
    from 'C:/gencsv/companies_teams.csv'
    NULL as ''
    csv;

copy tournaments_teams(tournament_id, team_id, participation_type, is_winner)
    from 'C:/gencsv/tournaments_teams.csv'
    NULL as ''
    csv;

