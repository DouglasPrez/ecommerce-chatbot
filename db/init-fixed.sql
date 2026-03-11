-- -----------------------------
-- Creates database
-- -----------------------------
-- Descomentar solo si ejecutas desde superusuario y la DB no existe
-- CREATE DATABASE ebot;

-- -----------------------------
-- Creates tables
-- -----------------------------
-- CREATE TABLE accounts(
-- 	id SERIAL PRIMARY KEY,
-- 	type INT NOT NULL
-- );

-- ----------------------------------------------------
-- Table 'sellers'
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS sellers(
    id SERIAL PRIMARY KEY,
    apiKey VARCHAR(50) NOT NULL,
    store_name VARCHAR(50) NOT NULL,
    email TEXT NOT NULL,
    password_ TEXT NOT NULL
);

-- ----------------------------------------------------
-- Table 'categories'
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS categories(
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(150) NOT NULL  -- ✅ ARREGLADO: Coma extra eliminada
);

-- ----------------------------------------------------
-- Table 'products'
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS products(
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    seller_id INT REFERENCES sellers(id) NOT NULL,
    category_id INT REFERENCES categories(id) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    url VARCHAR(350) NOT NULL,
    price MONEY NOT NULL,
    old_price MONEY NOT NULL,
    image_url VARCHAR(350) NOT NULL,
    details TEXT,
    availability BOOLEAN NOT NULL,
    last_updated DATE NOT NULL
);

-- ----------------------------------------------------
-- Table 'users'
-- ----------------------------------------------------
CREATE TABLE IF NOT EXISTS users(
    id SERIAL PRIMARY KEY,
    -- account_id INT references accounts(id) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email TEXT NOT NULL,
    password_ TEXT NOT NULL,
    username VARCHAR(50) NOT NULL
);

-- Agregar columna a categories después de que products exista
ALTER TABLE categories ADD COLUMN IF NOT EXISTS product_id INT REFERENCES products(id);

-- ALTER TABLE sellers ADD account_id INT REFERENCES accounts(id);

CREATE TABLE IF NOT EXISTS addresses(
    id SERIAL PRIMARY KEY,
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zip INT NOT NULL
);

CREATE TABLE IF NOT EXISTS credit_cards(
    id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    card_number BIGINT NOT NULL,
    card_name VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS transactions(
    id SERIAL PRIMARY KEY,
    credit_card_id INT REFERENCES credit_cards(id),
    total_price MONEY NOT NULL
);

CREATE TABLE IF NOT EXISTS shippings(
    id SERIAL PRIMARY KEY,
    address_id INT REFERENCES addresses(id) NOT NULL,
    shipping_method VARCHAR(250) NOT NULL,
    shipping_charge MONEY NOT NULL,
    shipping_estimated_delivery_day DATE
);

CREATE TABLE IF NOT EXISTS orders(
    id SERIAL PRIMARY KEY,
    transaction_id INT REFERENCES transactions(id) NOT NULL,
    user_id INT REFERENCES users(id) NOT NULL,
    product_id INT REFERENCES products(id) NOT NULL,
    quantity INT NOT NULL,
    shipping_id INT REFERENCES shippings(id) NOT NULL,
    order_date DATE NOT NULL,
    total_amount MONEY NOT NULL
);

ALTER TABLE users ADD COLUMN IF NOT EXISTS creditcard_id INT REFERENCES credit_cards(id);