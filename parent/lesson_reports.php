<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

// Helper to get kids
$stmt = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$stmt->execute([$parent_id]);
$children = $stmt->fetchAll();
if(!$child_id && count($children)>0) $child_id = $children[0]['child_id'];

// Fetch Lesson History
if ($child_id) {
    $sql = "SELECT lp.*, l.lesson_title, s.subject_name 
            FROM lesson_progress lp 
            JOIN lessons l ON lp.lesson_id = l.lesson_id 
            JOIN subjects s ON l.subject_id = s.subject_id 
            WHERE lp.child_id = ? AND lp.is_completed = 1 
            ORDER BY lp.completed_at DESC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$child_id]);
    $reports = $stmt->fetchAll();
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Lesson Completion Reports</h1>
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
                <th>Subject</th>
                <th>Lesson Title</th>
                <th>Completed Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <?php if(isset($reports) && count($reports) > 0): ?>
                <?php foreach($reports as $r): ?>
                <tr>
                    <td><?php echo htmlspecialchars($r['subject_name']); ?></td>
                    <td><?php echo htmlspecialchars($r['lesson_title']); ?></td>
                    <td><?php echo date('M d, Y h:i A', strtotime($r['completed_at'])); ?></td>
                    <td><span style="color:green; font-weight:bold;">Completed</span></td>
                </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr><td colspan="4">No lessons completed yet.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php include 'includes/footer.php'; ?>
