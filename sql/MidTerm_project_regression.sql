# MIDTERM PROJECT REGRESSION - REAL STATE PRICE PREDICTION
# SQL questions - regression

# Q1, Q2, Q3
# Create database,table and import the data
Create database house_price_regression;
use house_price_regression;
create table house_price_data(id char(10), date char(10), bedrooms double, bathrooms double , sqft_living double, sqft_lot double,
floors double, waterfront double, view double, cond double, grade double, sqft_above double, sqft_basement double, yr_built double, yr_renovated double, zipcode double, lat double,
longt double, sqft_living15 double, sqft_lot15 double, price double);

# Q4
# Select all the data and check
select * from house_price_data;

# Q5
# change data type of date
UPDATE house_price_data set date = str_to_date(date, "%m/%d/%Y");
SET SQL_SAFE_UPDATES = 0;

# drop date column
ALTER TABLE house_price_data
DROP COLUMN date;

# check results and limit to 10
select * from house_price_data limit 10;

# Q6
# Use sql query to find how many rows of data you have.
select distinct count(id) from house_price_data;
select * from house_price_data;

# Q7
# find unique values
select distinct bedrooms, bathrooms, floors, cond, grade from house_price_data;

# Q8
# Arrange the data in a decreasing order by the price of the house. 
# Return only the IDs of the top 10 most expensive houses in your data.
SELECT id, price FROM house_price_data ORDER BY price DESC LIMIT 10;

# Q9
# What is the average price of all the properties in your data?
select avg(price) as avg_price from house_price_data;

# Q10
# Group 1
select avg(price), bedrooms as houses_bedrooms from house_price_data group by bedrooms;

# Group 2
select avg(sqft_living15), bedrooms as houses_sqft from house_price_data group by bedrooms;

# Group 3
select avg(price), waterfront as houses_with_waterfront from house_price_data where waterfront = 1;
select avg(price), waterfront as houses_without_waterfront from house_price_data where waterfront = 0;

# Group 4
select avg(cond) , avg(grade) ,
(stddev_samp(cond) * stddev_samp(grade)) as 'Correlation '
from house_price_data;

# Q11
select * from house_price_data 
where(
(bedrooms = 3 or bedrooms = 4) 
and (bathrooms > 3)
and (floors = 1) 
and (waterfront = 0) 
and (cond >= 3)
and (grade >= 5) 
and (price < 300000));

# With those conditions there is not any house available. Instead, removing the number of bedrooms (=3 or/and 4) 
# there are the next options:

select * from house_price_data 
where( 
(bathrooms > 3)
and (floors = 1) 
and (waterfront = 0) 
and (cond >= 3)
and (grade >= 5) 
and (price < 300000));

# Q12
SELECT * FROM house_price_data WHERE price > (SELECT AVG(price) * 2 FROM house_price_data);
# the avg price is 540296.57

# Q13
CREATE VIEW twice_more_avg AS
SELECT * FROM house_price_data WHERE price > (SELECT AVG(price) * 2 FROM house_price_data);

# Q14
#SELECT *  from house_price_data where bedrooms = 3 AS three_bedrooms_price
select distinct round((select avg(price) from house_price_data where bedrooms = 4) - 
(select avg(price) from house_price_data where bedrooms = 3),2) as 'difference' from house_price_data;

# Q15
select distinct zipcode, count(id) from house_price_data group by zipcode;

# Q16
select * from house_price_data 
where(yr_renovated !=0);

# Q17
select * from house_price_data order by price desc limit 10,1;

