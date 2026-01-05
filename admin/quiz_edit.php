<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$id = $_GET['id'] ?? null;
if (!$id) { header("Location: quizzes_list.php"); exit; }

$quiz = $pdo->prepare("SELECT * FROM quizzes WHERE quiz_id = ?");
$quiz->execute([$id]);
$data = $quiz->fetch();

$subjects = $pdo->query("SELECT * FROM subjects")->fetchAll();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $subject_id = $_POST['subject_id'];
    $title = trim($_POST['quiz_title']);

    $stmt = $pdo->prepare("UPDATE quizzes SET subject_id=?, quiz_title=? WHERE quiz_id=?");
    $stmt->execute([$subject_id, $title, $id]);
    header("Location: quizzes_list.php");
    exit;
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Edit Quiz</h2>
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
            <label>Quiz Title</label>
            <input type="text" name="quiz_title" value="<?php echo htmlspecialchars($data['quiz_title']); ?>" required>
        </div>
        
        <button type="submit" class="btn btn-warning">Update Quiz</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
