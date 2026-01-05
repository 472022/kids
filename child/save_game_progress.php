<?php
require_once '../config/db.php';
require_once 'includes/rewards_helper.php'; // Add helper
session_start();

header('Content-Type: application/json');

if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'child') {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);

if ($input) {
    $child_id = $_SESSION['user_id'];
    $game_id = $input['game_id'];
    $score = $input['score'];
    $stars = $input['stars'];
    $level = $input['level'];

    // Update Game Progress
    // Check if exists
    $stmt = $pdo->prepare("SELECT * FROM game_progress WHERE child_id = ? AND game_id = ?");
    $stmt->execute([$child_id, $game_id]);
    $exists = $stmt->fetch();

    if ($exists) {
        // Update only if high score or accumulating? Usually accumulate stars/score, but keep high level.
        // Let's accumulate score/stars, update level if higher.
        $newScore = $exists['score'] + $score;
        $newStars = $exists['stars_earned'] + $stars;
        $newLevel = max($exists['level_completed'], $level);
        
        $upd = $pdo->prepare("UPDATE game_progress SET score = ?, stars_earned = ?, level_completed = ?, last_played = NOW() WHERE game_progress_id = ?");
        $upd->execute([$newScore, $newStars, $newLevel, $exists['game_progress_id']]);
    } else {
        $ins = $pdo->prepare("INSERT INTO game_progress (child_id, game_id, score, stars_earned, level_completed) VALUES (?, ?, ?, ?, ?)");
        $ins->execute([$child_id, $game_id, $score, $stars, $level]);
    }

    // Update Child Total Stars
    $pdo->prepare("UPDATE children SET total_stars = total_stars + ? WHERE child_id = ?")->execute([$stars, $child_id]);
    
    // Check Badges
    $newBadges = checkAndUnlockBadges($child_id, $pdo);

    // Log
    $pdo->prepare("INSERT INTO activity_logs (child_id, activity_type, activity_details) VALUES (?, 'game', ?)")
        ->execute([$child_id, "Played Game ID $game_id. Earned $stars stars."]);

    echo json_encode(['success' => true, 'new_badges' => $newBadges]);
} else {
    echo json_encode(['success' => false]);
}
?>