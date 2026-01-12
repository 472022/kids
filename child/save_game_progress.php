<?php
session_start();
require_once '../config/db.php';

// Get JSON Input
$data = json_decode(file_get_contents('php://input'), true);

if (!isset($_SESSION['user_id']) || !$data) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized or invalid data']);
    exit;
}

$child_id = $_SESSION['user_id'];
$game_id = $data['game_id'];
$score = $data['score'] ?? 0;
$stars = $data['stars'] ?? 0;
$level = $data['level'] ?? 1;

try {
    // 1. Check if progress exists for this game
    $stmt = $pdo->prepare("SELECT * FROM game_progress WHERE child_id = ? AND game_id = ?");
    $stmt->execute([$child_id, $game_id]);
    $existing = $stmt->fetch();

    if ($existing) {
        // Update if new score is higher or just cumulative stars
        // Let's make stars cumulative, but score best?
        // Actually, requirement says "Stars are collected".
        $new_stars = $existing['stars_earned'] + $stars;
        $best_score = max($existing['high_score'], $score);
        
        $update = $pdo->prepare("UPDATE game_progress SET stars_earned = ?, high_score = ?, level_reached = ? WHERE progress_id = ?");
        $update->execute([$new_stars, $best_score, max($existing['level_reached'], $level), $existing['progress_id']]);
    } else {
        // Insert new
        $insert = $pdo->prepare("INSERT INTO game_progress (child_id, game_id, stars_earned, high_score, level_reached) VALUES (?, ?, ?, ?, ?)");
        $insert->execute([$child_id, $game_id, $stars, $score, $level]);
    }

    // 2. Update Total Stars for Child
    $updateChild = $pdo->prepare("UPDATE children SET total_stars = total_stars + ? WHERE child_id = ?");
    $updateChild->execute([$stars, $child_id]);

    echo json_encode(['success' => true, 'message' => 'Progress saved!']);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>