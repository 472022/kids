<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$id = $_GET['id'] ?? null;
if (!$id) { header("Location: games_list.php"); exit; }

$stmt = $pdo->prepare("SELECT * FROM games WHERE game_id = ?");
$stmt->execute([$id]);
$game = $stmt->fetch();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = trim($_POST['game_name']);
    $type = trim($_POST['game_type']);
    $desc = trim($_POST['description']);
    $outcome = trim($_POST['learning_outcome']);
    $notes = trim($_POST['notes']);

    $stmt = $pdo->prepare("UPDATE games SET game_name=?, game_type=?, description=?, learning_outcome=?, notes=? WHERE game_id=?");
    $stmt->execute([$name, $type, $desc, $outcome, $notes, $id]);
    header("Location: games_list.php");
    exit;
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Edit Game</h2>
    <form method="POST">
        <div class="form-group">
            <label>Game Name</label>
            <input type="text" name="game_name" value="<?php echo htmlspecialchars($game['game_name']); ?>" required>
        </div>
        <div class="form-group">
            <label>Game Type</label>
            <input type="text" name="game_type" value="<?php echo htmlspecialchars($game['game_type']); ?>">
        </div>
        <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="3"><?php echo htmlspecialchars($game['description']); ?></textarea>
        </div>
        <div class="form-group">
            <label>Learning Outcome</label>
            <textarea name="learning_outcome" rows="2"><?php echo htmlspecialchars($game['learning_outcome']); ?></textarea>
        </div>
        <div class="form-group">
            <label>Admin Notes</label>
            <textarea name="notes" rows="2"><?php echo htmlspecialchars($game['notes'] ?? ''); ?></textarea>
        </div>
        <button type="submit" class="btn btn-warning">Update Game</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
