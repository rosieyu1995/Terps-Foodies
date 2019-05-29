--What are the overall Top 10 popular restaurants (by #ofreview/score ranking) near UMD?
	CREATE VIEW RestaurantInfo AS
	SELECT *
	FROM Restaurant r, Location l, Classify c, Category cg, Review rv
	WHERE r.restaurantID = l.restaurantID
	AND r.restaurantID = c.restaurantID
	AND r.restaurantID = rv.restaurantID
	AND c.categoryID = cg.categoryID;

	SELECT *
FROM RestaurantInfo ri
	ORDER BY ri.reviewCount DESC
LIMIT 10;
--What are the Top 10  restaurants (by ranking) in different categories?
	SELECT *
	FROM RestaurantInfo ri
	WHERE categoryName = 'xxx'
	ORDER BY ranking DESC
LIMIT 10;

--What are the Top 10 restaurant (by ranking) in different cities?
SELECT TOP 10 r.restaurantName, r.avgRating AS "Ranking", l.city
FROM Restaurant AS r, Location as l
WHERE r.restaurantID = l.restaurantID
ORDER BY ranking DESC;

--What are the Top 10 restaurant (by ranking) within different price range?
SELECT TOP 10 r.*, AVG(rv.ranking) AS ranking, r.priceRange,
FROM Restaurant AS r, Location as l,
WHERE r.restaurantID = l.restaurantID,
GROUP BY r.priceRange,
ORDER BY ranking DESC;

--What are the Top 10 restaurant (by ranking) in a certain category, city and price range?
SELECT TOP 10 *, AVG(rv.rating) ranking
FROM Restaurant r, Location l, Classify c, Category cg, Review rv
WHERE r.restaurantID = l.restaurantID
AND r.restaurantID = c.restaurantID
AND r.restaurantID = rv.restaurantID
AND c.categoryID = cg.categoryID
AND cg.categoryName = 'xxx'
AND l.city = 'xxx'
AND r.priceRange = 'xxx'
GROUP BY *
ORDER BY ranking DESC;


--What are the Top 10 restaurants (by ranking) at night?
SELECT TOP 10 *, AVG(rv.rating) ranking, TIME_FORMAT(CONVERT(TIME, openingHour), ‘%H %i’) openingHour, TIME_FORMAT(CONVERT(TIME, closingHour), ‘%H %i’) closingHour
FROM Restaurant r, Location l, Classify c, Category cg, Review rv
WHERE r.restaurantID = l.restaurantID
AND r.restaurantID = c.restaurantID
AND r.restaurantID = rv.restaurantID
AND c.categoryID = cg.categoryID
AND EXISTS (SELECT restaurantID, LEFT(Monday, STRPOS(Monday, ‘-') -1 ) openingHour, 
       RIGHT(Monday, LENGTH(Monday) - STRPOS(Monday, ‘-')) closingHour FROM Restaurant)
	AND openingHour > ‘21:00’
	AND closingHour < ‘6:00’
GROUP BY *
	ORDER BY ranking DESC;

--What are people’s comments on selected restaurants?
SELECT r.restaurantId,r.restaurantName,w.text
FROM restaurant r, review w
WHERE r.restauranrID=w.restaurantID AND r.restaurantName=’xxx’;

--What restaurants are opening in certain hours?
SELECT  * 
FROM restaurant r, category c, review w,reviewer rv,l.location
WHERE r.restaurantID = l.restaurantID
AND r.restaurantID = c.restaurantID
AND r.restaurantID = w.restaurantID
AND w.reviewID=rv.reviewID
AND r.Sarurday IN (SELECT  TIME_FORMAT(CONVERT(TIME, openingHour), ‘%H %i’) openingHour, TIME_FORMAT(CONVERT(TIME, closingHour), ‘%H %i’) closingHour
FROM restaurant
WHERE openingHour = ‘21:00’;

--What are the restaurants’ websites for further information and reservation?
SELECT r.websiteURL, 
FROM restaurant r
WHERE r.restaurantID=111;

--What restaurants are suitable for groups of people?
SELECT  *
FROM restaurant r, category c, review w,reviewer rv,l.location
WHERE r.restaurantID = l.restaurantID
AND r.restaurantID = c.restaurantID
AND r.restaurantID = w.restaurantID
AND w.reviewID=rv.reviewID
WHERE r.is_group =’Yes’
ORDER BY r.restaurantName;


