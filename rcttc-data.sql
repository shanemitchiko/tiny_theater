use tiny_theaters;

-- INSERT
select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
from temp_data;

insert into customer (first_name, last_name, customer_email, customer_phone, customer_address)
	select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
	from temp_data;

select * from customer;

select distinct theater, theater_address, theater_phone, theater_email
from temp_data;

insert into theater (`name`, theater_address, theater_phone, theater_email)
	select distinct theater, theater_address, theater_phone, theater_email
	from temp_data;

select * from theater;

select distinct `show`
from temp_data;

insert into `show` (`name`)
	select distinct `show`
	from temp_data;

select * from `show`;

select distinct t.theater_id,
					s.show_id,
					d.`date`,
                    d.ticket_price
from temp_data d
inner join theater t on d.theater = t.`name`
inner join `show` s on d.`show` = s.`name`;

insert into theater_show (theater_id, show_id, `date`, price)
	select distinct t.theater_id,
					s.show_id,
					d.`date`,
                 d.ticket_price
	from temp_data d
	inner join theater t on d.theater = t.`name`
	inner join `show` s on d.`show` = s.`name`; 
    
select * from theater_show;


select distinct c.customer_id,
				unique ts(theater_id, show_id, `date`),
                 d.`seat`,
                 ts.`date`
from temp_data d
inner join customer c on d.customer_email = c.customer_email
inner join theater_show ts on d.`date` = ts.`date`;

insert into ticket (customer_id, theater_show_id, seat)
	select distinct c.customer_id,
                ts.theater_show_id,
                d.`seat`,
                ts.`date`
from temp_data d
inner join customer c on d.customer_email = c.customer_email
inner join theater_show ts on d.`date` = ts.`date`;

select distinct c.customer_id,
                t.theater_id,
                   s.show_id,
                  d.`seat`,
				  ts.`date`
from temp_data d
inner join customer c on d.customer_email = c.customer_email
inner join theater t on d.theater = t.`name`
inner join `show` s on d.`show` = s.`name`
inner join theater_show ts on d.`date` = ts.`date`;

insert into ticket (customer_id, unique(theater_id, show_id, `date`), seat)
	select distinct c.customer_id,
                t.theater_id,
                   s.show_id,
                  d.`seat`,
				  ts.`date`
from temp_data d
inner join customer c on d.customer_email = c.customer_email
inner join theater t on d.theater = t.`name`
inner join `show` s on d.`show` = s.`name`
inner join theater_show ts on d.`date` = ts.`date`;

insert into ticket (customer_id,  

select * from ticket;


-- UPDATE 
-- update theater_show 
	

				
    

