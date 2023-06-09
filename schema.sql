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

-- Create the vets table
CREATE TABLE vets(
	id SERIAL PRIMARY KEY,
	name varchar(20) NOT NULL,
	age integer NOT NULL,
	date_of_graduation date NOT NULL
);

-- Create the specializations table
CREATE TABLE specializations(
	species_id int REFERENCES species(id),
	vet_id int REFERENCES vets(id)
);

-- Create the visits table
CREATE TABLE visits(
	animal_id int REFERENCES animals(id),
	vet_id int REFERENCES vets(id),
	visit_date date NOT NULL
)
