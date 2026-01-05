<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$subjects = $pdo->query("SELECT * FROM subjects")->fetchAll();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $subject_id = $_POST['subject_id'];
    $title = trim($_POST['lesson_title']);
    $desc = trim($_POST['lesson_description']);
    $video = trim($_POST['video_url']);

    if (!empty($title) && !empty($video) && !empty($subject_id)) {
        // MCQ Data
        $quiz_question = $_POST['quiz_question'];
        $option_a = $_POST['option_a'];
        $option_b = $_POST['option_b'];
        $option_c = $_POST['option_c'];
        $correct_option = $_POST['correct_option'];

        $stmt = $pdo->prepare("INSERT INTO lessons (subject_id, lesson_title, lesson_description, video_url, quiz_question, option_a, option_b, option_c, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$subject_id, $title, $desc, $video, $quiz_question, $option_a, $option_b, $option_c, $correct_option]);
        header("Location: lessons_list.php");
        exit;
    }
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Add New Lesson</h2>
    <form method="POST">
        <div class="form-group">
            <label>Subject</label>
            <select name="subject_id" required>
                <option value="">Select Subject</option>
                <?php foreach($subjects as $s): ?>
                    <option value="<?php echo $s['subject_id']; ?>"><?php echo htmlspecialchars($s['subject_name']); ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        
        <div class="form-group">
            <label>Lesson Title</label>
            <input type="text" name="lesson_title" required>
        </div>
        
        <div class="form-group">
            <label>Description</label>
            <textarea name="lesson_description" rows="4"></textarea>
        </div>
        
        <div class="form-group">
            <label>Video URL (YouTube Embed)</label>
            <input type="text" name="video_url" placeholder="https://www.youtube.com/embed/..." required>
        </div>

        <hr>
        <h3>Add Quick Quiz (MCQ)</h3>
        <div class="form-group">
            <label>Quiz Question</label>
            <input type="text" name="quiz_question" placeholder="e.g. What color is the apple?" required>
        </div>
        <div class="form-group">
            <label>Option A</label>
            <input type="text" name="option_a" required>
        </div>
        <div class="form-group">
            <label>Option B</label>
            <input type="text" name="option_b" required>
        </div>
        <div class="form-group">
            <label>Option C</label>
            <input type="text" name="option_c" required>
        </div>
        <div class="form-group">
            <label>Correct Answer</label>
            <select name="correct_option" required>
                <option value="A">Option A</option>
                <option value="B">Option B</option>
                <option value="C">Option C</option>
            </select>
        </div>
        
        <button type="submit" class="btn btn-success">Save Lesson</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
