<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$child_id = $_SESSION['user_id'];

// Delete Drawing
if (isset($_GET['delete_id'])) {
    $stmt = $pdo->prepare("SELECT drawing_image FROM drawings WHERE drawing_id = ? AND child_id = ?");
    $stmt->execute([$_GET['delete_id'], $child_id]);
    $draw = $stmt->fetch();
    
    if ($draw) {
        // Delete file
        if (file_exists('../' . $draw['drawing_image'])) {
            unlink('../' . $draw['drawing_image']);
        }
        // Delete DB record
        $del = $pdo->prepare("DELETE FROM drawings WHERE drawing_id = ?");
        $del->execute([$_GET['delete_id']]);
        
        header("Location: my_drawings.php");
        exit;
    }
}

// Fetch Drawings
$stmt = $pdo->prepare("SELECT * FROM drawings WHERE child_id = ? ORDER BY created_at DESC");
$stmt->execute([$child_id]);
$drawings = $stmt->fetchAll();

include 'includes/header.php';
?>

<div style="max-width: 1000px; margin: 0 auto;">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h1 style="color:#2C3E50;">📂 My Art Gallery</h1>
        <a href="drawing.php" class="btn btn-success" style="background:#2ecc71; color:white; padding:10px 20px; text-decoration:none; border-radius:20px; font-weight:bold;">🎨 New Drawing</a>
    </div>

    <div class="card-grid">
        <?php foreach($drawings as $d): ?>
            <div class="card" style="padding:10px;">
                <div style="height:200px; overflow:hidden; border-radius:10px; margin-bottom:10px; background:#f9f9f9; display:flex; align-items:center; justify-content:center;">
                    <img src="../<?php echo htmlspecialchars($d['drawing_image']); ?>" style="width:100%; height:100%; object-fit:contain;" alt="My Drawing">
                </div>
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <span style="font-size:0.9rem; color:#888;"><?php echo date('M d, Y', strtotime($d['created_at'])); ?></span>
                    <a href="my_drawings.php?delete_id=<?php echo $d['drawing_id']; ?>" onclick="return confirm('Delete this masterpiece?');" style="color:#e74c3c; text-decoration:none; font-size:1.2rem;" title="Delete">🗑</a>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
    
    <?php if(empty($drawings)): ?>
        <div style="text-align:center; margin-top:50px;">
            <div style="font-size:4rem;">🖼</div>
            <p>Your gallery is empty! Go draw something amazing.</p>
        </div>
    <?php endif; ?>
</div>

</body>
</html>
