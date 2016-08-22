CREATE TABLE gift (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	name varchar
);

CREATE TABLE friend (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	first_name varchar,
	last_name varchar,
	phone_number varchar,
	relationship_id integer
);

CREATE TABLE friend_gift_link (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	friend_id integer,
	gift_id integer
);

CREATE TABLE relationship (
	id integer PRIMARY KEY AUTOINCREMENT,
	name varchar UNIQUE
);

CREATE TABLE vendor (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	name varchar,
	website varchar,
	phone_number varchar
);

CREATE TABLE listing (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	gift_id integer,
	vendor_id integer,
	currency_id integer,
	price numeric,
	url varchar
);

CREATE TABLE reason (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	friend_id integer,
	reason varchar,
	date datetime
);

CREATE TABLE currency (
	id integer PRIMARY KEY AUTOINCREMENT,
	name varchar UNIQUE,
	symbol varchar
);

