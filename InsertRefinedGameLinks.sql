INSERT INTO public.daily_games 
(
game_bk
,date_key
,link_url
,calendar_year
,calendar_month
,calendar_day
,double_header_game
,home_team
,away_team
,is_regular
,is_playoff
,is_spring
)

SELECT
sq.game_bk
,CAST(sq.calendar_year AS INT)*10000 
+ CAST(sq.calendar_month AS INT) * 100 
+ CAST(sq.calendar_day AS INT) AS date_key
,sq.link_url
,sq.calendar_year
,sq.calendar_month
,sq.calendar_day
,sq.double_header_game
,sq.home_team
,sq.away_team
,sq.is_regular
,sq.is_playoff
,sq.is_spring
FROM

(SELECT
link_url
,split_part(split_part(link_url, '/', 4), '.', 1) AS game_bk
,calendar_year
,substring(split_part(split_part(link_url, calendar_year, 2),'.',1),1,2) AS calendar_month
,substring(split_part(split_part(link_url, calendar_year, 2),'.',1),3,2) AS calendar_day
,CAST(substring(split_part(split_part(link_url, calendar_year, 2),'.',1),5,1) AS INT) AS double_header_game
,split_part(link_url, '/', 3) AS home_team
,MAX((CASE WHEN team = split_part(link_url, '/', 3) 
	       THEN NULL 
	       ELSE team 
	       END)) AS away_team
,is_regular
,is_playoff
,is_spring
FROM etl.game_links
GROUP BY
link_url
,calendar_year
,split_part(link_url, '/', 3)
,is_regular
,is_playoff
,is_spring)sq
LEFT JOIN public.daily_games dg ON dg.game_bk = sq.game_bk
WHERE dg.game_bk IS NULL