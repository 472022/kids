<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$id = $_GET['id'] ?? null;
if ($id) {
    $stmt = $pdo->prepare("DELETE FROM quizzes WHERE quiz_id = ?");
    $stmt->execute([$id]);
}
header("Location: quizzes_list.php");
?>