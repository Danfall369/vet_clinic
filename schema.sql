CREATE TABLE animals(
	id SERIAL PRIMARY KEY,
	name varchar(20) NOT NULL,
	date_of_birth date NOT NULL,
	escape_attempts int NOT NULL DEFAULT 0,
	neutered boolean NOT NULL DEFAULT false,
	weight_kg float NOT NULL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR;