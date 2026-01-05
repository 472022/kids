<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

$stmt = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$stmt->execute([$parent_id]);
$children = $stmt->fetchAll();
if(!$child_id && count($children)>0) $child_id = $children[0]['child_id'];

// Calculate Progress for Charts
$dates = [];
$lessonCounts = [];
$quizCounts = [];

if ($child_id) {
    // Last 7 days data
    for ($i = 6; $i >= 0; $i--) {
        $date = date('Y-m-d', strtotime("-$i days"));
        $dates[] = date('M d', strtotime($date));
        
        $l = $pdo->query("SELECT COUNT(*) FROM lesson_progress WHERE child_id = $child_id AND DATE(completed_at) = '$date'")->fetchColumn();
        $q = $pdo->query("SELECT COUNT(*) FROM quiz_results WHERE child_id = $child_id AND DATE(attempted_at) = '$date'")->fetchColumn();
        
        $lessonCounts[] = $l;
        $quizCounts[] = $q;
    }
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Learning Analytics</h1>
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

<div class="card" style="margin-bottom:30px;">
    <h3>Weekly Activity Overview</h3>
    <canvas id="weeklyChart" style="width:100%; height:300px;"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('weeklyChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: <?php echo json_encode($dates); ?>,
            datasets: [
                {
                    label: 'Lessons Completed',
                    data: <?php echo json_encode($lessonCounts); ?>,
                    borderColor: '#2ecc71',
                    tension: 0.1
                },
                {
                    label: 'Quizzes Taken',
                    data: <?php echo json_encode($quizCounts); ?>,
                    borderColor: '#9b59b6',
                    tension: 0.1
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { stepSize: 1 }
                }
            }
        }
    });
</script>

<?php include 'includes/footer.php'; ?>
