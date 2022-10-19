

-- -- Info
-- Prices:
    -- - ID
    -- - Price
    -- - TIMESTAMP

-- Bikes:
--     - Models
--         - The Flyer (FLY) - (price id)
--         - The Big Haul (HAUL) - (price id)
--         - The Skinny (SKIN) - (price id)
--         - Big Buddy (BUD) - (price id)
--         - (might add more models)

-- Order:
--     - One or many Bikes (bikes)
--     - Can be multiplymodels (bikes)
--     - When the order was placed
--     - Note per Bike ('Default empty string')
--     - Price needs to be able to change or hardcoded based on order time
--     - customer ID


CREATE DATABASE bike_shop

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL
);

CREATE TABLE bikes (
    bike_code TEXT PRIMARY KEY,
    bike_name TEXT NOT NULL,
    bike_price_id INT REFERENCES prices
)

CREATE TABLE prices (
    id SERIAL PRIMARY KEY,
    price NUMERIC(10, 2) NOT NULL,
    -- discount NUMERIC(10, 2) NOT NULL DEFAULT 0,
    price_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers,
    order_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    code TEXT REFERENCES bikes,
    discount NUMERIC(10, 2) NOT NULL DEFAULT 0,
    notes TEXT NOT NULL DEFAULT ''
)

SELECT c.first_name, c.last_name, b.bike_name, o.order_date, o.notes, COUNT(p.price - p.price * o.discount),
    FROM prices AS p
        JOIN bikes AS b ON b.bike_price_id = p.id
        JOIN orders AS o ON o.code = b.bike_code
        JOIN customers AS c ON o.customer_id = c.id
    GROUP BY o.customer_id, o.order_date, b.bike_name, o.notes, c.first_name, c.last_name


