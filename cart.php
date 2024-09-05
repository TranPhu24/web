<?php
session_start();
include 'connectdb.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['product_id'], $_POST['quantity'])) {
        $product_id = $_POST['product_id'];
        $quantity = intval($_POST['quantity']);
        $user_id = $_SESSION['user_id'];

        $stmt = $pdo->prepare("SELECT quantity FROM products WHERE id = :product_id");
        $stmt->execute(['product_id' => $product_id]);
        $product = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($product && $product['quantity'] >= $quantity) {
            $stmt = $pdo->prepare("SELECT * FROM cart WHERE user_id = :user_id AND product_id = :product_id");
            $stmt->execute(['user_id' => $user_id, 'product_id' => $product_id]);
            $cart_item = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($cart_item) {
                $stmt = $pdo->prepare("UPDATE cart SET quantity = quantity + :quantity WHERE user_id = :user_id AND product_id = :product_id");
                $stmt->execute(['quantity' => $quantity, 'user_id' => $user_id, 'product_id' => $product_id]);
            } else {
                $stmt = $pdo->prepare("INSERT INTO cart (user_id, product_id, quantity) VALUES (:user_id, :product_id, :quantity)");
                $stmt->execute(['user_id' => $user_id, 'product_id' => $product_id, 'quantity' => $quantity]);
            }

            $stmt = $pdo->prepare("UPDATE products SET quantity = quantity - :quantity WHERE id = :product_id");
            $stmt->execute(['quantity' => $quantity, 'product_id' => $product_id]);

            $stmt = $pdo->prepare("SELECT quantity FROM products WHERE id = :product_id");
            $stmt->execute(['product_id' => $product_id]);
            $product = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($product['quantity'] <= 0) {
                $stmt = $pdo->prepare("UPDATE products SET status = 'Hết hàng' WHERE id = :product_id");
                $stmt->execute(['product_id' => $product_id]);
            }

            header("Location: index.php");
            exit();
        } else {
            echo "<script>alert('Số lượng hàng không đủ');</script>";
        }
    } elseif (isset($_POST['remove_item'])) {
        $product_id = $_POST['remove_product_id'];
        $user_id = $_SESSION['user_id'];

        $stmt = $pdo->prepare("SELECT quantity FROM cart WHERE user_id = :user_id AND product_id = :product_id");
        $stmt->execute(['user_id' => $user_id, 'product_id' => $product_id]);
        $cart_item = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($cart_item) {
            $stmt = $pdo->prepare("UPDATE products SET quantity = quantity + :quantity WHERE id = :product_id");
            $stmt->execute(['quantity' => $cart_item['quantity'], 'product_id' => $product_id]);
        }

        $stmt = $pdo->prepare("DELETE FROM cart WHERE user_id = :user_id AND product_id = :product_id");
        $stmt->execute(['user_id' => $user_id, 'product_id' => $product_id]);

        header("Location: cart.php");
        exit();
    } elseif (isset($_POST['checkout'])) {
        $user_id = $_SESSION['user_id'];

        $stmt = $pdo->prepare("SELECT p.name, p.description, c.quantity, p.price, c.product_id FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = :user_id");
        $stmt->execute(['user_id' => $user_id]);
        $cart_items = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $total_price = 0;
        foreach ($cart_items as $item) {
            $total_price += $item['price'] * $item['quantity'];
        }

        $stmt = $pdo->prepare("INSERT INTO orders (user_id, total_price) VALUES (:user_id, :total_price)");
        $stmt->execute(['user_id' => $user_id, 'total_price' => $total_price]);

        $order_id = $pdo->lastInsertId();

        foreach ($cart_items as $item) {
            $stmt = $pdo->prepare("INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (:order_id, :product_id, :quantity, :price)");
            $stmt->execute([
                'order_id' => $order_id,
                'product_id' => $item['product_id'],
                'quantity' => $item['quantity'],
                'price' => $item['price']
            ]);
        }

        $stmt = $pdo->prepare("DELETE FROM cart WHERE user_id = :user_id");
        $stmt->execute(['user_id' => $user_id]);

        echo "<script>alert('Đơn hàng của bạn đã được tạo thành công!'); window.location.href='cart.php';</script>";
        exit();
    } else {
        echo "Lỗi: Dữ liệu sản phẩm không đầy đủ.";
    }
}

$stmt = $pdo->prepare("SELECT p.name, p.description, c.quantity, p.price, c.product_id FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = :user_id");
$stmt->execute(['user_id' => $_SESSION['user_id']]);
$cart_items = $stmt->fetchAll(PDO::FETCH_ASSOC);

$total_price = 0;
foreach ($cart_items as $item) {
    $total_price += $item['price'] * $item['quantity'];
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/product.css">
    <link rel="stylesheet" href="css/cart.css">
</head>
<body>

    <header>
        <div class="logo">
            <a href="index.php">
                <img src="images/logo.png" alt="Moji Logo">
            </a>
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
            <a href="cart.php" class="cart">🛒 Giỏ hàng của bạn</a>
        </div>
    </header>


    <main>
        <div class="container">
            <h1>Giỏ hàng</h1>

            <div class="cart-wrapper">
                <?php if (count($cart_items) > 0): ?>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>Mô tả</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Tổng cộng</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($cart_items as $item): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($item['name']); ?></td>
                                    <td><?php echo htmlspecialchars($item['description']); ?></td>
                                    <td><?php echo htmlspecialchars($item['quantity']); ?></td>
                                    <td><?php echo number_format($item['price'], 0, ',', '.'); ?> VND</td>
                                    <td><?php echo number_format($item['price'] * $item['quantity'], 0, ',', '.'); ?> VND</td>
                                    <td>
                                        <form action="" method="POST">
                                            <input type="hidden" name="remove_product_id" value="<?php echo $item['product_id']; ?>">
                                            <button type="submit" name="remove_item" class="remove-button">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>

                    <div class="total-price">
                        <h2>Tổng giá: <?php echo number_format($total_price, 0, ',', '.'); ?> VND</h2>
                        <div class="cart-actions">
                            <a href="index2.php" class="continue-shopping">Mua tiếp</a>
                            <form action="" method="POST" style="display: inline;">
                                <button type="submit" name="checkout" class="checkout">Thanh toán</button>
                            </form>
                        </div>
                    </div>
                <?php else: ?>
                    <p>Giỏ hàng của bạn đang trống.</p>
                <?php endif; ?>
            </div>
        </div>
    </main>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Moji Shop. All Rights Reserved.</p>
    </footer>
</body>
</html>
