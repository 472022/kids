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
    $stmt = $pdo->prepare("SELECT * FROM activity_logs WHERE child_id = ? ORDER BY created_at DESC LIMIT 50");
    $stmt->execute([$child_id]);
    $logs = $stmt->fetchAll();
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Activity Timeline</h1>
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
    <ul style="list-style:none; padding:0;">
        <?php if(isset($logs) && count($logs) > 0): ?>
            <?php foreach($logs as $log): ?>
                <li style="border-left: 2px solid #3498db; padding-left: 20px; margin-left: 10px; padding-bottom: 20px; position:relative;">
                    <div style="position:absolute; left:-6px; top:0; width:10px; height:10px; background:#3498db; border-radius:50%;"></div>
                    <div style="font-size:0.8rem; color:#888; margin-bottom:5px;"><?php echo date('M d, Y h:i A', strtotime($log['created_at'])); ?></div>
                    <div style="font-weight:bold; color:#2C3E50;"><?php echo htmlspecialchars(ucfirst($log['activity_type'])); ?></div>
                    <div><?php echo htmlspecialchars($log['activity_details']); ?></div>
                </li>
            <?php endforeach; ?>
        <?php else: ?>
            <p>No activity recorded yet.</p>
        <?php endif; ?>
    </ul>
</div>

<?php include 'includes/footer.php'; ?>
