<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parents = $pdo->query("SELECT * FROM parents ORDER BY created_at DESC")->fetchAll();

if (isset($_GET['delete_id'])) {
    $stmt = $pdo->prepare("DELETE FROM parents WHERE parent_id = ?");
    $stmt->execute([$_GET['delete_id']]);
    header("Location: parents_list.php");
    exit;
}

include 'includes/header.php';
?>

<h2>Manage Parents & Children</h2>

<table>
    <thead>
        <tr>
            <th>Parent Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Children</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($parents as $parent): ?>
        <?php
            $kids = $pdo->prepare("SELECT child_name FROM children WHERE parent_id = ?");
            $kids->execute([$parent['parent_id']]);
            $children = $kids->fetchAll(PDO::FETCH_COLUMN);
        ?>
        <tr>
            <td><?php echo htmlspecialchars($parent['parent_name']); ?></td>
            <td><?php echo htmlspecialchars($parent['parent_email']); ?></td>
            <td><?php echo htmlspecialchars($parent['parent_phone']); ?></td>
            <td><?php echo implode(', ', $children); ?></td>
            <td>
                <a href="parents_list.php?delete_id=<?php echo $parent['parent_id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Deleting a parent will delete all linked children. Continue?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
