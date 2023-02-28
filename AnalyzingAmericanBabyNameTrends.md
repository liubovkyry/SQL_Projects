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
###
## 6. Many males with the same name
###
## 7. Top male names over the years
###
## 8. The most years at number one
###
