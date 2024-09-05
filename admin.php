<?php
include 'connectdb.php'; 
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_product'])) {
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $quantity = $_POST['quantity'];

    $stmt = $pdo->prepare("INSERT INTO products (name, description, price, quantity) VALUES (:name, :description, :price, :quantity)");
    $stmt->execute(['name' => $name, 'description' => $description, 'price' => $price, 'quantity' => $quantity]);

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

    echo "<script>alert('Mặt hàng đã được cập nhật');</script>"; }

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['delete_product'])) {
    $id = $_POST['id'];

    $stmt = $pdo->prepare("DELETE FROM products WHERE id = :id");
    $stmt->execute(['id' => $id]);

    echo "<script>alert('Mặt hàng đã được xóa.');</script>"; }

$stmt = $pdo->query("SELECT * FROM products");
$products = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý mặt hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 20px;
            padding: 20px;
        }

        h2 {
            color: #444;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            font-weight: bold;
        }

        button:hover {
            background-color: #45a049;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }
    </style>
</head>
<body>

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
                <form action="admin.php" method="POST">
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

<!-- Thêm mặt hàng mới -->
<h2>Thêm mặt hàng mới</h2>
<form action="admin.php" method="POST">
    <label for="name">Tên:</label>
    <input type="text" id="name" name="name" required><br>
    <label for="description">Mô tả:</label>
    <textarea id="description" name="description" required></textarea><br>
    <label for="price">Giá:</label>
    <input type="number" id="price" name="price" required><br>
    <label for="quantity">Số lượng:</label>
    <input type="number" id="quantity" name="quantity" required><br>
    <button type="submit" name="add_product">Thêm mặt hàng</button>
    
</form>

</body>
</html>