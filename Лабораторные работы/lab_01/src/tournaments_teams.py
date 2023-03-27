



from dataclasses import dataclass
from gen_config import TEAMS_AMOUNT, TOURNAMENTS_AMOUNT, TOURNAMENTS_TEAMS_FILE
from random import choice, randint
from tools import dataclass_to_csv

@dataclass
class TournamentTeam:
    tournament_id: int
    team_id: int
    participation_type: str
    is_winner: bool


def tournaments_teams_gen():
    file = open("./dataset/"+TOURNAMENTS_TEAMS_FILE, "w")
    for i in range(TOURNAMENTS_AMOUNT):
        teams = [i+1 for i in range(TEAMS_AMOUNT)]
        winner = True
        for j in range(choice([32, 64,128,256])):
            obj = TournamentTeam(tournament_id = i+1,
                                team_id = teams.pop(randint(0, len(teams)-1)),
                                participation_type = choice(["invite", "qualification"]),
                                is_winner=winner)
            winner = False
            file.write(dataclass_to_csv(obj))
    file.close()