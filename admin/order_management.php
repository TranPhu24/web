<?php
session_start();
include '../connectdb.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: ../login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['update_order_status'])) {
    $order_id = $_POST['order_id'];
    $status = $_POST['status'];

    $stmt = $pdo->prepare("UPDATE orders SET status = :status, updated_at = CURRENT_TIMESTAMP WHERE id = :order_id");
    $stmt->execute(['order_id' => $order_id, 'status' => $status]);

    echo "<script>alert('Trạng thái đơn hàng đã được cập nhật.');</script>";
}

$orderStmt = $pdo->query("SELECT o.id, o.user_id, o.total_price, o.status, o.created_at, u.username 
                          FROM orders o 
                          JOIN users u ON o.user_id = u.id");
$orders = $orderStmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng</title>
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

    <h2>Quản lý đơn hàng</h2>
    <table>
        <tr>
            <th>ID Đơn hàng</th>
            <th>ID Khách hàng</th>
            <th>Tên khách hàng</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
            <th>Ngày tạo</th>
            <th>Thao tác</th>
        </tr>
        <?php foreach ($orders as $order): ?>
            <tr>
                <td><?php echo htmlspecialchars($order['id']); ?></td>
                <td><?php echo htmlspecialchars($order['user_id']); ?></td>
                <td><?php echo htmlspecialchars($order['username']); ?></td>
                <td><?php echo htmlspecialchars($order['total_price']); ?></td>
                <td><?php echo htmlspecialchars($order['status']); ?></td>
                <td><?php echo htmlspecialchars($order['created_at']); ?></td>
                <td>
                    <form action="order_management.php" method="POST">
                        <input type="hidden" name="order_id" value="<?php echo $order['id']; ?>">
                        <select name="status">
                            <option value="Đang xử lý" <?php if ($order['status'] == 'Đang xử lý') echo 'selected'; ?>>Đang xử lý</option>
                            <option value="Đã giao" <?php if ($order['status'] == 'Đã giao') echo 'selected'; ?>>Đã giao</option>
                            <option value="Hoàn thành" <?php if ($order['status'] == 'Hoàn thành') echo 'selected'; ?>>Hoàn thành</option>
                            <option value="Đã hủy" <?php if ($order['status'] == 'Đã hủy') echo 'selected'; ?>>Đã hủy</option>
                        </select>
                        <button type="submit" name="update_order_status">Cập nhật trạng thái</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>

</body>
</html>
