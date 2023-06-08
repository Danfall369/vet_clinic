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

CREATE TABLE owners(
	id SERIAL PRIMARY KEY,
	full_name varchar(20) NOT NULL,
	age integer NOT NULL
);

CREATE TABLE species(
	id SERIAL PRIMARY KEY,
	name varchar(20) NOT NULL
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);