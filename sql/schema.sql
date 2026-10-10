-- Reference schema for the four imported CSV files.
-- If importing through pgAdmin, create these tables first.
-- The source order_date is DD-MM-YYYY; set DateStyle to DMY before import if needed.
SET datestyle TO 'DMY';

CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

CREATE TABLE IF NOT EXISTS pizza_types (
    pizza_type_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    ingredients TEXT
);

CREATE TABLE IF NOT EXISTS pizzas (
    pizza_id TEXT PRIMARY KEY,
    pizza_type_id TEXT NOT NULL REFERENCES pizza_types(pizza_type_id),
    size TEXT NOT NULL,
    price NUMERIC(8,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS order_details (
    order_details_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    pizza_id TEXT NOT NULL REFERENCES pizzas(pizza_id),
    quantity INTEGER NOT NULL
);
