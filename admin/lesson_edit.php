<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$id = $_GET['id'] ?? null;
if (!$id) { header("Location: lessons_list.php"); exit; }

$lesson = $pdo->prepare("SELECT * FROM lessons WHERE lesson_id = ?");
$lesson->execute([$id]);
$data = $lesson->fetch();
if (!$data) { header("Location: lessons_list.php"); exit; }

$subjects = $pdo->query("SELECT * FROM subjects")->fetchAll();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $subject_id = $_POST['subject_id'];
    $title = trim($_POST['lesson_title']);
    $desc = trim($_POST['lesson_description']);
    $video = trim($_POST['video_url']);
    
    // MCQ Data
    $quiz_question = $_POST['quiz_question'];
    $option_a = $_POST['option_a'];
    $option_b = $_POST['option_b'];
    $option_c = $_POST['option_c'];
    $correct_option = $_POST['correct_option'];

    $stmt = $pdo->prepare("UPDATE lessons SET subject_id=?, lesson_title=?, lesson_description=?, video_url=?, quiz_question=?, option_a=?, option_b=?, option_c=?, correct_option=? WHERE lesson_id=?");
    $stmt->execute([$subject_id, $title, $desc, $video, $quiz_question, $option_a, $option_b, $option_c, $correct_option, $id]);
    header("Location: lessons_list.php");
    exit;
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Edit Lesson</h2>
    <form method="POST">
        <div class="form-group">
            <label>Subject</label>
            <select name="subject_id" required>
                <?php foreach($subjects as $s): ?>
                    <option value="<?php echo $s['subject_id']; ?>" <?php echo $s['subject_id'] == $data['subject_id'] ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($s['subject_name']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>
        
        <div class="form-group">
            <label>Lesson Title</label>
            <input type="text" name="lesson_title" value="<?php echo htmlspecialchars($data['lesson_title']); ?>" required>
        </div>
        
        <div class="form-group">
            <label>Description</label>
            <textarea name="lesson_description" rows="4"><?php echo htmlspecialchars($data['lesson_description']); ?></textarea>
        </div>
        
        <div class="form-group">
            <label>Video URL</label>
            <input type="text" name="video_url" value="<?php echo htmlspecialchars($data['video_url']); ?>" required>
        </div>

        <hr>
        <h3>Edit Quick Quiz (MCQ)</h3>
        <div class="form-group">
            <label>Quiz Question</label>
            <input type="text" name="quiz_question" value="<?php echo htmlspecialchars($data['quiz_question'] ?? ''); ?>" placeholder="e.g. What color is the apple?" required>
        </div>
        <div class="form-group">
            <label>Option A</label>
            <input type="text" name="option_a" value="<?php echo htmlspecialchars($data['option_a'] ?? ''); ?>" required>
        </div>
        <div class="form-group">
            <label>Option B</label>
            <input type="text" name="option_b" value="<?php echo htmlspecialchars($data['option_b'] ?? ''); ?>" required>
        </div>
        <div class="form-group">
            <label>Option C</label>
            <input type="text" name="option_c" value="<?php echo htmlspecialchars($data['option_c'] ?? ''); ?>" required>
        </div>
        <div class="form-group">
            <label>Correct Answer</label>
            <select name="correct_option" required>
                <option value="A" <?php echo ($data['correct_option'] ?? '') == 'A' ? 'selected' : ''; ?>>Option A</option>
                <option value="B" <?php echo ($data['correct_option'] ?? '') == 'B' ? 'selected' : ''; ?>>Option B</option>
                <option value="C" <?php echo ($data['correct_option'] ?? '') == 'C' ? 'selected' : ''; ?>>Option C</option>
            </select>
        </div>
        
        <button type="submit" class="btn btn-warning">Update Lesson</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
