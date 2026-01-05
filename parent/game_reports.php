<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

$stmt = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$stmt->execute([$parent_id]);
$children = $stmt->fetchAll();
if(!$child_id && count($children)>0) $child_id = $children[0]['child_id'];

if ($child_id) {
    $sql = "SELECT gp.*, g.game_name, g.game_type 
            FROM game_progress gp 
            JOIN games g ON gp.game_id = g.game_id 
            WHERE gp.child_id = ? 
            ORDER BY gp.last_played DESC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$child_id]);
    $reports = $stmt->fetchAll();
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Game Activity Reports</h1>
    <?php if(count($children) > 1): ?>
        <form method="GET">
            <select name="child_id" onchange="this.form.submit()" style="padding:5px;">
                <?php foreach($children as $c): ?>
                    <option value="<?php echo $c['child_id']; ?>" <?php echo ($child_id == $c['child_id']) ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($c['child_name']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </form>
    <?php endif; ?>
</div>

<div class="card">
    <table class="data-table">
        <thead>
            <tr>
                <th>Game Name</th>
                <th>Type</th>
                <th>Level Reached</th>
                <th>Score</th>
                <th>Stars Earned</th>
                <th>Last Played</th>
            </tr>
        </thead>
        <tbody>
            <?php if(isset($reports) && count($reports) > 0): ?>
                <?php foreach($reports as $r): ?>
                <tr>
                    <td><?php echo htmlspecialchars($r['game_name']); ?></td>
                    <td><?php echo htmlspecialchars($r['game_type']); ?></td>
                    <td><?php echo $r['level_completed']; ?></td>
                    <td><?php echo $r['score']; ?></td>
                    <td><?php echo $r['stars_earned']; ?> ⭐</td>
                    <td><?php echo date('M d, Y h:i A', strtotime($r['last_played'])); ?></td>
                </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr><td colspan="6">No games played yet.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php include 'includes/footer.php'; ?>
