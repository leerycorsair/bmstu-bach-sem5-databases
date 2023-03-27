\c postgres;
DROP database if exists bmstu;
CREATE database bmstu;
\c bmstu;

CREATE TABLE "players" (
  "id" SERIAL,
  "nickname" varchar,
  "realname" varchar,
  "birthdate" date,
  "country" varchar,
  "mmr" int,
  "role" varchar,
  "signature_hero" varchar
);

CREATE TABLE "teams" (
  "id" SERIAL,
  "name" varchar,
  "created_at" date,
  "email" varchar,
  "total_earnings" int,
  "region" varchar,
  "tier" int
);

CREATE TABLE "tournaments" (
  "id" SERIAL,
  "name" varchar,
  "tier" int,
  "prize_pool" int,
  "date_start" date,
  "duration" int,
  "dpc_points" int,
  "location" varchar
);

CREATE TABLE "companies" (
  "id" SERIAL,
  "name" varchar,
  "country" varchar,
  "website" varchar,
  "revenue" int,
  "industry" varchar
);

CREATE TABLE "teams_players" (
  "id" SERIAL,
  "team_id" int,
  "player_id" int,
  "contract_date" date,
  "contract_time" int
);

CREATE TABLE "companies_tournaments" (
  "id" SERIAL,
  "company_id" int,
  "tournament_id" int,
  "deposit" int
);

CREATE TABLE "companies_teams" (
  "id" SERIAL,
  "company_id" int,
  "team_id" int,
  "contract_date" date,
  "contract_time" int
);

CREATE TABLE "tournaments_teams" (
  "id" SERIAL,
  "tournament_id" int,
  "team_id" int,
  "participation_type" varchar,
  "is_winner" boolean
);
