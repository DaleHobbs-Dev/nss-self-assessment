DROP TABLE IF EXISTS ReceiptItem;
DROP TABLE IF EXISTS Receipt;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Product (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

CREATE TABLE Receipt (
    id INT PRIMARY KEY,
    customer_id INT,
    date DATETIME,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(id)
);

CREATE TABLE ReceiptItem (
    id INT PRIMARY KEY,
    receipt_id INT,
    product_id INT,
    quantity INT,
    line_total DECIMAL(10, 2),
    FOREIGN KEY (receipt_id) REFERENCES Receipt(id),
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

-- Insert Customers
INSERT INTO Customer (id, name, email, phone) VALUES
(1, 'Alice Johnson', 'alice@email.com', '555-0101'),
(2, 'Bob Smith', 'bob@email.com', '555-0102');

-- Insert Products
INSERT INTO Product (id, name, price, category) VALUES
(1, 'Notebook', 5.00, 'Stationery'),
(2, 'Pen', 1.50, 'Stationery'),
(3, 'Backpack', 45.00, 'Bags'),
(4, 'Water Bottle', 12.00, 'Accessories'),
(5, 'Laptop Sleeve', 25.00, 'Accessories');

-- Insert Receipts
INSERT INTO Receipt (id, customer_id, date, total_amount) VALUES
(1, 1, '2024-02-01 10:30:00', 17.50),
(2, 1, '2024-02-05 14:15:00', 70.00),
(3, 2, '2024-02-03 11:00:00', 13.50);

-- Insert Receipt Items
-- Receipt 1: Alice buys notebook and pens
INSERT INTO ReceiptItem (id, receipt_id, product_id, quantity, line_total) VALUES
(1, 1, 1, 2, 10.00),   -- 2 Notebooks @ $5.00 each
(2, 1, 2, 5, 7.50);    -- 5 Pens @ $1.50 each

-- Receipt 2: Alice buys backpack and laptop sleeve
INSERT INTO ReceiptItem (id, receipt_id, product_id, quantity, line_total) VALUES
(3, 2, 3, 1, 45.00),   -- 1 Backpack @ $45.00
(4, 2, 5, 1, 25.00);   -- 1 Laptop Sleeve @ $25.00

-- Receipt 3: Bob buys pens and a water bottle
INSERT INTO ReceiptItem (id, receipt_id, product_id, quantity, line_total) VALUES
(5, 3, 2, 3, 4.50),    -- 3 Pens @ $1.50 each
(6, 3, 4, 1, 12.00);   -- 1 Water Bottle @ $12.00

SELECT * FROM Receipt;
SELECT * FROM ReceiptItem;

SELECT r.id AS receipt_id, p.name AS product_name, p.category, ri.quantity, ri.line_total FROM Receipt r
JOIN ReceiptItem ri ON r.id = ri.receipt_id
JOIN Product p ON ri.product_id = p.id
WHERE receipt_id = 1
ORDER BY ri.line_total DESC;