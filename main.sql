CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
delete from USers
drop table USERS
select*from USERS

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO categories (name) VALUES 
('Đựng bút đa năng'),
('Bút các loại'),
('Hộp bút'),
('Kẹp/Đựng tài liệu'),
('Thước kẻ'),
('Dụng cụ học tập khác');

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0), 
    quantity INT NOT NULL CHECK (quantity >= 0), 
    status VARCHAR(50) DEFAULT 'Còn hàng', 
    image VARCHAR(255),
    category_id INT,  
    CONSTRAINT fk_category
        FOREIGN KEY (category_id) 
        REFERENCES categories(id)  
);
drop table products
select*from products
INSERT INTO products (name, description, price, quantity, status, image, category_id) VALUES 
('Bút bi đa năng', 'Bút bi đa năng với nhiều màu sắc.', 5000, 100, 'Còn hàng', 'bi.jpg', 1),
('Bút chì màu', 'Bút chì màu chất lượng cao.', 10000, 150, 'Còn hàng', 'but_chi_mau.png', 2),
('Hộp bút xinh xắn', 'Hộp bút với thiết kế xinh xắn và tiện lợi.', 15000, 200, 'Còn hàng', 'hop_but.png', 3),
('Kẹp tài liệu', 'Kẹp tài liệu chất lượng, bền bỉ.', 20000, 80, 'Còn hàng', 'kep_tai_lieu.png', 4),
('Thước kẻ nhựa', 'Thước kẻ nhựa trong suốt 30cm.', 5000, 120, 'Còn hàng', 'thuoc_ke.png', 5),
('Bộ dụng cụ học tập', 'Bộ dụng cụ học tập đa năng.', 25000, 50, 'Còn hàng', 'dung_cu_hoc_tap.png', 6);
delete from products

CREATE TABLE search_keywords (
    id SERIAL PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);
drop table search_keywords

delete from search_keywords
select*from search_keywords
INSERT INTO search_keywords (keyword, category_id) VALUES

('đựng bút đa năng', 1),
('hộp đựng bút', 1),
('bút đa năng', 1),

('bút bi', 2),
('bút mực', 2),
('bút chì', 2),
('bút xóa', 2),
('bút lông', 2),

('hộp bút', 3),
('hộp bút đẹp', 3),
('hộp bút dễ thương', 3),

('kẹp tài liệu', 4),
('đựng tài liệu', 4),
('bìa tài liệu', 4),

('thước kẻ', 5),
('thước kẻ nhựa', 5),
('thước kẻ gỗ', 5),

('gọt bút chì', 6),
('tẩy bút chì', 6),
('dụng cụ học tập', 6);



CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL
);
drop table cart
select*from cart
delete from cart

UPDATE products
SET status = 'Hết hàng'
WHERE stock = 0;


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Đang xử lý',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
select*from order_items
select*from orders


