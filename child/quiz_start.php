<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$quiz_id = $_GET['quiz_id'] ?? null;
if (!$quiz_id) { header("Location: quizzes.php"); exit; }

$stmt = $pdo->prepare("SELECT * FROM quizzes WHERE quiz_id = ?");
$stmt->execute([$quiz_id]);
$quiz = $stmt->fetch();

include 'includes/header.php';
?>

<div class="glass-panel" style="max-width:600px; margin:50px auto; text-align:center;">
    <h1 style="color:#FF6B6B; font-size:3rem; margin-bottom:20px; font-family: 'Fredoka One';"><?php echo htmlspecialchars($quiz['quiz_title']); ?></h1>
    <p style="font-size:1.5rem; margin-bottom:40px; color: #5D4037;">Are you ready to test your knowledge?</p>
    
    <div style="font-size:5rem; margin-bottom:30px;">🧐</div>
    
    <div style="background: rgba(255,255,255,0.5); padding: 20px; border-radius: 20px; display: inline-block; margin-bottom: 40px;">
        <ul style="text-align:left; font-size:1.2rem; margin:0; list-style:none; padding:0; color: #5D4037;">
            <li style="margin-bottom: 10px;">✅ There are 10 questions.</li>
            <li style="margin-bottom: 10px;">✅ Choose the best answer.</li>
            <li>✅ Earn stars for good scores!</li>
        </ul>
    </div>
    <br>
    
    <a href="quiz_attempt.php?quiz_id=<?php echo $quiz_id; ?>" class="big-btn" style="width: auto; height: auto; padding: 20px 50px; border-radius: 50px; font-size: 1.5rem; background: #2ecc71; box-shadow: 0 8px 0 #27ae60; display: inline-block;">
        Let's Go! 🚀
    </a>
</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
