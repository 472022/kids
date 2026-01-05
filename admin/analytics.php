<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$stats = [
    'lessons_completed' => $pdo->query("SELECT COUNT(*) FROM lesson_progress WHERE is_completed = 1")->fetchColumn(),
    'quizzes_taken' => $pdo->query("SELECT COUNT(*) FROM quiz_results")->fetchColumn(),
    'avg_quiz_score' => $pdo->query("SELECT AVG(score) FROM quiz_results")->fetchColumn(),
    'active_users_today' => $pdo->query("SELECT COUNT(DISTINCT child_id) FROM activity_logs WHERE DATE(created_at) = CURDATE()")->fetchColumn()
];

include 'includes/header.php';
?>

<h2>Analytics Overview</h2>

<div class="stats-grid">
    <div class="stat-card">
        <h3>Lessons Completed</h3>
        <p class="stat-number"><?php echo $stats['lessons_completed']; ?></p>
    </div>
    <div class="stat-card">
        <h3>Quizzes Taken</h3>
        <p class="stat-number"><?php echo $stats['quizzes_taken']; ?></p>
    </div>
    <div class="stat-card">
        <h3>Avg Quiz Score</h3>
        <p class="stat-number"><?php echo number_format($stats['avg_quiz_score'], 1); ?>%</p>
    </div>
    <div class="stat-card">
        <h3>Active Users Today</h3>
        <p class="stat-number"><?php echo $stats['active_users_today']; ?></p>
    </div>
</div>

<div class="chart-box" style="margin-top: 20px;">
    <h3>Most Popular Games</h3>
    <?php
        $topGames = $pdo->query("SELECT g.game_name, COUNT(gp.game_id) as plays FROM game_progress gp JOIN games g ON gp.game_id = g.game_id GROUP BY gp.game_id ORDER BY plays DESC LIMIT 5")->fetchAll();
    ?>
    <table>
        <thead>
            <tr>
                <th>Game Name</th>
                <th>Total Plays</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($topGames as $game): ?>
            <tr>
                <td><?php echo htmlspecialchars($game['game_name']); ?></td>
                <td><?php echo $game['plays']; ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php include 'includes/footer.php'; ?>
