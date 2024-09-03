create schema cars;
use cars;

select * from cardekho;

select count(*) from cardekho;

# How Many cars will be available in year 2023?
select count(*) from cardekho
where year=2023;

# How Many cars will be available in year 2020, 2021, 2022?
select year,count(*) from cardekho
where year in (2020,2021,2022) group by year;  #88

#Print the total of all cars by year



select year,count(*) as Total_Cars from cardekho
group by year
order by Total_Cars DESC ;

#How many diesel cars will be there in 2020?

select count(*) as DieselCarsin2020 from cardekho
where fuel="Diesel" and year=2020;

#How many petrol cars will be there in 2020?
select count(*) as PetrolCarsin2020 from cardekho
where fuel="Petrol" and year=2020;

#Print all fuel cars by every year

Delimiter //
Create procedure get_yearly_cars(in pfuel varchar(20))
Begin
select year,count(*) as totalcars from cardekho
where fuel=pfuel
group by year
order by totalcars;
END //
Delimiter ;

call get_yearly_cars("Diesel");
call get_yearly_cars("Petrol");
call get_yearly_cars("CNG");

#Which year had more than 100 cars?

select year,count(*) as totalcars from cardekho
group by year
having totalcars>100
order by totalcars desc;

#Which year had less than 100 cars?

select year,count(*) as totalcars from cardekho
group by year
having totalcars<100
order by totalcars desc;

#All cars count details between 2015 and 2023

select count(*) from cardekho where
year between 2015 and 2023
order by year;


#Average Selling Price of cars by year
Select year,avg(selling_price) as AvgSelling from cardekho
group by year
order by AvgSelling desc;

select * from cardekho;


#Analyze the relationship between kilometers driven and the selling price of cars.

select 
CASE
WHEN km_driven<20000 THEN 'Low Mileage'
WHEN km_driven BETWEEN 20000 AND 100000 THEN 'Medium Mileage'
Else 'High Mileage'
END AS mileage_category,
AVG(selling_price) as avg_selling_price
from cardekho
group by mileage_category;

# Compare the average selling price of cars with different fuel types (e.g., Petrol, Diesel).

Delimiter //
Create procedure get_avgselling(in pfuel varchar(20))
Begin
select year,avg(selling_price)as AvgSellingPrice from cardekho
where fuel=pfuel
group by year
order by AvgsellingPrice;
END //
Delimiter ;
drop procedure get_avgselling;

call get_avgselling("Diesel");
call get_avgselling("Petrol");
call get_avgselling("CNG");

-- Determine which seller type (Dealer, Individual, etc.) results in the 
-- highest average selling price.(TOP 3)
select seller_type,avg(selling_price) as AvgSelling
from cardekho 
group by seller_type
order by AvgSelling desc
limit 3;

#Determine whether cars owned by the first, second, or 
#mo owners have the highest average selling price.

