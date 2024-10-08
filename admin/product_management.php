<?php
session_start();
include '../connectdb.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: ../login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_product'])) {
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $quantity = $_POST['quantity'];
    $category_id = $_POST['category_id'];

    $stmt = $pdo->prepare("INSERT INTO products (name, description, price, quantity, category_id) VALUES (:name, :description, :price, :quantity, :category_id)");
    $stmt->execute(['name' => $name, 'description' => $description, 'price' => $price, 'quantity' => $quantity, 'category_id' => $category_id]);

    echo "<script>alert('Mặt hàng mới đã được thêm.');</script>";
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['update_product'])) {
    $id = $_POST['id'];
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $quantity = $_POST['quantity'];

    $stmt = $pdo->prepare("UPDATE products SET name = :name, description = :description, price = :price, quantity = :quantity WHERE id = :id");
    $stmt->execute(['id' => $id, 'name' => $name, 'description' => $description, 'price' => $price, 'quantity' => $quantity]);

    echo "<script>alert('Mặt hàng đã được cập nhật');</script>";
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['delete_product'])) {
    $id = $_POST['id'];

    $stmt = $pdo->prepare("DELETE FROM products WHERE id = :id");
    $stmt->execute(['id' => $id]);

    echo "<script>alert('Mặt hàng đã được xóa.');</script>";
}

$stmt = $pdo->query("SELECT * FROM products");
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý mặt hàng</title>
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>
<div class="logo">
        <a href="../index.php">
            <img src="../images/logo.png" alt="Moji Logo">
        </a>
    </div>

    <nav>
        <ul style="list-style: none; padding: 0;">
            <li style="display: inline-block; margin-right: 20px;">
                <a href="product_management.php">Quản lý mặt hàng</a>
            </li>
            <li style="display: inline-block;">
                <a href="order_management.php">Quản lý đơn hàng</a>
            </li>
        </ul>
    </nav>
    <hr>

    <h2>Quản lý mặt hàng</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Mô tả</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Thao tác</th>
        </tr>
        <?php foreach ($products as $product): ?>
            <tr>
                <td><?php echo htmlspecialchars($product['id']); ?></td>
                <td><?php echo htmlspecialchars($product['name']); ?></td>
                <td><?php echo htmlspecialchars($product['description']); ?></td>
                <td><?php echo htmlspecialchars($product['price']); ?></td>
                <td><?php echo htmlspecialchars($product['quantity']); ?></td>
                <td>
                    <form action="product_management.php" method="POST">
                        <input type="hidden" name="id" value="<?php echo $product['id']; ?>">
                        <input type="text" name="name" value="<?php echo $product['name']; ?>">
                        <input type="text" name="description" value="<?php echo $product['description']; ?>">
                        <input type="number" name="price" value="<?php echo $product['price']; ?>">
                        <input type="number" name="quantity" value="<?php echo $product['quantity']; ?>">
                        <button type="submit" name="update_product" style="background-color: yellow;">Cập nhật</button>
                        <button type="submit" name="delete_product" style="background-color: red;">Xóa</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>

    <h2>Thêm mặt hàng mới</h2>
    <form action="product_management.php" method="POST">
        <label for="name">Tên:</label>
        <input type="text" id="name" name="name" required><br>
        <label for="description">Mô tả:</label>
        <textarea id="description" name="description" required></textarea><br>
        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" required><br>
        <label for="quantity">Số lượng:</label>
        <input type="number" id="quantity" name="quantity" required><br>
        <label for="category_id">Loại hàng:</label>
        <input type="number" id="category_id" name="category_id" required><br>
        
        <button type="submit" name="add_product">Thêm mặt hàng</button>
    </form>

</body>
</html>
