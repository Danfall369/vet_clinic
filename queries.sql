-- Select all animals whose name ends with 'mon'
SELECT * FROM animals WHERE name LIKE '%mon';

-- Select the names of animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- Select the names of animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered=true AND escape_attempts < 3;

-- Select the date of birth of animals with names 'Agumon' or 'Pikachu'
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- Select the name and escape attempts of animals that weigh more than 10.5 kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Select all animals that are neutered
SELECT * FROM animals WHERE neutered=true;

-- Select all animals except those with the name 'Gabumon'
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Select all animals with a weight between 10.7 and 17.3 kg
SELECT * FROM animals WHERE weight_kg BETWEEN 10.7 AND 17.3;

-- Begin a transaction
BEGIN;

-- Update the species of all animals to 'unspecified'
UPDATE animals SET species='unspecified';

-- Rollback the transaction
ROLLBACK;

-- Begin a transaction
BEGIN;

-- Update the species of animals with names ending in 'mon' to 'Digimon'
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';

-- Update the species of animals with a NULL species to 'Pokemon'
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;

-- Commit the transaction
COMMIT;

-- Begin a transaction
BEGIN;

-- Delete all rows from the animals table
DELETE FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Begin a transaction
BEGIN;

-- Delete animals born after January 1, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint named 'animals'
SAVEPOINT animals;

-- Update the weight of animals to its negative value
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the 'animals' savepoint
ROLLBACK TO animals;

-- Update the weight of animals to its negative value where weight is less than 0
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- Count the number of rows in the animals table
SELECT COUNT(*) FROM animals;

-- Count the number of rows in the animals table where escape_attempts is 0
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Calculate the average weight of animals
SELECT AVG(weight_kg) FROM animals;

-- Select the neutered status and count of animals where escape_attempts is greater than 0, grouped by neutered status
SELECT neutered, COUNT(*) FROM animals WHERE escape_attempts > 0 GROUP BY neutered;

-- Select the species, minimum weight, and maximum weight of animals, grouped by species
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- Select the species and average escape attempts of animals born between 1990 and 2000, grouped by species
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- Select the names of animals owned by a person with the full name 'Melody Pond'
SELECT name FROM Animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- Select all animals whose species is 'Pokemon'
SELECT * FROM Animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- Select the full name of owners and the names of their animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- Select the species names and the count of animals for each species
SELECT species.name, COUNT(animals.id)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- Select the names of animals owned by 'Jennifer Orwell' and whose species is 'Digimon'
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- Select the names of animals owned by 'Dean Winchester' and have never attempted to escape
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Select the full name of the owner with the most animals
SELECT owners.full_name, COUNT(animals.id) AS total_animals FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY total_animals DESC
LIMIT 1;
 
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.visit_date
FROM visits
JOIN animals ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) AS animal_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species_id
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
ORDER BY vets.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal_name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS animals_name, COUNT(*) as visits_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visits_count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
Limit 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) as visits_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS species_name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;