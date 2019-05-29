USE BUDT758_DB_0502_08;

CREATE TABLE [Restaurant] (
	restaurantID VARCHAR(10) NOT NULL,
	restaurantName VARCHAR(MAX),
	priceRange VARCHAR(10),
	phoneNumber CHAR(10),
	reviewCount NUMERIC,
	websiteURL VARCHAR(MAX),
	avgRating NUMERIC,
	is_Group VARCHAR(5),
	CONSTRAINT pk_Restaurant_restaurantID PRIMARY KEY (restaurantID))
CREATE TABLE [Day] (
	dayID VARCHAR (10) NOT NULL,
	weekday VARCHAR (20)
	CONSTRAINT pk_Day_dayID PRIMARY KEY (dayID))
CREATE TABLE [Operation] (
	restaurantID VARCHAR(10) NOT NULL,
	dayID VARCHAR(10) NOT NULL,
	openingHour time,
	endingHour time,
	is_Night VARCHAR(10),
	CONSTRAINT pk_operation_restaurantID_dayID PRIMARY KEY (restaurantID, dayID),
	CONSTRAINT fk_operation_restaurantID FOREIGN KEY (restaurantID)
			REFERENCES [Restaurant] (restaurantID)
			ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_operation_dayID FOREIGN KEY (dayID)
			REFERENCES [Day] (dayID)
			ON DELETE NO ACTION ON UPDATE CASCADE)

CREATE TABLE [Location] (
	restaurantID VARCHAR(10) NOT NULL,
	address VARCHAR (100),
	city VARCHAR(20),
	zipcode CHAR(5),
	latitude DECIMAL(9,6),
	longitude DECIMAL(9,6),
	CONSTRAINT pk_Location_restaurantID PRIMARY KEY (restaurantID),
	CONSTRAINT fk_Location_restaurantID FOREIGN KEY (restaurantID)
			REFERENCES [Restaurant] (restaurantID)
			ON DELETE CASCADE ON UPDATE CASCADE)
CREATE TABLE [Category] (
	categoryID VARCHAR(10) NOT NULL,
	categoryName VARCHAR(40),
	CONSTRAINT pk_Category_categoryID PRIMARY KEY(categoryID));
CREATE TABLE [Classify] (
   	restaurantID VARCHAR(10) NOT NULL,
   	categoryID VARCHAR(10) NOT NULL,
    CONSTRAINT pk_Classify_restaurantID_categoryID PRIMARY KEY (restaurantID, categoryID),
   	CONSTRAINT fk_Classify_restaurantID FOREIGN KEY (restaurantID)
          	REFERENCES [Restaurant] (restaurantID)
			ON DELETE NO ACTION ON UPDATE NO ACTION,
   	CONSTRAINT fk_Classify_categoryID FOREIGN KEY (categoryID)
          	REFERENCES [Category] (categoryID)
          	ON DELETE NO ACTION ON UPDATE CASCADE );
CREATE TABLE [Review] (
   	reviewID VARCHAR(10) NOT NULL,
   	restaurantID VARCHAR(10) NOT NULL,
   	text VARCHAR(MAX),
   	CONSTRAINT pk_Review_reviewID PRIMARY KEY (reviewID),
   	CONSTRAINT fk_Review_restaurantID FOREIGN KEY (restaurantID)
          	REFERENCES [Restaurant] (restaurantID)
			ON DELETE CASCADE ON UPDATE NO ACTION);


