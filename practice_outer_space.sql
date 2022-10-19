Tables 
>>Planet
---Name
---Orbital period in Yrs
---Orbits around what star
---Moon

>>Star
---Name
---Star Temp

>>Moon
---Name

-- OuterSpace SQL
CREATE DATABASE outer_space

-- Create tables 
--Moon Table
CREATE TABLE moon(
    moon_name TEXT PRIMARY KEY
);

--Insert Data
INSERT INTO moon(moon_name)
    VALUES
    ('The Moon'),
    ('Phobos'),
    ('Deimos');

--ALTERed Tables
-- To moon, adding reference 
ALTER TABLE moon ADD COLUMN orbit_planet TEXT;
ALTER TABLE moon
    ADD CONSTRAINT fk_orbit_planet
    FOREIGN KEY (orbit_planet) REFERENCES planet(planet);

--Note: Insert planet table information first before updates with references
UPDATE moon 
    SET orbit_planet = 'Earth' WHERE moon_name = 'The Moon';
UPDATE moon
    SET orbit_planet = 'Mars' WHERE moon_name NOT IN ('The Moon');


--Star Table
CREATE TABLE star(
    star_name TEXT PRIMARY KEY,
    star_temp TEXT NOT NULL
);

--ALTERed Text to INT
ALTER TABLE star
ALTER COLUMN star_temp TYPE INT USING star_temp :: INTEGER;

INSERT INTO star(star_name, star_temp)
    VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);

--Planet Table
CREATE TABLE planet (
    planet TEXT PRIMARY KEY,
    orbital_period_yrs FLOAT NOT NULL,
    orbits_star TEXT NOT NULL REFERENCES star,
    moon TEXT REFERENCES moon
);

--Delete 
ALTER TABLE planet DROP COLUMN moon;

INSERT INTO planet(
        planet,
        orbital_period_yrs,
        orbits_star
    )
    VALUES
    ('Earth', 1.00, 'The Sun'),
    ('Mars', 1.882, 'The Sun'),
    ('Venus', 0.62, 'The Sun'),
    ('Proxima Centauri b', 0.03, 'Proxima Centauri'),
    ('Gliese 876 b', 0.236, 'Gliese 876');


--Result 
SELECT planet, star_name, COUNT(moon_name) AS moon_count
    FROM planet
    LEFT OUTER JOIN moon
        ON moon.orbit_planet = planet.planet
    LEFT OUTER JOIN star
        ON star.star_name = planet.orbits_star
    GROUP BY planet, star.star_name;

    