-- 1) Database b
CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;
-- ---------------------------------------------------------------------------------------
-- 2) Customers table
CREATE TABLE customers (
    customer_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_code    VARCHAR(30) UNIQUE,
    first_name       VARCHAR(50),
    last_name        VARCHAR(50),
    email            VARCHAR(100),
    phone            VARCHAR(20),
    city             VARCHAR(100),
    state            VARCHAR(100),
    country          VARCHAR(100) DEFAULT 'India',
    segment          VARCHAR(50),           -- Consumer / Corporate / Home Office etc.
    signup_date      DATE,
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ---------------------------------------------------------------------------------------
-- 3) Products table
CREATE TABLE products (
    product_id       INT AUTO_INCREMENT PRIMARY KEY,
    product_code     VARCHAR(50) UNIQUE,
    product_name     VARCHAR(255),
    category         VARCHAR(100),          -- Electronics / Furniture / Clothing etc.
    sub_category     VARCHAR(100),
    cost_price       DECIMAL(10,2),
    selling_price    DECIMAL(10,2),
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ---------------------------------------------------------------------------------------
-- 4) Orders table
CREATE TABLE orders (
    order_id         INT AUTO_INCREMENT PRIMARY KEY,
    order_code       VARCHAR(50) UNIQUE,
    customer_id      INT,
    order_date       DATETIME,
    ship_date        DATETIME,
    ship_mode        VARCHAR(50),           -- Standard / Express etc.
    status           VARCHAR(30),           -- Completed / Cancelled / Returned / Processing
    shipping_cost    DECIMAL(10,2),
    ship_city        VARCHAR(100),
    ship_state       VARCHAR(100),
    ship_country     VARCHAR(100) DEFAULT 'India',
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ---------------------------------------------------------------------------------------
-- 5) Order items table
CREATE TABLE order_items (
    order_item_id    INT AUTO_INCREMENT PRIMARY KEY,
    order_id         INT,
    product_id       INT,
    quantity         INT,
    unit_price       DECIMAL(10,2),         -- Final unit price after discount (if any)
    discount_percent DECIMAL(5,2),          -- 0–100 (e.g. 10 = 10%)
    profit           DECIMAL(10,2),         -- Optional: ya baad me Python se calculate kar sakte hain
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ---------------------------------------------------------------------------------------
-- 6) Payments table
CREATE TABLE payments (
    payment_id       INT AUTO_INCREMENT PRIMARY KEY,
    order_id         INT,
    payment_date     DATETIME,
    payment_method   VARCHAR(50),           -- UPI / Credit Card / COD / Netbanking / Wallet
    amount           DECIMAL(10,2),
    payment_status   VARCHAR(30),           -- Paid / Refunded / Partially Paid
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ----------------------------------------------------------------------------------------------
SCHEMA & DATA FLOW NOTES – E-COMMERCE ANALYTICS PROJECT

1) Transactional Tables in MySQL:
The following tables were created and maintained in MySQL
to store raw transactional data:

- customers
- products
- orders
- order_items
- payments

2) RFM Table (Python → MySQL):
The RFM table was calculated in Python using Pandas
and directly loaded into MySQL via SQLAlchemy for
further validation and analysis.

3) CLV Tables (Python → Power BI):
Customer Lifetime Value (CLV) tables were computed
entirely in Python (profit-based CLV) and were
directly imported into Power BI using the Text/CSV option.
These tables are not part of the MySQL schema by design.

This hybrid approach reflects a real-world analytics workflow,
where SQL handles transactional storage while Python
handles analytical feature engineering.
