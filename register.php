<?php
include 'connectdb.php'; 

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $role = 'khach'; 

    try {
        $stmt = $pdo->prepare("INSERT INTO users (username, password, phone, email, role) 
                                VALUES (:username, :password, :phone, :email, :role)");
        
        $stmt->execute([
            'username' => $username,
            'password' => $password,
            'phone' => $phone,
            'email' => $email,
            'role' => $role  
        ]);

        header("Location: login.php");
        exit();
    } catch (PDOException $e) {
        if ($e->getCode() == 23505) {  
            echo "<script>alert('Lỗi: Tên đăng nhập, email hoặc số điện thoại đã tồn tại. Vui lòng thử lại.');</script>";
        } else {
            echo "<script>alert('Lỗi: " . $e->getMessage() . "');</script>";
        }    
    }
}
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link rel="stylesheet" href="css/register.css">
    <script src="js/index.js"></script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>ĐĂNG KÝ</h2>
            </div>
            <form action="register.php" method="POST" onsubmit="return validatePassword()">
                <div class="form-group">
                    <label for="username">Tên đăng nhập (*)</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu (*)</label>
                    <input type="password" id="password" name="password" 
                           pattern="(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}" 
                           title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ và số" 
                           required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Nhập lại mật khẩu (*)</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                    title="Mật khẩu không khớp"
                    required>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại (*)</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                <div class="form-group">
                    <label for="email">Email (*)</label>
                    <input type="email" id="email" name="email" 
                           pattern="[a-zA-Z0-9._%+-]+@gmail\.com" 
                           title="Email phải có định dạng @gmail.com" 
                           required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-submit">ĐĂNG KÝ</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>