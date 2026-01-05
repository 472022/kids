<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$subjects = $pdo->query("SELECT * FROM subjects ORDER BY created_at DESC")->fetchAll();

include 'includes/header.php';
?>

<div class="d-flex justify-content-between align-items-center mb-3" style="display:flex; justify-content:space-between;">
    <h2>Manage Subjects</h2>
    <a href="subject_add.php" class="btn btn-primary">Add New Subject</a>
</div>

<table>
    <thead>
        <tr>
            <th>Icon</th>
            <th>Subject Name</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($subjects as $subject): ?>
        <tr>
            <td>
                <?php if($subject['subject_icon']): ?>
                    <img src="../<?php echo htmlspecialchars($subject['subject_icon']); ?>" alt="Icon" width="50">
                <?php else: ?>
                    <span>No Icon</span>
                <?php endif; ?>
            </td>
            <td><?php echo htmlspecialchars($subject['subject_name']); ?></td>
            <td><?php echo date('M d, Y', strtotime($subject['created_at'])); ?></td>
            <td>
                <a href="subject_edit.php?id=<?php echo $subject['subject_id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                <a href="subject_delete.php?id=<?php echo $subject['subject_id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
