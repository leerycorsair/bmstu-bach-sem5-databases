
from companies import companies_gen
from companies_teams import companies_teams_gen
from companies_tournaments import companies_tournaments_gen
from players import players_gen
from teams import teams_gen
from teams_players import teams_players_gen
from tournaments import tournaments_gen
from tournaments_teams import tournaments_teams_gen


def data_gen():
    players_gen()
    teams_gen()
    tournaments_gen()
    companies_gen()
    teams_players_gen()
    companies_tournaments_gen()
    companies_teams_gen()
    tournaments_teams_gen()


if __name__ == "__main__":
    data_gen()