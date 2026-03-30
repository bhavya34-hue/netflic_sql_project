--Netfix Project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix(
     show_id VARCHAR(6),
     type VARCHAR(10),
     title VARCHAR(150),
     director VARCHAR(208),
     castS VARCHAR(1000),	
     country VARCHAR(150),	
     date_added	VARCHAR(50),
     release_year INT,	
     rating	VARCHAR(10),
     duration VARCHAR(15),
     listed_in VARCHAR(100),	
     description VARCHAR(250)
);

SELECT * 
FROM netflix;

SELECT COUNT(*) 
FROM netflix;

SELECT 
DISTINCT type
FROM netflix;

SELECT * 
FROM netflix;


-- Data Cleaning

-- Replace empty strings with NULL
UPDATE netflix
SET director = NULL
WHERE director = '';

UPDATE netflix
SET country = NULL
WHERE country = '';

UPDATE netflix
SET casts = NULL
WHERE casts = '';

-- Convert date_added to proper DATE format
ALTER TABLE netflix
ADD COLUMN date_added_clean DATE;

UPDATE netflix
SET date_added_clean = TO_DATE(date_added, 'Month DD, YYYY');

-- Extract numeric duration
ALTER TABLE netflix
ADD COLUMN duration_int INT;

UPDATE netflix
SET duration_int = SPLIT_PART(duration, ' ', 1)::INT;

-- Trim spaces
UPDATE netflix
SET country = TRIM(country),
    listed_in = TRIM(listed_in),
    director = TRIM(director),
    casts = TRIM(casts);

	
--15 Real based problems

--Q1
--Count the number of Movies vs TV Shows
SELECT 
   type,
   COUNT(*) AS total_content
FROM netflix
GROUP BY type;

--Q2
--Find the most common rating for movies and TV shows
SELECT type, rating
FROM (
    SELECT 
        type,
        rating,
        COUNT(*) AS total,
        RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix
    GROUP BY type, rating
) t
WHERE ranking = 1;

--Q3
--List all movies released in a specific year (e.g., 2020)
select * 
from netflix 
where
type = 'Movie'
and
release_year = 2020;

--Q4
--Find the top 5 countries with the most content on Netflix
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS new_country,
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q5
--Identify the longest movie
SELECT 
    title,
    duration_int
FROM netflix
WHERE type = 'Movie'
ORDER BY duration_int DESC
LIMIT 1;

--Q6
--ind content added in the last 5 years
SELECT *
FROM netflix
WHERE date_added_clean >= CURRENT_DATE - INTERVAL '5 years';

--Q7
--Find all the movies/TV shows by director 'Rajiv Chilaka'!
select *
from netflix
where director ilike '%Rajiv Chilaka%';

--Q8
--List all TV shows with more than 5 seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
AND duration_int > 5;

--Q9
--Count the number of content items in each genre
select 
TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))),
count(show_id) as most_content
from netflix
group by 1;

--Q10
--Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
select 
extract(year from TO_DATE(date_added, 'Month DD, YYYY')) as year, 
count(*),
round(
count(*)::numeric / (select count(*) from netflix where country ilike '%India%')::numeric * 100 )as average
from netflix
where country ilike '%India%'
group by 1;

--Q11
--List all movies that are documentaries
select * 
from netflix
where listed_in like '%Documentaries%';

--Q12 
--Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL OR director = '';

--Q13
--Find how many movies actor 'Salman Khan' appeared in last 10 years!
select *
from netflix
where casts ilike '%Salman Khan%'
and release_year > extract(year from current_date) -10;

--Q14
--Find the top 10 actors who have appeared in the highest number of movies produced in India.
select
TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))),
count(*) as total_content
from netflix
where country ilike '%India%'
group by 1
order by 2 desc
limit 10;

--Q15
--Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;

-- Q16
--Content Growth Over Time
SELECT 
    release_year,
    COUNT(*) AS total_content
FROM netflix
GROUP BY release_year
ORDER BY release_year;

--Q17
--Top Countries Producing Content Each Year
SELECT *
FROM (
    SELECT 
        release_year,
        TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
        COUNT(*) AS total,
        RANK() OVER(PARTITION BY release_year ORDER BY COUNT(*) DESC) AS rank
    FROM netflix
    WHERE country IS NOT NULL
    GROUP BY release_year, country
) t
WHERE rank = 1;

--Q18
--Most Active Directors
-- Top 10 directors with most content
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(director, ','))) AS director,
    COUNT(*) AS total_content
FROM netflix
WHERE director IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
