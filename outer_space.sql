
-- OuterSpace SQL
CREATE DATABASE outer_space

-- Create tables 
--Moon Table
CREATE TABLE moons(
    moon_name TEXT PRIMARY KEY,
    orbit_planet TEXT REFERENCES planets --not null, table names plural
);

--Star Table
CREATE TABLE stars(
    star_name TEXT PRIMARY KEY,
    star_temp INT NOT NULL --more specific
);

--Planet Table
CREATE TABLE planets (
    planet_name TEXT PRIMARY KEY, --consistency with planet_name
    orbital_period_yrs FLOAT NOT NULL,
    orbits_star TEXT NOT NULL REFERENCES stars,
);



--Insert Data
INSERT INTO moons(moon_name, orbit_planet)
    VALUES
    ('The Moon', 'Earth'),
    ('Phobos', 'Mars'),
    ('Deimos', 'Mars');


INSERT INTO stars(star_name, star_temp)
    VALUES
    ('The Sun', 5800),
    ('Proxima Centauri', 3042),
    ('Gliese 876', 3192);


INSERT INTO planets(
        planet_name,
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
SELECT planet_name, star_name, COUNT(moon_name) AS moon_count
    FROM planets
    LEFT OUTER JOIN moons
        ON moons.orbit_planet = planets.planet_name
    LEFT OUTER JOIN stars
        ON stars.star_name = planets.orbits_star
    GROUP BY planet_name, star.star_name
    ORDER BY planet_name;


--QUESTION 
-- SELECT planet, star_name, moon_name
--     FROM planet
--     LEFT OUTER JOIN moon
--         ON moon.orbit_planet = planet.planet
--     LEFT OUTER JOIN star
--         ON star.star_name = planet.orbits_star