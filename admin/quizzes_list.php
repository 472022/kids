<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$quizzes = $pdo->query("SELECT q.*, s.subject_name FROM quizzes q JOIN subjects s ON q.subject_id = s.subject_id ORDER BY q.created_at DESC")->fetchAll();

include 'includes/header.php';
?>

<div class="d-flex justify-content-between align-items-center mb-3" style="display:flex; justify-content:space-between;">
    <h2>Manage Quizzes</h2>
    <a href="quiz_add.php" class="btn btn-primary">Add New Quiz</a>
</div>

<table>
    <thead>
        <tr>
            <th>Subject</th>
            <th>Quiz Title</th>
            <th>Questions</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($quizzes as $quiz): ?>
        <?php 
            // Count questions
            $qCount = $pdo->prepare("SELECT COUNT(*) FROM quiz_questions WHERE quiz_id = ?");
            $qCount->execute([$quiz['quiz_id']]);
            $count = $qCount->fetchColumn();
        ?>
        <tr>
            <td><?php echo htmlspecialchars($quiz['subject_name']); ?></td>
            <td><?php echo htmlspecialchars($quiz['quiz_title']); ?></td>
            <td>
                <?php echo $count; ?>/10
                <a href="questions_manage.php?quiz_id=<?php echo $quiz['quiz_id']; ?>" class="btn btn-sm btn-info" style="color:white; margin-left:5px;">Manage Questions</a>
            </td>
            <td><?php echo date('M d, Y', strtotime($quiz['created_at'])); ?></td>
            <td>
                <a href="quiz_edit.php?id=<?php echo $quiz['quiz_id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                <a href="quiz_delete.php?id=<?php echo $quiz['quiz_id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
