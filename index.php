<?php
session_start();
include 'connectdb.php'; // Kết nối cơ sở dữ liệu

$category_id = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;
$search_keyword = isset($_GET['search']) ? trim($_GET['search']) : '';
$min_price = isset($_GET['min_price']) ? intval($_GET['min_price']) : 0;
$max_price = isset($_GET['max_price']) ? intval($_GET['max_price']) : 0;

$query = "SELECT * FROM products WHERE 1=1";
$params = [];

if ($search_keyword !== '') {
    $query .= " AND name LIKE :keyword";
    $params['keyword'] = '%' . $search_keyword . '%';
}

if ($category_id > 0) {
    $query .= " AND category_id = :category_id";
    $params['category_id'] = $category_id;
}

if ($min_price > 0) {
    $query .= " AND price >= :min_price";
    $params['min_price'] = $min_price;
}

if ($max_price > 0) {
    $query .= " AND price <= :max_price";
    $params['max_price'] = $max_price;
}

$stmt = $pdo->prepare($query);
$stmt->execute($params);

$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moji Shop</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/product.css">
    <script src="js/index.js"></script>
    <style>

    </style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="index.php">
                <img src="images/logo.png" alt="Moji Logo">
            </a>
        </div>

        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Tìm kiếm sản phẩm" autocomplete="off">
            <button type="button" id="searchButton">Tìm kiếm</button>
            <ul id="searchSuggestions" class="search-suggestions"></ul>
        </div>
        <div class="user-actions">
            <?php if(isset($_SESSION['username'])): ?>
                <span>Chào, <?php echo htmlspecialchars($_SESSION['username']); ?></span> |               
                    <a href="changepass.php">Đổi mật khẩu</a>
                    <a href="logout.php">Đăng xuất</a>
                
            <?php else: ?>
                <a href="login.php">Đăng nhập</a> | 
                <a href="register.php">Đăng ký</a>
            <?php endif; ?>
            <a href="cart.php" class="cart">🛒</a>
        </div>
    </header>
    <nav>
        <ul>
        <li><a href="index.php">Trang chủ</a></li>
            <li><a href="?category_id=1">Bút các loại</a></li>
            <li><a href="?category_id=2">Hộp bút</a></li>
            <li><a href="?category_id=3">Thước kẻ</a></li>
            <li><a href="?category_id=4">Kẹp/Đựng tài liệu</a></li>
            <li><a href="?category_id=5">Tập vở</a></li>
            <li><a href="?category_id=6">Dụng cụ học tập khác</a></li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main>

    <section class="products">
    <?php if (count($products) > 0): ?>
        <ul style="display: flex; flex-wrap: wrap; gap: 20px; padding: 0; list-style: none;">
            <?php foreach ($products as $product): ?>
                <?php 

                $category_image_path_map = [
                    1 => 'but', // Bút các loại
                    2 => 'bop', // Hộp bút
                    3 => 'thuoc', // Thước kẻ
                    4 => 'kep', // Kẹp/Đựng tài liệu
                    5 => 'tap', // Tập vở
                    6 => 'khac', // Dụng cụ học tập khác
                ];

                $image_subdirectory = $category_image_path_map[$product['category_id']];
                ?>
                
                <li class="product-item">
                    <img src="images/<?php echo htmlspecialchars($image_subdirectory); ?>/<?php echo htmlspecialchars($product['image']); ?>" alt="<?php echo htmlspecialchars($product['name']); ?>" class="product-image-small" />
                    <div class="product-summary">
                        <h3><?php echo htmlspecialchars($product['name']); ?></h3>
                        <p class="price"><?php echo number_format($product['price'], 0, ',', '.'); ?> VND</p>
                        <button class="details-button">Xem chi tiết</button>
                    </div>

                    <div class="product-full-details">
                        <img src="images/<?php echo htmlspecialchars($image_subdirectory); ?>/<?php echo htmlspecialchars($product['image']); ?>" alt="<?php echo htmlspecialchars($product['name']); ?>" class="product-image-large" />
                        <p class="product-description"><?php echo htmlspecialchars($product['description']); ?></p>
                        <form action="cart.php" method="POST">
                            <input type="hidden" name="product_id" value="<?php echo $product['id']; ?>">
                            <label for="quantity-<?php echo $product['id']; ?>">Số lượng:</label>
                            <input type="number" id="quantity-<?php echo $product['id']; ?>" name="quantity" value="1" min="1" class="quantity-input">
                            <button type="submit" class="add-to-cart">Thêm vào giỏ hàng</button>
                        </form>
                    </div>
                </li>
            <?php endforeach; ?>
        </ul>
    <?php else: ?>
        <p>Chưa có sản phẩm nào trong danh mục này.</p>
    <?php endif; ?>
</section>

<aside class="sidebar">
    <h2>TÌM SẢN PHẨM THEO GIÁ</h2>
    <hr>
    <ul>
        <li>
            <a href="#" class="category-toggle" data-category-id="1">Bút các loại</a>
            <ul class="sub-menu">
                <li><a href="?category_id=1&max_price=20000">Dưới 20000 VND</a></li>
                <li><a href="?category_id=1&min_price=20000&max_price=50000">Từ 20000 đến 50000 VND</a></li>
                <li><a href="?category_id=1&min_price=50000&max_price=100000">Từ 50000 đến 100000 VND</a></li>
                <li><a href="?category_id=1&min_price=100000">Trên 100000 VND</a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <li>
            <a href="#" class="category-toggle" data-category-id="2">Hộp bút</a>
            <ul class="sub-menu">
                <li><a href="?category_id=2&max_price=20000">Dưới 20000 VND</a></li>
                <li><a href="?category_id=2&min_price=20000&max_price=50000">Từ 20000 đến 50000 VND</a></li>
                <li><a href="?category_id=2&min_price=50000&max_price=100000">Từ 50000 đến 100000 VND</a></li>
                <li><a href="?category_id=2&min_price=100000">Trên 100000 VND</a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <li>
            <a href="#" class="category-toggle" data-category-id="3">Thước kẻ</a>
            <ul class="sub-menu">
                <li><a href="?category_id=3&max_price=20000">Dưới 20000 VND</a></li>
                <li><a href="?category_id=3&min_price=20000&max_price=50000">Từ 20000 đến 50000 VND</a></li>
                <li><a href="?category_id=3&min_price=50000&max_price=100000">Từ 50000 đến 100000 VND</a></li>
                <li><a href="?category_id=3&min_price=100000">Trên 100000 VND</a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <li>
            <a href="#" class="category-toggle" data-category-id="4">Kẹp/Đựng tài liệu</a>
            <ul class="sub-menu">
                <li><a href="?category_id=4&max_price=20000">Dưới 20000 VND</a></li>
                <li><a href="?category_id=4&min_price=20000&max_price=50000">Từ 20000 đến 50000 VND</a></li>
                <li><a href="?category_id=4&min_price=50000&max_price=100000">Từ 50000 đến 100000 VND</a></li>
                <li><a href="?category_id=4&min_price=100000">Trên 100000 VND</a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <li>
            <a href="#" class="category-toggle" data-category-id="5">Tập vở</a>
            <ul class="sub-menu">
                <li><a href="?category_id=5&max_price=20000">Dưới 20000 VND</a></li>
                <li><a href="?category_id=5&min_price=20000&max_price=50000">Từ 20000 đến 50000 VND</a></li>
                <li><a href="?category_id=5&min_price=50000&max_price=100000">Từ 50000 đến 100000 VND</a></li>
                <li><a href="?category_id=5&min_price=100000">Trên 100000 VND</a></li>
            </ul>
        </li>
    </ul>
    <ul>
        <li>
            <a href="#" class="category-toggle" data-category-id="6">Dụng cụ khác</a>
            <ul class="sub-menu">
                <li><a href="?category_id=6&max_price=20000">Dưới 20000 VND</a></li>
                <li><a href="?category_id=6&min_price=20000&max_price=50000">Từ 20000 đến 50000 VND</a></li>
                <li><a href="?category_id=6&min_price=50000&max_price=100000">Từ 50000 đến 100000 VND</a></li>
                <li><a href="?category_id=6&min_price=100000">Trên 100000 VND</a></li>
            </ul>
        </li>
    </ul>
</aside>

    </main>

    <!-- Footer Section -->
    <footer>
    <div class="contact-fanpage">
        <a href="#"><img src="/images/facebook.svg" alt="facebook"></a>
        <a href="#"><img src="/images/instagram.svg" alt="instagram"></a>
        <a href="#"><img src="/images/tiktok.svg" alt="tiktok"></a>
    </div>
    <div class="contact-info">
        <p><b>Phone</b>: 1-234-567-890</p>
        <p><b>Email</b>: info@mojishop.com</p>
    </div>
</footer>
</body>
</html>
