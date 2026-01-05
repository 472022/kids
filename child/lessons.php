<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';
include 'includes/header.php';

$child_id = $_SESSION['user_id'];
$subject_id = $_GET['subject_id'] ?? null;
?>

<div class="glass-panel">
    <?php if ($subject_id): ?>
        <?php
        // === VIEW 2: LESSON LIST ===
        
        // Get Subject Details
        $stmt = $pdo->prepare("SELECT * FROM subjects WHERE subject_id = ?");
        $stmt->execute([$subject_id]);
        $subject = $stmt->fetch();
        
        if(!$subject) {
            echo "<script>window.location.href='lessons.php';</script>";
            exit;
        }

        // Get Lessons with Progress
        $sql = "SELECT l.*, 
                (SELECT COUNT(*) FROM lesson_progress lp WHERE lp.lesson_id = l.lesson_id AND lp.child_id = ? AND lp.is_completed = 1) as is_completed
                FROM lessons l 
                WHERE l.subject_id = ? 
                ORDER BY l.created_at ASC";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$child_id, $subject_id]);
        $lessons = $stmt->fetchAll();
        ?>
        
        <div style="margin-bottom:20px;">
            <a href="lessons.php" class="btn-back">⬅ Back to Subjects</a>
            <h2 style="font-family:'Fredoka One'; color: var(--primary-color); font-size: 2rem;"><?php echo htmlspecialchars($subject['subject_name']); ?> Lessons</h2>
        </div>

        <div class="subject-row" style="justify-content: flex-start;">
            <?php foreach($lessons as $lesson): ?>
            <a href="lesson_view.php?lesson_id=<?php echo $lesson['lesson_id']; ?>" class="subject-card" style="width: 100%; border-radius: 20px; justify-content: space-between;">
                <div style="display:flex; align-items:center; gap: 20px;">
                    <div class="subject-icon" style="background: <?php echo $lesson['is_completed'] ? '#E8F5E9' : '#FFF3E0'; ?>; color: <?php echo $lesson['is_completed'] ? '#4CAF50' : '#FF9800'; ?>;">
                        <i class="fas <?php echo $lesson['is_completed'] ? 'fa-check' : 'fa-play'; ?>"></i>
                    </div>
                    <div>
                        <h3 style="margin:0; font-size:1.3rem; color: var(--text-color);"><?php echo htmlspecialchars($lesson['lesson_title']); ?></h3>
                        <p style="margin-top:5px; font-weight:normal;"><?php echo htmlspecialchars($lesson['lesson_description']); ?></p>
                    </div>
                </div>
                <?php if($lesson['is_completed']): ?>
                    <span style="font-size:1.5rem;">✅</span>
                <?php else: ?>
                    <span style="font-size:1.5rem; opacity: 0.5;">⏳</span>
                <?php endif; ?>
            </a>
            <?php endforeach; ?>
            
            <?php if(empty($lessons)): ?>
                <p style="font-size: 1.2rem; text-align:center; width: 100%;">No lessons available for this subject yet.</p>
            <?php endif; ?>
        </div>

    <?php else: ?>
        <?php
        // === VIEW 1: SUBJECT LIST ===
        $subjects = $pdo->query("SELECT * FROM subjects ORDER BY subject_name ASC")->fetchAll();
        ?>
        
        <h2 style="text-align:center; margin-bottom:40px; font-family:'Fredoka One'; color: var(--primary-color); font-size: 2.5rem;">Choose a Subject! 📚</h2>
        
        <div class="subject-row">
            <?php foreach($subjects as $subject): ?>
            <a href="lessons.php?subject_id=<?php echo $subject['subject_id']; ?>" class="subject-card">
                <div class="subject-icon">
                    <?php if($subject['subject_icon']): ?>
                        <img src="../<?php echo htmlspecialchars($subject['subject_icon']); ?>" alt="Icon" style="width:30px; height:30px;">
                    <?php else: ?>
                        <i class="fas fa-book"></i>
                    <?php endif; ?>
                </div>
                <div class="subject-info">
                    <h3><?php echo htmlspecialchars($subject['subject_name']); ?></h3>
                    <p>Click to learn!</p>
                </div>
            </a>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>

</div> <!-- End Dashboard Container (opened in header) -->
</body>
</html>
