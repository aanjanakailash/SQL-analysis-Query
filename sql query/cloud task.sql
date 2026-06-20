use sales_project;
select *from products;
#Write SELECT with COUNT, DISTINCT on all 4 tables
select cast(
		concat(
				"toatl unique orders:",(select count(distinct order_id) from mainsales2),char(10),
                 "total unique customers:",(select count(distinct customer_id) from customers ),char (10),
                 "total unique products:",(select count(distinct product_id) from products),char(10),
                 "Total unique city:",(select count(distinct city)from city_sales),char(10)
             )as char
        ) as total_unique_result;     
 #JOIN mainsales2 with customers on customer_id
 select *from mainsales2 ms join customers c on ms.customer_id=c.customer_id;
 #JOIN with products to get product names + sales amount
 select p.product_name,sum(ms.total_sales) from mainsales2 ms join products p on ms.product_id=p.product_id group by p.product_name ;
 #JOIN with city to get city-wise sales breakdown
select city ,sum(total_sales ),sum(profit), avg(discount_percent)  from mainsales2  group by city; 
#Find top 5 cities by total revenue using GROUP BY + ORDER BY
select city ,sum(profit)from mainsales2 group by city order by sum(profit) desc limit 5; 
#Total sales per product category using GROUP BY
select p.product_category ,sum(ms.total_sales) from mainsales2  ms join products p on ms.product_id=p.product_id group by p.product_category;
#Monthly sales trend using MONTH() / DATE_TRUNC
select date_format(order_date,"%M") ,sum(total_sales) from mainsales2 group by date_format(order_date,"%M") order by date_format(order_date,"%M")  ;
 #Rank customers by purchase value using RANK() OVER()
 select c.customer_name ,sum(ms.total_sales) ,rank() over(order by sum(ms.total_sales)desc) from mainsales2 
 ms join customers c on c.customer_id=ms.customer_id group by c.customer_name;
 #Find products with sales below average using subquery
 select p.product_name ,ms.total_sales from mainsales2 ms join products p on p.product_id=ms.product_id where ms.total_sales<
 ( select avg(ms.total_sales) from mainsales2 ms join products p on p.product_id=ms.product_id);
 
 
 #__________________________________________all opratores____________________________________________________________
 #Find all sales where total sales is between  5000. to 6k
 select order_id,total_sales from mainsales2 where total_sales  between  5000 and 6000;
 #IN
select count(customer_id),state from customers 
where state in ("Rajasthan" ,"Punjab")
group by state;
 select c.state,sum(ms.total_sales)
 from mainsales2 ms join customers c 
 on c.customer_id=ms.customer_id group by c.state 
 order by sum(ms.total_sales) 
 desc limit 3;
 #Find the total number of customers in each state, but show only states having more than 50 customers
 select count(customer_id),state from customers group by state having count(customer_id)>50;
 #Find how many customers belong to Rajasthan, Gujarat, and Punjab separately.
 select count(customer_id),state from customers where state in ("Rajasthan" ,"Gujarat","Bihar") group by state;
 #find total sales by each product 
 select p.product_name ,sum(ms.total_sales) as total_sales  
 from mainsales2 ms join products p on p.product_id=ms.product_id
 group by p.product_name  
 order by sum(ms.total_sales) desc limit 3; 
 
 #________________________CASE Statement ____________________________________
 select c.customer_name ,ms.total_sales ,
 CASE
		when ms.total_sales>100000 then "High sales "
        when ms.total_sales>50000 then "medium sales "
        when ms.total_sales>10000 then "low sales  "
        
        
 end as category
 from mainsales2 ms  join customers c on c.customer_id=ms.customer_id ;
 use sales_project;
 select *from mainsales2 order by discount_percent desc;
 
 #profit stutas
 select region ,sum(profit),
case 
		when sum(ms.profit)>100000 then "High profit"
        when sum(ms.profit)>50000 then "medium profit"
        when sum(ms.profit)>10000 then "low profit"
        when sum(ms.profit)>0 then "very less Profit"
        when sum(ms.profit)<0 then "Loss"
 end as profit_stutas  from mainsales2  ms  group by region;
 SELECT
    Region,
    SUM(Profit) AS Total_Profit,
    CASE
        WHEN SUM(Profit) >= 50000 THEN 'High Profit'
        WHEN SUM(Profit) >= 20000 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS Profit_Category
FROM mainsales2
GROUP BY Region;
select city,avg(Discount_percent),sum(profit) ,
case
		when avg(Discount_percent)>=10 then " very high dicount"
        when avg(Discount_percent)>=5 then "high dicount"
        when avg(Discount_percent)>=2 then "medium  dicount"
        else "low discount"
 end as discount_ctgy
 from mainsales2 group by city;
 select avg(total_sales) from mainsales2;
 #sub quries 
 select order_id ,total_sales from mainsales2 
 where total_sales>(select sum(total_sales)/count(order_id) from mainsales2 )
 order by total_sales desc;
 #Find customers whose sales are higher than the average sales of their own city.
SELECT
    c.customer_name,
    ms.total_sales,
    ms.city
FROM mainsales2 ms
JOIN customers c
    ON c.customer_id = ms.customer_id
WHERE ms.total_sales >
(
    SELECT AVG(m2.total_sales)
    FROM mainsales2 m2
    WHERE m2.city = ms.city
);

#Create a CTE that calculates total sales per customer.
#From that CTE, show only customers with sales > 200000.
with salesCTE as (
			select c.customer_name,sum(ms.total_sales) from mainsales2 ms
            join customers c on c.customer_id=ms.customer_id 
            group by c.customer_name having sum(ms.total_sales)>200000      
           )
            select *from salescte ;
            
            
 #Using CTE, find the top 10 customers by profit.
 with toptenCTE as (
			select c.customer_name ,sum(ms.total_Sales) from mainsales2 ms join customers c 
            on c.customer_id=ms.customer_id 
            group by c.customer_name order by sum(ms.total_sales) desc limit 10
            )
            select  *from toptenCTE;
use sales_project; 
#Rank customers based on Total Sales.  
select c.customer_name ,sum(ms.total_Sales), dense_rank () over( order by sum(ms.total_Sales)) 
from mainsales2 ms join customers c 
            on c.customer_id=ms.customer_id
            group by c.customer_name;
            
        
 
 