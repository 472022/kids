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
        
        $total_lessons = count($lessons);
        $completed_count = 0;
        foreach($lessons as $l) if($l['is_completed']) $completed_count++;
        $progress_percent = $total_lessons > 0 ? ($completed_count / $total_lessons) * 100 : 0;
        ?>
        
        <div class="lesson-header-banner" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
            <div style="flex-grow: 1;">
                <a href="lessons.php" class="btn-back-pill"><i class="fas fa-arrow-left"></i> Subjects</a>
                <h2 style="color: white; margin-top: 15px; font-size: 2.5rem;"><?php echo htmlspecialchars($subject['subject_name']); ?></h2>
                <p style="color: rgba(255,255,255,0.9); font-size: 1.1rem;">
                    <?php echo $completed_count; ?> of <?php echo $total_lessons; ?> lessons completed
                </p>
            </div>
            <div class="progress-circle" data-percent="<?php echo round($progress_percent); ?>">
                <svg viewBox="0 0 36 36" class="circular-chart orange">
                    <path class="circle-bg" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                    <path class="circle" stroke-dasharray="<?php echo $progress_percent; ?>, 100" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                    <text x="18" y="20.35" class="percentage"><?php echo round($progress_percent); ?>%</text>
                </svg>
            </div>
        </div>

        <div class="lesson-grid">
            <?php foreach($lessons as $index => $lesson): ?>
            <a href="lesson_view.php?lesson_id=<?php echo $lesson['lesson_id']; ?>" class="lesson-card <?php echo $lesson['is_completed'] ? 'completed' : ''; ?>">
                <div class="lesson-number">#<?php echo $index + 1; ?></div>
                <div class="lesson-content">
                    <h3><?php echo htmlspecialchars($lesson['lesson_title']); ?></h3>
                    <p><?php echo htmlspecialchars($lesson['lesson_description']); ?></p>
                </div>
                <div class="lesson-status">
                    <?php if($lesson['is_completed']): ?>
                        <div class="status-icon success"><i class="fas fa-star"></i></div>
                    <?php else: ?>
                        <div class="status-icon pending"><i class="fas fa-play"></i></div>
                    <?php endif; ?>
                </div>
            </a>
            <?php endforeach; ?>
            
            <?php if(empty($lessons)): ?>
                <div class="empty-state">
                    <i class="fas fa-layer-group"></i>
                    <p>No lessons available yet.</p>
                </div>
            <?php endif; ?>
        </div>

        <style>
            .lesson-header-banner {
                padding: 40px;
                border-radius: 25px;
                color: white;
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 40px;
                box-shadow: 0 10px 30px rgba(118, 75, 162, 0.3);
                position: relative;
                overflow: hidden;
            }
            .btn-back-pill {
                background: rgba(255,255,255,0.2);
                color: white;
                padding: 8px 20px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: bold;
                transition: background 0.2s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-back-pill:hover {
                background: rgba(255,255,255,0.3);
                color: white;
            }
            
            /* Circular Progress */
            .progress-circle { width: 100px; height: 100px; }
            .circular-chart { display: block; margin: 0 auto; max-width: 100%; max-height: 100%; }
            .circle-bg { fill: none; stroke: rgba(255,255,255,0.2); stroke-width: 3.8; }
            .circle { fill: none; stroke-width: 3.8; stroke-linecap: round; stroke: #4CAF50; transition: stroke-dasharray 1s ease-out; }
            .percentage { fill: white; font-family: 'Fredoka One', sans-serif; font-weight: bold; font-size: 0.5em; text-anchor: middle; }

            /* Lesson Grid */
            .lesson-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 25px;
            }
            .lesson-card {
                background: white;
                border-radius: 20px;
                padding: 25px;
                display: flex;
                align-items: center;
                gap: 20px;
                text-decoration: none;
                color: #2c3e50;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                transition: transform 0.2s, box-shadow 0.2s;
                position: relative;
                overflow: hidden;
                border-left: 5px solid #FF9800; /* Default pending color */
            }
            .lesson-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            }
            .lesson-card.completed {
                border-left-color: #4CAF50;
                background: linear-gradient(to right, #ffffff, #f1f8e9);
            }
            .lesson-number {
                font-size: 1.5rem;
                font-weight: bold;
                color: #b0bec5;
                font-family: 'Fredoka One';
            }
            .lesson-content h3 {
                margin: 0 0 5px 0;
                font-size: 1.2rem;
            }
            .lesson-content p {
                margin: 0;
                font-size: 0.9rem;
                color: #7f8c8d;
            }
            .status-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-left: auto;
            }
            .status-icon.success { background: #4CAF50; color: white; }
            .status-icon.pending { background: #FFF3E0; color: #FF9800; }
            
            .empty-state {
                grid-column: 1 / -1;
                text-align: center;
                padding: 50px;
                color: #95a5a6;
                font-size: 1.2rem;
            }
            .empty-state i { font-size: 3rem; margin-bottom: 15px; display: block; opacity: 0.5; }
        </style>

    <?php else: ?>
        <?php
        // === VIEW 1: SUBJECT LIST ===
        $subjects = $pdo->query("SELECT * FROM subjects ORDER BY subject_name ASC")->fetchAll();
        ?>
        
        <div style="text-align:center; margin-bottom:40px;">
            <h2 style="font-family:'Fredoka One'; color: var(--secondary-color); font-size: 3rem; margin-bottom:10px;">Choose a Subject! 📚</h2>
            <p style="font-size:1.5rem; color:#5D4037; font-weight:bold;">What do you want to learn today?</p>
        </div>
        
        <div class="subject-row" style="gap: 30px;">
            <?php foreach($subjects as $subject): ?>
            <?php 
                // Determine color based on subject name (simple hash or check)
                $colors = ['#FF9800', '#4CAF50', '#2196F3', '#9C27B0', '#E91E63'];
                $bg_color = $colors[$subject['subject_id'] % count($colors)];
                $icon = 'fa-book';
                if(strpos(strtolower($subject['subject_name']), 'math') !== false) $icon = 'fa-calculator';
                if(strpos(strtolower($subject['subject_name']), 'sci') !== false) $icon = 'fa-flask';
                if(strpos(strtolower($subject['subject_name']), 'eng') !== false) $icon = 'fa-font';
            ?>
            <a href="lessons.php?subject_id=<?php echo $subject['subject_id']; ?>" class="subject-card-enhanced" style="border-bottom: 5px solid <?php echo $bg_color; ?>;">
                <div class="card-icon-large" style="background: <?php echo $bg_color; ?>;">
                    <i class="fas <?php echo $icon; ?>"></i>
                </div>
                <div class="card-content">
                    <h3><?php echo htmlspecialchars($subject['subject_name']); ?></h3>
                    <span class="badge-pill">Start Learning</span>
                </div>
            </a>
            <?php endforeach; ?>
        </div>
        
        <style>
            .subject-card-enhanced {
                background: white;
                border-radius: 20px;
                padding: 30px;
                text-align: center;
                text-decoration: none;
                color: inherit;
                transition: transform 0.3s, box-shadow 0.3s;
                box-shadow: 0 10px 20px rgba(0,0,0,0.05);
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 280px;
                position: relative;
                overflow: hidden;
            }
            .subject-card-enhanced:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            }
            .card-icon-large {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 3rem;
                margin-bottom: 20px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .card-content h3 {
                font-family: 'Fredoka One', cursive;
                font-size: 1.8rem;
                color: #2c3e50;
                margin-bottom: 10px;
            }
            .badge-pill {
                background: #f1f2f6;
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 0.9rem;
                color: #7f8c8d;
                font-weight: bold;
            }
        </style>
    <?php endif; ?>
</div>

</div> <!-- End Dashboard Container (opened in header) -->
</body>
</html>
