<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$lessons = $pdo->query("SELECT l.*, s.subject_name FROM lessons l JOIN subjects s ON l.subject_id = s.subject_id ORDER BY l.created_at DESC")->fetchAll();

include 'includes/header.php';
?>

<div class="d-flex justify-content-between align-items-center mb-3" style="display:flex; justify-content:space-between;">
    <h2>Manage Lessons</h2>
    <a href="lesson_add.php" class="btn btn-primary">Add New Lesson</a>
</div>

<table>
    <thead>
        <tr>
            <th>Subject</th>
            <th>Title</th>
            <th>Video</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($lessons as $lesson): ?>
        <tr>
            <td><?php echo htmlspecialchars($lesson['subject_name']); ?></td>
            <td><?php echo htmlspecialchars($lesson['lesson_title']); ?></td>
            <td><a href="<?php echo htmlspecialchars($lesson['video_url']); ?>" target="_blank">Watch</a></td>
            <td><?php echo date('M d, Y', strtotime($lesson['created_at'])); ?></td>
            <td>
                <a href="lesson_edit.php?id=<?php echo $lesson['lesson_id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                <a href="lesson_delete.php?id=<?php echo $lesson['lesson_id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
