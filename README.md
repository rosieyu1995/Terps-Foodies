# Terps-Foodies


## Introduction

This project is to create a system that will demonstrate the ranking of restaurants around University of Maryland and focus on helping people to find out restaurants they like. The system allows users to filter rankings by different types of foods within different price range. Ranking top restaurants based on crawling Yelp datasets.

The database system's ER-Diagram:

![terps_foodies](https://github.com/rosieyu1995/Terps-Foodies/blob/master/Terps%20Foodies.png)

The database system's relational schema:

Restaurant(**restaurantID**, restaurantName, priceRange, phoneNumber, reviewCount, websiteURL, avgRating, is_Group)
Day(**dayID**, weekday)
Operation(**_restaurantID_**, **_dayID_**, openingHour, endingHour, is_Night)
Location(**restaurantID**, address, city, zipcode, latitude, longitude)
Category(**categoryID**, categoryName)
Classify(**_restaurantID_**, **_categoryID_**)
Review(**reviewID**, _restaurantID_, text)


## Objectives

Our system can help users answering their questions as the following:
- What is the ranking of popular restaurants near UMD?
- What is the ranking of high-rating restaurants near UMD?
- What is the ranking of restaurants in different categories?
- What is the ranking of restaurant in different cities?
- What is the ranking of restaurant within different price range?
- What restaurants are opening in certain hours?
- What is the ranking of restaurant in a certain category, city, price range and hours?
- What are restaurants that open at night within different cities?
- What restaurants are suitable for groups of people within different cities?
- What are people’s comments on top 10 restaurants?
- What are the quantiles of restaurants' average ratings in each city near the university?
- How many restaurants does each category have in different cities?
- What is the average rating of each category in different cities?


## Prerequisites

- MS SQL Server Management Studio
- Tableau
- R
- Wordle (WordCloud Generator Application)
Packages in R: 
- rvest
- Yelpr (Interface with Yelp Fusion API)
`install.packages("yelpr")
devtools::install_github("OmaymaS/yelpr")
library(yelpr) `


## Project Participants:

- Ho Huang
- Yaohong Zeng
- Baixue Chen

