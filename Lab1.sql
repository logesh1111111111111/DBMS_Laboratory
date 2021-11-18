create table publisher
(
	name varchar(25) PRIMARY KEY,
	address varchar(25),
	phone integer
);

create table book
(
	book_id varchar(5) PRIMARY KEY,
	title varchar(25),
	publisher_name varchar(25),
	publish_year date
);

create table book_author
(
	book_id varchar(5),
	author_name varchar(25),
	foreign key(book_id) references book(book_id) on delete cascade
);

create table library_programme
(
	programme_id integer primary key,
	programme_no integer,
	address varchar(50)
);

create table book_copies
(
	book_id varchar(5),
	programme_id integer primary key,
	no_of_copies integer,
	foreign key(book_id) references book(book_id) on delete cascade
);

create table card_no
(
	card_no integer primary key
);

create table book_lending
(
	book_id varchar(5),
	programme_id integer,
	card_no integer primary key,
	date_out date,
	due_date date,
	foreign key(book_id) references book(book_id) on delete cascade,
	foreign key(programme_id) references book_copies(programme_id) on delete cascade
);

insert into publisher values('Think and think','Pilani',244482);
insert into publisher values('Live last day long','Delhi',244872);
insert into publisher values('Slow down','Gurgav',124482);

insert into book values('B01','Think and think','Mehra','18-Jan-12');
insert into book values('B02','Live last day long','Pratap','12-Dec-03');
insert into book values('B03','Slow down','Nani','21-Feb-08');

insert into book_author values('B01','Bheem');
insert into book_author values('B02','Kalia');
insert into book_author values('B03','Jaggu');

insert into library_programme values(1,582,'Pune');
insert into library_programme values(2,583,'Goa');
insert into library_programme values(3,584,'Kochi');

alter table book_copies
add foreign key(programme_id) references library_programme(programme_id);

insert into book_copies values('B01',1,5);
insert into book_copies values('B02',2,7);
insert into book_copies values('B03',3,3);

insert into card values(101);
insert into card values(102);
insert into card values(103);

insert into book_lending values('B01',1,102,'21-Feb-12','21-Mar-01');
insert into book_lending values('B02',2,101,'21-Feb-13','21-Mar-04');
insert into book_lending values('B03',3,103,'21-Apr-12','21-Apr-18');


/////////////Queries////////////////////
select b.book_id, b.title, b.publisher_name, a.author_name, c.no_of_copies
from book b, book_author a, book_copies c
where b.book_id = a.book_id AND b.book_id = c.book_id;

select card_no
from book_lending
where date_out between '21-Feb-11' AND '21-Apr-13'
group by card_no
having count(*) = 1;

delete from book where book_id = 'B01';