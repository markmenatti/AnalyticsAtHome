CREATE TABLE daily_games
(
    game_sk uuid NOT NULL DEFAULT uuid_generate_v1()
	,game_bk varchar(50)
    ,date_key int
    ,link_url varchar(50)
    ,calendar_year varchar(10)
    ,calendar_month varchar(10)
    ,calendar_day varchar(10)
    ,double_header_game int
    ,home_team varchar(10)
    ,away_team varchar(10)
    ,is_regular smallint
    ,is_playoff smallint
    ,is_spring smallint
)
;

ALTER TABLE IF EXISTS daily_games
    OWNER to postgres;