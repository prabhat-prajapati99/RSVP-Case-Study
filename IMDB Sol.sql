	USE imdb;

-- Before you proceed to solve the assignment, it is a good practice to know what the data values in each table are.

SELECT
	*
FROM
	movie;

SELECT
	*
FROM
	ratings;

-- Similarly, Write queries to see data values from all tables 

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------


/* To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movie' and 'genre' tables. */

-- Segment 1:

-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

SELECT 
    COUNT(*) AS movie_row_count
FROM
    movie;

-- Similarly, write queries to find the total number of rows in each table
select count(*) names_row_count
 from names ;
 
select count(*)as  reting_row_count
 from ratings ;
 
 select count(*)as genre_row_count
 from genre ;
 
 select count(*) as role_maping_row_count
 from role_mapping ;
 
 select count(*) as director_mapping_row_count
 from director_mapping ;
 -- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Q2. Which columns in the 'movie' table have null values?
-- Type your code below:

-- Solution 1
SELECT 
    COUNT(*) AS title_nulls
FROM
    movie
WHERE title IS NULL;

SELECT 
    COUNT(*) AS year_nulls
FROM
    movie
WHERE year IS NULL;    

-- Similarly, write queries to find the null values of remaining columns in 'movie' table 

select count(*) as date_published_null
from movie 
where date_published is null ;

select count(*) as duration_null
from movie 
where duration is null ;


select count(*) as country_null
from movie 
where country is null ;


select count(*) as worlwide_gross_income_null
from movie 
where worlwide_gross_income is null ;


select count(*) as languages_null
from movie 
where languages is null ;



select count(*) as production_company_null
from movie 
where production_company is null ;

-- --------------------------------------------------------------------------------------------------


-- Solution 2
SELECT 
    COUNT(CASE
        WHEN title IS NULL THEN id
    END) AS title_nulls,
    COUNT(CASE
        WHEN year IS NULL THEN id
    END) AS year_nulls ,
    COUNT(CASE
        WHEN date_published IS NULL THEN id
    END) AS date_published_nulls ,
     COUNT(CASE
        WHEN duration IS NULL THEN id
    END) AS duration_nulls ,
    COUNT(CASE
        WHEN country IS NULL THEN id
    END) AS country_nulls ,
    count(case 
		when worlwide_gross_income is null then id 
	end) as worlwide_gross_income_nulls ,
         count(case 
		when languages is null then id 
	end) as languages_nulls ,
            count(case 
		when production_company is null then id 
	end) as production_company_nulls 
        FROM movie;
    
/* In Solution 2 above, id in each case statement has been used as a counter to count the number of null values. Whenever a value
   is null for a column, the id increments by 1. */

--  There are 20 nulls in country; 3724 nulls in worlwide_gross_income; 194 nulls in languages; 528 nulls in production_company.
  --  Notice that we do not need to check for null values in the 'id' column as it is a primary key.

-- As you can see, four columns of the 'movie' table have null values. Let's look at the movies released in each year. 

-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- Q3.1 Find the total number of movies released in each year.






/* Output format :

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	   2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+ */


-- Hint: Utilize the COUNT(*) function to count the number of movies.
-- Hint: Use the GROUP BY clause to group the results by the 'year' column.

-- Type your code below:
select year , count(id) as number_of_movies
from movie 
group by year ;


-- Q3.1 How does the trend look month-wise? (Output expected) 

-- To get the month from date_published column
SELECT
    MONTH(date_published) as month_num,
    date_published
FROM
    movie;


/* Output format :
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	  1			|	    134			|
|	  2			|	    231			|
|	  .			|		 .			|
+---------------+-------------------+ */

-- Type your code below:
select month(date_published) as num_of_month , count(id) as number_of_movies
from movie  
group by  month(date_published) 
order by num_of_month ;





/* The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the
'movies' table. 
We know that USA and India produce a huge number of movies each year. Lets find the number of movies produced by USA
or India in the last year. */
  
  -- ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- Example: Query to get the number of movies produced in USA
SELECT 
    COUNT(*) AS number_of_movies
FROM
    movie
WHERE country LIKE '%USA%';

  
-- Q4. How many movies were produced in the USA or India in the year 2019?
-- Hint: Use the LIKE operator to filter countries containing 'USA' or 'India'.

/* Output format

+---------------+
|number_of_movies|
+---------------+
|	  -		     |  */

-- Type your code below:
with cte1 as (
select * 
from movie 
where country like '%usa%' or '%india%' )

select count(*)  as number_of_movies
from cte1
where year = 2019;




/* USA and India produced more than a thousand movies (you know the exact number!) in the year 2019.
Exploring the table 'genre' will be fun, too.
Let’s find out the different genres in the dataset. */

-- -----------------------------------------------------------------------------------------------------------------------------------------------

-- Q5. Find the unique list of the genres present in the data set?

/* Output format
+---------------+
|genre|
+-----+
|  -  |
|  -  |
|  -  |  */

-- Type your code below:
select distinct genre 
from genre ;



/* So, RSVP Movies plans to make a movie on one of these genres.
Now, don't you want to know in which genre were the highest number of movies produced?
Combining both the 'movie' and the 'genre' table can give us interesting insights. */

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q6.Which genre had the highest number of movies produced overall?

-- Hint: Utilize the COUNT() function to count the occurrences of movie IDs for each genre.
-- Hint: Group the results by the 'genre' column using the GROUP BY clause.
-- Hint: Order the results by the count of movie IDs in descending order using the ORDER BY clause.
-- Hint: Use the LIMIT clause to restrict the result to only the top genre with the highest movie count.


/* Output format
+-----------+--------------+
|	genre	|	movie_count|
+-----------+---------------
|	  -		|	    -	   |

+---------------+----------+ */

-- Type your code below:

select genre , count(m.id) as movie_count
from movie as m join genre as g 
on m.id = g.movie_id 
group by genre 
order by  movie_count desc ;



/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q7. How many movies belong to only one genre?

-- Hint: Utilize a Common Table Expression (CTE) named 'movie_genre_summary' to summarize genre counts per movie.
-- Hint: Use the COUNT() function along with GROUP BY to count the number of genres for each movie.
-- Hint: Employ COUNT(DISTINCT) to count movies with only one genre.

/* Output format
+------------------------+
|single_genre_movie_count|
+------------------------+
|           -            |*/

-- Type your code below: 
with movie_genre_summary as (
select m.id  , count(genre) as no_of_genere
from movie as m join genre as g 
on m.id = g.movie_id 
group by m.id 
order by no_of_genere  ) 
select count(*) as single_genre_movie_count
from movie_genre_summary 
where no_of_genere = 1 ;




/* There are more than three thousand movies which have only one genre associated with them.
This is a significant number.
Now, let's find out the ideal duration for RSVP Movies’ next project.*/

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)        

-- Hint: Utilize a LEFT JOIN to combine the 'genre' and 'movie' tables based on the 'movie_id'.
-- Hint: Specify table aliases for clarity, such as 'g' for 'genre' and 'm' for 'movie'.
-- Hint: Employ the AVG() function to calculate the average duration for each genre.
-- Hint: GROUP BY the 'genre' column to calculate averages for each genre.


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	Thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select genre , round(avg(duration)) as avg_duration
from movie as m right join genre as g 
on m.id = g.movie_id 
group by genre  ;


/* Note that using an outer join is important as we are dealing with a large number of null values. Using
   an inner join will slow down query processing. */

/* Now you know that movies of genre 'Drama' (produced highest in number in 2019) have an average duration of
106.77 mins.
Let's find where the movies of genre 'thriller' lie on the basis of number of movies.*/

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Example: Find the ranking of each genre based on the number of movies associated with it. 
SELECT 
	  genre,
	  COUNT(movie_id) AS movie_count,
	  RANK () OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank
FROM
	genre
GROUP BY genre;
    
-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 

-- Hint: Use a Common Table Expression (CTE) named 'summary' to aggregate counts of movie IDs for each genre.
-- Hint: Utilize the COUNT() function along with GROUP BY to count the number of movie IDs for each genre.
-- Hint: Implement the RANK() function to assign a rank to each genre based on movie count.
-- Hint: Employ LOWER() function to ensure case-insensitive comparison.


/* Output format:
+---------------+-------------------+---------------------+
|   genre		|	 movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|   -	    	|	   -			|			-		  |
+---------------+-------------------+---------------------+*/

-- Type your code below: 
with cte1 as (
select g.genre , count(m.id) as  movie_count ,rank () over(order by count(m.id) desc ) as genre_rank  
from movie as m join genre as g
 on m.id = g.movie_id 
 group by g.genre 
 order by movie_count  desc ) 

 select * 
 from cte1
 where genre = 'thriller' ;





-- Thriller movies are in the top 3 among all genres in terms of the number of movies.

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* In the previous segment, you analysed the 'movie' and the 'genre' tables. 
   In this segment, you will analyse the 'ratings' table as well.
   To start with, let's get the minimum and maximum values of different columns in the table */

-- Segment 2:

-- Q10.  Find the minimum and maximum values for each column of the 'ratings' table except the movie_id column.

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/

-- Type your code below:

SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    min(total_votes)  as min_total_votes,
    max(total_votes) as max_total_votes ,
    min(median_rating) as min_median_rating ,
    max(median_rating) as max_median_rating    
FROM
    ratings;
    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating. */

select m.id , title ,round(avg( r.avg_rating),1) as avg_reting , row_number() over(order by avg_rating desc ) as movie_rank 
from movie as m join ratings as r 
on m.id = r.movie_id 
group by m.id , title  ;   


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Example: Determine the ranking of movies based on their average ratings.
SELECT
    m.title,
    avg_rating,
    ROW_NUMBER() OVER (ORDER BY avg_rating DESC) AS movie_rank
FROM
    movie AS m
        LEFT JOIN
    ratings AS r ON m.id = r.movie_id;
    
-- Q11. What are the top 10 movies based on average rating?

-- Hint: Use a Common Table Expression (CTE) named 'top_movies' to calculate the average rating for each movie and assign a rank.
-- Hint: Utilize a LEFT JOIN to combine the 'movie' and 'ratings' tables based on 'id' and 'movie_id' respectively.
-- Hint: Implement the AVG() function to calculate the average rating for each movie.
-- Hint: Use the ROW_NUMBER() function along with ORDER BY to assign ranks to movies based on average rating, ordered in descending order.

/* Output format:
+---------------+-------------------+---------------------+
|     title		|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
|     Fan		|		9.6			|			5	  	  |
|	  .			|		 .			|			.		  |
|	  .			|		 .			|			.		  |
|	  .			|		 .			|			.		  |
+---------------+-------------------+---------------------+*/

-- Type your code below:
select  title ,round(avg( r.avg_rating),1) as avg_reting , row_number() over(order by avg_rating desc ) as movie_rank 
from movie as m left join ratings as r 
on m.id = r.movie_id 
group by m.id , title  ;   


 



-- It's okay to use RANK() or DENSE_RANK() as well.

/* Do you find the movie 'Fan' in the top 10 movies with an average rating of 9.6? If not, please check your code
again.
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight. */

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q12. Summarise the ratings table based on the movie counts by median ratings.(order by median_rating)

/* Output format:
+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */

-- Type your code below:
select median_rating , count(movie_id) as movie_count
from ratings 
group by median_rating 
order by median_rating  ;



/* Movies with a median rating of 7 are the highest in number. 
Now, let's find out the production house with which RSVP Movies should look to partner with for its next project.*/

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Example: Identify the production companies and their respective rankings based on the number of movies they have produced.
SELECT 
    m.production_company,
    COUNT(m.id) AS movie_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(m.id) DESC) AS prod_company_rank
FROM
    movie AS m
        LEFT JOIN
    ratings AS r
		ON m.id = r.movie_id
        GROUP BY m.production_company;

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)?

-- Hint: Use a Common Table Expression (CTE) named 'top_prod' to find the top production companies based on movie count.
-- Hint: Utilize a LEFT JOIN to combine the 'movie' and 'ratings' tables based on 'id' and 'movie_id' respectively.
-- Hint: Exclude NULL production company values using IS NOT NULL in the WHERE clause.


/* Output format:
+------------------+-------------------+----------------------+
|production_company|    movie_count	   |    prod_company_rank |
+------------------+-------------------+----------------------+
|           	   |		 		   |			 	  	  |
+------------------+-------------------+----------------------+*/

-- Type your code below:
with cte1 as
 ( select production_company ,count(m.id) as movie_count , 
rank() over(order by count(m.id) desc )  as  prod_company_rank 
from movie as m left join  ratings as r
on m.id =  r.movie_id  
where avg_rating > 8 
group by production_company ) 
select * 
from cte1 
where production_company is not null ;



-- It's okay to use RANK() or DENSE_RANK() as well.
-- The answer can be either Dream Warrior Pictures or National Theatre Live or both.

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q14. How many movies released in each genre in March 2017 in the USA had more than 1,000 votes?(Split the question into parts and try to understand it.)

-- Hint: Utilize INNER JOINs to combine the 'genre', 'movie', and 'ratings' tables based on their relationships.
-- Hint: Use the WHERE clause to apply filtering conditions based on year, month, country, and total votes.
-- Hint: Extract the month from the 'date_published' column using the MONTH() function.
-- Hint: Employ LOWER() function for case-insensitive comparison of country names.
-- Hint: Utilize COUNT() function along with GROUP BY to count movies in each genre.


/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */


-- Type your code below:

with cte1 as (
select genre, 
        m.id
 from movie as m
    join genre as g on m.id = g.movie_id
    join ratings as r on g.movie_id = r.movie_id 
where        m.country like '%usa%' 
		and r.total_votes > 1000 
        and month( date_published) = 3
        and year(date_published) = 2017 ) 
        select  genre , count(*) as  movie_count 
        from cte1 
        group by genre ; 
        
        
        
        
	

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Lets try analysing the 'imdb' database using a unique problem statement.

-- Q15. Find the movies in each genre that start with the characters ‘The’ and have an average rating > 8.

-- Hint: Utilize INNER JOINs to combine the 'movie', 'genre', and 'ratings' tables based on their relationships.
-- Hint: Apply filtering conditions in the WHERE clause using the LIKE operator for the 'title' column and a condition for 'avg_rating'.
-- Hint: Use the '%' wildcard appropriately with the LIKE operator for pattern matching.


/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/

-- Type your code below:

select  title ,avg_rating , genre 
from movie as m join genre as g 
on m.id = g.movie_id 
join ratings as r 
on m.id = r.movie_id 
where title like '%the%'  and avg_rating > 8  ;



-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- You should also try out the same for median rating and check whether the ‘median rating’ column gives any
-- significant insights.

-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?

-- Hint: Use an INNER JOIN to combine the 'movie' and 'ratings' tables based on their relationship.
-- Hint: Pay attention to the date format for the BETWEEN operator and ensure it matches the format of the 'date_published' column.

/* Output format
+---------------+
|movie_count|
+-----------+
|     -     |  */

-- Type your code below:
select count(id) as movie_count 
from movie as m join ratings as r 
on m.id = r.movie_id 
where date_published  between '2018-04-01' and '2019-04-01' 
		and median_rating = 8;





-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Now, let's see the popularity of movies in different languages.


select languages ,count(id) as movie_count 
from movie as m join ratings as r 
on m.id = r.movie_id 
where date_published  between '2018-04-01' and '2019-04-01' 
		and median_rating = 8 
         and languages is not null
        group by languages 
        order by movie_count desc  ;
        
        
        
        
-- Example: Calculate the average number of votes per movie for German movies.
WITH votes_summary AS
(
    SELECT 
        COUNT(CASE WHEN LOWER(m.languages) LIKE '%german%' THEN m.id END) AS german_movie_count,
        SUM(CASE WHEN LOWER(m.languages) LIKE '%german%' THEN r.total_votes END) AS german_movie_votes
    FROM
        movie AS m 
        INNER JOIN
        ratings AS r 
        ON m.id = r.movie_id
)
SELECT 
    ROUND(german_movie_votes / german_movie_count, 2) AS german_votes_per_movie
FROM
    votes_summary;

-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.

/* Output format:
+---------------------------+---------------------------+
| german_votes_per_movie	|	italian_votes_per_movie	|
+---------------------------+----------------------------
|	-	                    |		    -   			|
|	.			            |		.	        		|
+---------------------------+---------------------------+ */

-- Type your code below:

WITH votes_summary AS
(
    SELECT 
        COUNT(CASE WHEN LOWER(m.languages) LIKE '%german%' THEN m.id END) AS german_movie_count,
        SUM(CASE WHEN LOWER(m.languages) LIKE '%german%' THEN r.total_votes END) AS german_movie_votes  , 
         COUNT(CASE WHEN LOWER(m.languages) LIKE '%Italian%' THEN m.id END) AS Italian_movie_count,
        SUM(CASE WHEN LOWER(m.languages) LIKE '%Italian%' THEN r.total_votes END) AS Italian_movie_votes
    FROM
        movie AS m 
        INNER JOIN
        ratings AS r 
        ON m.id = r.movie_id
)
SELECT 
    ROUND(german_movie_votes / german_movie_count, 2) AS german_votes_per_movie  ,
     ROUND(Italian_movie_count / Italian_movie_votes, 2) AS italian_votes_per_movie
FROM
    votes_summary;






WITH votes_summary AS
(
    SELECT 
        COUNT(CASE WHEN LOWER(m.languages) LIKE '%Italian%' THEN m.id END) AS Italian_movie_count,
        SUM(CASE WHEN LOWER(m.languages) LIKE '%Italian%' THEN r.total_votes END) AS Italian_movie_votes
    FROM
        movie AS m 
        INNER JOIN
        ratings AS r 
        ON m.id = r.movie_id
)
SELECT 
    ROUND(Italian_movie_votes / Italian_movie_count, 2) AS Italian_votes_per_movie
FROM
    votes_summary;

-- Answer is Yes


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------


/* Now that you have analysed the 'movie', 'genre' and 'ratings' tables, let us analyse another table - the 'names'
table. 
Let’s begin by searching for null values in the table. */

-- Segment 3:

-- Q18. Find the number of null values in each column of the 'names' table, except for the 'id' column.

/* Hint: You can find the number of null values for individual columns or follow below output format

+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/

-- Type your code below:



select count( case when name is null then 1 end)  as name_nulls ,
 count(case when  height is null then 1 end) as height_nulls ,
 count(case when  date_of_birth is null then 1 end) as date_of_birth_nulls ,
 count(case when  known_for_movies  is null then 1 end ) as known_for_movies_nulls 
from names ;



-- Solution 1
SELECT 
    COUNT(*) AS name_nulls
FROM
    names
WHERE name IS NULL;

-- Type your code for remaining columns to check null values 

SELECT 
    COUNT(*) AS name_nulls
FROM
    names
WHERE name IS NULL;

SELECT 
    COUNT(*) AS height_nulls
FROM
    names  
    WHERE height IS NULL;

    
    SELECT 
    COUNT(*) AS date_of_birth_nulls
FROM
    names 
    WHERE date_of_birth IS NULL;

  SELECT 
    COUNT(*) AS known_for_movies_nulls
FROM
    names 
    WHERE known_for_movies IS NULL;


-- Solution 2
-- use case statements to write the query to find null values of each column in names table
-- Hint: Refer question 2

-- Type your code below 
select count( case when name is null then 1 end)  as name_nulls ,
 count(case when  height is null then 1 end) as height_nulls ,
 count(case when  date_of_birth is null then 1 end) as date_of_birth_nulls ,
 count(case when  known_for_movies  is null then 1 end ) as known_for_movies_nulls 
from names ;






    
/* Answer: 0 nulls in name; 17335 nulls in height; 13413 nulls in date_of_birth; 15226 nulls in known_for_movies.
   There are no null values in the 'name' column. */ 


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/* The director is the most important person in a movie crew. 
   Let’s find out the top three directors each in the top three genres who can be hired by RSVP Movies. */

-- Q19. Who are the top three directors in each of the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)

/* Output format:
+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */

-- Type your code below:

WITH top_rated_genres AS
(
SELECT
    genre,
    COUNT(m.id) AS movie_count,
	RANK () OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM
    genre AS g
        LEFT JOIN
    movie AS m 
		ON g.movie_id = m.id
			INNER JOIN
		ratings AS r
			ON m.id=r.movie_id
WHERE avg_rating>8
GROUP BY genre
)
SELECT 
	n.name as director_name,
	COUNT(m.id) AS movie_count
FROM
	names AS n
		INNER JOIN
	director_mapping AS d
		ON n.id=d.name_id
			INNER JOIN
        movie AS m
			ON d.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
					INNER JOIN
						genre AS g
					ON g.movie_id = m.id
WHERE g.genre IN (SELECT DISTINCT genre FROM top_rated_genres WHERE genre_rank<=3)
		AND avg_rating>8
GROUP BY name
ORDER BY movie_count DESC
LIMIT 3;


/* James Mangold can be hired as the director for RSVP's next project. You may recall some of his movies like 'Logan'
and 'The Wolverine'.
Now, let’s find out the top two actors.*/

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q20. Who are the top two actors whose movies have a median rating >= 8?

-- Hint: Utilize INNER JOINs to combine the 'names', 'role_mapping', 'movie', and 'ratings' tables based on their relationships.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for median rating and category.
-- Hint: Group the results by the actor's name using GROUP BY.
-- Hint: Utilize aggregate functions such as COUNT() to count the number of movies each actor has participated in.


/* Output format:
+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christian Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */

-- Type your code below:
select name as actor_name , count(m.id) as movie_count
from movie as m join ratings as r 
on m.id = r.movie_id 
join role_mapping as rm 
on m.id = rm.movie_id 
join names as n 
on rm.name_id = n.id 
where median_rating >= 8 and category = 'actor' 
group by name_id  ,name
order by movie_count desc 
limit 2 ;




/* Did you find the actor 'Mohanlal' in the list? If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q21. Which are the top three production houses based on the number of votes received by their movies?

-- Hint: Use a Common Table Expression (CTE) named 'top_prod' to find the top production companies based on total votes.
-- Hint: Utilize a LEFT JOIN to combine the 'movie' and 'ratings' tables based on 'id' and 'movie_id' respectively.
-- Hint: Filter out NULL production company values using IS NOT NULL in the WHERE clause.
-- Hint: Utilize the SUM() function to calculate the total votes for each production company.
-- Hint: Implement the ROW_NUMBER() function along with ORDER BY to assign ranks to production companies based on total votes, ordered in descending order.
-- Hint: Limit the number of results to the top 3 using ROW_NUMBER() and WHERE clause.


/* Output format:
+-------------------+-------------------+---------------------+
|production_company |   vote_count		|	prod_comp_rank    |
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|		.		      |
|	.				|		.			|		.		  	  |
+-------------------+-------------------+---------------------+*/

-- Type your code below:
select production_company , sum(total_votes) as vote_count , 
row_number() over( order by sum(total_votes)  desc ) as prod_comp_rank 
from movie as m join ratings as r
 on m.id = r.movie_id 
 group by production_company 
 limit 3 ;
 



/* Yes, Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received for the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies is looking to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be. */

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the
-- list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes
-- should act as the tie breaker.)

/* Output format:
+---------------+---------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes	|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+---------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|		3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|		.		|	       .		  |	   .	    		 |		.	       |
|		.		|		.		|	       .		  |	   .	    		 |		.	       |
+---------------+---------------+---------------------+----------------------+-----------------+*/

-- Type your code below:

WITH actor_ratings AS
(
SELECT 
	n.name as actor_name,
    SUM(r.total_votes) AS total_votes,
    COUNT(m.id) as movie_count,
	ROUND(
		SUM(r.avg_rating*r.total_votes)
        /
		SUM(r.total_votes)
			,2) AS actor_avg_rating
FROM
	names AS n
		INNER JOIN
	role_mapping AS a
		ON n.id=a.name_id
			INNER JOIN
        movie AS m
			ON a.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
WHERE category = 'actor' AND LOWER(country) like '%india%'
GROUP BY actor_name
)
SELECT *,
	RANK() OVER (ORDER BY actor_avg_rating DESC, total_votes DESC) AS actor_rank
FROM
	actor_ratings
WHERE movie_count>=5;

-- The top actor is Vijay Sethupathi.

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q23.Find the top five actresses in Hindi movies released in India based on their average ratings.
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes
-- should act as the tie breaker.)

-- Hint: Utilize a Common Table Expression (CTE) named 'actress_ratings' to aggregate data for actresses based on specific criteria.
-- Hint: Use INNER JOINs to combine the 'names', 'role_mapping', 'movie', and 'ratings' tables based on their relationships.
-- Hint: Consider which columns are necessary for the output and ensure they are selected in the SELECT clause.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for category and language.
-- Hint: Utilize aggregate functions such as SUM() and COUNT() to calculate total votes, movie count, and average rating for each actress.
-- Hint: Use GROUP BY to group the results by actress name.
-- Hint: Implement the ROW_NUMBER() function along with ORDER BY to assign ranks to actresses based on average rating and total votes, ordered in descending order.
-- Hint: Specify the condition for selecting actresses with at least 3 movies using a WHERE clause.
-- Hint: Limit the number of results to the top 5 using LIMIT.


/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:
with actress_ratings as (
select name as actress , sum(total_votes) as total_votes , count(m.id) as movie_count ,
	ROUND(
		SUM(r.avg_rating*r.total_votes)
        /
		SUM(r.total_votes)
			,2) AS actor_avg_rating
		from movie as m join ratings as r 
		on m.id = r.movie_id 
			join role_mapping as rm 
            on m.id = rm.movie_id 
				join names as n 
                on rm.name_id = n.id  
          where languages = 'hindi'  and category = 'actress' 
          group by name )
          select * , 
          row_number() over(order by total_votes desc,  actor_avg_rating desc )  as actress_rank
          from actress_ratings 
          where movie_count >= 3  
          limit 5 ;
          
		
					











-- Taapsee Pannu tops the charts with an average rating of 7.74.

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Now let us divide all the thriller movies in the following categories and find out their numbers.
/* Q24. Consider thriller movies having at least 25,000 votes. Classify them according to their average ratings in
   the following categories: 
			Rating > 8: Superhit
			Rating between 7 and 8: Hit
			Rating between 5 and 7: One-time-watch
			Rating < 5: Flop   */
            
-- Hint: Utilize LEFT JOINs to combine the 'movie', 'ratings', and 'genre' tables based on their relationships.
-- Hint: Use the CASE statement to categorize movies based on their average rating into 'Superhit', 'Hit', 'One time watch', and 'Flop'.
-- Hint: Implement logical conditions within the CASE statement to define the movie categories based on rating ranges.
-- Hint: Apply filtering conditions in the WHERE clause to select movies with a specific genre ('thriller') and a total vote count exceeding 25000.
-- Hint: Utilize the LOWER() function to ensure case-insensitive comparison of genre names.

/* Output format :

+-------------------+-------------------+
|   movie_name	    |	movie_category  |
+-------------------+--------------------
|	Pet Sematary	|	One time watch	|
|       -       	|		.			|
|	    -   		|		.			|
+---------------+-------------------+ */


-- Type your code below:
select title as movie_name  ,
case 
 when avg_rating > 8 then 'Superhit' 
 when avg_rating between 7 and 8 then 'hit' 
 when avg_rating between 5 and 7 then 'One-time-watch'
 when avg_rating < 5 then 'Flop' 
 end as movie_category
from movie as m left join ratings as r 
on m.id = r.movie_id 
	left join genre as g 
    on m.id = g.movie_id 
    where genre = 'thriller' and total_votes >= 25000 ;




-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment. */

-- Segment 4:

-- Example: What is the genre-wise running total of the average movie duration? 
WITH genre_summary AS
(
SELECT 
    genre,
    ROUND(AVG(duration),2) AS avg_duration
FROM
    genre AS g
        LEFT JOIN
    movie AS m 
		ON g.movie_id = m.id
GROUP BY genre
)
SELECT *,
	SUM(avg_duration) OVER (ORDER BY genre ROWS UNBOUNDED PRECEDING) AS running_total_duration
FROM
	genre_summary;
    
    
-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to get the output according to the output format given below.)

-- Hint: Utilize a Common Table Expression (CTE) named 'genre_summary' to calculate the average duration for each genre.
-- Hint: Use a LEFT JOIN to combine the 'genre' and 'movie' tables based on the 'movie_id' and 'id' respectively.
-- Hint: Implement the ROUND() function to round the average duration to two decimal places.
-- Hint: Utilize the AVG() function along with GROUP BY to calculate the average duration for each genre.
-- Hint: In the main query, use the SUM() and AVG() window functions to compute the running total duration and moving average duration respectively.
-- Hint: Utilize the ROWS UNBOUNDED PRECEDING option to include all rows from the beginning of the partition.


/* Output format:
+---------------+-------------------+----------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration   |
+---------------+-------------------+----------------------+----------------------+
|	comedy		|			145		|	       106.2	   |	   128.42	      |
|		.		|			.		|	       .		   |	   .	    	  |
|		.		|			.		|	       .		   |	   .	    	  |
|		.		|			.		|	       .		   |	   .	    	  |
+---------------+-------------------+----------------------+----------------------+*/

-- Type your code below:
with genre_summary as (
select genre , round(avg(duration),2) as avg_duration
from movie as m right join genre as g 
on m.id  = g.movie_id 
group by genre )
select * , 
sum(avg_duration) over(order by genre ROWS between unbounded preceding AND current row) as running_total_duration , 
                 avg(avg_duration) over (order by genre ROWS between unbounded preceding and current row) as moving_avg_duration 
from genre_summary ;


-- Rounding off is good to have and not a must have, the same thing applies to sorting.

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let us find the top 5 movies for each year with the top 3 genres.

-- Q26. Which are the five highest-grossing movies in each year for each of the top three genres?
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:
select genre , year , title as movie_name , worlwide_gross_income ,
rank() over(partition by genre ,year order by worlwide_gross_income desc ) as movie_rank 
from movie as m join genre as g 
on m.id = g.movie_id  ;




-- Top 3 Genres based on most number of movies
WITH top_genres AS 
( 
SELECT 
    genre,
    COUNT(m.id) AS movie_count,
	RANK () OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM
    genre AS g
        LEFT JOIN
    movie AS m 
		ON g.movie_id = m.id
GROUP BY genre
)
,
top_grossing AS
(
SELECT 
    g.genre,
	year,
	m.title as movie_name,
    worlwide_gross_income,
    RANK() OVER (PARTITION BY g.genre, year 
				   ORDER BY CONVERT(REPLACE(TRIM(worlwide_gross_income), "$ ",""), UNSIGNED INT) DESC) AS movie_rank
FROM
movie AS m
	INNER JOIN
genre AS g
	ON g.movie_id = m.id
WHERE g.genre IN (SELECT DISTINCT genre FROM top_genres WHERE genre_rank<=3)
)
SELECT *
FROM
	top_grossing
WHERE movie_rank<=5;



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Finally, let’s find out the names of the top two production houses that have produced the highest number of hits
   among multilingual movies.
   
Q27. What are the top two production houses that have produced the highest number of hits (median rating >= 8) among
multilingual movies? */
-- Hint: Utilize a Common Table Expression (CTE) named 'top_prod' to find the top production companies based on movie count.
-- Hint: Use a LEFT JOIN to combine the 'movie' and 'ratings' tables based on their relationship.
-- Hint: Apply filtering conditions in the WHERE clause using logical conditions for median rating, production company existence, and language specification.
-- Hint: Utilize aggregate functions such as COUNT() to count the number of movies for each production company.
-- Hint: Implement the ROW_NUMBER() function along with ORDER BY to assign ranks to production companies based on movie count, ordered in descending order.
-- Hint:  Apply filtering conditions in the WHERE clause using logical conditions for median rating, production company existence, and language specification.
-- Hint: Limit the number of results to the top 2 using ROW_NUMBER() and WHERE clause.
-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0.
-- If there is a comma, that means the movie is of more than one language.


/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/

-- Type your code below: 

select production_company , count(m.id) as movie_count  ,
rank() over (order by count(m.id) desc ) compuny_rank
from movie as m left join ratings as r 
on m.id = r.movie_id 
where production_company is not null and  median_rating >= 8 and POSITION(',' IN languages)>0 
group by production_company
order by movie_count desc  
limit 2 ;



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q28. Who are the top 3 actresses based on the number of Super Hit movies (average rating > 8) in 'drama' genre?

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:

WITH actress_ratings AS
(
SELECT 
	n.name as actress_name,
    SUM(r.total_votes) AS total_votes,
    COUNT(m.id) as movie_count,
	ROUND(
		SUM(r.avg_rating*r.total_votes)
        /
		SUM(r.total_votes)
			,2) AS actress_avg_rating
FROM
	names AS n
		INNER JOIN
	role_mapping AS a
		ON n.id=a.name_id
			INNER JOIN
        movie AS m
			ON a.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
					INNER JOIN
				genre AS g
				ON m.id=g.movie_id
WHERE category = 'actress' AND lower(g.genre) ='drama'
GROUP BY actress_name
)
SELECT *,
	ROW_NUMBER() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank
FROM
	actress_ratings
LIMIT 3;



-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Q29. Get the following details for top 9 directors (based on number of movies):

Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating-
Max rating
Total movie duration

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/

-- Type your code below:

WITH top_directors AS
(
SELECT 
	n.id as director_id,
    n.name as director_name,
	COUNT(m.id) AS movie_count,
    RANK() OVER (ORDER BY COUNT(m.id) DESC) as director_rank
FROM
	names AS n
		INNER JOIN
	director_mapping AS d
		ON n.id=d.name_id
			INNER JOIN
        movie AS m
			ON d.movie_id = m.id
GROUP BY n.id
),
movie_summary AS
(
SELECT
	n.id as director_id,
    n.name as director_name,
    m.id AS movie_id,
    m.date_published,
	r.avg_rating,
    r.total_votes,
    m.duration,
    LEAD(date_published) OVER (PARTITION BY n.id ORDER BY m.date_published) AS next_date_published,
    DATEDIFF(LEAD(date_published) OVER (PARTITION BY n.id ORDER BY m.date_published),date_published) AS inter_movie_days
FROM
	names AS n
		INNER JOIN
	director_mapping AS d
		ON n.id=d.name_id
			INNER JOIN
        movie AS m
			ON d.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
WHERE n.id IN (SELECT director_id FROM top_directors WHERE director_rank<=9)
)
SELECT 
	director_id,
	director_name,
	COUNT(DISTINCT movie_id) as number_of_movies,
	ROUND(AVG(inter_movie_days),0) AS avg_inter_movie_days,
	ROUND(
	SUM(avg_rating*total_votes)
	/
	SUM(total_votes)
		,2) AS avg_rating,
    SUM(total_votes) AS total_votes,
    MIN(avg_rating) AS min_rating,
    MAX(avg_rating) AS max_rating,
    SUM(duration) AS total_duration
FROM 
movie_summary
GROUP BY director_id
ORDER BY number_of_movies DESC, avg_rating DESC;