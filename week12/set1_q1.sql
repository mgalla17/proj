CREATE TABLE seq (
	id integer PRIMARY KEY AUTOINCREMENT,
	accession varchar UNIQUE,
	display_id varchar,
	desc varchar,
	display_name varchar,
	length integer,
	seq varchar,
	primary_id varchar,
	namespace varchar,
	species varchar
);

CREATE TABLE blast (
	id integer PRIMARY KEY AUTOINCREMENT UNIQUE,
	search_seq_id integer,
	result_seq_id integer,
	e_value numeric
);

