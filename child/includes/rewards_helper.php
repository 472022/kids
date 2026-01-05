<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

function checkAndUnlockBadges($child_id, $pdo) {
    $unlocked = [];

    // --- FETCH STATS ---
    $lessons = $pdo->prepare("SELECT COUNT(*) FROM lesson_progress WHERE child_id = ? AND is_completed = 1");
    $lessons->execute([$child_id]);
    $lessonCount = $lessons->fetchColumn();

    $games = $pdo->prepare("SELECT COUNT(*) FROM game_progress WHERE child_id = ?");
    $games->execute([$child_id]);
    $gameCount = $games->fetchColumn();

    $quizzes = $pdo->prepare("SELECT COUNT(*) FROM quiz_results WHERE child_id = ? AND is_completed = 1");
    $quizzes->execute([$child_id]);
    $quizCount = $quizzes->fetchColumn();

    $perfectQuiz = $pdo->prepare("SELECT COUNT(*) FROM quiz_results WHERE child_id = ? AND score = 10");
    $perfectQuiz->execute([$child_id]);
    $perfectCount = $perfectQuiz->fetchColumn();

    // Get Total Stars
    $starsStmt = $pdo->prepare("SELECT total_stars FROM children WHERE child_id = ?");
    $starsStmt->execute([$child_id]);
    $totalStars = $starsStmt->fetchColumn();

    // Update Level (Every 50 stars = 1 level)
    $newLevel = floor($totalStars / 50) + 1;
    $pdo->prepare("UPDATE children SET level = ? WHERE child_id = ?")->execute([$newLevel, $child_id]);

    // --- DEFINE BADGES ---
    $checks = [
        'First Lesson' => ($lessonCount >= 1),
        'First Game' => ($gameCount >= 1),
        'First Quiz' => ($quizCount >= 1),
        'Star Collector' => ($totalStars >= 50),
        'Level Up!' => ($newLevel >= 2),
        'Super Scholar' => ($lessonCount >= 5),
        'Game Master' => ($gameCount >= 5),
        'Quiz Whiz' => ($perfectCount >= 1)
    ];

    // --- CHECK & UNLOCK ---
    foreach ($checks as $title => $condition) {
        if ($condition) {
            // Get Achievement ID
            $stmt = $pdo->prepare("SELECT achievement_id FROM achievements WHERE title = ?");
            $stmt->execute([$title]);
            $aid = $stmt->fetchColumn();

            if ($aid) {
                // Check if already earned
                $check = $pdo->prepare("SELECT COUNT(*) FROM child_achievements WHERE child_id = ? AND achievement_id = ?");
                $check->execute([$child_id, $aid]);
                if ($check->fetchColumn() == 0) {
                    // Unlock!
                    $pdo->prepare("INSERT INTO child_achievements (child_id, achievement_id, earned_at) VALUES (?, ?, NOW())")->execute([$child_id, $aid]);
                    $unlocked[] = $title;
                }
            }
        }
    }

    return $unlocked;
}
?>