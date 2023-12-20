-- WHAT WERE THE TOP MOST 10 SHOWS BASED ON IMDB SCORE --
select title,type, 
imdb_score
FROM netflixtable
WHERE imdb_score >= 8.0
AND type = 'show'
ORDER BY imdb_score DESC
LIMIT 10;

-- WHAT WERE THE TOP MOST 10 MOVIES BASED ON IMDB SCORE --
select title,type, 
imdb_score
FROM netflixtable
WHERE imdb_score >= 8.0
AND type = 'movie'
ORDER BY imdb_score DESC
LIMIT 10;

-- WHAT WERE THE BOTTOM 10 MOVIES BASED ON IMDB SCORE --
SELECT title, 
type, 
imdb_score
FROM netflixtable
WHERE imdb_score <= 5 and type = 'MOVIE'
ORDER BY imdb_score ASC
limit 10;

-- WHAT WERE THE BOTTOM 10 SHOWS BASED ON IMDB SCORE --
SELECT title, 
type, 
imdb_score
FROM netflixtable
WHERE imdb_score <= 5 and type = 'show'
ORDER BY imdb_score ASC
limit 10;

-- WHICH SHOWS ON NETFLIX HAVE THE MOST SEASONS --
select title, sum(seasons) as Total_seasons from netflixtable
where type = 'show'
group by title
order by Total_seasons desc
limit 10;

-- CALCULATING THE AVERAGE RUNTIME OF MOVIES AND SHOWS SEPERATELY --
select
'Movies' as content_type,
round(avg(runtime),2) as avg_runtime_min
from netflixtable
where type = 'Movie'
union all
select
'Show' as content_type,
round(avg(runtime),2) as avg_runtime_min
from netflixtable
where type = 'Show';

-- TOP 10 MOST COMMON PRODUCTION COUNTRIES --
select production_countries, count(*) as most_production_countries
from netflixtable
group by production_countries
order by most_production_countries desc
limit 10;

-- TOP 10 MOVIES WITH HIGHEST TMDB POPULARITY --
select title , tmdb_popularity
from netflixtable
where type = 'movie'
order by tmdb_popularity desc
limit 10;

-- TOP 10 MOVIES WITH HIGHEST IMDB SCORE IN DRAMA GENRE
select title , imdb_score
from netflixtable
where type = 'movie' and genres like '%drama%'
order by imdb_score desc
limit 10;

-- WHICH GENRE HAS THE MOST MOVIES --
select genres, count(*) as total_count
from netflixtable
where type = 'movie'
group by genres
order by total_count desc
limit 10;

-- WHICH GENRE HAS THE MOST TV SHOWS --
select genres, count(*) as total_count
from netflixtable
where type = 'show'
group by genres
order by total_count desc
limit 10;

-- WHICH GENRE HAS THE MOST MOVIES OR TV SHOWS --
select genres, count(*) as total_count
from netflixtable
where type = 'movie' or type = 'show'
group by genres
order by total_count desc
limit 3;

-- HOW MANY MOVIES AND SHOWS FALL IN EACH DECADE IN NETFLIX'S LIBRARY --
SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
	COUNT(*) AS movies_shows_count
FROM netflixtable
WHERE release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;

-- WHAT WERE THE AVERAGE IMDB AND TMDB SCORES FOR EACH AGE CERTIFICATIONS FOR MOVIES --
select distinct age_certification,
round(avg(imdb_score),2) as avg_imdb_score,
round(avg(tmdb_score),2) as avg_tmdb_score
from netflixtable
group by age_certification
order by avg_imdb_score desc;
  
-- AVERAGE IMDB SCORE FOR LEADING ACTOR/ACTRESSS IN MOVIES OR SHOWS --     
SELECT c.name AS actor_actress, 
ROUND(AVG(n.imdb_score), 2) AS average_imdb_score
FROM credits AS c
JOIN netflixtable AS n ON c.id = n.id
WHERE c.role like '%actor%' OR c.role like '%actress%'
      AND c.character like '%leading role%'
GROUP BY c.name
ORDER BY average_imdb_score DESC;

-- WHICH ACTORS/ACTRESSES PLAYED THE SAME CHARACTER IN MULTIPLE MOVIES OR TV SHOWS --
select c.name as actor_actress, c.character,
count(distinct n.title) as num_titles from netflixtable as n
join credits as c on c.id = n.id
where c.role like '%actor%' or c.role like'%actress%'
group by c.name , c.character
having count(distinct n.title) >1 ;

-- ACTORS WHO HAVE STARRED IN THE MOST HIGHLY RATED MOVIES OR SHOWS --
select c.name as actor_actress , 
count(*) as num_highly_rated_movies 
from netflixtable as n 
join credits as c on c.id = n.id
where c.role like '%actor%'
and n.title like '%movie%' or n.title like '%show%'
and n.imdb_score like '__5'
and n.tmdb_score like '8_'
group by c.name
order by num_highly_rated_movies desc;

-- WHO WERE THE TOP 20 ACTORS THAT APPEARED THE MOST IN MOVIES/SHOWS --
select distinct name as actor,
count(*) as num_of_appearences
from credits
where role like '%actor%'
group by name 
order by num_of_appearences desc
limit 20;

-- WHO WERE THE TOP 20 DIRECTORS THAT DIRECTED THE MOST MOVIES/SHOWS --
select distinct name as actor,
count(*) as num_of_appearences
from credits
where role like '%director%'
group by name 
order by num_of_appearences desc
limit 20;

-- FINDING THE TITLES AND DIRECTORS OF MOVIES RELEASED ON OR AFTER 2010
select distinct n.title , n.release_year , c.name
from netflixtable as n
join credits as c on n.id = c.id
where n.title like '%movie%'
and n.release_year like '201_'
and c.role like '%director%'
order by n.release_year desc;






     
     































