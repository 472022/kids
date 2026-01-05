<?php
require_once '../config/db.php';
session_start();

// Parent Auth Check
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'parent') {
    header("Location: ../login.php");
    exit;
}

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

// Get Linked Children
$stmt = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$stmt->execute([$parent_id]);
$children = $stmt->fetchAll();

// If child_id provided, verify ownership
if ($child_id) {
    $verify = $pdo->prepare("SELECT * FROM children WHERE child_id = ? AND parent_id = ?");
    $verify->execute([$child_id, $parent_id]);
    $currentChild = $verify->fetch();
    
    if (!$currentChild) {
        die("Unauthorized access to this child.");
    }

    // Fetch Stats
    $lCount = $pdo->query("SELECT COUNT(*) FROM lesson_progress WHERE child_id = $child_id AND is_completed = 1")->fetchColumn();
    $qCount = $pdo->query("SELECT COUNT(*) FROM quiz_results WHERE child_id = $child_id AND is_completed = 1")->fetchColumn();
    $gCount = $pdo->query("SELECT COUNT(*) FROM game_progress WHERE child_id = $child_id")->fetchColumn();
    
    $totalLessons = $pdo->query("SELECT COUNT(*) FROM lessons")->fetchColumn();
    $lPercent = $totalLessons > 0 ? ($lCount / $totalLessons) * 100 : 0;
    
    // Badges
    $badges = $pdo->prepare("SELECT a.title, a.badge_icon FROM child_achievements ca JOIN achievements a ON ca.achievement_id = a.achievement_id WHERE ca.child_id = ?");
    $badges->execute([$child_id]);
    $earnedBadges = $badges->fetchAll();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Parent Dashboard - Child Progress</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body style="background:#f4f6f9;">

<nav style="background:white; padding:20px; box-shadow:0 2px 5px rgba(0,0,0,0.1); margin-bottom:30px;">
    <div style="max-width:1000px; margin:0 auto; display:flex; justify-content:space-between; align-items:center;">
        <span style="font-size:1.5rem; font-weight:bold; color:#2C3E50;">👨‍👩‍👧‍👦 Parent Portal</span>
        <a href="../logout.php" class="btn btn-secondary">Logout</a>
    </div>
</nav>

<div style="max-width:1000px; margin:0 auto; padding:20px;">
    
    <h2>Select Child</h2>
    <div style="display:flex; gap:15px; margin-bottom:30px;">
        <?php foreach($children as $child): ?>
            <a href="progress.php?child_id=<?php echo $child['child_id']; ?>" style="text-decoration:none;">
                <div style="background:white; padding:15px; border-radius:10px; box-shadow:0 2px 5px #ddd; display:flex; align-items:center; gap:10px; border:2px solid <?php echo ($child_id == $child['child_id']) ? '#4ECDC4' : 'transparent'; ?>;">
                    <div style="font-size:2rem;"><?php echo $child['avatar'] ? '<img src="../'.$child['avatar'].'">' : '🧑‍🎓'; ?></div>
                    <div>
                        <div style="font-weight:bold; color:#333;"><?php echo htmlspecialchars($child['child_name']); ?></div>
                        <div style="font-size:0.9rem; color:#888;">Level <?php echo $child['level']; ?></div>
                    </div>
                </div>
            </a>
        <?php endforeach; ?>
    </div>

    <?php if ($child_id && isset($currentChild)): ?>
        <div style="background:white; padding:30px; border-radius:20px; box-shadow:0 5px 15px rgba(0,0,0,0.05);">
            <h2 style="border-bottom:2px solid #eee; padding-bottom:10px; margin-bottom:20px;">
                Progress Report: <?php echo htmlspecialchars($currentChild['child_name']); ?>
            </h2>

            <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap:20px; margin-bottom:30px;">
                <div style="background:#e3f2fd; padding:20px; border-radius:15px; text-align:center;">
                    <h3>⭐ Total Stars</h3>
                    <div style="font-size:2.5rem; color:#2196f3;"><?php echo $currentChild['total_stars']; ?></div>
                </div>
                <div style="background:#e8f5e9; padding:20px; border-radius:15px; text-align:center;">
                    <h3>📚 Lessons</h3>
                    <div style="font-size:2.5rem; color:#4caf50;"><?php echo round($lPercent); ?>%</div>
                    <div style="font-size:0.9rem; color:#666;"><?php echo $lCount; ?> completed</div>
                </div>
                <div style="background:#fff3e0; padding:20px; border-radius:15px; text-align:center;">
                    <h3>🎮 Games</h3>
                    <div style="font-size:2.5rem; color:#ff9800;"><?php echo $gCount; ?></div>
                    <div style="font-size:0.9rem; color:#666;">Sessions Played</div>
                </div>
            </div>

            <h3>🏆 Earned Badges</h3>
            <div style="display:flex; flex-wrap:wrap; gap:15px; margin-top:15px;">
                <?php foreach($earnedBadges as $badge): ?>
                    <div style="background:#fff; border:1px solid #eee; padding:10px 20px; border-radius:50px; display:flex; align-items:center; gap:10px; box-shadow:0 2px 5px #eee;">
                        <span style="font-size:1.5rem;"><?php echo $badge['badge_icon']; ?></span>
                        <span style="font-weight:bold; color:#555;"><?php echo htmlspecialchars($badge['title']); ?></span>
                    </div>
                <?php endforeach; ?>
                <?php if(empty($earnedBadges)): ?>
                    <p style="color:#888;">No badges earned yet.</p>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>

</div>

</body>
</html>
