<?php
include 'connectdb.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $phone = $_POST['phone'];
    $new_password = password_hash($_POST['new_password'], PASSWORD_BCRYPT);

    try {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username AND phone = :phone");
        $stmt->execute([
            'username' => $username,
            'phone' => $phone
        ]);

        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            $update_stmt = $pdo->prepare("UPDATE users SET password = :new_password WHERE id = :id");
            $update_stmt->execute([
                'new_password' => $new_password,
                'id' => $user['id']
            ]);

            echo "<script>alert('Cập nhật mật khẩu thành công!');</script>";
            header("Location: login.php ");
            exit();
        } else {
            echo "<script>alert('Thông tin không khớp. Vui lòng thử lại.');</script>";
        }
    } catch (PDOException $e) {
        echo "<script>alert('Lỗi: " . $e->getMessage() . "');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>QUÊN MẬT KHẨU</h2>
            </div>
            <form action="forgot_password.php" method="POST">
                <div class="form-group">
                    <label for="username">Tên đăng nhập (*)</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại (*)</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                <div class="form-group">
                    <label for="new_password">Mật khẩu mới (*)</label>
                    <input type="password" id="new_password" name="new_password" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-submit">CẬP NHẬT MẬT KHẨU</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
