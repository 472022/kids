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
    $sql = "SELECT qr.*, q.quiz_title, s.subject_name 
            FROM quiz_results qr 
            JOIN quizzes q ON qr.quiz_id = q.quiz_id 
            JOIN subjects s ON q.subject_id = s.subject_id 
            WHERE qr.child_id = ? 
            ORDER BY qr.attempted_at DESC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$child_id]);
    $reports = $stmt->fetchAll();
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Quiz Performance Reports</h1>
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
                <th>Quiz Title</th>
                <th>Score</th>
                <th>Date Taken</th>
                <th>Result</th>
            </tr>
        </thead>
        <tbody>
            <?php if(isset($reports) && count($reports) > 0): ?>
                <?php foreach($reports as $r): ?>
                <tr>
                    <td><?php echo htmlspecialchars($r['subject_name']); ?></td>
                    <td><?php echo htmlspecialchars($r['quiz_title']); ?></td>
                    <td><?php echo $r['score']; ?>/10</td>
                    <td><?php echo date('M d, Y h:i A', strtotime($r['attempted_at'])); ?></td>
                    <td>
                        <?php 
                        if($r['score'] >= 8) echo '<span style="color:green; font-weight:bold;">Excellent</span>';
                        elseif($r['score'] >= 5) echo '<span style="color:orange; font-weight:bold;">Good</span>';
                        else echo '<span style="color:red; font-weight:bold;">Needs Practice</span>';
                        ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr><td colspan="5">No quizzes taken yet.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php include 'includes/footer.php'; ?>
