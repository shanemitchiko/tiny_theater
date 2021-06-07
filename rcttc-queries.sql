use tiny_theaters;

-- Find all performances from '2021-07-01' to '2021-09-31'
select *
    from theater_show 
where `date` between '2021-07-01' and  '2021-09-30';
    
select * 
from theater_show;
    
-- List customers without duplication.
select *
from customer;

-- Find all customers without a .com email address.
select *
from customer
where customer_email not like '%.com';

-- Find the three cheapest shows.
select *
from theater_show
order by price asc
limit 3;

-- List customers and the show they're attending with no duplication.
select
	concat(c.first_name, " ", c.last_name) full_name,
    s.`name`
from customer c
inner join ticket tk on c.customer_id = tk.customer_id 
inner join theater_show ts on tk.theater_show_id = ts.theater_show_id and tk.customer_id = c.customer_id
inner join `show` s on ts.show_id = s.show_id;
-- ^^ need to finish

-- List customer, show, theater, and seat number in one query.
select 
	concat(c.first_name, " ", c.last_name) full_name,
    s.`name` `show`,
    t.`name` theater,
    tk.`seat` seat
from theater_show ts
left outer join theater t on ts.theater_id = t.theater_id
left outer join `show` s on ts.theater_show_id = s.show_id
left outer join ticket tk on ts.theater_show_id = tk.theater_show_id
left outer join customer c on tk.customer_id = c.customer_id;
    
-- Find customers without an address.
select 
	concat(first_name, " ", last_name) full_name,
    customer_address
from customer
where customer_address like '';

select *
from customer;

-- Recreate the spreadsheet data with a single query. Use column aliases to produce the original column names.
select c.first_name customer_first,
	   c.last_name customer_last,
       c.customer_email customer_email,
       c.customer_phone customer_phone,
       c.customer_address customer_address,
       tk.`seat` seat,
       s.`name` `show`,
       ts.`date` `date`,
       t.`name` theater,
       t.theater_address theater_address,
       t.theater_phone theater_phone,
       t.theater_email theater_email
from customer c
inner join ticket tk on c.customer_id = tk.customer_id
inner join theater_show ts on tk.theater_show_id = ts.theater_show_id
inner join `show` s on ts.show_id = s.show_id
inner join theater t on ts.theater_id = t.theater_id;

-- Count total tickets purchased per customer.
select concat(c.first_name, " ", c.last_name) full_name,
	   count(tk.theater_show_id) ticket_count
from ticket tk
inner join customer c on tk.customer_id = c.customer_id
group by c.customer_id;

-- Calculate the total revenue per show based on tickets sold.
select s.`name` `show`,
	   -- count(tk.customer_id) ticket_count
       sum((select count(tk.customer_id)
			from `show` s
			inner join theater_show ts on s.show_id = ts.show_id
			inner join ticket tk on ts.theater_show_id = tk.theater_show_id
			inner join customer c on tk.customer_id = c.customer_id
			group by s.`name`
            limit 1) * ts.price) total_revenue
      -- sum(ts.price * ticket_count) total
from `show` s
inner join theater_show ts on s.show_id = ts.show_id
inner join ticket tk on ts.theater_show_id = tk.theater_show_id
inner join customer c on tk.customer_id = c.customer_id
group by s.`name`;

-- Calculate the total revenue per theater based on tickets sold.
select t.`name` theater,
	   sum((select count(tk.customer_id)
			from theater t
			inner join theater_show ts on t.theater_id = ts.theater_id
			inner join ticket tk on ts.theater_show_id = tk.theater_show_id
			inner join customer c on tk.customer_id = c.customer_id
			group by t.`name`
            limit 1) * ts.price) total_revenue
from theater t
inner join theater_show ts on t.theater_id = ts.theater_id
inner join ticket tk on ts.theater_show_id = tk.theater_show_id
inner join customer c on tk.customer_id = c.customer_id
group by t.`name`;

-- Who is the biggest supporter of RCTTC? Who spent the most in 2021?
select concat(c.first_name, " ", c.last_name) full_name,
		 sum((select count(tk.theater_show_id) 
              from customer c
			  inner join ticket tk on c.customer_id = tk.customer_id
			  group by c.customer_id
              limit 1) * ts.price) total_revenue 
from customer c
inner join ticket tk on c.customer_id = tk.customer_id
inner join theater_show ts on ts.theater_show_id = tk.theater_show_id
group by c.customer_id
order by total_revenue desc 
limit 1;

	   





