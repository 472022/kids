<?php
require_once 'config/db.php';

$achievements = [
    ['title' => 'First Lesson', 'desc' => 'Complete your first lesson.', 'icon' => '📘'],
    ['title' => 'First Game', 'desc' => 'Play your first game.', 'icon' => '🎮'],
    ['title' => 'First Quiz', 'desc' => 'Complete your first quiz.', 'icon' => '❓'],
    ['title' => 'Star Collector', 'desc' => 'Earn 50 stars.', 'icon' => '⭐'],
    ['title' => 'Level Up!', 'desc' => 'Reach Level 2.', 'icon' => '🏆'],
    ['title' => 'Super Scholar', 'desc' => 'Complete 5 lessons.', 'icon' => '🎓'],
    ['title' => 'Game Master', 'desc' => 'Play 5 different games.', 'icon' => '🕹️'],
    ['title' => 'Quiz Whiz', 'desc' => 'Score 10/10 on a quiz.', 'icon' => '💯']
];

foreach ($achievements as $a) {
    // Check if exists
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM achievements WHERE title = ?");
    $stmt->execute([$a['title']]);
    if ($stmt->fetchColumn() == 0) {
        $ins = $pdo->prepare("INSERT INTO achievements (title, description, badge_icon) VALUES (?, ?, ?)");
        $ins->execute([$a['title'], $a['desc'], $a['icon']]);
        echo "Inserted: " . $a['title'] . "<br>";
    }
}
echo "Achievements Seeded.";
?>