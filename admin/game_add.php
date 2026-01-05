<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = trim($_POST['game_name']);
    $type = trim($_POST['game_type']);
    $desc = trim($_POST['description']);
    $outcome = trim($_POST['learning_outcome']);
    $notes = trim($_POST['notes']);

    if (!empty($name)) {
        $stmt = $pdo->prepare("INSERT INTO games (game_name, game_type, description, learning_outcome, notes) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$name, $type, $desc, $outcome, $notes]);
        header("Location: games_list.php");
        exit;
    }
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Add New Game Metadata</h2>
    <form method="POST">
        <div class="form-group">
            <label>Game Name</label>
            <input type="text" name="game_name" required>
        </div>
        <div class="form-group">
            <label>Game Type</label>
            <input type="text" name="game_type" placeholder="e.g. Puzzle, Math, Memory">
        </div>
        <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="3"></textarea>
        </div>
        <div class="form-group">
            <label>Learning Outcome</label>
            <textarea name="learning_outcome" rows="2"></textarea>
        </div>
        <div class="form-group">
            <label>Admin Notes</label>
            <textarea name="notes" rows="2"></textarea>
        </div>
        <button type="submit" class="btn btn-success">Save Game</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
