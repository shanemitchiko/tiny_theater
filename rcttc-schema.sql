drop database if exists tiny_theaters;
create database tiny_theaters;

use tiny_theaters;

create table theater (
	theater_id int primary key auto_increment,
    `name` varchar(75) not null,
    theater_address varchar(75) not null,
    theater_phone varchar(75) not null,
    theater_email varchar(75) not null
    );
    
create table `show` (
	show_id int primary key auto_increment,
    `name` varchar(75)
    );
    
create table theater_show (
	theater_show_id int primary key auto_increment,
    theater_id int not null,
    show_id int not null,
    `date` date not null,
	price decimal(6,2) not null,
	constraint uq_theater_show 
		unique (theater_id, show_id, `date`),
	constraint fk_theater_show_theater_id
		foreign key (theater_id)
        references theater(theater_id),
	constraint fk_theater_show_show_id
		foreign key (show_id)
        references  `show`(show_id)
        );
    
create table customer (
	customer_id int primary key auto_increment,
    first_name varchar(75) not null,
    last_name varchar(75) not null,
    customer_email varchar(75) not null,
    customer_phone varchar(75) null,
    customer_address varchar(75) null
    );
    
	create table ticket (
	customer_id int not null, 
	theater_show_id int not null,
    seat varchar(2),
    constraint pk_customer_theater_show
		primary key (customer_id, theater_show_id, seat),
	constraint fk_customer_id
		foreign key (customer_id)
        references customer(customer_id),
	constraint fk_theater_show_id
		foreign key (theater_show_id)
        references theater_show(theater_show_id),
		constraint uq_seat_theater_show_id
		 unique (seat,theater_show_id)
        );
        

  
    
