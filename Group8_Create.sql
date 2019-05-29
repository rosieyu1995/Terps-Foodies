USE BUDT758_DB_0502_08;

CREATE TABLE [Restaurant] (
	restaurantID VARCHAR(10) NOT NULL,
	restaurantName VARCHAR(MAX),
	priceRange VARCHAR(10),
	monday VARCHAR(40),
	tuesday VARCHAR(40),
	wednesday VARCHAR(40),
	thursday VARCHAR(40),
	friday VARCHAR(40),
	saturday VARCHAR(40),
	sunday VARCHAR(40),
	phoneNumber CHAR(10),
	reviewCount NUMERIC,
	websiteURL VARCHAR(MAX),
	avgRating NUMERIC,
	is_Group VARCHAR(5),
	CONSTRAINT pk_Restaurant_restaurantID PRIMARY KEY (restaurantID))
CREATE TABLE [Location] (
	restaurantID VARCHAR(10) NOT NULL,
	address VARCHAR (100),
	city VARCHAR(20),
	zipcode CHAR(5),
	CONSTRAINT pk_Location_restaurantID_address PRIMARY KEY (restaurantID, address),
	CONSTRAINT fk_Location_restaurantID FOREIGN KEY (restaurantID)
	REFERENCES [Restaurant] (restaurantID))
CREATE TABLE [Category] (
	categoryID VARCHAR(10) NOT NULL,
	categoryName VARCHAR(40),
	CONSTRAINT pk_Category_categoryID PRIMARY KEY(categoryID));
CREATE TABLE [Classify] (
   	restaurantID VARCHAR(10) NOT NULL,
   	categoryID VARCHAR(10) NOT NULL,
    CONSTRAINT pk_Classify_restaurantID_categoryID PRIMARY KEY (restaurantID, categoryID),
   	CONSTRAINT fk_Classify_restaurantID FOREIGN KEY (restaurantID)
          	REFERENCES [Restaurant] (restaurantID),
   	CONSTRAINT fk_Classify_categoryID FOREIGN KEY (categoryID)
          	REFERENCES [Category] (categoryID)
          	ON DELETE NO ACTION ON UPDATE NO ACTION );
CREATE TABLE [Reviewer] (
   	reviewerID VARCHAR(10) NOT NULL,
   	firstName VARCHAR(20),
   	lastName VARCHAR(20),
   	registrationYear NUMERIC,
   	CONSTRAINT pk_Reviewer_reviewerID PRIMARY KEY (reviewerID));
CREATE TABLE [Review] (
   	reviewID VARCHAR(10) NOT NULL,
   	restaurantID VARCHAR(10) NOT NULL,
   	reviewerID VARCHAR(10) NOT NULL,
   	rating NUMERIC,
   	text VARCHAR(MAX),
   	reviewDate DATE,
   	CONSTRAINT pk_Review_reviewID PRIMARY KEY (reviewID),
   	CONSTRAINT fk_Review_restaurantID FOREIGN KEY (restaurantID)
          	REFERENCES [Restaurant] (restaurantID)
	ON DELETE CASCADE ON UPDATE NO ACTION,
   	CONSTRAINT fk_Review_reviewerID FOREIGN KEY (reviewerID)
          	REFERENCES [Reviewer] (reviewerID)
	ON DELETE CASCADE ON UPDATE NO ACTION);


DROP TABLE [Review];
DROP TABLE [Reviewer];
DROP TABLE [Classify];
DROP TABLE [Category];
DROP TABLE [Location];
DROP TABLE [Restaurant];
