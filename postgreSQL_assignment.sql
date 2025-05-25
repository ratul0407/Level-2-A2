-- Active: 1748109511760@@127.0.0.1@5432@conservation_db


-- create a database named conservation_db
CREATE DATABASE conservation_db;


--creating the ranger table
CREATE TABLE rangers(ranger_id BIGSERIAL PRIMARY KEY NOT NULL, "name" VARCHAR(50) NOT NULL, region VARCHAR(100) NOT NULL);


--creating the species table
CREATE TABLE species(species_id BIGSERIAL PRIMARY KEY NOT NULL, common_name VARCHAR(50) NOT NULL, scientific_name VARCHAR(100) NOT NULL, discovery_date DATE NOT NULL, conservation_status VARCHAR(20) NOT NULL);




--creating the sightings table
CREATE TABLE sightings(sighting_id BIGSERIAL PRIMARY KEY NOT NULL, ranger_id INTEGER REFERENCES rangers(ranger_id), species_id INTEGER REFERENCES species(species_id), sighting_time TIMESTAMP WITHOUT TIME ZONE, "location" VARCHAR(100), notes VARCHAR(200));


--inserting data for the rangers table
INSERT INTO rangers ("name", region) VALUES('Alice Green', 'Northen Hills'), ('Bob White', 'River Delta'), ('Carol King', 'Mountain Range');


--inserting data for the species table
INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) VALUES('Snow Leopard', 'Panthera uncia', DATE '1775-01-01', 'Endangered'), ('Bengal Tiger', 'Panthera tigris tigris', DATE '1758-01-01', 'Endangered'), ('Red panda', 'Ailurus fulgens', DATE '1825-01-01', 'Vulnerable'), ('Asiatic Elephant', 'Elephas maximus indicus', DATE '1758-01-01', 'Endangered');


--inserting data for the sightings table
INSERT INTO sightings(species_id, ranger_id, "location", sighting_time,  notes) VALUES(1, 1, 'Peak Ridge', TIMESTAMP WITHOUT TIME ZONE '2024-05-10 07:45:00', 'Camera trap image'), (2, 2, 'Bankwood Area', TIMESTAMP WITHOUT TIME ZONE '2024-05-12 16:20:00', 'Juvenile seen'), (3,3, 'Bamboo Grove Ease', TIMESTAMP WITHOUT TIME ZONE '2024-05-15 09:10:00', 'Feeding observed'), (1,2,'Snowfall Pass', TIMESTAMP WITHOUT TIME ZONE '2024-05-18 18:30:00', NULL);


--PROBLEM 1

INSERT INTO rangers("name", region) VALUES ('Derek Fox', 'Coastal Plains');


--PROBLEM 2

SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings;

--PROBLEM 3

SELECT * FROM sightings WHERE "location" ILIKE '%pass%';

--PROBLEM 4
SELECT "name", COUNT("name") AS total_sightings FROM rangers
    JOIN sightings on rangers.ranger_id = sightings.ranger_id GROUP BY "name";


-- PROBLEM 5

SELECT common_name FROM species LEFT JOIN sightings ON sightings.species_id = species.species_id WHERE sighting_id ISNULL;

--PROBLEM 6

SELECT common_name, sighting_time, "name"  FROM sightings JOIN species ON sightings.species_id = species.species_id JOIN rangers on sightings.ranger_id = rangers.ranger_id ORDER BY sighting_time DESC LIMIT 2;

--PROBLEM 7

UPDATE species 
    SET conservation_status = 'Historic'
    WHERE EXTRACT(YEAR FROM discovery_date) < 1800;


--PROBLEM 8

SELECT sighting_time, 
CASE
WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning' 
WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
WHEN EXTRACT(HOUR FROM sighting_time) > 17 THEN 'Night'
END AS time_of_day
FROM sightings;

--PROBLEM 9

DELETE FROM rangers WHERE ranger_id IN (SELECT rangers.ranger_id FROM rangers LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id WHERE sighting_id IS NULL);