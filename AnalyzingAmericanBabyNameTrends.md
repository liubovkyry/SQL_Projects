# Project: Analyzing American Baby Name Trends
## 1. Classic American names
How have American baby name tastes changed since 1920? Which names have remained popular for over 100 years, and how do those names compare to more recent top baby names? These are considerations for many new parents, but the skills we'll practice while answering these queries are broadly applicable. After all, understanding trends and popularity is important for many businesses, too!

We'll be working with data provided by the United States Social Security Administration, which lists first names along with the number and sex of babies they were given to in each year. For processing speed purposes, we've limited the dataset to first names which were given to over 5,000 American babies in a given year. Our data spans 101 years, from 1920 through 2020.
![image](https://user-images.githubusercontent.com/118057504/221827536-0d20bc03-dbb0-4776-8c2e-0ba316ade422.png)


### Task 1: Instructions
Find names that have been given to over 5,000 babies of either sex every year for the 101 years from 1920 through 2020; recall that names only show up in our dataset when at least 5,000 babies have been given that name in a year.

 - Select first_name and the total number of babies that have ever been given that name.
 - Group by first_name and filter for those names that appear in all 101 years.
 - Order the results by the total number of babies that have ever been given that name, descending.
 - Use HAVING instead of WHERE to filter based on the results of aggregating functions such as AVG() or COUNT().
```
SELECT first_name, SUM(num)
FROM baby_names
GROUP BY first_name
HAVING COUNT(year) = 101
ORDER BY SUM(num) DESC;
```
![image](https://user-images.githubusercontent.com/118057504/221828749-b69824ee-6330-4d56-a888-3170cabfb64f.png)

## 2. Timeless or trendy?
Wow, it looks like there are a lot of timeless traditionally male names! Elizabeth is holding her own for the female names, too.

Now, let's broaden our understanding of the dataset by looking at all names. We'll attempt to capture the type of popularity that each name in the dataset enjoyed. Was the name classic and popular across many years or trendy, only popular for a few years? Let's find out.
### Task 2: Instructions
Classify each name's popularity according to the number of years that the name appears in the dataset.

 - Select first_name, the sum of babies who've ever been given that name, and popularity_type.
 - Classify all names in the dataset as 'Classic,' 'Semi-classic,' 'Semi-trendy,' or 'Trendy' based on whether the name appears in the dataset more than 80, 50, 20, or 0 times, respectively.
 - Alias the new classification column as popularity_type.
 - Order the results alphabetically by first_name.

```
SELECT first_name,
SUM(num),
CASE WHEN COUNT(year) >80 THEN 'Classic'
WHEN COUNT(year) >50 THEN 'Semi-classic'
WHEN COUNT(year) >20 THEN 'Semi-trendy'
 ELSE 'Trendy'  END AS popularity_type
FROM baby_names
GROUP BY first_name
ORDER BY first_name;
```
![image](https://user-images.githubusercontent.com/118057504/221829151-dc91af27-a8b5-4552-aaec-b499c80f41ad.png)

## 3. Top-ranked female names since 1920
Did you find your favorite American celebrity's name on the popularity chart? Was it classic or trendy? How do you think the name Henry did? What about Jaxon?

Since we didn't get many traditionally female names in our classic American names search in the first task, let's limit our search to names which were given to female babies.

We can use this opportunity to practice window functions by assigning a rank to female names based on the number of babies that have ever been given that name. What are the top-ranked female names since 1920?
### Task 3: Instructions
Let's take a look at the ten highest-ranked American female names in our dataset.

 - Select name_rank, first_name, and the sum of babies who've ever had that name.
 - RANK the first_name by the sum of babies who've ever had that name, aliasing as name_rank and showing the names in descending order by name_rank.
 - Filter the data to include only results where sex equals 'F'.
 - Limit to ten results.

```
SELECT RANK() OVER(ORDER BY SUM(num) DESC) AS name_rank,
first_name,
SUM(num)
FROM baby_names
WHERE sex = 'F'
GROUP BY first_name
LIMIT 10;
```
![image](https://user-images.githubusercontent.com/118057504/221829855-6c9b374e-778a-45af-92d4-1e88ff95df05.png)

## 4. Picking a baby name
Perhaps a friend has heard of our work analyzing baby names and would like help choosing a name for her baby, a girl. She doesn't like any of the top-ranked names we found in the previous task.

She's set on a traditionally female name ending in the letter 'a' since she's heard that vowels in baby names are trendy. She's also looking for a name that has been popular in the years since 2015.

Let's see what we can do to find some options for this friend!
### Task 4: Instructions
Return a list of first names which meet this friend's baby name criteria.

 - Select only the first_name column.
 - Filter the data for results where sex equals 'F', the year is greater than 2015, and the first_name ends in an 'a.'
 - Group the data by first_name and order by the total number of babies ever given that first_name, descending.

```
SELECT first_name
FROM baby_names
WHERE sex = 'F' AND year > 2015 AND first_name LIKE '%a'
GROUP BY first_name
ORDER BY SUM(num) DESC;
```
![image](https://user-images.githubusercontent.com/118057504/221830169-3a181f29-f322-41e5-83fb-db98b82f359d.png)

## 5. The Olivia expansion
Based on the results in the previous task, we can see that Olivia is the most popular female name ending in 'A' since 2015. When did the name Olivia become so popular?

Let's explore the rise of the name Olivia with the help of a window function.
### Task 5: Instructions
Find the cumulative number of babies named Olivia over the years since the name first appeared in our dataset.

 - Select year, first_name, num of Olivias in that year, and cumulative_olivias.
 - Using a window function, sum the cumulative number of babies who have ever been named Olivia up to that year; alias as cumulative_olivias.
 - Filter the results so that only data for the name Olivia is returned.
 - Order the results by year from the earliest year Olivia appeared in the dataset to the most recent.

```
SELECT year, first_name,
num,
SUM(num) OVER(ORDER BY year ASC) AS cumulative_olivias
FROM baby_names
WHERE first_name = 'Olivia'
GROUP BY year, first_name, num
ORDER BY year;
```
![image](https://user-images.githubusercontent.com/118057504/221830623-f1bc78e5-fc94-42b1-882b-167df1005306.png)

## 6. Many males with the same name
Wow, Olivia has had a meteoric rise! Let's take a look at traditionally male names now. We saw in the first task that there are nine traditionally male names given to at least 5,000 babies every single year in our 101-year dataset! Those names are classics, but showing up in the dataset every year doesn't necessarily mean that the timeless names were the most popular. Let's explore popular male names a little further.

In the next two tasks, we will build up to listing every year along with the most popular male name in that year. This presents a common problem: how do we find the greatest X in a group? Or, in the context of this problem, how do we find the male name given to the highest number of babies in a year?

In SQL, one approach is to use a subquery. We can first write a query that selects the year and the maximum num of babies given any single male name in that year. For example, in 1989, the male name given to the highest number of babies was given to 65,339 babies. We'll write this query in this task. In the next task, we can use the code from this task as a subquery to look up the first_name that was given to 65,339 babies in 1989… as well as the top male first name for all other years!
### Task 6: Instructions
Write a query that selects the year and the maximum num of babies given any male name in that year.

 - Select the year and the maximum num of babies given any one male name in that year; alias the maximum as max_num.
 - Filter the data to include only results where sex equals 'M'.

```
SELECT year, MAX(num) AS max_num
FROM baby_names
WHERE sex = 'M'
GROUP BY year;
```
![image](https://user-images.githubusercontent.com/118057504/221830999-b03440b7-0ee5-4bcb-86bc-e0d0cd0b5370.png)

## 7. Top male names over the years
In the previous task, we found the maximum number of babies given any one male name in each year. Incredibly, the most popular name each year varied from being given to less than 20,000 babies to being given to more than 90,000!

In this task, we find out what that top male name is for each year in our dataset.
### Task 7: Instructions
Using the previous task's code as a subquery, look up the first_name that corresponds to the maximum number of babies given a specific male name in a year.

 - Select year, the first_name given to the largest number of male babies, and num of babies given the first_name that year.
 - Join baby_names to the code in the last task as a subquery, using whatever alias you like and joining on both columns in the subquery (Use an INNER JOIN so that only the first_name given to listed number of babies is returned for each year.

).
 - Order the results by year, starting with the most recent year.

```
SELECT b.year, first_name, num
FROM baby_names AS b
INNER JOIN(SELECT year, MAX(num) AS max_num
FROM baby_names
WHERE sex = 'M'
GROUP BY year) AS sub
ON b.year = sub.year AND b.num = sub.max_num
ORDER BY year DESC;
```
![image](https://user-images.githubusercontent.com/118057504/221832334-592645fc-d993-4a8a-9ad8-906388c98821.png)

## 8. The most years at number one
Noah and Liam have ruled the roost in the last few years, but if we scroll down in the results, it looks like Michael and Jacob have also spent a good number of years as the top name! Which name has been number one for the largest number of years? Let's use a common table expression to find out.
### Task 8: Instructions
Return a list of first names that have been the top male first name in any year along with a count of the number of years that name has been the top name.

 - Select first_name and a count of the number of years that the first_name appeared as a year's top name in the last task; alias this count as count_top_name.
 - To do this, use the code from the previous task as a common table expression.
 - Group by first_name and order the results from the name with the most years at the top to the name with the fewest.

```
WITH cte AS(SELECT b.year, first_name, num
FROM baby_names AS b
INNER JOIN(SELECT year, MAX(num) AS max_num
FROM baby_names
WHERE sex = 'M'
GROUP BY year) AS sub
ON b.year = sub.year AND b.num = sub.max_num
ORDER BY year DESC)
SELECT first_name, COUNT(year) AS count_top_name
FROM cte
GROUP BY first_name
ORDER BY count_top_name DESC;
```
![image](https://user-images.githubusercontent.com/118057504/221832234-1defbf90-f7f7-4305-b7be-4d2aaa9d3d65.png)

