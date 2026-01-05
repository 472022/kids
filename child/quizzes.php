<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$child_id = $_SESSION['user_id'];

// Get all subjects
$subjects = $pdo->query("SELECT * FROM subjects ORDER BY subject_name ASC")->fetchAll();

include 'includes/header.php';
?>

<div class="glass-panel">
    <div style="text-align:center; margin-bottom:40px;">
        <h1 style="font-family:'Fredoka One'; color: var(--primary-color); font-size: 3rem; margin-bottom:10px;">Time for a Quiz! 🧠</h1>
        <p style="font-size:1.5rem; color:#5D4037; font-weight:bold;">Test your knowledge and earn stars!</p>
    </div>

    <?php foreach($subjects as $subject): ?>
        <?php
            // Fetch quizzes for this subject
            $stmt = $pdo->prepare("SELECT * FROM quizzes WHERE subject_id = ?");
            $stmt->execute([$subject['subject_id']]);
            $quizzes = $stmt->fetchAll();

            // Skip subjects with no quizzes
            if(empty($quizzes)) continue;
        ?>

        <div style="margin-bottom: 50px;">
            <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 20px; border-bottom: 2px dashed #FFCC80; padding-bottom: 10px;">
                <div class="subject-icon" style="width: 50px; height: 50px; font-size: 1.5rem; margin: 0;">
                    <?php if($subject['subject_icon']): ?>
                        <img src="../<?php echo htmlspecialchars($subject['subject_icon']); ?>" alt="Icon" style="width:25px; height:25px;">
                    <?php else: ?>
                        <i class="fas fa-book"></i>
                    <?php endif; ?>
                </div>
                <h2 style="font-family: 'Fredoka One'; color: #E65100; font-size: 2rem; margin: 0;">
                    <?php echo htmlspecialchars($subject['subject_name']); ?>
                </h2>
            </div>

            <div class="subject-row" style="justify-content: flex-start;">
                <?php foreach($quizzes as $quiz): ?>
                    <?php
                        // Check if all lessons in this subject are completed
                        $totalLessons = $pdo->prepare("SELECT COUNT(*) FROM lessons WHERE subject_id = ?");
                        $totalLessons->execute([$quiz['subject_id']]);
                        $total = $totalLessons->fetchColumn();
                        
                        $completedLessons = $pdo->prepare("SELECT COUNT(*) FROM lesson_progress lp JOIN lessons l ON lp.lesson_id = l.lesson_id WHERE l.subject_id = ? AND lp.child_id = ? AND lp.is_completed = 1");
                        $completedLessons->execute([$quiz['subject_id'], $child_id]);
                        $completed = $completedLessons->fetchColumn();
                        
                        $isLocked = ($completed < $total);
                        
                        // Check if quiz already taken
                        $quizResult = $pdo->prepare("SELECT score FROM quiz_results WHERE quiz_id = ? AND child_id = ?");
                        $quizResult->execute([$quiz['quiz_id'], $child_id]);
                        $result = $quizResult->fetch();
                    ?>
                    
                    <div class="subject-card" style="width: 300px; flex-direction: column; text-align: center; padding: 30px; opacity: <?php echo $isLocked ? '0.8' : '1'; ?>;">
                        <div class="subject-icon" style="width: 80px; height: 80px; font-size: 3rem; background: #FFF3E0; color: #FF9800;">
                            <?php if($subject['subject_icon']): ?>
                                <img src="../<?php echo htmlspecialchars($subject['subject_icon']); ?>" alt="Icon" style="width:40px; height:40px;">
                            <?php else: ?>
                                <i class="fas fa-question"></i>
                            <?php endif; ?>
                        </div>
                        
                        <h3 style="margin-top:15px; font-family:'Fredoka One'; color: #E65100;"><?php echo htmlspecialchars($quiz['quiz_title']); ?></h3>
                        
                        <?php if($result): ?>
                            <div style="background:#4CAF50; color:white; padding:10px 20px; border-radius:20px; margin-top:15px; font-weight:bold; box-shadow: 0 4px 0 #2E7D32;">
                                ⭐ Score: <?php echo $result['score']; ?>/10
                            </div>
                        <?php elseif($isLocked): ?>
                            <div style="background:#B0BEC5; color:white; padding:10px 20px; border-radius:20px; margin-top:15px; font-size:0.9rem; font-weight:bold;">
                                🔒 Locked<br>
                                <span style="font-size:0.8rem; font-weight:normal;">(<?php echo $completed; ?>/<?php echo $total; ?> lessons)</span>
                            </div>
                        <?php else: ?>
                            <a href="quiz_start.php?quiz_id=<?php echo $quiz['quiz_id']; ?>" class="big-btn" style="width: auto; height: auto; padding: 10px 25px; font-size: 1.2rem; background: #FF9800; box-shadow: 0 5px 0 #E65100; margin-top: 15px;">
                                🚀 Start Quiz
                            </a>
                        <?php endif; ?>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endforeach; ?>

    <?php if(empty($subjects)): ?>
        <p style="text-align:center; width:100%;">No quizzes available yet.</p>
    <?php endif; ?>

</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
