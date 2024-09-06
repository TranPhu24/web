CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'khach')) 
);
delete from USers
drop table USERS
select*from USERS

INSERT INTO users (username, password, phone, email, role) 
VALUES ('Phu', '$2y$10$n1oHXqpwqsrTFuPYKaIPGujx4BRm7vR.DHTFaMeT715.6Zb1kenkC',
		'123456789', 'admin@example.com', 'admin');

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
drop table categories


INSERT INTO categories (name) VALUES 
('Bút các loại'),
('Hộp bút'),
('Thước kẻ'),
('Kẹp/Đựng tài liệu'),
('Tập vở'),
('Dụng cụ học tập khác');
select *from categories
delete from categories

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

INSERT INTO products (name, description, price, quantity, status, image, category_id) VALUES 
('Bút bi đa năng', 'Bút bi đa năng với nhiều màu sắc.', 5000, 100, 'Còn hàng', 'b1.jpg', 1),
('Bút bi màu đen', 'Bút bi màu đen chất lượng cao.', 5500, 150, 'Còn hàng', 'b2.jpg', 1),
('Bút bi đỏ', 'Bút bi màu đỏ sáng tạo.', 6000, 100, 'Còn hàng', 'b3.jpg', 1),
('Bút bi màu xanh lá', 'Bút bi màu xanh lá thân thiện với môi trường.', 5000, 180, 'Còn hàng', 'b4.jpg', 1),
('Bút bi tím', 'Bút bi màu tím đặc biệt.', 5500, 120, 'Còn hàng', 'b5.jpg', 1),
('Bút bi vàng', 'Bút bi màu vàng nổi bật.', 6000, 130, 'Còn hàng', 'b6.jpg', 1),
('Bút bi màu cam', 'Bút bi màu cam dành cho trẻ em.', 5000, 160, 'Còn hàng', 'b7.jpg', 1),
('Bút bi nâu', 'Bút bi màu nâu cổ điển.', 5500, 140, 'Còn hàng', 'b8.jpg', 1),
('Bút bi bạc', 'Bút bi màu bạc sang trọng.', 6500, 110, 'Còn hàng', 'b9.jpg', 1),
('Bút bi vàng hồng', 'Bút bi màu vàng hồng nữ tính.', 7000, 90, 'Còn hàng', 'b10.jpg', 1),
('Bút bi xám', 'Bút bi màu xám cho doanh nhân.', 6000, 80, 'Còn hàng', 'b11.jpg', 1),
('Bút bi trắng', 'Bút bi màu trắng tinh khiết.', 5500, 50, 'Còn hàng', 'b12.jpg', 1),

-- Bút chì 
('Bút chì HB', 'Bút chì HB cho học sinh.', 3000, 200, 'Còn hàng', 'c1.jpg', 1),
('Bút chì 2B', 'Bút chì 2B viết mềm mại.', 3200, 150, 'Còn hàng', 'c2.jpg', 1),
('Bút chì 4B', 'Bút chì 4B dành cho nghệ thuật.', 3500, 120, 'Còn hàng', 'c3.jpg', 1),
('Bút chì 6B', 'Bút chì 6B cho bản vẽ đậm nét.', 3800, 100, 'Còn hàng', 'c4.jpg', 1),
('Bút chì màu xanh', 'Bút chì màu xanh thân thiện với môi trường.', 3300, 140, 'Còn hàng', 'c5.jpg', 1),
('Bút chì màu đỏ', 'Bút chì màu đỏ sáng tạo.', 3400, 130, 'Còn hàng', 'c6.jpg', 1),
('Bút chì màu vàng', 'Bút chì màu vàng tươi sáng.', 3500, 110, 'Còn hàng', 'c7.jpg', 1),
('Bút chì màu đen', 'Bút chì màu đen cổ điển.', 3600, 90, 'Còn hàng', 'c8.jpg', 1),
('Bút chì màu tím', 'Bút chì màu tím lạ mắt.', 3700, 80, 'Còn hàng', 'c9.jpg', 1),

-- Bút dạ 
('Bút dạ màu đỏ', 'Bút dạ màu đỏ nổi bật.', 7000, 200, 'Còn hàng', 'd1.jpg', 1),
('Bút dạ màu xanh', 'Bút dạ màu xanh đậm.', 7200, 150, 'Còn hàng', 'd2.jpg', 1),
('Bút dạ màu đen', 'Bút dạ màu đen mạnh mẽ.', 7500, 120, 'Còn hàng', 'd3.jpg', 1),
('Bút dạ màu vàng', 'Bút dạ màu vàng rực rỡ.', 7800, 100, 'Còn hàng', 'd4.jpg', 1),
('Bút dạ màu cam', 'Bút dạ màu cam sặc sỡ.', 7300, 140, 'Còn hàng', 'd5.jpg', 1),
('Bút dạ màu tím', 'Bút dạ màu tím sáng tạo.', 7400, 130, 'Còn hàng', 'd6.jpg', 1),
('Bút dạ màu hồng', 'Bút dạ màu hồng nữ tính.', 7500, 110, 'Còn hàng', 'd7.jpg', 1),
('Bút dạ màu xanh lá', 'Bút dạ màu xanh lá tươi mát.', 7600, 90, 'Còn hàng', 'd8.jpg', 1),
('Bút dạ màu nâu', 'Bút dạ màu nâu sang trọng.', 7700, 80, 'Còn hàng', 'd9.jpg', 1),
('Bút dạ màu bạc', 'Bút dạ màu bạc tinh tế.', 8000, 70, 'Còn hàng', 'd10.jpg', 1),

-- Bút lông 
('Bút lông màu đen', 'Bút lông màu đen cho nghệ thuật.', 9000, 50, 'Còn hàng', 'l1.jpg', 1),

-- Bóp đựng bút 
('Bóp đựng bút da màu nâu', 'Bóp đựng bút làm từ da màu nâu cao cấp.', 150000, 50, 'Còn hàng', 'h1.jpg', 2),
('Bóp đựng bút vải màu xanh', 'Bóp đựng bút vải bền màu xanh.', 120000, 70, 'Còn hàng', 'h2.jpg', 2),
('Bóp đựng bút nhựa trong suốt', 'Bóp đựng bút làm từ nhựa trong suốt, dễ dàng nhìn thấy bên trong.', 190000, 80, 'Còn hàng', 'h3.jpg', 2),
('Bóp đựng bút hoa văn cổ điển', 'Bóp đựng bút với hoa văn cổ điển, thích hợp cho mọi lứa tuổi.', 188000, 40, 'Còn hàng', 'h4.jpg', 2),
('Bóp đựng bút mini', 'Bóp đựng bút nhỏ gọn, tiện lợi mang theo.', 90000, 90, 'Còn hàng', 'h5.jpg', 2),
('Bóp đựng bút bằng da màu đen', 'Bóp đựng bút làm từ da màu đen sang trọng.', 160000, 60, 'Còn hàng', 'h6.jpg', 2),
('Bóp đựng bút họa tiết động vật', 'Bóp đựng bút với họa tiết động vật dễ thương.', 140000, 100, 'Còn hàng', 'h7.jpg', 2),
('Bóp đựng bút phong cách vintage', 'Bóp đựng bút phong cách vintage, thích hợp cho những ai yêu thích sự hoài cổ.', 176000, 30, 'Còn hàng', 'h8.jpg', 2),
('Bóp đựng bút màu pastel', 'Bóp đựng bút màu pastel nhẹ nhàng, trẻ trung.', 130000, 120, 'Còn hàng', 'h9.jpg', 2),
('Bóp đựng bút hình hoạt hình', 'Bóp đựng bút với hình các nhân vật hoạt hình nổi tiếng.', 11000, 150, 'Còn hàng', 'h10.jpg', 2),
('Bóp đựng bút kim loại', 'Bóp đựng bút làm từ kim loại bền bỉ, chắc chắn.', 70000, 20, 'Còn hàng', 'h11.jpg', 2),
('Bóp đựng bút đa ngăn', 'Bóp đựng bút với nhiều ngăn tiện lợi để sắp xếp đồ dùng.', 190000, 25, 'Còn hàng', 'h12.jpg', 2),
('Bóp đựng bút thổ cẩm', 'Bóp đựng bút làm từ vải thổ cẩm độc đáo.', 150000, 45, 'Còn hàng', 'h13.jpg', 2),
('Bóp đựng bút màu cam', 'Bóp đựng bút màu cam sáng, nổi bật.', 134000, 75, 'Còn hàng', 'h14.jpg', 2),
('Bóp đựng bút hình học', 'Bóp đựng bút với họa tiết hình học hiện đại.', 146000, 65, 'Còn hàng', 'h15.jpg', 2),
('Bóp đựng bút màu trắng', 'Bóp đựng bút màu trắng đơn giản và tinh tế.', 127000, 80, 'Còn hàng', 'h16.jpg', 2),
('Bóp đựng bút màu hồng', 'Bóp đựng bút màu hồng nữ tính.', 13000, 60, 'Còn hàng', 'h17.jpg', 2),
('Bóp đựng bút chống nước', 'Bóp đựng bút làm từ chất liệu chống nước, bảo vệ bút tốt hơn.', 17000, 55, 'Còn hàng', 'h18.jpg', 2),
('Bóp đựng bút ánh kim', 'Bóp đựng bút màu ánh kim lấp lánh, thời trang.', 165000, 40, 'Còn hàng', 'h19.jpg', 2),
('Bóp đựng bút màu xám', 'Bóp đựng bút màu xám trung tính, phù hợp với mọi lứa tuổi.', 152000, 85, 'Còn hàng', 'h20.jpg', 2),
('Bóp đựng bút hình tam giác', 'Bóp đựng bút thiết kế hình tam giác lạ mắt.', 145000, 70, 'Còn hàng', 'h21.jpg', 2),
('Bóp đựng bút da tổng hợp', 'Bóp đựng bút làm từ da tổng hợp, thân thiện với môi trường.', 181000, 50, 'Còn hàng', 'h22.jpg', 2),
('Bóp đựng bút mini màu xanh dương', 'Bóp đựng bút nhỏ gọn, màu xanh dương tươi mát.', 90000, 95, 'Còn hàng', 'h23.jpg', 2),
('Bóp đựng bút hình thoi', 'Bóp đựng bút với họa tiết hình thoi nổi bật.', 152000, 65, 'Còn hàng', 'h24.jpg', 2),
('Bóp đựng bút kháng khuẩn', 'Bóp đựng bút có khả năng kháng khuẩn, an toàn cho người dùng.', 198000, 50, 'Còn hàng', 'h25.jpg', 2),
('Bóp đựng bút màu tím', 'Bóp đựng bút màu tím nhẹ nhàng.', 138000, 100, 'Còn hàng', 'h26.jpg', 2),
('Bóp đựng bút họa tiết chấm bi', 'Bóp đựng bút với họa tiết chấm bi đáng yêu.', 12000, 110, 'Còn hàng', 'h27.jpg', 2),
('Bóp đựng bút màu đỏ', 'Bóp đựng bút màu đỏ đậm, cá tính.', 142000, 90, 'Còn hàng', 'h28.jpg', 2),
('Bóp đựng bút màu bạc', 'Bóp đựng bút màu bạc sang trọng.', 164000, 40, 'Còn hàng', 'h29.jpg', 2),
('Bóp đựng bút màu vàng', 'Bóp đựng bút màu vàng tươi sáng.', 130000, 80, 'Còn hàng', 'h30.jpg', 2),
('Bóp đựng bút phong cách quân đội', 'Bóp đựng bút với họa tiết quân đội mạnh mẽ.', 156000, 70, 'Còn hàng', 'h31.jpg', 2),
('Bóp đựng bút họa tiết hoa', 'Bóp đựng bút với họa tiết hoa tinh tế.', 149000, 60, 'Còn hàng', 'h32.jpg', 2),
('Bóp đựng bút màu nâu đất', 'Bóp đựng bút màu nâu đất ấm áp.', 103000, 85, 'Còn hàng', 'h33.jpg', 2),
('Bóp đựng bút đa chức năng', 'Bóp đựng bút với nhiều ngăn và chức năng tiện lợi.', 20000, 30, 'Còn hàng', 'h34.jpg', 2),
('Bóp đựng bút màu xanh lá', 'Bóp đựng bút màu xanh lá tươi mát.', 122000, 90, 'Còn hàng', 'h35.jpg', 2),
('Bóp đựng bút hình vuông', 'Bóp đựng bút thiết kế hình vuông độc đáo.', 157000, 50, 'Còn hàng', 'h36.jpg', 2),
('Bóp đựng bút màu đen', 'Bóp đựng bút màu đen huyền bí.', 128000, 95, 'Còn hàng', 'h37.jpg', 2),
('Bóp đựng bút họa tiết lập phương', 'Bóp đựng bút với họa tiết lập phương hiện đại.', 145000, 75, 'Còn hàng', 'h38.jpg', 2),
('Bóp đựng bút thiết kế đơn giản', 'Bóp đựng bút thiết kế đơn giản nhưng tinh tế.', 137000, 65, 'Còn hàng', 'h39.jpg', 2),
('Bóp đựng bút phong cách thể thao', 'Bóp đựng bút thiết kế dành riêng cho người yêu thể thao.', 152000, 55, 'Còn hàng', 'h40.jpg', 2),
('Bóp đựng bút màu xanh navy', 'Bóp đựng bút màu xanh navy cổ điển.', 126000, 85, 'Còn hàng', 'h41.jpg', 2),
('Bóp đựng bút màu hồng nhạt', 'Bóp đựng bút màu hồng nhạt dễ thương.', 137000, 75, 'Còn hàng', 'h42.jpg', 2),

('Thước kẻ 15cm nhựa trong', 'Thước kẻ 15cm làm từ nhựa trong suốt, dễ dàng nhìn thấy giấy bên dưới.', 3000, 200, 'Còn hàng', 'R1.jpg', 3),
('Thước kẻ 20cm nhựa màu xanh', 'Thước kẻ 20cm nhựa màu xanh, bền và chắc chắn.', 3500, 180, 'Còn hàng', 'R2.jpg', 3),
('Thước kẻ 30cm kim loại', 'Thước kẻ 30cm làm từ kim loại, chống gãy và bền bỉ.', 7000, 150, 'Còn hàng', 'R3.jpg', 3),
('Thước kẻ 15cm màu đỏ', 'Thước kẻ 15cm màu đỏ nổi bật, dễ dàng sử dụng.', 3000, 220, 'Còn hàng', 'R4.jpg', 3),
('Thước kẻ dẻo 20cm', 'Thước kẻ dẻo 20cm, có thể uốn cong mà không bị gãy.', 4000, 170, 'Còn hàng', 'R5.jpg', 3),
('Thước kẻ 30cm màu vàng', 'Thước kẻ 30cm màu vàng sáng, dễ dàng nhìn thấy trên giấy trắng.', 3500, 190, 'Còn hàng', 'R6.jpg', 3),
('Thước kẻ 20cm nhựa trong có họa tiết', 'Thước kẻ 20cm nhựa trong suốt có họa tiết trang trí.', 3200, 210, 'Còn hàng', 'R7.jpg', 3),
('Thước kẻ 30cm kim loại mạ bạc', 'Thước kẻ 30cm làm từ kim loại mạ bạc, sang trọng và bền.', 8000, 130, 'Còn hàng', 'R8.jpg', 3),
('Thước kẻ 15cm màu tím', 'Thước kẻ 15cm màu tím, thích hợp cho học sinh.', 3000, 200, 'Còn hàng', 'R9.jpg', 3),
('Thước kẻ 20cm có thước đo góc', 'Thước kẻ 20cm tích hợp thước đo góc, tiện lợi và đa dụng.', 5000, 140, 'Còn hàng', 'R10.jpg', 3),
('Thước kẻ dẻo 30cm', 'Thước kẻ dẻo 30cm, có thể uốn cong linh hoạt.', 4500, 160, 'Còn hàng', 'R11.jpg', 3),
('Thước kẻ 15cm gỗ', 'Thước kẻ 15cm làm từ gỗ tự nhiên, thân thiện với môi trường.', 6000, 110, 'Còn hàng', 'R12.jpg', 3),
('Thước kẻ 20cm màu cam', 'Thước kẻ 20cm màu cam tươi sáng.', 3500, 150, 'Còn hàng', 'R13.jpg', 3),
('Thước kẻ 30cm nhựa trong', 'Thước kẻ 30cm làm từ nhựa trong suốt, dễ dàng nhìn thấy giấy bên dưới.', 4000, 180, 'Còn hàng', 'R14.jpg', 3),
('Thước kẻ 15cm kim loại', 'Thước kẻ 15cm làm từ kim loại, bền bỉ và chắc chắn.', 5000, 140, 'Còn hàng', 'R15.jpg', 3),
('Thước kẻ 20cm màu hồng', 'Thước kẻ 20cm màu hồng, dễ thương và phù hợp với các bạn nữ.', 3500, 160, 'Còn hàng', 'R16.jpg', 3),
('Thước kẻ dẻo 15cm', 'Thước kẻ dẻo 15cm, có thể uốn cong mà không bị gãy.', 3500, 190, 'Còn hàng', 'R17.jpg', 3),
('Thước kẻ 30cm gỗ', 'Thước kẻ 30cm làm từ gỗ, thích hợp cho học sinh.', 7000, 120, 'Còn hàng', 'R18.jpg', 3),
('Thước kẻ 15cm màu xanh lá', 'Thước kẻ 15cm màu xanh lá, thân thiện và dễ sử dụng.', 3000, 210, 'Còn hàng', 'R19.jpg', 3),
('Thước kẻ 20cm có lỗ', 'Thước kẻ 20cm với thiết kế có lỗ để vẽ hình tròn dễ dàng.', 4500, 140, 'Còn hàng', 'R20.jpg', 3),
('Thước kẻ 30cm màu đen', 'Thước kẻ 30cm màu đen chuyên nghiệp.', 4000, 150, 'Còn hàng', 'R21.jpg', 3),
('Thước kẻ 15cm màu bạc', 'Thước kẻ 15cm màu bạc sáng bóng, nổi bật.', 3500, 180, 'Còn hàng', 'R22.jpg', 3),
('Thước kẻ 20cm dẻo trong suốt', 'Thước kẻ 20cm dẻo trong suốt, linh hoạt và dễ sử dụng.', 4000, 160, 'Còn hàng', 'R23.jpg', 3),
('Thước kẻ 30cm có tay cầm', 'Thước kẻ 30cm với tay cầm tiện lợi khi sử dụng.', 5000, 130, 'Còn hàng', 'R24.jpg', 3),
('Thước kẻ 15cm màu vàng', 'Thước kẻ 15cm màu vàng nổi bật.', 3000, 200, 'Còn hàng', 'R25.jpg', 3),
('Thước kẻ 20cm kim loại', 'Thước kẻ 20cm làm từ kim loại, bền chắc.', 6000, 120, 'Còn hàng', 'R26.jpg', 3),
('Thước kẻ 30cm nhựa dẻo màu xanh', 'Thước kẻ 30cm nhựa dẻo màu xanh, linh hoạt.', 4500, 170, 'Còn hàng', 'R27.jpg', 3),
('Thước kẻ 15cm nhựa dẻo', 'Thước kẻ 15cm nhựa dẻo, dễ sử dụng và bền bỉ.', 3500, 190, 'Còn hàng', 'R28.jpg', 3),
('Thước kẻ 20cm màu nâu', 'Thước kẻ 20cm màu nâu cổ điển.', 3500, 180, 'Còn hàng', 'R29.jpg', 3),
('Thước kẻ 30cm màu trắng', 'Thước kẻ 30cm màu trắng đơn giản.', 4000, 150, 'Còn hàng', 'R30.jpg', 3),
('Thước kẻ 15cm màu xanh dương', 'Thước kẻ 15cm màu xanh dương tươi sáng.', 3000, 160, 'Còn hàng', 'R31.jpg', 3),
('Thước kẻ 20cm màu tím', 'Thước kẻ 20cm màu tím, lạ mắt và thu hút.', 3500, 140, 'Còn hàng', 'R32.jpg', 3),
('Thước kẻ 30cm trong suốt có vạch', 'Thước kẻ 30cm trong suốt với các vạch đo rõ ràng.', 4000, 180, 'Còn hàng', 'R33.jpg', 3),
('Thước kẻ 15cm màu cam', 'Thước kẻ 15cm màu cam năng động.', 3000, 190, 'Còn hàng', 'R34.jpg', 3),
('Thước kẻ 20cm gỗ', 'Thước kẻ 20cm làm từ gỗ, bền bỉ và thân thiện với môi trường.', 6000, 110, 'Còn hàng', 'R35.jpg', 3),
('Thước kẻ 30cm màu xanh lá', 'Thước kẻ 30cm màu xanh lá tươi mát.', 4000, 150, 'Còn hàng', 'R36.jpg', 3),

('Kẹp tài liệu nhựa màu xanh', 'Kẹp tài liệu nhựa bền màu xanh, phù hợp cho văn phòng.', 5000, 100, 'Còn hàng', 'k1.jpg', 4),
('Kẹp tài liệu kim loại', 'Kẹp tài liệu kim loại chắc chắn, giữ tài liệu an toàn.', 8000, 150, 'Còn hàng', 'k2.jpg', 4),
('Kẹp tài liệu màu đỏ', 'Kẹp tài liệu màu đỏ nổi bật, dễ dàng nhận biết.', 5000, 200, 'Còn hàng', 'k3.jpg', 4),
('Kẹp tài liệu mini', 'Kẹp tài liệu kích thước nhỏ gọn, tiện lợi.', 3000, 300, 'Còn hàng', 'k4.jpg', 4),
('Kẹp tài liệu màu đen', 'Kẹp tài liệu màu đen chuyên nghiệp, phù hợp với môi trường văn phòng.', 5000, 120, 'Còn hàng', 'k5.jpg', 4),
('Kẹp tài liệu nhựa trong', 'Kẹp tài liệu nhựa trong suốt, cho phép nhìn rõ nội dung bên trong.', 6000, 80, 'Còn hàng', 'k6.jpg', 4),
('Kẹp tài liệu dạng kẹp giấy', 'Kẹp tài liệu dạng kẹp giấy, dễ sử dụng và lưu trữ.', 4000, 250, 'Còn hàng', 'k7.jpg', 4),
('Kẹp tài liệu màu vàng', 'Kẹp tài liệu màu vàng tươi sáng, giúp phân loại tài liệu dễ dàng.', 5000, 100, 'Còn hàng', 'k8.jpg', 4),
('Kẹp tài liệu kim loại màu bạc', 'Kẹp tài liệu kim loại màu bạc sáng bóng.', 8500, 70, 'Còn hàng', 'k9.jpg', 4),
('Kẹp tài liệu với hoa văn', 'Kẹp tài liệu có hoa văn trang trí, thêm phần thẩm mỹ cho tài liệu.', 7000, 90, 'Còn hàng', 'k10.jpg', 4),
('Kẹp tài liệu màu tím', 'Kẹp tài liệu màu tím nhẹ nhàng, phù hợp cho mọi lứa tuổi.', 5000, 150, 'Còn hàng', 'k11.jpg', 4),
('Kẹp tài liệu nhựa màu cam', 'Kẹp tài liệu nhựa bền màu cam.', 5000, 120, 'Còn hàng', 'k12.jpg', 4),
('Kẹp tài liệu gỗ', 'Kẹp tài liệu làm từ gỗ tự nhiên, thân thiện với môi trường.', 9000, 50, 'Còn hàng', 'k13.jpg', 4),
('Kẹp tài liệu màu xanh lá', 'Kẹp tài liệu màu xanh lá tươi mát, mang lại cảm giác dễ chịu.', 5000, 110, 'Còn hàng', 'k14.jpg', 4),
('Kẹp tài liệu đa năng', 'Kẹp tài liệu đa năng, có thể sử dụng cho nhiều loại giấy tờ.', 10000, 60, 'Còn hàng', 'k15.jpg', 4),
('Kẹp tài liệu kim loại màu đen', 'Kẹp tài liệu kim loại màu đen, chắc chắn và bền bỉ.', 8500, 130, 'Còn hàng', 'k16.jpg', 4),
('Kẹp tài liệu màu hồng', 'Kẹp tài liệu màu hồng dễ thương.', 5000, 140, 'Còn hàng', 'k17.jpg', 4),
('Kẹp tài liệu nhựa cứng', 'Kẹp tài liệu làm từ nhựa cứng, đảm bảo độ bền.', 6000, 90, 'Còn hàng', 'k18.jpg', 4),
('Kẹp tài liệu màu trắng', 'Kẹp tài liệu màu trắng tinh tế, phù hợp với mọi không gian.', 5000, 100, 'Còn hàng', 'k19.jpg', 4),
('Kẹp tài liệu họa tiết chấm bi', 'Kẹp tài liệu với họa tiết chấm bi độc đáo.', 7000, 80, 'Còn hàng', 'k20.jpg', 4),
('Kẹp tài liệu màu nâu', 'Kẹp tài liệu màu nâu cổ điển.', 5000, 95, 'Còn hàng', 'k21.jpg', 4),
('Kẹp tài liệu với tay cầm', 'Kẹp tài liệu có tay cầm, tiện lợi khi sử dụng.', 8500, 50, 'Còn hàng', 'k22.jpg', 4),
('Kẹp tài liệu màu bạc', 'Kẹp tài liệu màu bạc sang trọng.', 8000, 120, 'Còn hàng', 'k23.jpg', 4),
('Kẹp tài liệu nhựa dẻo', 'Kẹp tài liệu làm từ nhựa dẻo, linh hoạt và dễ sử dụng.', 4000, 160, 'Còn hàng', 'k24.jpg', 4),
('Kẹp tài liệu màu xanh dương', 'Kẹp tài liệu màu xanh dương tươi mát.', 5000, 130, 'Còn hàng', 'k25.jpg', 4),
('Kẹp tài liệu kim loại màu vàng', 'Kẹp tài liệu kim loại màu vàng, chắc chắn và nổi bật.', 9000, 80, 'Còn hàng', 'k26.jpg', 4),
('Kẹp tài liệu màu đen với hoa văn', 'Kẹp tài liệu màu đen với hoa văn trang trí.', 7500, 110, 'Còn hàng', 'k27.jpg', 4),
('Kẹp tài liệu bằng thép không gỉ', 'Kẹp tài liệu làm từ thép không gỉ, bền bỉ với thời gian.', 10000, 60, 'Còn hàng', 'k28.jpg', 4),
('Kẹp tài liệu màu xám', 'Kẹp tài liệu màu xám hiện đại.', 5000, 90, 'Còn hàng', 'k29.jpg', 4),
('Kẹp tài liệu họa tiết hoa', 'Kẹp tài liệu với họa tiết hoa đẹp mắt.', 7000, 70, 'Còn hàng', 'k30.jpg', 4),
('Kẹp tài liệu màu cam', 'Kẹp tài liệu màu cam năng động.', 5000, 140, 'Còn hàng', 'k31.jpg', 4),
('Kẹp tài liệu nhựa mềm', 'Kẹp tài liệu làm từ nhựa mềm, dễ dàng sử dụng.', 4500, 150, 'Còn hàng', 'k32.jpg', 4),
('Kẹp tài liệu màu xanh ngọc', 'Kẹp tài liệu màu xanh ngọc tươi sáng.', 5000, 80, 'Còn hàng', 'k33.jpg', 4),

('Tập vở viết 100 trang', 'Tập vở viết 100 trang giấy trắng, chất lượng cao.', 10000, 150, 'Còn hàng', 'T1.jpg', 5),
('Tập vở viết 200 trang', 'Tập vở viết 200 trang giấy dày, bền đẹp.', 15000, 120, 'Còn hàng', 'T2.jpg', 5),
('Tập vở viết màu xanh', 'Tập vở viết với bìa màu xanh tươi mát.', 12000, 100, 'Còn hàng', 'T3.jpg', 5),
('Tập vở viết có họa tiết', 'Tập vở viết trang trí họa tiết sáng tạo.', 13000, 90, 'Còn hàng', 'T4.jpg', 5),
('Tập vở viết kẻ ngang', 'Tập vở viết kẻ ngang dễ dàng ghi chép.', 11000, 110, 'Còn hàng', 'T5.jpg', 5),
('Tập vở viết kẻ ô ly', 'Tập vở viết kẻ ô ly, thích hợp cho học sinh.', 11500, 130, 'Còn hàng', 'T6.jpg', 5),
('Tập vở viết bìa cứng', 'Tập vở viết bìa cứng, bảo vệ trang viết tốt.', 14000, 70, 'Còn hàng', 'T7.jpg', 5),
('Tập vở viết màu đỏ', 'Tập vở viết với bìa màu đỏ nổi bật.', 12000, 85, 'Còn hàng', 'T8.jpg', 5),
('Tập vở viết 50 trang', 'Tập vở viết 50 trang nhỏ gọn, tiện lợi.', 8000, 200, 'Còn hàng', 'T9.jpg', 5),
('Tập vở viết cho học sinh', 'Tập vở viết thiết kế dành riêng cho học sinh.', 10000, 150, 'Còn hàng', 'T10.jpg', 5),
('Tập vở viết bìa nhựa', 'Tập vở viết bìa nhựa chống thấm nước.', 13000, 95, 'Còn hàng', 'T11.jpg', 5),
('Tập vở viết bìa mềm', 'Tập vở viết bìa mềm, dễ dàng mang theo.', 9000, 160, 'Còn hàng', 'T12.jpg', 5),
('Tập vở viết màu vàng', 'Tập vở viết với bìa màu vàng sáng.', 12000, 140, 'Còn hàng', 'T13.jpg', 5),
('Tập vở viết có hình ảnh', 'Tập vở viết với bìa có hình ảnh đẹp mắt.', 12500, 130, 'Còn hàng', 'T14.jpg', 5),
('Tập vở viết 150 trang', 'Tập vở viết 150 trang, đủ dùng cho học kỳ.', 13000, 100, 'Còn hàng', 'T15.jpg', 5),
('Tập vở viết màu tím', 'Tập vở viết với bìa màu tím lãng mạn.', 12000, 80, 'Còn hàng', 'T16.jpg', 5),
('Tập vở viết giấy tái chế', 'Tập vở viết làm từ giấy tái chế, thân thiện với môi trường.', 14000, 70, 'Còn hàng', 'T17.jpg', 5),
('Tập vở viết phong cách vintage', 'Tập vở viết với bìa phong cách vintage cổ điển.', 15000, 60, 'Còn hàng', 'T18.jpg', 5),
('Tập vở viết có dây cột', 'Tập vở viết có dây cột tiện lợi.', 13500, 90, 'Còn hàng', 'T19.jpg', 5),
('Tập vở viết màu đen', 'Tập vở viết với bìa màu đen chuyên nghiệp.', 12000, 85, 'Còn hàng', 'T20.jpg', 5),
('Tập vở viết kẻ chấm', 'Tập vở viết kẻ chấm giúp ghi chú chính xác.', 11500, 75, 'Còn hàng', 'T21.jpg', 5),
('Tập vở viết màu cam', 'Tập vở viết với bìa màu cam năng động.', 12000, 110, 'Còn hàng', 'T22.jpg', 5),
('Tập vở viết bìa màu hồng', 'Tập vở viết với bìa màu hồng dễ thương.', 12500, 95, 'Còn hàng', 'T23.jpg', 5),
('Tập vở viết bìa màu xanh lá', 'Tập vở viết với bìa màu xanh lá tươi mát.', 12000, 105, 'Còn hàng', 'T24.jpg', 5),
('Tập vở viết khổ nhỏ', 'Tập vở viết khổ nhỏ, tiện lợi bỏ túi.', 9000, 180, 'Còn hàng', 'T25.jpg', 5),
('Tập vở viết khổ lớn', 'Tập vở viết khổ lớn, ghi chú thoải mái.', 15000, 70, 'Còn hàng', 'T26.jpg', 5),
('Tập vở viết có in logo', 'Tập vở viết có in logo doanh nghiệp.', 16000, 50, 'Còn hàng', 'T27.jpg', 5),
('Tập vở viết màu xám', 'Tập vở viết với bìa màu xám thanh lịch.', 12000, 100, 'Còn hàng', 'T28.jpg', 5),
('Tập vở viết bìa màu nâu', 'Tập vở viết với bìa màu nâu ấm áp.', 13000, 120, 'Còn hàng', 'T29.jpg', 5),
('Tập vở viết có kẹp', 'Tập vở viết có kẹp, giữ giấy chắc chắn.', 13500, 80, 'Còn hàng', 'T30.jpg', 5),
('Tập vở viết có túi đựng', 'Tập vở viết có túi đựng đồ tiện lợi.', 14000, 60, 'Còn hàng', 'T31.jpg', 5),

('Dao rọc giấy lưỡi lớn', 'Dao rọc giấy lưỡi lớn, thích hợp để cắt các vật liệu dày.', 12000, 100, 'Còn hàng', 'D1.jpg', 6),
('Dao rọc giấy lưỡi nhỏ', 'Dao rọc giấy lưỡi nhỏ, phù hợp để cắt giấy và các vật liệu mỏng.', 10000, 150, 'Còn hàng', 'D2.jpg', 6),
('Dao rọc giấy an toàn', 'Dao rọc giấy với thiết kế an toàn, dễ sử dụng.', 15000, 90, 'Còn hàng', 'D3.jpg', 6),
('Dao rọc giấy lưỡi rút', 'Dao rọc giấy có lưỡi rút, tiện lợi và an toàn khi sử dụng.', 13000, 120, 'Còn hàng', 'D4.jpg', 6),
('Dao rọc giấy lưỡi xoay', 'Dao rọc giấy lưỡi xoay, dễ dàng cắt theo nhiều góc độ.', 14000, 110, 'Còn hàng', 'D5.jpg', 6),
('Dao rọc giấy đa năng', 'Dao rọc giấy đa năng với nhiều chức năng cắt khác nhau.', 16000, 80, 'Còn hàng', 'D6.jpg', 6),

-- Lịch 2025 
('Lịch 2025 treo tường', 'Lịch 2025 treo tường, thiết kế đẹp mắt và tiện dụng.', 25000, 200, 'Còn hàng', 'L1.jpg', 6),
('Lịch 2025 để bàn', 'Lịch 2025 để bàn, nhỏ gọn và tiện lợi cho văn phòng.', 20000, 180, 'Còn hàng', 'L2.jpg', 6),
('Lịch 2025 mini', 'Lịch 2025 mini, phù hợp để đặt trên bàn làm việc.', 15000, 220, 'Còn hàng', 'L3.jpg', 6),
('Lịch 2025 hình động vật', 'Lịch 2025 với hình ảnh động vật dễ thương.', 18000, 160, 'Còn hàng', 'L4.jpg', 6),
('Lịch 2025 phong cảnh', 'Lịch 2025 với hình ảnh phong cảnh đẹp mắt.', 23000, 140, 'Còn hàng', 'L5.jpg', 6),
('Lịch 2025 doanh nghiệp', 'Lịch 2025 in logo doanh nghiệp, thích hợp để tặng khách hàng.', 30000, 100, 'Còn hàng', 'L6.jpg', 6),
('Lịch 2025 treo tường cỡ lớn', 'Lịch 2025 treo tường kích thước lớn, rõ ràng và dễ nhìn.', 35000, 70, 'Còn hàng', 'L7.jpg', 6),
('Lịch 2025 để bàn cỡ nhỏ', 'Lịch 2025 để bàn kích thước nhỏ gọn, tiện lợi.', 15000, 190, 'Còn hàng', 'L8.jpg', 6),
('Lịch 2025 tết', 'Lịch 2025 chủ đề Tết với nhiều hình ảnh truyền thống.', 27000, 130, 'Còn hàng', 'L9.jpg', 6),
('Lịch 2025 nghệ thuật', 'Lịch 2025 với các bức tranh nghệ thuật nổi tiếng.', 32000, 85, 'Còn hàng', 'L10.jpg', 6),
('Lịch 2025 theo ngày', 'Lịch 2025 với từng ngày riêng biệt, dễ dàng ghi chú.', 29000, 120, 'Còn hàng', 'L11.jpg', 6),
('Lịch 2025 trẻ em', 'Lịch 2025 dành cho trẻ em với hình ảnh vui nhộn.', 20000, 200, 'Còn hàng', 'L12.jpg', 6),
('Lịch 2025 thiết kế hiện đại', 'Lịch 2025 với thiết kế hiện đại, phù hợp cho không gian sống.', 25000, 140, 'Còn hàng', 'L13.jpg', 6),

-- Móc khóa 
('Móc khóa kim loại', 'Móc khóa làm từ kim loại bền bỉ, thiết kế sang trọng.', 10000, 300, 'Còn hàng', 'M1.jpg', 6),
('Móc khóa nhựa hình động vật', 'Móc khóa nhựa với hình các con vật dễ thương.', 7000, 400, 'Còn hàng', 'M2.jpg', 6),
('Móc khóa gỗ', 'Móc khóa làm từ gỗ tự nhiên, thân thiện với môi trường.', 9000, 250, 'Còn hàng', 'M3.jpg', 6),
('Móc khóa đa năng', 'Móc khóa đa năng với nhiều công dụng khác nhau.', 15000, 150, 'Còn hàng', 'M4.jpg', 6),
('Móc khóa LED', 'Móc khóa tích hợp đèn LED, chiếu sáng tiện lợi.', 12000, 200, 'Còn hàng', 'M5.jpg', 6),
('Móc khóa hình trái tim', 'Móc khóa hình trái tim, thích hợp làm quà tặng.', 8000, 350, 'Còn hàng', 'M6.jpg', 6),
('Móc khóa khắc tên', 'Móc khóa có thể khắc tên theo yêu cầu.', 20000, 100, 'Còn hàng', 'M7.jpg', 6),
('Móc khóa bông', 'Móc khóa hình bông mềm mại và dễ thương.', 11000, 180, 'Còn hàng', 'M8.jpg', 6),
('Móc khóa hình siêu nhân', 'Móc khóa với hình ảnh siêu nhân nổi tiếng.', 9000, 240, 'Còn hàng', 'M9.jpg', 6),
('Móc khóa nam châm', 'Móc khóa có nam châm, dễ dàng gắn vào bề mặt kim loại.', 14000, 130, 'Còn hàng', 'M10.jpg', 6),
('Móc khóa hình ngôi sao', 'Móc khóa hình ngôi sao lấp lánh.', 10000, 220, 'Còn hàng', 'M11.jpg', 6),
('Móc khóa màu sắc', 'Móc khóa với nhiều màu sắc khác nhau.', 7000, 300, 'Còn hàng', 'M12.jpg', 6),
('Móc khóa thông minh', 'Móc khóa thông minh có thể định vị qua GPS.', 30000, 50, 'Còn hàng', 'M13.jpg', 6),

-- Giấy Note 
('Giấy Note màu vàng', 'Giấy Note màu vàng, dễ dàng ghi chú và dán vào tài liệu.', 5000, 200, 'Còn hàng', 'N1.jpg', 6),
('Giấy Note nhiều màu', 'Giấy Note nhiều màu sắc, thích hợp cho văn phòng.', 7000, 180, 'Còn hàng', 'N2.jpg', 6),
('Giấy Note hình trái tim', 'Giấy Note hình trái tim, dễ thương và sáng tạo.', 6000, 150, 'Còn hàng', 'N3.jpg', 6),
('Giấy Note hình vuông', 'Giấy Note hình vuông truyền thống.', 5000, 220, 'Còn hàng', 'N4.jpg', 6),
('Giấy Note có dòng kẻ', 'Giấy Note có dòng kẻ, tiện lợi cho việc ghi chú.', 5500, 200, 'Còn hàng', 'N5.jpg', 6),
('Giấy Note chống nước', 'Giấy Note làm từ chất liệu chống nước, bền bỉ.', 8000, 120, 'Còn hàng', 'N6.jpg', 6),
('Giấy Note hình ngôi sao', 'Giấy Note hình ngôi sao độc đáo.', 6000, 180, 'Còn hàng', 'N7.jpg', 6),
('Giấy Note nhỏ gọn', 'Giấy Note kích thước nhỏ gọn, tiện lợi mang theo.', 4000, 250, 'Còn hàng', 'N8.jpg', 6),
('Giấy Note hình hoa', 'Giấy Note hình hoa xinh xắn.', 7000, 140, 'Còn hàng', 'N9.jpg', 6),
('Giấy Note có hình', 'Giấy Note với các hình ảnh minh họa vui nhộn.', 7500, 160, 'Còn hàng', 'N10.jpg', 6),
('Giấy Note màu hồng', 'Giấy Note màu hồng dễ thương.', 5000, 190, 'Còn hàng', 'N11.jpg', 6),
('Giấy Note 3D', 'Giấy Note 3D, tạo hiệu ứng thị giác thú vị.', 9000, 100, 'Còn hàng', 'N12.jpg', 6),
('Giấy Note kèm bút', 'Giấy Note đi kèm với bút viết tiện lợi.', 10000, 80, 'Còn hàng', 'N13.jpg', 6),
('Giấy Note trong suốt', 'Giấy Note trong suốt, có thể ghi chú mà không che nội dung.', 7000, 170, 'Còn hàng', 'N14.jpg', 6),

-- Quạt 
('Quạt mini USB', 'Quạt mini cắm USB, nhỏ gọn và tiện lợi.', 20000, 100, 'Còn hàng', 'Q1.jpg', 6),
('Quạt cầm tay', 'Quạt cầm tay tiện lợi, có thể mang theo mọi nơi.', 15000, 130, 'Còn hàng', 'Q2.jpg', 6),
('Quạt để bàn', 'Quạt để bàn, thích hợp cho văn phòng.', 25000, 90, 'Còn hàng', 'Q3.jpg', 6),

('Gọt bút chì', 'Gọt bút chì G1', 12000, 100, 'Còn hàng', 'G1.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G2', 34000, 100, 'Còn hàng', 'G2.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G3', 37000, 100, 'CÒn hàng', 'G3.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G4', 10000, 100, 'Còn hàng', 'G4.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G5', 22000, 100, 'Còn hàng', 'G5.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G6', 11000, 100, 'Còn hàng', 'G6.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G7', 15000, 100, 'Còn hàng', 'G7.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G8', 19000, 100, 'Còn hàng', 'G8.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G9', 16000, 100, 'Còn hàng', 'G9.jpg', 6),
('Gọt bút chì', 'Gọt bút chì G10', 19000, 100, 'Còn hàng', 'G10.jpg', 6);

select*from products
delete from products





CREATE TABLE search_keywords (
    id SERIAL PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);
drop table search_keywords


INSERT INTO search_keywords (keyword, category_id) VALUES

('Bút bi', 1),
('Bút chì', 1),
('Bút dạ', 1),
('Bút lông', 1),

('bút bi', 1),
('bút chì', 1),
('bút dạ', 1),
('bút lông', 1),

('Bóp bút', 2),
('bóp bút', 2),

('Thước kẻ', 3),
('thước kẻ', 3),

('kẹp tài liệu', 4),
('Kẹp tài liệu', 4),

('Tập vở', 5),
('tập vở', 5),


('gọt bút chì', 6),
('Gọt bút chì', 6),
('Giấy Note', 6),
('giấy Note', 6),
('Dao rọc giấy', 6),
('dao rọc giấy', 6),
('Móc', 6),
('Quạt', 6);
delete from search_keywords
select*from search_keywords



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
WHERE quantity = 0;


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Đang xử lý',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
drop table orders
select*from orders
delete from orders

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
drop table order_items
delete from order_items
select*from order_items



