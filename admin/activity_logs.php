<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$filter_date = $_GET['date'] ?? '';
$filter_type = $_GET['type'] ?? '';

$sql = "SELECT a.*, c.child_name FROM activity_logs a JOIN children c ON a.child_id = c.child_id WHERE 1=1";
$params = [];

if ($filter_date) {
    $sql .= " AND DATE(a.created_at) = ?";
    $params[] = $filter_date;
}
if ($filter_type) {
    $sql .= " AND a.activity_type LIKE ?";
    $params[] = "%$filter_type%";
}

$sql .= " ORDER BY a.created_at DESC LIMIT 100";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$logs = $stmt->fetchAll();

include 'includes/header.php';
?>

<h2>Activity Logs</h2>

<form method="GET" style="margin-bottom: 20px; background: white; padding: 15px; border-radius: 8px;">
    <div style="display: flex; gap: 10px;">
        <input type="date" name="date" value="<?php echo htmlspecialchars($filter_date); ?>" class="form-control">
        <select name="type" class="form-control">
            <option value="">All Activity Types</option>
            <option value="login" <?php if($filter_type=='login') echo 'selected'; ?>>Login</option>
            <option value="lesson" <?php if($filter_type=='lesson') echo 'selected'; ?>>Lesson</option>
            <option value="quiz" <?php if($filter_type=='quiz') echo 'selected'; ?>>Quiz</option>
            <option value="game" <?php if($filter_type=='game') echo 'selected'; ?>>Game</option>
        </select>
        <button type="submit" class="btn btn-primary">Filter</button>
    </div>
</form>

<table>
    <thead>
        <tr>
            <th>Time</th>
            <th>Child</th>
            <th>Activity</th>
            <th>Details</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($logs as $log): ?>
        <tr>
            <td><?php echo date('Y-m-d H:i:s', strtotime($log['created_at'])); ?></td>
            <td><?php echo htmlspecialchars($log['child_name']); ?></td>
            <td><?php echo htmlspecialchars($log['activity_type']); ?></td>
            <td><?php echo htmlspecialchars($log['activity_details']); ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
