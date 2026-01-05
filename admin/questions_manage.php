<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$quiz_id = $_GET['quiz_id'] ?? null;
if (!$quiz_id) { header("Location: quizzes_list.php"); exit; }

$quiz = $pdo->prepare("SELECT * FROM quizzes WHERE quiz_id = ?");
$quiz->execute([$quiz_id]);
$quizData = $quiz->fetch();

// Add Question
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['add_question'])) {
    $q = trim($_POST['question']);
    $a = trim($_POST['option_a']);
    $b = trim($_POST['option_b']);
    $c = trim($_POST['option_c']);
    $d = trim($_POST['option_d']);
    $correct = $_POST['correct_option'];

    $stmt = $pdo->prepare("INSERT INTO quiz_questions (quiz_id, question, option_a, option_b, option_c, option_d, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->execute([$quiz_id, $q, $a, $b, $c, $d, $correct]);
    header("Location: questions_manage.php?quiz_id=" . $quiz_id);
    exit;
}

// Delete Question
if (isset($_GET['delete_id'])) {
    $stmt = $pdo->prepare("DELETE FROM quiz_questions WHERE question_id = ?");
    $stmt->execute([$_GET['delete_id']]);
    header("Location: questions_manage.php?quiz_id=" . $quiz_id);
    exit;
}

$questions = $pdo->prepare("SELECT * FROM quiz_questions WHERE quiz_id = ?");
$questions->execute([$quiz_id]);
$qList = $questions->fetchAll();

include 'includes/header.php';
?>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Manage Questions: <?php echo htmlspecialchars($quizData['quiz_title']); ?></h2>
    <a href="quizzes_list.php" class="btn btn-secondary">Back to Quizzes</a>
</div>

<div class="form-container" style="margin-bottom: 30px;">
    <h3>Add New Question (<?php echo count($qList); ?>/10)</h3>
    <?php if(count($qList) >= 10): ?>
        <p style="color: green;">Quiz has reached the limit of 10 questions.</p>
    <?php else: ?>
    <form method="POST">
        <div class="form-group">
            <label>Question Text</label>
            <input type="text" name="question" required>
        </div>
        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px;">
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
                <label>Option D</label>
                <input type="text" name="option_d" required>
            </div>
        </div>
        <div class="form-group">
            <label>Correct Option</label>
            <select name="correct_option" required>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
            </select>
        </div>
        <button type="submit" name="add_question" class="btn btn-success">Add Question</button>
    </form>
    <?php endif; ?>
</div>

<table>
    <thead>
        <tr>
            <th>Question</th>
            <th>Correct</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($qList as $q): ?>
        <tr>
            <td><?php echo htmlspecialchars($q['question']); ?></td>
            <td><?php echo htmlspecialchars($q['correct_option']); ?></td>
            <td>
                <a href="questions_manage.php?quiz_id=<?php echo $quiz_id; ?>&delete_id=<?php echo $q['question_id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Delete this question?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
