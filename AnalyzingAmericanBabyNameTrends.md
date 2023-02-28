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
###
## 4. Picking a baby name
###
## 5. The Olivia expansion
###
## 6. Many males with the same name
###
## 7. Top male names over the years
###
## 8. The most years at number one
###
