SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND  escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.7 AND 17.3;

BEGIN;
UPDATE animals SET species='unspecified';
ROLLBACK;
BEGIN;
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;
COMMIT;
BEGIN;
DELETE FROM animals;
ROLLBACK;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT animals;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg <0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*)  FROM animals WHERE escape_attempts > 0 GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name FROM Animals
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

SELECT * FROM Animals
JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name FROM animals
join owners ON animals.owner_id = owners.id
join species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name FROM animals
join owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS total_animals FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY total_animals DESC
LIMIT 1;