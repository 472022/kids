<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$question_id = $_GET['id'] ?? null;
$quiz_id = $_GET['quiz_id'] ?? null;

if (!$question_id || !$quiz_id) { header("Location: quizzes_list.php"); exit; }

$stmt = $pdo->prepare("SELECT * FROM quiz_questions WHERE question_id = ?");
$stmt->execute([$question_id]);
$question = $stmt->fetch();

if (!$question) { echo "Question not found."; exit; }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $q = trim($_POST['question']);
    $a = trim($_POST['option_a']);
    $b = trim($_POST['option_b']);
    $c = trim($_POST['option_c']);
    $d = trim($_POST['option_d']);
    $correct = $_POST['correct_option'];

    $update = $pdo->prepare("UPDATE quiz_questions SET question=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_option=? WHERE question_id=?");
    $update->execute([$q, $a, $b, $c, $d, $correct, $question_id]);
    
    header("Location: questions_manage.php?quiz_id=" . $quiz_id . "&msg=updated");
    exit;
}

include 'includes/header.php';
?>

<div class="form-container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Edit Question</h2>
        <a href="questions_manage.php?quiz_id=<?php echo $quiz_id; ?>" class="btn btn-secondary">Back</a>
    </div>

    <form method="POST">
        <div class="form-group">
            <label>Question Text</label>
            <input type="text" name="question" value="<?php echo htmlspecialchars($question['question']); ?>" required>
        </div>
        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px;">
            <div class="form-group">
                <label>Option A</label>
                <input type="text" name="option_a" value="<?php echo htmlspecialchars($question['option_a']); ?>" required>
            </div>
            <div class="form-group">
                <label>Option B</label>
                <input type="text" name="option_b" value="<?php echo htmlspecialchars($question['option_b']); ?>" required>
            </div>
            <div class="form-group">
                <label>Option C</label>
                <input type="text" name="option_c" value="<?php echo htmlspecialchars($question['option_c']); ?>" required>
            </div>
            <div class="form-group">
                <label>Option D</label>
                <input type="text" name="option_d" value="<?php echo htmlspecialchars($question['option_d']); ?>" required>
            </div>
        </div>
        <div class="form-group">
            <label>Correct Option</label>
            <select name="correct_option" required>
                <option value="A" <?php echo $question['correct_option'] == 'A' ? 'selected' : ''; ?>>A</option>
                <option value="B" <?php echo $question['correct_option'] == 'B' ? 'selected' : ''; ?>>B</option>
                <option value="C" <?php echo $question['correct_option'] == 'C' ? 'selected' : ''; ?>>C</option>
                <option value="D" <?php echo $question['correct_option'] == 'D' ? 'selected' : ''; ?>>D</option>
            </select>
        </div>
        <button type="submit" class="btn btn-warning">Update Question</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
