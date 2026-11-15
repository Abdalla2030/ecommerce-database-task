-- Run CREATE DATABASE separately, outside a transaction.
CREATE DATABASE ecommerce;

-- DataGrip: reconnect to ecommerce BEFORE running the statements below.
CREATE TABLE Category (
    category_id INT CONSTRAINT cat_id_pk PRIMARY KEY,
    category_name VARCHAR(50) CONSTRAINT cat_name_nn NOT NULL
);

CREATE TABLE Product (
    product_id INT CONSTRAINT prod_id_pk PRIMARY KEY,
    category_id INT CONSTRAINT cat_id_fk REFERENCES Category(category_id),
    name VARCHAR(100) CONSTRAINT prod_name_nn NOT NULL,
    description VARCHAR(150),
    price NUMERIC(10,2) CONSTRAINT prod_price_pos CHECK (price > 0),
    stock_quantity INT DEFAULT 0 CONSTRAINT prod_qty_pos CHECK (stock_quantity >= 0)
);

CREATE TABLE Customer (
    customer_id INT CONSTRAINT cus_id_pk PRIMARY KEY,
    first_name VARCHAR(100) CONSTRAINT first_name_nn NOT NULL,
    last_name VARCHAR(100) CONSTRAINT last_name_nn NOT NULL,
    email VARCHAR(50) CONSTRAINT cus_email_uq UNIQUE,
    password VARCHAR(255)
);

CREATE TABLE Orders (
    order_id INT CONSTRAINT ord_id_pk PRIMARY KEY,
    customer_id INT CONSTRAINT cus_id_fk REFERENCES Customer(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2) CONSTRAINT total_amount_pos CHECK (total_amount > 0)
);

CREATE TABLE Order_details (
    order_detail_id INT CONSTRAINT ord_det_id_pk PRIMARY KEY,
    order_id INT CONSTRAINT ord_id_fk REFERENCES Orders(order_id),
    product_id INT CONSTRAINT prod_id_fk REFERENCES Product(product_id),
    quantity INT CONSTRAINT ord_det_qty_pos CHECK (quantity > 0),
    unit_price NUMERIC(10,2) CONSTRAINT ord_unt_pri_pos CHECK (unit_price > 0)
);
