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
				ts.theater_show_id,
                d.`seat`
from temp_data d
inner join customer c on d.customer_email = c.customer_email
inner join theater_show ts on d.`date` = ts.`date`
inner join theater t on d.theater = t.`name` and ts.theater_id = t.theater_id
inner join `show` s on d.`show` = s.`name` and ts.show_id = s.show_id;

insert into ticket (customer_id, theater_show_id, seat)
select distinct c.customer_id,
				ts.theater_show_id,
                d.`seat`
from temp_data d
inner join customer c on d.customer_email = c.customer_email
inner join theater_show ts on d.`date` = ts.`date`
inner join theater t on d.theater = t.`name` and ts.theater_id = t.theater_id
inner join `show` s on d.`show` = s.`name` and ts.show_id = s.show_id;
                
select * from ticket;

drop table temp_data;


-- UPDATE 
-- 1. theater: Little Fitz update date '2021-03-01- show: the sky lit up  old price: $20.00 new price: $22.25 
-- update theater_show 
select * from theater;
-- Little Fitz || theater_id = 2

select * from `show`;
-- The Sky Lit Up || show_id = 4

select * 
from theater_show;
-- theater_show_id = 5

update theater_show set
		price = '22.25'
where theater_show_id = 5;

-- 2. theater: Little Fitz date '2021-03-01- show: the sky lit up
-- update 'Pooh Bedburrow' and 'Cullen Guirau' seat reservations to be in the same row. 
-- Requires updates to all reservations for that performance. 
-- Confirm no duplication and that everyone is as close to their original seat as possible

select *
from customer
where last_name = 'Bedburrow' or last_name = 'Guirau';
-- Bedburrow ID = 37
-- Guirau ID = 38

select *
from ticket
where theater_show_id = 5;

update ticket set
	seat = '' 
where customer_id = 38 and theater_show_id = 5 and seat = 'B4';

update ticket set
	seat = 'B4'
where customer_id = 37 and theater_show_id = 5 and seat = 'A4';

update ticket set
	seat = 'A4'
where customer_id = 36 and theater_show_id = 5 and seat = 'A2';

update ticket set 
	seat = 'A2' 
where customer_id = 39 and theater_show_id = 5 and seat = 'C2';

update ticket set 
	seat = 'C2' 
where customer_id = 38 and theater_show_id = 5 and seat = '';

-- 3. swap 'Hashim Daouze' and 'Elicia Heymann' phone numbers

select *
from customer
where last_name = 'Daouze' or last_name = 'Heymann';
-- Daouze phone # = '338-922-3547'
-- Heymann phone # = '129-168-4725'

update customer set
	customer_phone = '129-168-4725'
where customer_id = 36;

update customer set
	customer_phone = '338-922-3547'
where customer_id = 44;

-- DELETE
-- 1. theater: Little Fitz date '2021-09-24' show: the sky lit up  
-- delete all single-ticket reservations
select * from theater;
-- Little Fitz || theater_id = 2

select * from `show`;
-- The Sky Lit Up || show_id = 4

select * 
from theater_show
where theater_id = 2 and show_id and `date` = '2021-09-24';
-- theater_show_id = 6

select *
from ticket
where theater_show_id = 6;

delete from ticket
where customer_id = 43 and theater_show_id = 6;

delete from ticket
where customer_id = 45 and theater_show_id = 6;

delete from ticket
where customer_id = 46 and theater_show_id = 6;

-- 2 delete customer 'Shannah Ramsell'
select *
from customer
where last_name = 'Ramsell'; -- ID = 2;

select * 
from ticket
where customer_id = 42;

delete from ticket
where customer_id = 42;

delete from customer
where customer_id = 42;



			
    

