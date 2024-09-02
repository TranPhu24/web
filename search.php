<?php
session_start();
include 'connectdb.php'; 

if (isset($_POST['keyword'])) {
    $keyword = trim($_POST['keyword']); 

    $stmt = $pdo->prepare("SELECT DISTINCT keyword FROM search_keywords WHERE keyword LIKE :keyword LIMIT 5");
    $stmt->execute(['keyword' => '%' . $keyword . '%']);
    $keywords = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($keywords);
    exit();
}
?>
