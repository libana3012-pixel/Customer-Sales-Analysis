-- Synthetic retail data shared conceptually with the sales revenue case study.
-- SQLite. Run on a fresh database.
PRAGMA foreign_keys=ON;
CREATE TABLE customers (customer_id TEXT PRIMARY KEY, market TEXT NOT NULL, joined_date TEXT NOT NULL);
CREATE TABLE orders (order_id TEXT PRIMARY KEY, customer_id TEXT NOT NULL REFERENCES customers(customer_id), order_date TEXT NOT NULL);
CREATE TABLE products (product_id TEXT PRIMARY KEY, category TEXT NOT NULL);
CREATE TABLE order_items (order_id TEXT NOT NULL REFERENCES orders(order_id), product_id TEXT NOT NULL REFERENCES products(product_id), quantity INTEGER NOT NULL CHECK(quantity>0), unit_price NUMERIC NOT NULL CHECK(unit_price>=0), PRIMARY KEY(order_id,product_id));
INSERT INTO customers VALUES
('C001','NO','2026-02-11'),('C002','NO','2026-02-20'),('C003','SE','2026-03-01'),('C004','NO','2026-03-04'),
('C005','DK','2026-03-28'),('C006','SE','2026-04-13'),('C007','NO','2026-05-02'),('C008','DK','2026-05-10');
INSERT INTO products VALUES ('P01','Home'),('P02','Office'),('P03','Lifestyle'),('P04','Home'),('P05','Office'),('P06','Lifestyle');
INSERT INTO orders VALUES
('O001','C001','2026-03-03'),('O002','C002','2026-03-08'),('O003','C003','2026-03-13'),
('O004','C001','2026-04-04'),('O005','C004','2026-04-12'),('O006','C005','2026-04-19'),
('O007','C002','2026-05-03'),('O008','C006','2026-05-11'),('O009','C003','2026-05-20'),
('O010','C001','2026-06-06'),('O011','C004','2026-06-15'),('O012','C007','2026-06-22');
INSERT INTO order_items VALUES
('O001','P01',1,120),('O001','P03',2,35),('O002','P02',1,85),('O003','P04',1,160),('O003','P06',1,25),
('O004','P01',2,120),('O005','P05',1,60),('O005','P03',1,35),('O006','P02',2,85),('O007','P04',1,160),
('O008','P01',1,120),('O008','P06',2,25),('O009','P05',2,60),('O010','P03',3,35),('O010','P02',1,85),
('O011','P04',1,160),('O011','P05',1,60),('O012','P06',3,25),('O012','P01',1,120);
