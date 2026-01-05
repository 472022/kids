<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$games = $pdo->query("SELECT * FROM games ORDER BY created_at DESC")->fetchAll();

include 'includes/header.php';
?>

<div class="d-flex justify-content-between align-items-center mb-3" style="display:flex; justify-content:space-between;">
    <h2>Manage Games</h2>
    <a href="game_add.php" class="btn btn-primary">Add New Game</a>
</div>

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Learning Outcome</th>
            <th>Notes</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach($games as $game): ?>
        <tr>
            <td><?php echo htmlspecialchars($game['game_name']); ?></td>
            <td><?php echo htmlspecialchars($game['game_type']); ?></td>
            <td><?php echo htmlspecialchars($game['learning_outcome']); ?></td>
            <td><?php echo htmlspecialchars($game['notes'] ?? ''); ?></td>
            <td>
                <a href="game_edit.php?id=<?php echo $game['game_id']; ?>" class="btn btn-warning btn-sm">Edit</a>
                <a href="game_delete.php?id=<?php echo $game['game_id']; ?>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php include 'includes/footer.php'; ?>
