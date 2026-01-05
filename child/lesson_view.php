<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$lesson_id = $_GET['lesson_id'] ?? null;
$child_id = $_SESSION['user_id'];

if (!$lesson_id) {
    header("Location: lessons.php");
    exit;
}

// Fetch Lesson
$stmt = $pdo->prepare("SELECT * FROM lessons WHERE lesson_id = ?");
$stmt->execute([$lesson_id]);
$lesson = $stmt->fetch();

if (!$lesson) {
    echo "Lesson not found.";
    exit;
}

require_once 'includes/rewards_helper.php';

// Mark as Complete
if (isset($_POST['mark_complete'])) {
    // Check if already completed
    $check = $pdo->prepare("SELECT * FROM lesson_progress WHERE child_id = ? AND lesson_id = ?");
    $check->execute([$child_id, $lesson_id]);
    
    if ($check->rowCount() == 0) {
        // Insert Progress
        $ins = $pdo->prepare("INSERT INTO lesson_progress (child_id, lesson_id, is_completed, completed_at) VALUES (?, ?, 1, NOW())");
        $ins->execute([$child_id, $lesson_id]);
        
        // Add Stars (5 for lesson)
        $pdo->prepare("UPDATE children SET total_stars = total_stars + 5 WHERE child_id = ?")->execute([$child_id]);
        
        // Check Badges
        checkAndUnlockBadges($child_id, $pdo);

        // Log Activity
        $log = $pdo->prepare("INSERT INTO activity_logs (child_id, activity_type, activity_details) VALUES (?, 'lesson', ?)");
        $details = "Completed lesson: " . $lesson['lesson_title'];
        $log->execute([$child_id, $details]);
    }
    
    // Redirect to subject list
    header("Location: lessons.php?subject_id=" . $lesson['subject_id']);
    exit;
}

// Helper function to get YouTube Embed URL
function getYoutubeEmbedUrl($url) {
    $shortUrlRegex = '/youtu.be\/([a-zA-Z0-9_-]+)\??/i';
    $longUrlRegex = '/youtube.com\/((?:embed)|(?:watch))((?:\?v\=)|(?:\/))([a-zA-Z0-9_-]+)/i';

    if (preg_match($longUrlRegex, $url, $matches)) {
        $youtube_id = $matches[count($matches) - 1];
    }

    if (preg_match($shortUrlRegex, $url, $matches)) {
        $youtube_id = $matches[1];
    }
    
    if (isset($youtube_id)) {
        return 'https://www.youtube.com/embed/' . $youtube_id;
    }
    
    return $url; // Return original if no match (fallback)
}

$embedUrl = getYoutubeEmbedUrl($lesson['video_url']);

include 'includes/header.php';
?>

<div class="glass-panel" style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <a href="lessons.php?subject_id=<?php echo $lesson['subject_id']; ?>" class="btn-back">⬅ Back to Lessons</a>
    
    <div class="lesson-split-container" style="background: white; border-radius: 30px; overflow: hidden; box-shadow: 0 10px 20px rgba(0,0,0,0.1); margin-top: 20px; display: flex; flex-wrap: wrap;">
        
        <!-- Left Column: Video Player (70%) -->
        <div class="lesson-video-col" style="flex: 7; min-width: 300px; background: black;">
            <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
                <iframe src="<?php echo htmlspecialchars($embedUrl); ?>" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>
        
        <!-- Right Column: Content (30%) -->
        <div class="lesson-content-col" style="flex: 3; min-width: 250px; padding: 30px; display: flex; flex-direction: column; justify-content: space-between; border-left: 1px solid #eee;">
            <div>
                <h1 style="margin-top:0; font-family:'Fredoka One'; color: var(--primary-color); font-size: 2rem; line-height: 1.2;">
                    <?php echo htmlspecialchars($lesson['lesson_title']); ?>
                </h1>
                <hr style="border: 0; border-top: 2px dashed #eee; margin: 15px 0;">
                <p style="font-size:1.1rem; line-height:1.6; color:#5D4037;">
                    <?php echo nl2br(htmlspecialchars($lesson['lesson_description'])); ?>
                </p>
            </div>
            
            <div id="mcq-section" style="margin-top: 30px;">
                <?php if (!empty($lesson['quiz_question'])): ?>
                    <div style="background: #FFF3E0; padding: 20px; border-radius: 15px; border: 2px dashed #FFB74D;">
                        <h3 style="color: #E65100; font-size: 1.2rem; margin-bottom: 15px;">
                            <i class="fas fa-question-circle"></i> Quick Quiz:
                        </h3>
                        <p style="font-weight: bold; margin-bottom: 15px;"><?php echo htmlspecialchars($lesson['quiz_question']); ?></p>
                        
                        <div id="quiz-options">
                            <label style="display: block; margin-bottom: 10px; cursor: pointer;">
                                <input type="radio" name="quiz_option" value="A"> <?php echo htmlspecialchars($lesson['option_a']); ?>
                            </label>
                            <label style="display: block; margin-bottom: 10px; cursor: pointer;">
                                <input type="radio" name="quiz_option" value="B"> <?php echo htmlspecialchars($lesson['option_b']); ?>
                            </label>
                            <label style="display: block; margin-bottom: 10px; cursor: pointer;">
                                <input type="radio" name="quiz_option" value="C"> <?php echo htmlspecialchars($lesson['option_c']); ?>
                            </label>
                        </div>
                        
                        <button type="button" id="checkAnswerBtn" class="big-btn" style="width: 100%; height: auto; padding: 10px; font-size: 1rem; background: #FF9800; box-shadow: 0 4px 0 #E65100; margin-top: 10px;">
                            Check Answer
                        </button>
                        <p id="quiz-feedback" style="margin-top: 10px; font-weight: bold;"></p>
                    </div>
                <?php endif; ?>
            </div>

            <form method="POST" id="completeForm" style="margin-top: 30px; text-align: center; display: <?php echo !empty($lesson['quiz_question']) ? 'none' : 'block'; ?>;">
                <button type="submit" name="mark_complete" class="big-btn" style="width: 100%; height: auto; padding: 15px 20px; font-size: 1.3rem; background: #4CAF50; box-shadow: 0 6px 0 #2E7D32; display: inline-flex; justify-content: center; align-items: center; gap: 10px;">
                    <i class="fas fa-check-circle" style="font-size: 1.5rem; margin: 0;"></i>
                    <span>Mark Complete</span>
                </button>
            </form>

            <?php if (!empty($lesson['quiz_question'])): ?>
            <script>
                document.getElementById('checkAnswerBtn').addEventListener('click', function() {
                    const selected = document.querySelector('input[name="quiz_option"]:checked');
                    const feedback = document.getElementById('quiz-feedback');
                    const completeForm = document.getElementById('completeForm');
                    const correct = "<?php echo $lesson['correct_option']; ?>";
                    
                    if (!selected) {
                        feedback.style.color = 'red';
                        feedback.textContent = "Please select an answer!";
                        return;
                    }
                    
                    if (selected.value === correct) {
                        feedback.style.color = 'green';
                        feedback.textContent = "Correct! Great job! 🎉";
                        // Hide quiz button, show complete button
                        this.style.display = 'none';
                        completeForm.style.display = 'block';
                        // Disable inputs
                        document.querySelectorAll('input[name="quiz_option"]').forEach(el => el.disabled = true);
                    } else {
                        feedback.style.color = 'red';
                        feedback.textContent = "Oops! Try again. 😅";
                    }
                });
            </script>
            <?php endif; ?>
        </div>
        
    </div>
</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
