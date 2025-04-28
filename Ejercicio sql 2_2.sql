-- EJERCICIO 1 --
select c.category_name , p.product_name , p.unit_price , avg(p.unit_price )
over (partition by c.category_id order by c.category_name ) as Promedio_Category
from products p
join categories c 
on p.category_id  = c.category_id


-- EJERCICIO 2 --
select
avg(od.unit_price * od.quantity) over (partition by c.customer_id) as Avg_Vt_Cliente 
, o.order_id,  c.customer_id,  e.employee_id ,o.order_date,o.required_date , o.shipped_date   
from
  Customers c
join
  Orders o on c.customer_id = o.customer_id
join
  Order_Details od on o.order_id = od.order_id
join
  Employees e on

-- EJERCICIO 3 --
select p.product_name , c.category_name, p.quantity_per_unit , od.unit_price 
, avg(od.quantity) over (partition by p.category_id) as avg_quantity
from products p
join order_details od  on p.product_id  = od.product_id 
join categories c on p.category_id =c.category_id
order by c.category_name , p.product_name asc

-- EJERCICIO 4 --
select c.customer_id , o.order_date , 
min(o.order_date) over (partition by c.customer_id) as earlistordate
from customers c 
join orders o on c.customer_id =o.customer_id

-- EJERCICIO 5 --
select p.product_id , p.product_name, p.unit_price, p.category_id, 
max(p.unit_price) over (partition by p.category_id) as Max_Price
from products p

-- EJERCICIO 6 -- Consulta Fede
select
  row_number() over (order by total_quantity desc) as Ranking,
  product_name,
  total_quantity
from (
  select
    p.product_name,
    sum(od.quantity) as total_quantity
  from products p
  join order_details od on p.product_id = od.product_id
  group by p.product_name
) as resumen
order by total_quantity desc

-- EJERCICIO 7 -- Consulta Fede
select
row_number() over (order by c.customer_id ) as rownumber,
c.customer_id , c.company_name , c.contact_name , c.contact_title, c.address
from customers c 


-- EJERCICIO 8 --
select  rank() over(order by e.birth_date desc) as Ranking ,
e.first_name|| ' ' || e.last_name , e.birth_date
from employees e 

-- EJERCICIO 9 --
select 
sum(od.unit_price * od.quantity) over (partition by c.customer_id order by c.customer_id) as SumOrderAmount ,
o.order_id , c.customer_id , e.employee_id , o.order_date, o.required_date
from customers c
join orders o  on c.customer_id = o.customer_id 
join order_details od  on o.order_id = od.order_id 
join employees e on o.employee_id= e.employee_id

-- EJERCICIO 10 --
select c.category_name , p.product_name , od.unit_price , od.quantity , 
sum (od.unit_price * od.quantity  ) over (partition by c.category_name ) as TotalSales 
from order_details od 
join products p   on p.product_id = od.product_id
join categories c   on p.category_id = c.category_id
order by c.category_name 

-- EJERCICIO 11 --
select o.ship_country , o.order_id , o.shipped_date , o.freight,  
sum (o.freight) over (partition by o.ship_country) as TotalShippingCost
from orders o 
where o.shipped_date is not null
order by o.ship_country  , o.shipped_date 


--EJERCICIO 12 -- 
select 
  c.customer_id,
  c.company_name,
  sum(od.unit_price * od.quantity)  as TotalSales,
  rank() over (order by sum(od.unit_price * od.quantity ) desc ) as Ranking
from customers c
join orders o ON c.customer_id = o.customer_id 
join order_details od ON o.order_id = od.order_id 
group by c.customer_id , c.company_name 

-- EJERCICIO 13 --
select e.employee_id , e.first_name , e.last_name, e.hire_date,
rank() over (order by e.hire_date asc) as Rank
from employees e 

-- EJERCICIO 14 --
select p.product_id , p.product_name  , p.unit_price,
rank () over (order by p.unit_price desc) as Rank
from products p 

-- EJERCICIO 15 -- 
select od.order_id , p.product_id , od.quantity ,
lag(od.quantity  ) over (partition by p.product_id ) as PrevQuantity
from products p 
inner join order_details od  on p.product_id = od.product_id
order by od.order_id , p.product_id asc

-- EJERCICIO 16 --
select o.order_id , o.order_date , c.customer_id ,
lag(o.order_date) over (partition by c.customer_id order by o.order_date) as LatsOrderDate
from customers c  
join orders o on c.customer_id = o.customer_id
order by c.customer_id , o.order_id asc

-- EJERCICIO 17 --
select p.product_id , p.product_name , p.unit_price ,
lag(p.unit_price) over (order by p.product_id) as LasUnitPrice,
p.unit_price - (lag(p.unit_price) over (order by p.product_id) ) as PriceDifference
from products p 


-- EJERCICIO 18 --
select p.product_id , p.product_name , p.unit_price ,
lead(p.unit_price) over (order by p.product_id) as NextPrice
from products p 

--EJERCICIO 19 -- NO LO PUDE RESOLVER SOLO CHAT GPT
WITH ventas_por_categoria AS (
    SELECT
        c.category_name,
        SUM(od.unit_price * od.quantity) AS TotalSales
    FROM
        products p
    INNER JOIN
        categories c ON p.category_id = c.category_id
    INNER JOIN
        order_details od ON p.product_id = od.product_id
    GROUP BY
        c.category_name
)
SELECT
    category_name,
    TotalSales,
    LEAD(TotalSales) OVER (ORDER BY category_name) AS NextTotalSales
FROM
    ventas_por_categoria
ORDER BY
    category_name;
