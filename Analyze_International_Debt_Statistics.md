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



