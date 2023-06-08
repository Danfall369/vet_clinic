-- Create the animals table
CREATE TABLE animals(
	id SERIAL PRIMARY KEY,
	name varchar(20) NOT NULL,
	date_of_birth date NOT NULL,
	escape_attempts int NOT NULL DEFAULT 0,
	neutered boolean NOT NULL DEFAULT false,
	weight_kg float NOT NULL
);

-- Add the species column to the animals table
ALTER TABLE animals
ADD COLUMN species VARCHAR;

-- Create the owners table
CREATE TABLE owners(
	id SERIAL PRIMARY KEY,
	full_name varchar(20) NOT NULL,
	age integer NOT NULL
);

-- Create the species table
CREATE TABLE species(
	id SERIAL PRIMARY KEY,
	name varchar(20) NOT NULL
);

-- Alter the animals table to add the species_id column
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

-- Alter the animals table to add the owner_id column
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);
