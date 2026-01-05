<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$id = $_GET['id'] ?? null;

if ($id) {
    // Check for linked lessons
    $check = $pdo->prepare("SELECT COUNT(*) FROM lessons WHERE subject_id = ?");
    $check->execute([$id]);
    
    if ($check->fetchColumn() > 0) {
        // Prevent deletion
        echo "<script>alert('Cannot delete subject with existing lessons.'); window.location='subjects_list.php';</script>";
    } else {
        $stmt = $pdo->prepare("DELETE FROM subjects WHERE subject_id = ?");
        $stmt->execute([$id]);
        header("Location: subjects_list.php");
    }
} else {
    header("Location: subjects_list.php");
}
?>