<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

$stmt = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$stmt->execute([$parent_id]);
$children = $stmt->fetchAll();
if(!$child_id && count($children)>0) $child_id = $children[0]['child_id'];

if ($child_id) {
    $stmt = $pdo->prepare("SELECT * FROM drawings WHERE child_id = ? ORDER BY created_at DESC");
    $stmt->execute([$child_id]);
    $drawings = $stmt->fetchAll();
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Art Gallery</h1>
    <?php if(count($children) > 1): ?>
        <form method="GET">
            <select name="child_id" onchange="this.form.submit()" style="padding:5px;">
                <?php foreach($children as $c): ?>
                    <option value="<?php echo $c['child_id']; ?>" <?php echo ($child_id == $c['child_id']) ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($c['child_name']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </form>
    <?php endif; ?>
</div>

<div class="card-grid">
    <?php if(isset($drawings) && count($drawings) > 0): ?>
        <?php foreach($drawings as $d): ?>
            <div class="card" style="padding:10px;">
                <div style="height:200px; overflow:hidden; border-radius:5px; margin-bottom:10px; background:#f9f9f9; display:flex; align-items:center; justify-content:center;">
                    <!-- Adjust path: Drawing path is saved as 'assets/drawings/...' relative to root. We are in parent/ -->
                    <img src="../<?php echo htmlspecialchars($d['drawing_image']); ?>" style="width:100%; height:100%; object-fit:contain;" alt="Drawing">
                </div>
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <span style="font-size:0.8rem; color:#888;"><?php echo date('M d, Y', strtotime($d['created_at'])); ?></span>
                    <a href="../<?php echo htmlspecialchars($d['drawing_image']); ?>" download class="btn btn-primary" style="padding:5px 10px; font-size:0.8rem;">Download</a>
                </div>
            </div>
        <?php endforeach; ?>
    <?php else: ?>
        <p>No drawings found.</p>
    <?php endif; ?>
</div>

<?php include 'includes/footer.php'; ?>
