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



