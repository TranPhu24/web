<?php
session_start(); 
include 'connectdb.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    try {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
        $stmt->execute(['username' => $username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['role'] = $user['role'];

            if ($user['role'] == 'admin') {
                header("Location: admin/admin.php");
            } else {
                header("Location: index.php");
            }
            exit();
        } else {
            echo "<script>alert('Tên đăng nhập hoặc mật khẩu không đúng.');</script>";
        }
    } catch (PDOException $e) {
        echo "Lỗi: " . $e->getMessage();
    }
}
?>



<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>ĐĂNG NHẬP</h2>
            </div>
            <form action="login.php" method="POST">
                <div class="form-group">
                    <label for="username">Tên đăng nhập (*)</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu (*)</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-submit">ĐĂNG NHẬP</button>
                </div>
                <div class="form-group">
                    <a href="forgot_password.php" style="text-decoration: none;">Quên mật khẩu?</a>
                </div>
                <div class="form-group">
                    <a href="register.php" style="text-decoration: none;" >Đăng ký</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
