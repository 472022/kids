<?php
require_once '../config/db.php';

// Set header variable
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
// Manually fetch child info to pass to header
if (isset($_SESSION['user_id'])) {
    $stmt = $pdo->prepare("SELECT child_name, child_age, total_stars FROM children WHERE child_id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $child = $stmt->fetch();
    if ($child) {
        $child_name_header = $child['child_name'];
    }
}

// Fetch Progress Stats
$child_id = $_SESSION['user_id'];
$stmt = $pdo->prepare("SELECT COUNT(*) FROM quiz_results WHERE child_id = ? AND is_completed = 1");
$stmt->execute([$child_id]);
$completed_quizzes = $stmt->fetchColumn();

// Fetch Subjects (for the subject row)
$stmt = $pdo->query("SELECT * FROM subjects LIMIT 3");
$subjects = $stmt->fetchAll();

// Include the new unified header
require_once 'includes/header.php';
?>

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            Learn • Play • Explore • Have Fun!
        </div>

        <!-- Big Activity Buttons -->
        <div class="activity-row">
            <a href="lessons.php" class="big-btn btn-learn">
                <i class="fas fa-book-open"></i>
                Learn
            </a>
            <a href="games.php" class="big-btn btn-games">
                <i class="fas fa-gamepad"></i>
                Play Games
            </a>
            <a href="quizzes.php" class="big-btn btn-quiz">
                <i class="fas fa-question-circle"></i>
                Take Quiz
            </a>
            <a href="drawing.php" class="big-btn btn-draw">
                <i class="fas fa-palette"></i>
                Draw & Color
            </a>
        </div>

        <!-- Start Learning (Subjects) -->
        <div style="margin-bottom: 20px;">
            <span class="welcome-banner" style="background: #4CAF50; font-size: 1.2rem;">Start Learning!</span>
        </div>

        <div class="subject-row">
            <!-- Dynamic Subjects or Fallback -->
            <?php if ($subjects): ?>
                <?php foreach ($subjects as $subject): ?>
                <a href="lessons.php?subject_id=<?php echo $subject['subject_id']; ?>" class="subject-card">
                    <div class="subject-icon">
                        <?php if(strpos(strtolower($subject['subject_name']), 'math') !== false): ?>
                            <i class="fas fa-calculator"></i>
                        <?php elseif(strpos(strtolower($subject['subject_name']), 'sci') !== false): ?>
                            <i class="fas fa-flask"></i>
                        <?php elseif(strpos(strtolower($subject['subject_name']), 'eng') !== false): ?>
                            <i class="fas fa-font"></i>
                        <?php else: ?>
                            <i class="fas fa-book"></i>
                        <?php endif; ?>
                    </div>
                    <div class="subject-info">
                        <h3><?php echo htmlspecialchars($subject['subject_name']); ?></h3>
                        <p>Click to start!</p>
                    </div>
                </a>
                <?php endforeach; ?>
            <?php else: ?>
                <!-- Static Fallback if no subjects -->
                <a href="lessons.php" class="subject-card">
                    <div class="subject-icon"><i class="fas fa-font"></i></div>
                    <div class="subject-info"><h3>English</h3><p>ABC & Grammar</p></div>
                </a>
                <a href="lessons.php" class="subject-card">
                    <div class="subject-icon"><i class="fas fa-calculator"></i></div>
                    <div class="subject-info"><h3>Maths</h3><p>123 & Counting</p></div>
                </a>
                <a href="lessons.php" class="subject-card">
                    <div class="subject-icon"><i class="fas fa-flask"></i></div>
                    <div class="subject-info"><h3>Science</h3><p>World & Nature</p></div>
                </a>
            <?php endif; ?>
        </div>

    </div> <!-- End Dashboard Container -->

    <!-- Footer Progress Bar - Clickable Link to Profile -->
    <a href="progress.php" class="dashboard-footer" style="text-decoration: none; color: inherit; cursor: pointer; transition: transform 0.2s;">
        <div class="stat-item">
            Quizzes: <?php echo $completed_quizzes; ?> / 10
        </div>
        <div class="stat-item" style="color: #FBC02D;">
            Stars Earned: <?php echo htmlspecialchars($child['total_stars'] ?? 0); ?> <i class="fas fa-star"></i>
        </div>
        <div style="display: flex; align-items: center; flex-grow: 1; margin-left: 20px;">
            <span class="stat-item" style="font-size: 0.9rem; margin-right: 10px;">Your Progress</span>
            <div class="progress-container">
                <div class="progress-bar-fill" style="width: <?php echo min(($child['total_stars'] ?? 0), 100); ?>%;"></div>
            </div>
        </div>
    </a>
    <style>
        .dashboard-footer:hover {
            transform: translateX(-50%) scale(1.02);
            box-shadow: 0 -8px 25px rgba(0,0,0,0.15);
        }
    </style>

</body>
</html>
