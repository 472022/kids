<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$subjects = $pdo->query("SELECT * FROM subjects")->fetchAll();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $subject_id = $_POST['subject_id'];
    $title = trim($_POST['quiz_title']);

    if (!empty($title) && !empty($subject_id)) {
        $stmt = $pdo->prepare("INSERT INTO quizzes (subject_id, quiz_title) VALUES (?, ?)");
        $stmt->execute([$subject_id, $title]);
        $quiz_id = $pdo->lastInsertId();
        header("Location: questions_manage.php?quiz_id=" . $quiz_id);
        exit;
    }
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Add New Quiz</h2>
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
            <label>Quiz Title</label>
            <input type="text" name="quiz_title" required>
        </div>
        
        <button type="submit" class="btn btn-success">Create Quiz & Add Questions</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
