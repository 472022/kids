<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

// Fetch Statistics
try {
    $stats = [];
    
    $stats['parents'] = $pdo->query("SELECT COUNT(*) FROM parents")->fetchColumn();
    $stats['children'] = $pdo->query("SELECT COUNT(*) FROM children")->fetchColumn();
    $stats['lessons'] = $pdo->query("SELECT COUNT(*) FROM lessons")->fetchColumn();
    $stats['games'] = $pdo->query("SELECT COUNT(*) FROM games")->fetchColumn();
    $stats['quizzes'] = $pdo->query("SELECT COUNT(*) FROM quizzes")->fetchColumn();
    
    // Example: Recent Activities
    $recent_activities = $pdo->query("SELECT a.*, c.child_name FROM activity_logs a JOIN children c ON a.child_id = c.child_id ORDER BY a.created_at DESC LIMIT 5")->fetchAll();

} catch (PDOException $e) {
    die("Error loading dashboard: " . $e->getMessage());
}

include 'includes/header.php';
?>

<div class="dashboard-header">
    <h1>Admin Dashboard</h1>
    <p>Welcome back, <?php echo htmlspecialchars($_SESSION['name']); ?>!</p>
</div>

<!-- Widgets -->
<div class="stats-grid">
    <div class="stat-card">
        <h3>Parents</h3>
        <p class="stat-number"><?php echo $stats['parents']; ?></p>
    </div>
    <div class="stat-card">
        <h3>Children</h3>
        <p class="stat-number"><?php echo $stats['children']; ?></p>
    </div>
    <div class="stat-card">
        <h3>Lessons</h3>
        <p class="stat-number"><?php echo $stats['lessons']; ?></p>
    </div>
    <div class="stat-card">
        <h3>Games</h3>
        <p class="stat-number"><?php echo $stats['games']; ?></p>
    </div>
    <div class="stat-card">
        <h3>Quizzes</h3>
        <p class="stat-number"><?php echo $stats['quizzes']; ?></p>
    </div>
</div>

<!-- Charts Section -->
<div class="charts-container">
    <div class="chart-box">
        <h3>User Growth</h3>
        <canvas id="userGrowthChart"></canvas>
    </div>
    <div class="chart-box">
        <h3>Content Distribution</h3>
        <canvas id="contentChart"></canvas>
    </div>
</div>

<!-- Recent Activity -->
<div class="recent-activity">
    <h3>Recent Activities</h3>
    <table>
        <thead>
            <tr>
                <th>Child</th>
                <th>Activity</th>
                <th>Details</th>
                <th>Time</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($recent_activities as $activity): ?>
            <tr>
                <td><?php echo htmlspecialchars($activity['child_name']); ?></td>
                <td><?php echo htmlspecialchars($activity['activity_type']); ?></td>
                <td><?php echo htmlspecialchars($activity['activity_details']); ?></td>
                <td><?php echo date('M d, H:i', strtotime($activity['created_at'])); ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Dummy Data for Charts (Replace with real AJAX data in production)
    const ctx1 = document.getElementById('userGrowthChart').getContext('2d');
    new Chart(ctx1, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Active Users',
                data: [12, 19, 3, 5, 2, 3],
                borderColor: '#4ECDC4',
                tension: 0.1
            }]
        }
    });

    const ctx2 = document.getElementById('contentChart').getContext('2d');
    new Chart(ctx2, {
        type: 'doughnut',
        data: {
            labels: ['Lessons', 'Games', 'Quizzes'],
            datasets: [{
                data: [<?php echo $stats['lessons']; ?>, <?php echo $stats['games']; ?>, <?php echo $stats['quizzes']; ?>],
                backgroundColor: ['#FF6B6B', '#4ECDC4', '#FFE66D']
            }]
        }
    });
</script>

<?php include 'includes/footer.php'; ?>
