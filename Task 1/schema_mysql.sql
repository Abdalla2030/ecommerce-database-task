-- MySQL 8.0.16+ (CHECK constraints are enforced).
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Category (
    category_id INT,
    category_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (category_id)
) ENGINE=InnoDB;

CREATE TABLE Product (
    product_id INT,
    category_id INT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(150),
    price NUMERIC(10,2),
    stock_quantity INT DEFAULT 0,
    PRIMARY KEY (product_id),
    CONSTRAINT cat_id_fk FOREIGN KEY (category_id) REFERENCES Category(category_id),
    CONSTRAINT prod_price_pos CHECK (price > 0),
    CONSTRAINT prod_qty_pos CHECK (stock_quantity >= 0)
) ENGINE=InnoDB;

CREATE TABLE Customer (
    customer_id INT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(50),
    password VARCHAR(255),
    PRIMARY KEY (customer_id),
    CONSTRAINT cus_email_uq UNIQUE (email)
) ENGINE=InnoDB;

CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2),
    PRIMARY KEY (order_id),
    CONSTRAINT cus_id_fk FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT total_amount_pos CHECK (total_amount > 0)
) ENGINE=InnoDB;

CREATE TABLE Order_details (
    order_detail_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price NUMERIC(10,2),
    PRIMARY KEY (order_detail_id),
    CONSTRAINT ord_id_fk FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT prod_id_fk FOREIGN KEY (product_id) REFERENCES Product(product_id),
    CONSTRAINT ord_det_qty_pos CHECK (quantity > 0),
    CONSTRAINT ord_unt_pri_pos CHECK (unit_price > 0)
) ENGINE=InnoDB;
