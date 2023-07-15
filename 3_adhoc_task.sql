

----------1. Get the order id alone from the order_Id column-------------
 select substring(order_id,4,14)  as order_id from sales_purchase_data_updated
 ----------2. order_month, should have month of the order date and year_month should have year of the month-----
 select 
 order_date,
 month (order_date)as order_month,
 year (order_date)as order_year
 from sales_purchase_data_updated  ;
 -------------3. Customer id--------
 select substring(customer_id,4,8)  as customer_id from sales_purchase_data_updated
 ----------4. Concatenate Region,Country, city, state as location_info for each records---------
 select concat(region,'_',country,'_',city,'_',state) as location_info from sales_purchase_data_updated 
 ------
 use internship;
 show tables;

 select * from sales_purchase_data
 ---------------------------------------------------------------------------------------------------------------------------------
 ********************     creating a new table    *************************************************************
 DROP TABLE IF EXISTS sales_order_info;
CREATE TABLE Sales_order_info AS
SELECT
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Sales / Quantity AS per_quantity_price,
    super_type,
    Discount,
    Profit,
    Loss
FROM sales_purchase_data;
select *from sales_order_info
    
---------5 a) product id ‎----------
select substring(product_id,5,15) as product_id from sales_order_info 

--------5 b‎) per_quantity_price should be  output of Sales / Quantity of each customer records‎-------
‎select * from sales_order_info
--------5 c)sales_type should be 3 categories ‎---------
select 
product_id,
category,
sub_category,
product_name,
sales,
quantity,
sales/quantity as per_quantity_price,
case 
   when sales>1000 then 'super'
   when sales>400 and sales<1000  then 'average'
   else 'low'
   end as sales_type,
   discount,
   profit,
   loss
from sales_order_info;
select * from sales_order_info
---------5 d) Loss will be 1 if profit is negative----------
select 
product_id,
category,
sub_category,
product_name,
sales,
quantity,
sales/quantity as per_quantity_price,
case 
   when sales>1000 then 'super'
   when sales>400 and sales<1000  then 'average'
   else 'low'
   end as sales_type,
   discount,
   profit,
   case
   when profit < 0 then 1
   else 0
   end as loss
from sales_order_info;

-------------6 Count of distinct order_ids in  sales_purchase_data_updated table----------------------
select count(*) order_id from sales_purchase_data_updated

-----------7.  Count of Unique product names in Sales_order_info ‎--------------------
select count(*) product_names from sales_order_info

----------8. Count of distinct Segments in sales_purchase_data_updated table-------------
select count(*) segments from sales_purchase_data_updated

--------9.Recent order date in  sales_purchase_data_updated table-----
select max(order_date) from  sales_purchase_data_updated 

------10.Old order date in sales_purchase_data_updated table---------
select min(order_date)from sales_purchase_data_updated

-------11.Customer info of all the columns for the maximum order date----------
select *from sales_purchase_data_updated
where order_date = (select max(order_date) from sales_purchase_data_updated);
-------12. No .of Unique Customers from Texas and New york-----------
SELECT
    COUNT(DISTINCT CASE WHEN State = 'Texas' THEN Customer_ID END) AS no_of_customer_texas,
    COUNT(DISTINCT CASE WHEN State = 'New York' THEN Customer_ID END) AS no_of_customer_newyork
FROM sales_purchase_data_updated ;

===============================================================================================================================