# Analyze International Debt Statistics



<!-- https://app.datacamp.com/learn/projects/754 -->

## Project Description
It's not that we humans only take debts to manage our necessities. A country may also take debt to manage its economy. For example, infrastructure spending is one costly ingredient required for a country's citizens to lead comfortable lives. The World Bank is the organization that provides debt to countries.

In this project, you are going to analyze international debt data collected by The World Bank. The dataset contains information about the amount of debt (in USD) owed by developing countries across several categories. You are going to find the answers to questions like:

What is the total amount of debt that is owed by the countries listed in the dataset?
Which country owns the maximum amount of debt and what does that amount look like?
What is the average amount of debt owed by countries across different debt indicators?
The data used in this project is provided by The World Bank. It contains both national and regional debt statistics for several countries across the globe as recorded from 1970 to 2015.
 https://www.worldbank.org/en/home

## Project Tasks
1. The World Bank's international debt data
2. Finding the number of distinct countries
3. Finding out the distinct debt indicators
4. Totaling the amount of debt owed by the countries
5. Country with the highest debt
6. Average amount of debt across indicators
7. The highest amount of principal repayments
8. The most common debt indicator
9. Other viable debt issues and conclusion

### 1. The World Bank's international debt data
It's not that we humans only take debts to manage our necessities. A country may also take debt to manage its economy. For example, infrastructure spending is one costly ingredient required for a country's citizens to lead comfortable lives. The World Bank is the organization that provides debt to countries.

In this notebook, we are going to analyze international debt data collected by The World Bank. The dataset contains information about the amount of debt (in USD) owed by developing countries across several categories. We are going to find the answers to questions like:

What is the total amount of debt that is owed by the countries listed in the dataset?
Which country owns the maximum amount of debt and what does that amount look like?
What is the average amount of debt owed by countries across different debt indicators?

The first line of code connects us to the international_debt database where the table international_debt is residing. Let's first SELECT all of the columns from the international_debt table. Also, we'll limit the output to the first ten rows to keep the output clean.

```
%%sql
postgresql:///international_debt

    SELECT *
FROM international_debt
LIMIT 10;    
```
![image](https://user-images.githubusercontent.com/118057504/218063561-2f1ea40a-1806-4634-b341-fd74841aa800.png)

### 2. Finding the number of distinct countries
From the first ten rows, we can see the amount of debt owed by Afghanistan in the different debt indicators. But we do not know the number of different countries we have on the table. There are repetitions in the country names because a country is most likely to have debt in more than one debt indicator.

Without a count of unique countries, we will not be able to perform our statistical analyses holistically. In this section, we are going to extract the number of unique countries present in the table.

Task 2: Instructions
Find the number of distinct countries.

Use the DISTINCT clause and the COUNT() function in pair on the country_name column.
Alias the resulting column as total_distinct_countries.

```
SELECT COUNT(DISTINCT country_name)
     AS total_distinct_countries
FROM international_debt;
```

![image](https://user-images.githubusercontent.com/118057504/218065398-284809c3-96da-40ce-b80b-fb573643689d.png)

### 3. Finding out the distinct debt indicators
We can see there are a total of 124 countries present on the table. As we saw in the first section, there is a column called indicator_name that briefly specifies the purpose of taking the debt. Just beside that column, there is another column called indicator_code which symbolizes the category of these debts. Knowing about these various debt indicators will help us to understand the areas in which a country can possibly be indebted to.

Task 3: Instructions
Extract the unique debt indicators in the table.

Use the DISTINCT clause on the indicator_code column.
Alias the resulting column as distinct_debt_indicators.
Order the results by distinct_debt_indicators

```
SELECT DISTINCT indicator_code
AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators;
```
![image](https://user-images.githubusercontent.com/118057504/218067426-7b978b4e-a948-4761-9569-40fc94c38864.png)

### 4. Totaling the amount of debt owed by the countries
As mentioned earlier, the financial debt of a particular country represents its economic state. But if we were to project this on an overall global scale, how will we approach it?

Let's switch gears from the debt indicators now and find out the total amount of debt (in USD) that is owed by the different countries. This will give us a sense of how the overall economy of the entire world is holding up.

Task 4: Instructions
Find out the total amount of debt as reflected in the table.

Use the built-in SUM function on the debt column, then divide it by 1000000 and round the result to 2 decimal places so that the output is fathomable.
Alias the resulting column as total_debt.

```
SELECT ROUND(SUM(debt)/1000000, 2) AS total_debt
FROM international_debt; 

```
![image](https://user-images.githubusercontent.com/118057504/218083659-fa39869b-bd84-408b-8d79-01b9bb9cdab8.png)

### 5. Country with the highest debt
"Human beings cannot comprehend very large or very small numbers. It would be useful for us to acknowledge that fact." - Daniel Kahneman. That is more than 3 million million USD, an amount which is really hard for us to fathom.

Now that we have the exact total of the amounts of debt owed by several countries, let's now find out the country that owns the highest amount of debt along with the amount. Note that this debt is the sum of different debts owed by a country across several categories. This will help to understand more about the country in terms of its socio-economic scenarios. We can also find out the category in which the country owns its highest debt. But we will leave that for now.

Task 5: Instructions
Find out the country owing to the highest debt.

Select the country_name and debt columns, then apply the SUM function on the debt column.
Alias the column resulted from the summation as total_debt.
GROUP the results BY country_name and ORDER them BY the new alias total_debt in a descending manner.
LIMIT the number of rows to be one.

```
SELECT country_name, 
    SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;
```
![image](https://user-images.githubusercontent.com/118057504/218083871-53f0c6dd-3e08-4f75-bf65-65862c13975e.png)


### 6. Average amount of debt across indicators
So, it was China. A more in-depth breakdown of China's debts can be found here.

We now have a brief overview of the dataset and a few of its summary statistics. We already have an idea of the different debt indicators in which the countries owe their debts. We can dig even further to find out on an average how much debt a country owes? This will give us a better sense of the distribution of the amount of debt across different indicators.

Task 6: Instructions
Determine the average amount of debt owed across the categories.

Select indicator_code aliased as debt_indicator, then select indicator_name and debt.
Apply an aggregate function on the debt column to average out its values and alias it as average_debt.
Group the results by the newly created debt_indicator and already present indicator_name columns.
Sort the output with respect to the average_debt column in a descending manner and limit the results to ten.

```
SELECT indicator_code AS debt_indicator,
    indicator_name, AVG(debt) AS average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt DESC
LIMIT 10;
```
![image](https://user-images.githubusercontent.com/118057504/218084073-79f4a5e6-5076-4caf-b660-fbc8b1f2d6f8.png)

### 7. The highest amount of principal repayments
We can see that the indicator DT.AMT.DLXF.CD tops the chart of average debt. This category includes repayment of long term debts. Countries take on long-term debt to acquire immediate capital. More information about this category can be found here.

An interesting observation in the above finding is that there is a huge difference in the amounts of the indicators after the second one. This indicates that the first two indicators might be the most severe categories in which the countries owe their debts.

We can investigate this a bit more so as to find out which country owes the highest amount of debt in the category of long term debts (DT.AMT.DLXF.CD). Since not all the countries suffer from the same kind of economic disturbances, this finding will allow us to understand that particular country's economic condition a bit more specifically.

Task 7: Instructions
Find out the country with the highest amount of principal repayments.

Select the country_name and indicator_name columns.
Add a WHERE clause to filter out the maximum debt in DT.AMT.DLXF.CD category.

```
SELECT country_name,
    indicator_name  
FROM international_debt
WHERE debt = (SELECT MAX(debt)
        FROM international_debt
        WHERE indicator_code = 'DT.AMT.DLXF.CD');
```
![image](https://user-images.githubusercontent.com/118057504/218084312-7b461264-5543-4fa6-a400-d2840dbaaebe.png)


### 8. The most common debt indicator
China has the highest amount of debt in the long-term debt (DT.AMT.DLXF.CD) category. This is verified by The World Bank. It is often a good idea to verify our analyses like this since it validates that our investigations are correct.

We saw that long-term debt is the topmost category when it comes to the average amount of debt. But is it the most common indicator in which the countries owe their debt? Let's find that out.

Task 8: Instructions
Find out the debt indicator that appears most frequently.

Select the indicator_code column, then separately apply an aggregate function to count its values. Alias the column resulting from the counting as indicator_count.
Group the results by indicator_code and order them first by the newly created indicator_count column then the indicator_code column, both in a descending manner.
Limit the resulting number of rows to 20.

```
SELECT 
indicator_code, 
COUNT(indicator_code) AS indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC
LIMIT 20;
```
![image](https://user-images.githubusercontent.com/118057504/218084595-2b54a9cd-769c-42f8-995e-d17022a3b138.png)

### 9. Other viable debt issues and conclusion
There are a total of six debt indicators in which all the countries listed in our dataset have taken debt. The indicator DT.AMT.DLXF.CD is also there in the list. So, this gives us a clue that all these countries are suffering from a common economic issue. But that is not the end of the story, but just a part of the story.

Let's change tracks from debt_indicators now and focus on the amount of debt again. Let's find out the maximum amount of debt that each country has. With this, we will be in a position to identify the other plausible economic issues a country might be going through.

In this notebook, we took a look at debt owed by countries across the globe. We extracted a few summary statistics from the data and unraveled some interesting facts and figures. We also validated our findings to make sure the investigations are correct.

Task 9: Instructions
Get the maximum amount of debt that each country owes.

Select the country_name and apply an aggregate function to take the maximum of debt. Alias the aggregate column as maximum_debt.
Group the results by country_name.
Order the results by maximum_debt in descending order.
Limit the output to 10 rows.
```
SELECT country_name, MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10;
```
![image](https://user-images.githubusercontent.com/118057504/218084747-297521c6-2c3e-4f02-b37b-803117e9f844.png)


