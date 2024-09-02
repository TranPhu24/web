<?php
session_start();
include 'connectdb.php'; // Kết nối cơ sở dữ liệu

$category_id = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;
$search_keyword = isset($_GET['search']) ? trim($_GET['search']) : '';

if ($search_keyword !== '') {
    $stmt = $pdo->prepare("SELECT * FROM products WHERE name LIKE :keyword");
    $stmt->execute(['keyword' => '%' . $search_keyword . '%']);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
} elseif ($category_id > 0) {
    $stmt = $pdo->prepare("SELECT * FROM products WHERE category_id = :category_id");
    $stmt->execute(['category_id' => $category_id]);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    $stmt = $pdo->query("SELECT * FROM products");
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
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
        .search-suggestions {
            border: 1px solid #ddd;
            max-height: 150px;
            overflow-y: auto;
            position: absolute;
            background-color: white;
            width: 300px;
            display: none;
            z-index: 1000;
        }
        .search-suggestions li {
            padding: 10px;
            cursor: pointer;
        }
        .search-suggestions li:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <a href="index2.php">
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
            <li><a href="?category_id=1">Đựng bút đa năng</a></li>
            <li><a href="?category_id=2">Bút các loại</a></li>
            <li><a href="?category_id=3">Hộp bút</a></li>
            <li><a href="?category_id=4">Kẹp/Đựng tài liệu</a></li>
            <li><a href="?category_id=5">Thước kẻ</a></li>
            <li><a href="?category_id=6">Dụng cụ học tập khác</a></li>
        </ul>
    </nav>
    <!-- Main Content -->
    <main>
        <section class="products">
            <?php if (count($products) > 0): ?>
                <ul style="display: flex; flex-wrap: wrap; gap: 20px; padding: 0; list-style: none;">
                    <?php foreach ($products as $product): ?>
                        <li class="product-item">
                            <img src="images/<?php echo htmlspecialchars($product['image']); ?>" alt="<?php echo htmlspecialchars($product['name']); ?>" class="product-image-small" />
                            <div class="product-summary">
                                <h3><?php echo htmlspecialchars($product['name']); ?></h3>
                                <p class="price"><?php echo number_format($product['price'], 0, ',', '.'); ?> VND</p>
                                <button class="details-button">Xem chi tiết</button>
                            </div>
                            <!-- Hidden product detail section -->
                            <div class="product-full-details">
                                <img src="images/<?php echo htmlspecialchars($product['image']); ?>" alt="<?php echo htmlspecialchars($product['name']); ?>" class="product-image-large" />
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
    </main>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Moji Shop. All Rights Reserved.</p>
    </footer>

    <script>
document.addEventListener('DOMContentLoaded', function() {
    var searchInput = document.getElementById('searchInput');
    var searchSuggestions = document.getElementById('searchSuggestions');

    searchInput.addEventListener('keyup', function() {
        var keyword = searchInput.value;
        console.log("Keyword entered:", keyword); // Log từ khóa nhập vào

        if (keyword.length > 0) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'search.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    console.log("Response received:", xhr.responseText); // Log phản hồi từ server
                    var results = JSON.parse(xhr.responseText);
                    var suggestions = '';

                    results.forEach(function(result) {
                        suggestions += '<li>' + result.keyword + '</li>';
                    });

                    searchSuggestions.innerHTML = suggestions;
                    searchSuggestions.style.display = 'block';

                    searchSuggestions.querySelectorAll('li').forEach(function(item) {
                        item.addEventListener('click', function() {
                            var selectedKeyword = this.textContent.trim();
                            searchInput.value = selectedKeyword;
                            searchSuggestions.style.display = 'none';
                            window.location.href = '?search=' + encodeURIComponent(selectedKeyword);
                        });
                    });
                } else {
                    console.error("Error: " + xhr.status);
                }
            };
            xhr.send('keyword=' + encodeURIComponent(keyword));
        } else {
            searchSuggestions.style.display = 'none';
        }
    });

    document.addEventListener('click', function(e) {
        if (!searchInput.contains(e.target) && !searchSuggestions.contains(e.target)) {
            searchSuggestions.style.display = 'none';
        }
    });
});


    </script>
</body>
</html>
