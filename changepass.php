<?php
session_start();
include 'connectdb.php'; 

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];
$stmt = $pdo->prepare("SELECT * FROM users WHERE id = :user_id");
$stmt->execute(['user_id' => $user_id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['change_password'])) {
    $current_password = $_POST['current_password'];
    $new_password = $_POST['new_password'];
    $confirm_password = $_POST['confirm_password'];

    if (password_verify($current_password, $user['password'])) {
        if ($new_password === $confirm_password) {
            $new_password_hashed = password_hash($new_password, PASSWORD_BCRYPT);
            $stmt = $pdo->prepare("UPDATE users SET password = :new_password WHERE id = :user_id");
            $stmt->execute(['new_password' => $new_password_hashed, 'user_id' => $user_id]);
            $message = "Mật khẩu đã được thay đổi thành công!";
        } else {
            $message = "Mật khẩu mới và mật khẩu xác nhận không trùng khớp.";
        }
    } else {
        $message = "Mật khẩu hiện tại không đúng.";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thay đổi mật khẩu</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .form-group button {
            padding: 10px 15px;
            background-color: #ff6f9c;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group button:hover {
            background-color: #e0557f;
        }

        .message {
            color: green;
            margin-bottom: 15px;
        }

        .error {
            color: red;
            margin-bottom: 15px;
        }
    </style>
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
                <a href="logout.php">Đăng xuất</a> 
            <?php else: ?>
                <a href="login.php">Đăng nhập</a> | 
                <a href="register.php">Đăng ký</a>
            <?php endif; ?>
            <a href="cart.php" class="cart">🛒</a>
        </div>
    </header>


    <main>
        <div class="container">
            <h2>THAY ĐỔI MẬT KHẨU</h2>
            <p>Bạn nên cập nhập mật khẩu thường xuyên vì lý do bảo mật</p>
            <hr>
            <?php if (isset($message)): ?>
                <p class="<?php echo ($message == "Mật khẩu đã được thay đổi thành công!") ? 'message' : 'error'; ?>">
                    <?php echo htmlspecialchars($message); ?>
                </p>
            <?php endif; ?>
            <form method="POST" action="changepass.php">
                <div class="form-group">
                    <label for="current_password">Mật khẩu cũ:</label>
                    <input type="password" name="current_password" placeholder="Mật khẩu cũ" required>
                </div>
                <div class="form-group">
                    <label for="new_password">Mật khẩu mới:</label>
                    <input type="password" name="new_password" placeholder="Mật khẩu mới" required>
                </div>
                <div class="form-group">
                    <label for="confirm_password">Xác nhận mật khẩu:</label>
                    <input type="password" name="confirm_password" placeholder="Xác nhận mật khẩu" required>
                </div>
                <div class="form-group">
                    <button type="submit" name="change_password">Xác nhận</button>
                </div>
            </form>
        </div>
    </main>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Moji Shop. All Rights Reserved.</p>
    </footer>
</body>
</html>
