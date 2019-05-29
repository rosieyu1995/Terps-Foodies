USE BUDT758_DB_0502_08;

--What is the ranking of popular restaurants near UMD?
SELECT r.restaurantName, r.reviewCount, ca.categoryName, r.priceRange, r.avgRating, r.websiteURL
FROM Restaurant r, Classify cl, Category ca
WHERE r.restaurantID = cl.restaurantID AND cl.categoryID = ca.categoryID
ORDER BY r.reviewCount DESC;

--What is the ranking of high-rating restaurants near UMD?
SELECT r.restaurantName, r.avgRating, ca.categoryName, r.priceRange
FROM Restaurant r, Classify cl, Category ca
WHERE r.restaurantID = cl.restaurantID AND cl.categoryID = ca.categoryID
ORDER BY r.avgRating DESC;

--What is the ranking of restaurants in different categories?
SELECT r.restaurantName, r.reviewCount, ca.categoryName, r.priceRange, r.avgRating, r.websiteURL
FROM Restaurant r, Classify cl, Category ca
WHERE r.restaurantID = cl.restaurantID AND cl.categoryID = ca.categoryID AND ca.categoryName = 'sushi'
ORDER BY r.avgRating DESC;

--What is the ranking of restaurant in different cities?
SELECT r.restaurantName, r.reviewCount, ca.categoryName, r.priceRange, r.avgRating, r.websiteURL
FROM Restaurant r, Classify cl, Category ca, Location l
WHERE r.restaurantID = cl.restaurantID AND cl.categoryID = ca.categoryID 
AND r.restaurantID = l.restaurantID AND l.city = 'College Park'
ORDER BY r.avgRating DESC;

--What is the ranking of restaurant within different price range?
SELECT r.restaurantName, r.reviewCount, ca.categoryName, r.priceRange, r.avgRating, r.websiteURL
FROM Restaurant r, Classify cl, Category ca
WHERE r.restaurantID = cl.restaurantID AND cl.categoryID = ca.categoryID AND r.priceRange = '$$'
ORDER BY r.avgRating DESC;

--What restaurants are opening in certain hours?
SELECT DISTINCT r.restaurantName, r.reviewCount, ca.categoryName, r.priceRange, r.avgRating, r.websiteURL, o.openingHour 
FROM Restaurant r, Category ca, Classify cl, Day d, Operation o 
WHERE r.restaurantID = cl.restaurantID 
	AND cl.categoryID = ca.categoryID
	AND r.restaurantID = o.restaurantID 
	AND d.dayID = o.dayID
	AND o.openingHour = '10:00';

--What is the ranking of restaurant in a certain category, city, price range and hours?
SELECT DISTINCT r.restaurantName, r.reviewCount, ca.categoryName, r.priceRange, r.avgRating, r.websiteURL, o.openingHour, l.city
FROM Restaurant r, Location l, Category ca, Classify cl, Day d, Operation o 
WHERE r.restaurantID = cl.restaurantID 
	AND cl.categoryID = ca.categoryID
	AND r.restaurantID = o.restaurantID 
	AND d.dayID = o.dayID
	AND ca.categoryName ='seafood'
	AND l.city = 'College Park'
	AND r.priceRange = '$$'
	AND o.openingHour = '10:00';

--What are restaurants that open at night within cities?
SELECT DISTINCT(r.restaurantName), o.is_Night, l.city
FROM Restaurant as r, Location as l, Day as d, Operation as o
WHERE r.restaurantID = l.restaurantID
AND d.dayID = o.dayID 
AND r.restaurantID = o.restaurantID
AND o.is_Night = 'yes';

--What restaurants are suitable for groups of people within cities?
SELECT  r.restaurantName, r.reviewCount, r.is_Group, c.categoryName, r.priceRange, r.avgRating, r.websiteURL
FROM Restaurant r, Category c, Classify cl, Location l, (
	SELECT DISTINCT r.restaurantID 
	FROM Restaurant as r, Category as c, Classify as cl, Location as l
	WHERE r.restaurantID = cl.restaurantID
	AND c.categoryID = cl.categoryID
	AND l.restaurantID = r.restaurantID
	AND r.is_Group = 'Y') AS t1
WHERE r.restaurantID = t1.restaurantID
AND r.restaurantID = cl.restaurantID
AND c.categoryID = cl.categoryID
AND l.restaurantID = r.restaurantID;
