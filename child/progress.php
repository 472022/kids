<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$child_id = $_SESSION['user_id'];

// Fetch Stats
$child = $pdo->prepare("SELECT * FROM children WHERE child_id = ?");
$child->execute([$child_id]);
$userData = $child->fetch();

// Simplified count queries
$lCount = $pdo->query("SELECT COUNT(*) FROM lesson_progress WHERE child_id = $child_id AND is_completed = 1")->fetchColumn();
$qCount = $pdo->query("SELECT COUNT(*) FROM quiz_results WHERE child_id = $child_id AND is_completed = 1")->fetchColumn();
$gCount = $pdo->query("SELECT COUNT(*) FROM game_progress WHERE child_id = $child_id")->fetchColumn();

// Totals for Percentages (Assuming some totals for demo)
$totalLessons = $pdo->query("SELECT COUNT(*) FROM lessons")->fetchColumn();
$totalQuizzes = $pdo->query("SELECT COUNT(*) FROM quizzes")->fetchColumn();

$lPercent = $totalLessons > 0 ? ($lCount / $totalLessons) * 100 : 0;
$qPercent = $totalQuizzes > 0 ? ($qCount / $totalQuizzes) * 100 : 0;

include 'includes/header.php';
?>

<div class="glass-panel" style="max-width:900px; margin:0 auto;">
    
    <div style="text-align:center; background:linear-gradient(135deg, #FF9800, #F57C00); color:white; padding: 40px; border-radius: 30px; box-shadow: 0 10px 20px rgba(245, 124, 0, 0.3); margin-bottom: 30px;">
        <div style="font-size:5rem; background: rgba(255,255,255,0.2); width: 120px; height: 120px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px auto; border: 4px solid white;">
            <?php echo $userData['avatar'] ? '<img src="../'.$userData['avatar'].'">' : '🧑‍🎓'; ?>
        </div>
        <h1 style="margin:10px 0; font-family: 'Fredoka One'; font-size: 2.5rem;"><?php echo htmlspecialchars($userData['child_name']); ?></h1>
        
        <div style="display:flex; justify-content:center; gap:40px; font-size:1.5rem; margin-top:20px;">
            <div style="background: rgba(255,255,255,0.2); padding: 10px 25px; border-radius: 20px;">⭐ Stars: <strong><?php echo $userData['total_stars']; ?></strong></div>
            <div style="background: rgba(255,255,255,0.2); padding: 10px 25px; border-radius: 20px;">🏆 Level: <strong><?php echo $userData['level']; ?></strong></div>
        </div>
        
        <div style="margin-top:25px; font-size:1.3rem; background:rgba(255,255,255,0.9); color: #E65100; padding:15px; border-radius:15px; font-weight: bold;">
            "You're doing amazing! Keep it up! 🚀"
        </div>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-bottom: 30px;">
        <div class="subject-card" style="width: 100%; display: block; background: white; padding: 25px; box-sizing: border-box;">
            <h3 style="color: #4CAF50; margin-bottom: 15px; font-size: 1.5rem;"><i class="fas fa-book-open"></i> Lessons Progress</h3>
            <div class="progress-container" style="background: #E8F5E9; border: none; height: 30px; margin: 0; width: 100%;">
                <div class="progress-bar-fill" style="width: <?php echo $lPercent; ?>%; background: #4CAF50; line-height: 30px; text-align: right; padding-right: 10px; color: white; font-weight: bold; min-width: 2em;">
                    <?php echo round($lPercent); ?>%
                </div>
            </div>
            <p style="margin-top: 10px; color: #666;"><?php echo $lCount; ?> out of <?php echo $totalLessons; ?> lessons completed</p>
        </div>

        <div class="subject-card" style="width: 100%; display: block; background: white; padding: 25px; box-sizing: border-box;">
            <h3 style="color: #9C27B0; margin-bottom: 15px; font-size: 1.5rem;"><i class="fas fa-question-circle"></i> Quiz Mastery</h3>
            <div class="progress-container" style="background: #F3E5F5; border: none; height: 30px; margin: 0; width: 100%;">
                <div class="progress-bar-fill" style="width: <?php echo $qPercent; ?>%; background: #9C27B0; line-height: 30px; text-align: right; padding-right: 10px; color: white; font-weight: bold; min-width: 2em;">
                    <?php echo round($qPercent); ?>%
                </div>
            </div>
            <p style="margin-top: 10px; color: #666;"><?php echo $qCount; ?> quizzes completed</p>
        </div>
    </div>

    <div class="subject-card" style="width: 100%; display: flex; align-items: center; justify-content: space-between; padding: 25px; margin-bottom: 30px; background: white;">
        <div>
            <h3 style="color: #FF9800; font-size: 1.5rem; margin: 0;"><i class="fas fa-gamepad"></i> Games Played</h3>
            <p style="margin: 5px 0 0; color: #666;">Total gaming sessions</p>
        </div>
        <div style="font-size:3rem; color:#FF9800; font-weight:bold; font-family: 'Fredoka One';">
            <?php echo $gCount; ?>
        </div>
    </div>
    
    <div style="text-align:center;">
        <a href="achievements.php" class="big-btn" style="width: auto; height: auto; padding: 15px 40px; font-size: 1.5rem; background: #FFC107; box-shadow: 0 6px 0 #FFA000; color: #333; display: inline-block;">
            <i class="fas fa-trophy" style="font-size: 1.5rem; margin-right: 10px;"></i> View My Badges
        </a>
    </div>
</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
