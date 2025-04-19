select distinct CATEGORY_NAME from categories c 				-- / EJERCICIO 1 /

select distinct region  from customers							-- / EJERCICIO 2 /

select distinct contact_title from customers					-- / EJERCICIO 3 /

select * from customers c order by c.country 					-- / EJERCICIO 4 /

select * from orders o order by employee_id , o.order_date 		-- / EJERCICIO 5 /

insert into customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax ) values ('RCROS', 'Edvai','Diego Pregot', 'NN', 'Pellegini 3131', 'Rosario', 'Santa Fe', '2000', 'Argentina', '543412296969', '  000  ')  -- / EJERCICIO 6 /

insert into  region  (region_id, region_description) values ('5', 'Northwest')    -- / EJERCICIO 7 /

select * from customers c  where region is null					-- / EJERCICIO 8 /


select contact_name, contact_title, address , city , coalesce(region,'No disponible') as region  from customers c  -- / EJERCICIO 9 /


select product_name, coalesce (unit_price, 10) as unit_price   from products p 						-- / EJERCICIO 10 /

SELECT company_name, contact_name, order_date							-- / EJERCICIO 11 /
FROM orders
INNER JOIN customers
ON orders.customer_ID = customers.customer_ID

select o.order_id , p.product_name , od.discount 				-- / EJERCICIO 12 /
from orders o 
inner join order_details od
on od.order_id = o.order_id  
inner join products p 
on od.product_id =  p.product_id 

select e.employee_id , e.last_name , et.territory_id , t.territory_description			-- / EJERCICIO 13 /
from employees e
left join employee_territories et 
on e.employee_id = et.employee_id
left join territories t 
on et.territory_id = t.territory_id

select o.order_id, c.company_name 			--/ EJERCICIO 14 /
from orders o 
left join customers c 
on o.customer_id = c.customer_id

select o.order_id, c.company_name 			-- / EJERCICIO 15 /
from orders o 
right join customers c 
on o.customer_id = c.customer_id

select sh.company_name , o.order_date		-- / EJERCICIO 16 /
from orders o
right join shippers sh
on o.ship_via  = sh.shipper_id
where o.order_date between ('1996-01-01') and  ('1996-12-31')

select e.first_name , e.last_name , et.territory_id 		-- / EJERCICIO 17 /
from employees e  
full outer join employee_territories et 
on e.employee_id = et.employee_id

select o.order_id , od.unit_price , od.quantity , od.unit_price * od.quantity as Total		-- / EJERCICIO 18 /
from orders o
full outer join order_details od 
on o.order_id = od.order_id

select c.company_name 			-- / EJERCICIO 19 /
from customers c 
union 
select s.company_name
from suppliers s 


select distinct p.product_name , od.product_id     		-- / EJERCICIO 20 /                     // EJERCICIO 21 //
from order_details od
left join products p
on od.product_id = p.product_id
order by od.product_id

select distinct c.company_name    						                                     -- // EJERCICIO 22 //
from orders o
left join customers c 
on o.customer_id  = c.customer_id
where c.country = 'Argentina'

select p.product_name                                                  -- // EJERCICIO 23 //
from products p
where p.product_id  not in (
    select distinct od.product_id 
    from customers  c
    join orders o on c.customer_id = o.customer_id 
    join order_details od on o.order_id  = od.order_id
    where c.country  = 'France'
);

select o.order_id , sum(o.quantity) as Cantidades                      -- // EJERCICIO 24 //
from order_details o
join products p 
on o.product_id = p.product_id
group by o.order_id 

select p.product_name , avg(p.units_in_stock)                        -- // EJERCICIO 25 //
from products p 
group by p.product_name

select p.product_name , sum(p.units_in_stock) as Cantidad          --  // EJERCICIO 26 //
from products p 
group by p.product_name
having sum(p.units_in_stock) > 100

select c.company_name  , avg(o.order_id)                            -- // EJERCICIO 27 //
from customers c 
left join orders o
on c.customer_id  = o.customer_id 
group by c.company_name 
having avg(o.order_id) > 10

select p.product_name ,                                            -- // EJERCICIO 28 //
case
	when p.discontinued = 1 then 'Discontinued'
	when p.discontinued = 0 then c.category_name
end as Category_product
from products p
join categories c 
on p.category_id  = c.category_id

select e.first_name , e.last_name,                                 -- // EJERCICIO 29 //
case
	when e.title = 'Sales Manager' then 'Gerente de ventas'
	else e.title
end as Titulo
from employees e 