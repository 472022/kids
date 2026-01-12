<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$child_id = $_SESSION['user_id'];

// Get all subjects
$subjects = $pdo->query("SELECT * FROM subjects ORDER BY subject_name ASC")->fetchAll();

include 'includes/header.php';
?>

<div class="glass-panel" style="background: linear-gradient(to bottom, #ffffff, #f8f9fa);">
    <div style="text-align:center; margin-bottom:50px; padding: 40px; background: #FFEB3B; border-radius: 30px; box-shadow: 0 10px 20px rgba(255, 235, 59, 0.3);">
        <h1 style="font-family:'Fredoka One'; color: #E65100; font-size: 3.5rem; margin-bottom:10px; text-shadow: 2px 2px 0px #FFF9C4;">Time for a Quiz! 🧠</h1>
        <p style="font-size:1.5rem; color:#5D4037; font-weight:bold;">Test your knowledge and earn shiny stars!</p>
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

        <div class="quiz-section">
            <div class="section-header">
                <div class="icon-circle" style="background: #E1F5FE; color: #0288D1;">
                    <?php if($subject['subject_icon']): ?>
                        <img src="../<?php echo htmlspecialchars($subject['subject_icon']); ?>" alt="Icon">
                    <?php else: ?>
                        <i class="fas fa-book-open"></i>
                    <?php endif; ?>
                </div>
                <h2><?php echo htmlspecialchars($subject['subject_name']); ?> Challenges</h2>
            </div>

            <div class="quiz-grid">
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
                        $remaining = $total - $completed;
                        
                        // Check if quiz already taken
                        $quizResult = $pdo->prepare("SELECT score FROM quiz_results WHERE quiz_id = ? AND child_id = ?");
                        $quizResult->execute([$quiz['quiz_id'], $child_id]);
                        $result = $quizResult->fetch();
                    ?>
                    
                    <div class="quiz-card <?php echo $isLocked ? 'locked' : ($result ? 'completed' : 'unlocked'); ?>">
                        <?php if($isLocked): ?>
                            <div class="lock-overlay">
                                <i class="fas fa-lock"></i>
                                <p>Complete <?php echo $remaining; ?> more lesson<?php echo $remaining > 1 ? 's' : ''; ?>!</p>
                            </div>
                        <?php endif; ?>

                        <div class="card-top">
                            <span class="badge">Quiz</span>
                            <h3><?php echo htmlspecialchars($quiz['quiz_title']); ?></h3>
                        </div>

                        <div class="card-bottom">
                            <?php if($result): ?>
                                <div class="score-badge">
                                    <i class="fas fa-trophy"></i>
                                    <span><?php echo $result['score']; ?>/10</span>
                                </div>
                                <a href="quiz_start.php?quiz_id=<?php echo $quiz['quiz_id']; ?>" class="btn-retry">Try Again</a>
                            <?php elseif($isLocked): ?>
                                <div class="progress-bar">
                                    <div class="fill" style="width: <?php echo ($completed / max($total, 1)) * 100; ?>%;"></div>
                                </div>
                            <?php else: ?>
                                <a href="quiz_start.php?quiz_id=<?php echo $quiz['quiz_id']; ?>" class="btn-start">
                                    Start Now <i class="fas fa-arrow-right"></i>
                                </a>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endforeach; ?>

    <?php if(empty($subjects)): ?>
        <div class="empty-state">
            <i class="fas fa-puzzle-piece"></i>
            <p>No quizzes available yet. Check back later!</p>
        </div>
    <?php endif; ?>

</div>

<style>
    /* Section Styling */
    .quiz-section { margin-bottom: 60px; }
    .section-header { display: flex; align-items: center; gap: 20px; margin-bottom: 30px; }
    .icon-circle { width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.8rem; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
    .icon-circle img { width: 30px; height: 30px; object-fit: contain; }
    .section-header h2 { font-family: 'Fredoka One'; color: #37474F; font-size: 2.2rem; margin: 0; }

    /* Grid Layout */
    .quiz-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; }

    /* Quiz Card Styling */
    .quiz-card {
        background: white;
        border-radius: 25px;
        padding: 30px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        transition: transform 0.3s, box-shadow 0.3s;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        min-height: 200px;
        border: 2px solid transparent;
    }
    
    .quiz-card.unlocked { border-color: #FF9800; background: linear-gradient(to bottom right, #ffffff, #FFF3E0); }
    .quiz-card.unlocked:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(255, 152, 0, 0.2); }
    
    .quiz-card.completed { border-color: #4CAF50; background: linear-gradient(to bottom right, #ffffff, #E8F5E9); }
    .quiz-card.locked { background: #f5f5f5; border: 2px dashed #cfd8dc; }

    /* Locked State */
    .lock-overlay {
        position: absolute; inset: 0; background: rgba(255,255,255,0.6);
        display: flex; flex-direction: column; align-items: center; justify-content: center;
        z-index: 10; backdrop-filter: blur(2px); color: #78909c; text-align: center;
    }
    .lock-overlay i { font-size: 3rem; margin-bottom: 10px; }
    .lock-overlay p { font-weight: bold; margin: 0; padding: 0 20px; }

    /* Card Content */
    .badge {
        background: #ECEFF1; color: #546E7A; padding: 5px 12px; border-radius: 15px;
        font-size: 0.8rem; font-weight: bold; text-transform: uppercase; letter-spacing: 1px;
    }
    .quiz-card.unlocked .badge { background: #FFE0B2; color: #E65100; }
    .quiz-card.completed .badge { background: #C8E6C9; color: #2E7D32; }

    .card-top h3 { font-family: 'Fredoka One'; font-size: 1.8rem; color: #263238; margin: 15px 0; line-height: 1.3; }

    /* Buttons & Status */
    .btn-start {
        display: inline-block; width: 100%; padding: 12px; background: #FF9800; color: white;
        text-align: center; border-radius: 15px; text-decoration: none; font-weight: bold; font-size: 1.1rem;
        box-shadow: 0 5px 0 #F57C00; transition: all 0.2s;
    }
    .btn-start:hover { transform: translateY(2px); box-shadow: 0 3px 0 #F57C00; }

    .score-badge {
        display: flex; align-items: center; justify-content: center; gap: 10px;
        font-size: 1.5rem; font-family: 'Fredoka One'; color: #2E7D32; margin-bottom: 10px;
    }
    .score-badge i { color: #FFD700; filter: drop-shadow(0 2px 2px rgba(0,0,0,0.2)); }

    .btn-retry {
        display: block; text-align: center; color: #7f8c8d; text-decoration: none; font-size: 0.9rem; font-weight: bold;
    }
    .btn-retry:hover { color: #2c3e50; text-decoration: underline; }

    .progress-bar { height: 8px; background: #cfd8dc; border-radius: 4px; overflow: hidden; }
    .progress-bar .fill { height: 100%; background: #b0bec5; }

    .empty-state { text-align: center; padding: 60px; color: #b0bec5; font-size: 1.5rem; }
    .empty-state i { font-size: 4rem; margin-bottom: 20px; display: block; opacity: 0.5; }
</style>

</div> <!-- End Dashboard Container -->
</body>
</html>
