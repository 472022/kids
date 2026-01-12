<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

// Fetch Children
$stmt = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$stmt->execute([$parent_id]);
$children = $stmt->fetchAll();

// Default to first child if not set
if (!$child_id && count($children) > 0) {
    $child_id = $children[0]['child_id'];
}

// Fetch Stats for selected child
if ($child_id) {
    // Verify ownership
    $valid = false;
    foreach($children as $c) { if($c['child_id'] == $child_id) $valid = true; }
    if(!$valid) die("Unauthorized");

    // Use prepared statements for security
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM lesson_progress WHERE child_id = ? AND is_completed = 1");
    $stmt->execute([$child_id]);
    $lCount = $stmt->fetchColumn();

    $stmt = $pdo->prepare("SELECT COUNT(*) FROM quiz_results WHERE child_id = ? AND is_completed = 1");
    $stmt->execute([$child_id]);
    $qCount = $stmt->fetchColumn();

    $stmt = $pdo->prepare("SELECT COUNT(*) FROM game_progress WHERE child_id = ?");
    $stmt->execute([$child_id]);
    $gCount = $stmt->fetchColumn();

    $stmt = $pdo->prepare("SELECT total_stars, level FROM children WHERE child_id = ?");
    $stmt->execute([$child_id]);
    $childStats = $stmt->fetch();
    
    $totalStars = $childStats['total_stars'] ?? 0;
    $level = $childStats['level'] ?? 1;
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Dashboard Overview</h1>
    
    <!-- Child Selector -->
    <?php if(count($children) > 1): ?>
    <form method="GET">
        <select name="child_id" onchange="this.form.submit()" style="padding:10px; border-radius:5px;">
            <?php foreach($children as $child): ?>
                <option value="<?php echo $child['child_id']; ?>" <?php echo ($child_id == $child['child_id']) ? 'selected' : ''; ?>>
                    <?php echo htmlspecialchars($child['child_name']); ?>
                </option>
            <?php endforeach; ?>
        </select>
    </form>
    <?php endif; ?>
</div>

<?php if($child_id): ?>
    <div class="card-grid">
        <div class="stat-card" style="border-color: #f1c40f;">
            <h3>⭐ Total Stars</h3>
            <div style="font-size: 2.5rem; font-weight: bold;"><?php echo $totalStars; ?></div>
        </div>
        <div class="stat-card" style="border-color: #3498db;">
            <h3>🏆 Current Level</h3>
            <div style="font-size: 2.5rem; font-weight: bold;"><?php echo $level; ?></div>
        </div>
        <div class="stat-card" style="border-color: #2ecc71;">
            <h3>📚 Lessons Completed</h3>
            <div style="font-size: 2.5rem; font-weight: bold;"><?php echo $lCount; ?></div>
        </div>
        <div class="stat-card" style="border-color: #9b59b6;">
            <h3>❓ Quizzes Taken</h3>
            <div style="font-size: 2.5rem; font-weight: bold;"><?php echo $qCount; ?></div>
        </div>
        <div class="stat-card" style="border-color: #e67e22;">
            <h3>🎮 Games Played</h3>
            <div style="font-size: 2.5rem; font-weight: bold;"><?php echo $gCount; ?></div>
        </div>
    </div>

    <div class="card">
        <h3>Recent Activity</h3>
        <?php
            $logs = $pdo->prepare("SELECT * FROM activity_logs WHERE child_id = ? ORDER BY created_at DESC LIMIT 5");
            $logs->execute([$child_id]);
            $activities = $logs->fetchAll();
        ?>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Time</th>
                    <th>Activity</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach($activities as $act): ?>
                <tr>
                    <td><?php echo date('M d, H:i', strtotime($act['created_at'])); ?></td>
                    <td><?php echo htmlspecialchars(ucfirst($act['activity_type'])); ?></td>
                    <td><?php echo htmlspecialchars($act['activity_details']); ?></td>
                </tr>
                <?php endforeach; ?>
                <?php if(empty($activities)): ?>
                    <tr><td colspan="3">No recent activity.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
        <div style="margin-top:15px; text-align:right;">
            <a href="activity_timeline.php?child_id=<?php echo $child_id; ?>" class="btn btn-primary">View Full Timeline</a>
        </div>
    </div>

<?php else: ?>
    <p>No children linked to this account.</p>
<?php endif; ?>

<?php include 'includes/footer.php'; ?>
