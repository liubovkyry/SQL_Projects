# When Was the Golden Age of Video Games?

<!-- https://app.datacamp.com/learn/projects/1413 -->

## Project Description

In this project, you'll analyze video game critic and user scores as well as sales data for the top 400 video games released since 1977. You'll search for a golden age of video games by identifying release years that users and critics liked best, and you'll explore the business side of gaming by looking at game sales data.

Your search will involve joining datasets and comparing results with set theory. You'll also filter, group, and order data. Make sure you brush up on these skills before trying this project!

## Project Tasks

1. The ten best-selling video games
2. Missing review scores
3. Years that video game critics loved
4. Was 1982 really that great?
5. Years that dropped off the critics' favorites list
6. Years video game players loved
7. Years that both players and critics loved
8. Sales in the best video game years

Video games are big business: the global gaming market is projected to be worth more than $300 billion by 2027 according to Mordor Intelligence. With so much money at stake, the major game publishers are hugely incentivized to create the next big hit. But are games getting better, or has the golden age of video games already passed?

In this project, we'll explore the top 400 best-selling video games created between 1977 and 2020. We'll compare a dataset on game sales with critic and user reviews to determine whether or not video games have improved as the gaming market has grown.

![image](https://user-images.githubusercontent.com/118057504/219178330-59c24e16-815f-4093-ab06-ee863d2d0e9f.png)


## 1. The ten best-selling video games

### Task 1: Instructions
Let's find the ten best-selling video games in game_sales.

 - Select all columns for the top ten best-selling video games (based on games_sold) in game_sales.
 - Order the results from the best-selling game down to the tenth best-selling game.
 
 ```
 SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;
```

![image](https://user-images.githubusercontent.com/118057504/219179234-783f8b8b-8162-4700-9e4d-a25149c05cf6.png)

## 2. Missing review scores
Wow, the best-selling video games were released between 1985 to 2017! That's quite a range; we'll have to use data from the reviews table to gain more insight on the best years for video games.

First, it's important to explore the limitations of our database. One big shortcoming is that there is not any reviews data for some of the games on the game_sales table.

### Task 2: Instructions
Let's determine how many games in the game_sales table are missing both a user_score and a critic_score.

 - Join the game_sales and reviews tables together so that all games from the game_sales table are listed in the results, whether or not they have associated reviews.
 - Select the count of games where both the associated critic_score and the associated user_score are null.

```
SELECT COUNT(game)
FROM game_sales
FULL JOIN reviews
USING(game)
WHERE critic_score IS NULL and user_score IS NULL;
```
![image](https://user-images.githubusercontent.com/118057504/219420581-838d98f3-3b50-4956-acb5-d9a27405d59f.png)

## 3. Years that video game critics loved
It looks like a little less than ten percent of the games on the game_sales table don't have any reviews data. That's a small enough percentage that we can continue our exploration, but the missing reviews data is a good thing to keep in mind as we move on to evaluating results from more sophisticated queries.

There are lots of ways to measure the best years for video games! Let's start with what the critics think.

### Task 3: Instructions
Find the years with the highest average critic_score.

 - Select release year and average critic score for each year; average critic score for each year will be rounded to two decimal places and aliased as avg_critic_score.
 - Join the game_sales and reviews tables so that only games which appear on both tables are represented.
 - Group the data by release year.
 - Order the data from highest to lowest avg_critic_score and limit the results to the top ten years.

```
SELECT 
year,
ROUND(AVG(critic_score),2) AS avg_critic_score
FROM game_sales
INNER JOIN reviews
USING(game)
GROUP BY year
ORDER BY avg_critic_score DESC
LIMIT 10;
```
![image](https://user-images.githubusercontent.com/118057504/219422604-cf1a9903-3fe6-4bf1-8dbf-76765c9e14e8.png)

## 4. Was 1982 really that great?
The range of great years according to critic reviews goes from 1982 until 2020: we are no closer to finding the golden age of video games!

Hang on, though. Some of those avg_critic_score values look like suspiciously round numbers for averages. The value for 1982 looks especially fishy. Maybe there weren't a lot of video games in our dataset that were released in certain years.

Let's update our query and find out whether 1982 really was such a great year for video games.

### Task 4: Instructions
Find game critics' ten favorite years, this time with the stipulation that a year must have more than four games released in order to be considered.

 - Starting with your query from the previous task, update it so that the selected data additionally includes a count of games released in a given year, and alias this count as num_games.
 - Filter your query so that only years with more than four games released are returned.

<i>NOTE:
Use HAVING instead of WHERE to filter based on the results of aggregating functions such as AVG() or COUNT().

You'll need to use HAVING COUNT(g.game) > 4 rather than HAVING num_games > 4 because a column alias cannot be used in the same level where you've defined it.</i>

```
SELECT 
year,
ROUND(AVG(critic_score),2) AS avg_critic_score,
COUNT(game) AS num_games
FROM game_sales
INNER JOIN reviews
USING(game) 
GROUP BY year
HAVING COUNT(game) > 4
ORDER BY avg_critic_score DESC
LIMIT 10;
```
![image](https://user-images.githubusercontent.com/118057504/219426410-d395bb0f-2cf8-43d4-90d2-dd6dffd7d915.png)

## 5. Years that dropped off the critics' favorites list
That looks better! The num_games column convinces us that our new list of the critics' top games reflects years that had quite a few well-reviewed games rather than just one or two hits. But which years dropped off the list due to having four or fewer reviewed games? Let's identify them so that someday we can track down more game reviews for those years and determine whether they might rightfully be considered as excellent years for video game releases!

It's time to brush off your set theory skills. To get started, we've created tables with the results of our previous two queries:

### Task 5: Instructions
Use set theory to find the years that were on our first critics' favorite list but not the second.

 - Select the year and avg_critic_score for those years that were on our first critics' favorite list but not the second due to having four or fewer reviewed games.
 - Order the results from highest to lowest avg_critic_score.
 - 
![image](https://user-images.githubusercontent.com/118057504/219426796-d3f15ef8-eb5d-4172-a02d-59cdf4a0a0fb.png)

```
SELECT 
year,
avg_critic_score
FROM top_critic_years
EXCEPT
SELECT
year,
avg_critic_score
FROM top_critic_years_more_than_four_games;
```
![image](https://user-images.githubusercontent.com/118057504/219451284-c1c32e1a-5112-4526-8f6f-6516ba9323b2.png)

## 6. Years video game players loved
Based on our work in the task above, it looks like the early 1990s might merit consideration as the golden age of video games based on critic_score alone, but we'd need to gather more games and reviews data to do further analysis.

Let's move on to looking at the opinions of another important group of people: players! To begin, let's create a query very similar to the one we used in Task Four, except this one will look at user_score averages by year rather than critic_score averages.

### Task 6: Instructions
Update your query from Task Four so that it returns years with ten highest avg_user_score values.

 - You'll still select year and an average of user_score for each year, rounded to two decimal places and aliased as avg_user_score; also include a count of games released in a given year, aliased as num_games.
 - Include only years with more than four reviewed games; group the data by year.
 - Order data from highest to lowest avg_user_score, and limit the results to the top ten years.
 
 ```
 SELECT year, 
AVG(user_score) AS avg_user_score,
ROUND(COUNT(game),2) AS num_games
FROM game_sales
INNER JOIN reviews
USING(game) 
GROUP BY year
HAVING COUNT(game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;
```
![image](https://user-images.githubusercontent.com/118057504/219452793-45a3776c-73fa-4ec3-a598-417b5d9146c1.png)

## 7. Years that both players and critics loved
Alright, we've got a list of the top ten years according to both critic reviews and user reviews. Are there any years that showed up on both tables? If so, those years would certainly be excellent ones!

Recall that we have access to the top_critic_years_more_than_four_games table, which stores the results of our top critic years query from Task 4:
![image](https://user-images.githubusercontent.com/118057504/219452972-90c0027d-35a1-4369-bc8f-5dde33baf8bc.png)

### Task 7: Instructions
Create a list of years that appear on both the top_critic_years_more_than_four_games table and the top_user_years_more_than_four_games table.

 - Using set theory, select only the year results that appear on both tables.

```
SELECT year
FROM top_critic_years_more_than_four_games
INTERSECT
SELECT year
FROM top_user_years_more_than_four_games;
```
![image](https://user-images.githubusercontent.com/118057504/219454524-5d8af487-b1ab-4d3c-8d6f-92967ce0dabb.png)

## 8. Sales in the best video game years
Looks like we've got three years that both users and critics agreed were in the top ten! There are many other ways of measuring what the best years for video games are, but let's stick with these years for now. We know that critics and players liked these years, but what about video game makers? Were sales good? Let's find out.
We'll use the query from the previous task as a subquery in this one!

### Task 8: Instructions
Add a column showing total games_sold in each year to the table you created in the previous task.

 - Select year and the sum of games_sold, aliased as total_games_sold; order your results by total_games_sold descending.
 - Filter the game_sales table based on whether the year is in the list of years you returned in the previous task, using your code from the previous task as a subquery.
 - Group the results by year.

```
SELECT year, SUM(games_sold) AS total_games_sold
FROM game_sales
WHERE year IN(SELECT year
FROM top_critic_years_more_than_four_games
INTERSECT
SELECT year
FROM top_user_years_more_than_four_games)
GROUP BY year
ORDER BY total_games_sold DESC;
```
![image](https://user-images.githubusercontent.com/118057504/219455998-1dd3acb1-c1f3-4099-8bd8-c20f2dc176e7.png)


