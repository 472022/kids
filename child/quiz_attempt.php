<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$quiz_id = $_GET['quiz_id'] ?? null;
$child_id = $_SESSION['user_id'];
if (!$quiz_id) { header("Location: quizzes.php"); exit; }

// Get Questions
$stmt = $pdo->prepare("SELECT * FROM quiz_questions WHERE quiz_id = ?");
$stmt->execute([$quiz_id]);
$questions = $stmt->fetchAll();

require_once 'includes/rewards_helper.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $score = 0;
    $user_answers = []; // Store answers for review

    foreach($questions as $q) {
        $qid = $q['question_id'];
        $selected = $_POST["q_$qid"] ?? null;
        $user_answers[$qid] = $selected;

        if ($selected && $selected == $q['correct_option']) {
            $score++;
        }
    }
    
    // Save Result
    $save = $pdo->prepare("INSERT INTO quiz_results (child_id, quiz_id, score, is_completed) VALUES (?, ?, ?, 1)");
    $save->execute([$child_id, $quiz_id, $score]);
    
    // Add Stars (10 for quiz + bonus for perfect score)
    $stars = 10;
    if ($score == 10) $stars += 5; // Bonus
    $pdo->prepare("UPDATE children SET total_stars = total_stars + ? WHERE child_id = ?")->execute([$stars, $child_id]);

    // Check Badges
    $newBadges = checkAndUnlockBadges($child_id, $pdo);
    
    // Log
    $pdo->prepare("INSERT INTO activity_logs (child_id, activity_type, activity_details) VALUES (?, 'quiz', ?)")
        ->execute([$child_id, "Completed quiz with score $score/10"]);

    // Show Result Screen
    include 'includes/header.php';
    ?>
    <div class="glass-panel" style="max-width:800px; margin:50px auto; text-align:center;">
        <h1 style="font-size:3rem; color:#2ecc71; font-family: 'Fredoka One';">Quiz Completed! 🎉</h1>
        <div style="font-size:6rem; margin:20px 0;">
            <?php 
                if($score >= 8) echo "🏆";
                elseif($score >= 5) echo "⭐";
                else echo "👍";
            ?>
        </div>
        <h2 style="font-size:2.5rem; color: #5D4037;">You scored: <?php echo $score; ?>/10</h2>
        
        <?php if(!empty($newBadges)): ?>
            <div style="background:#f1c40f; padding:20px; border-radius:20px; margin-top:20px; animation: pop 0.5s;">
                <h3 style="color: #5D4037;">🎉 New Badges Unlocked!</h3>
                <?php foreach($newBadges as $b): ?>
                    <span style="font-size:1.5rem; font-weight:bold; display:block; color: #333;">🏅 <?php echo htmlspecialchars($b); ?></span>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <!-- Review Section -->
        <div style="margin-top: 40px; text-align: left;">
            <h3 style="text-align: center; color: #E65100; font-family: 'Fredoka One'; margin-bottom: 20px;">Review Your Answers</h3>
            
            <?php foreach($questions as $index => $q): ?>
                <?php 
                    $qid = $q['question_id'];
                    $user_choice = $user_answers[$qid] ?? null;
                    $correct = $q['correct_option'];
                    $is_correct = ($user_choice == $correct);
                ?>
                <div style="background: rgba(255,255,255,0.9); padding: 20px; border-radius: 15px; margin-bottom: 20px; border-left: 10px solid <?php echo $is_correct ? '#4CAF50' : '#F44336'; ?>; box-shadow: 0 5px 15px rgba(0,0,0,0.05);">
                    <p style="font-weight: bold; font-size: 1.1rem; margin-bottom: 10px; color: #5D4037;">
                        <?php echo ($index + 1) . ". " . htmlspecialchars($q['question']); ?>
                    </p>
                    
                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <!-- User Answer -->
                        <div style="flex: 1; padding: 10px; border-radius: 10px; background: <?php echo $is_correct ? '#E8F5E9' : '#FFEBEE'; ?>; color: <?php echo $is_correct ? '#2E7D32' : '#C62828'; ?>;">
                            <strong>Your Answer:</strong> 
                            <?php 
                                if($user_choice) echo htmlspecialchars($q['option_' . strtolower($user_choice)]); 
                                else echo "No Answer";
                            ?>
                            <?php echo $is_correct ? '✅' : '❌'; ?>
                        </div>
                        
                        <!-- Correct Answer (Only show if wrong) -->
                        <?php if(!$is_correct): ?>
                            <div style="flex: 1; padding: 10px; border-radius: 10px; background: #E3F2FD; color: #1565C0;">
                                <strong>Correct Answer:</strong> <?php echo htmlspecialchars($q['option_' . strtolower($correct)]); ?>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>

        <a href="quizzes.php" class="big-btn" style="width: auto; height: auto; padding: 15px 40px; border-radius: 40px; margin-top: 20px; font-size: 1.5rem; background: #FF9800; box-shadow: 0 6px 0 #E65100; display: inline-block;">Back to Quizzes</a>
    </div>
    </body></html>
    <?php
    exit;
}

include 'includes/header.php';
?>

<div class="glass-panel" style="max-width:800px; margin:0 auto;">
    <form method="POST">
        <?php foreach($questions as $index => $q): ?>
            <div style="margin-bottom:30px; text-align:left; background: rgba(255,255,255,0.8); padding: 20px; border-radius: 20px; border: 2px solid #FFE0B2;">
                <h3 style="margin-top:0; color: #E65100; font-family: 'Fredoka One';">Question <?php echo $index + 1; ?></h3>
                <p style="font-size:1.3rem; font-weight:bold; color: #5D4037;"><?php echo htmlspecialchars($q['question']); ?></p>
                
                <div style="display:grid; grid-template-columns: 1fr 1fr; gap:15px; margin-top:20px;">
                    <label style="background:#fff; padding:15px; border-radius:10px; cursor:pointer; border:2px solid #FFCC80; display:flex; align-items:center; color: #5D4037;">
                        <input type="radio" name="q_<?php echo $q['question_id']; ?>" value="A" required style="width:20px; height:20px; margin-right:10px;">
                        <?php echo htmlspecialchars($q['option_a']); ?>
                    </label>
                    <label style="background:#fff; padding:15px; border-radius:10px; cursor:pointer; border:2px solid #FFCC80; display:flex; align-items:center; color: #5D4037;">
                        <input type="radio" name="q_<?php echo $q['question_id']; ?>" value="B" style="width:20px; height:20px; margin-right:10px;">
                        <?php echo htmlspecialchars($q['option_b']); ?>
                    </label>
                    <label style="background:#fff; padding:15px; border-radius:10px; cursor:pointer; border:2px solid #FFCC80; display:flex; align-items:center; color: #5D4037;">
                        <input type="radio" name="q_<?php echo $q['question_id']; ?>" value="C" style="width:20px; height:20px; margin-right:10px;">
                        <?php echo htmlspecialchars($q['option_c']); ?>
                    </label>
                    <label style="background:#fff; padding:15px; border-radius:10px; cursor:pointer; border:2px solid #FFCC80; display:flex; align-items:center; color: #5D4037;">
                        <input type="radio" name="q_<?php echo $q['question_id']; ?>" value="D" style="width:20px; height:20px; margin-right:10px;">
                        <?php echo htmlspecialchars($q['option_d']); ?>
                    </label>
                </div>
            </div>
        <?php endforeach; ?>
        
        <div style="text-align:center; margin-bottom:20px;">
            <button type="submit" style="background:#FF6B6B; color:white; border:none; padding:20px 60px; font-size:1.5rem; border-radius:50px; cursor:pointer; font-weight:bold; box-shadow:0 8px 0 #ee5253; transition:transform 0.1s; font-family: 'Fredoka One';">
                Submit Quiz 📝
            </button>
        </div>
    </form>
</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
