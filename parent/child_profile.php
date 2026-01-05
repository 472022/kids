<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$parent_id = $_SESSION['user_id'];
$child_id = $_GET['child_id'] ?? null;

// Fetch Children for Dropdown
$children = $pdo->prepare("SELECT * FROM children WHERE parent_id = ?");
$children->execute([$parent_id]);
$kids = $children->fetchAll();
if(!$child_id && count($kids) > 0) $child_id = $kids[0]['child_id'];

// Handle Update
$msg = '';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $cid = $_POST['child_id'];
    $name = trim($_POST['child_name']);
    $age = $_POST['child_age'];
    $pass = trim($_POST['child_password']);
    
    // Verify Ownership
    $check = $pdo->prepare("SELECT COUNT(*) FROM children WHERE child_id = ? AND parent_id = ?");
    $check->execute([$cid, $parent_id]);
    
    if ($check->fetchColumn() > 0) {
        if (!empty($pass)) {
            // Update with Password
            $upd = $pdo->prepare("UPDATE children SET child_name = ?, child_age = ?, child_password = ? WHERE child_id = ?");
            $upd->execute([$name, $age, $pass, $cid]);
            $msg = "Profile updated successfully (Password changed).";
        } else {
            // Update without Password
            $upd = $pdo->prepare("UPDATE children SET child_name = ?, child_age = ? WHERE child_id = ?");
            $upd->execute([$name, $age, $cid]);
            $msg = "Profile updated successfully.";
        }
    } else {
        $msg = "Error: Unauthorized.";
    }
}

// Fetch Current Child Data
if ($child_id) {
    $stmt = $pdo->prepare("SELECT * FROM children WHERE child_id = ? AND parent_id = ?");
    $stmt->execute([$child_id, $parent_id]);
    $currentChild = $stmt->fetch();
}

include 'includes/header.php';
?>

<div class="page-header">
    <h1 class="page-title">Child Settings</h1>
</div>

<?php if($msg): ?>
    <div style="background:#d4edda; color:#155724; padding:15px; border-radius:5px; margin-bottom:20px;">
        <?php echo $msg; ?>
    </div>
<?php endif; ?>

<div class="card" style="max-width:600px;">
    <?php if(count($kids) > 1): ?>
        <form method="GET" style="margin-bottom:20px;">
            <label>Select Child to Edit:</label>
            <select name="child_id" onchange="this.form.submit()" class="form-control">
                <?php foreach($kids as $k): ?>
                    <option value="<?php echo $k['child_id']; ?>" <?php echo ($child_id == $k['child_id']) ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($k['child_name']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </form>
    <?php endif; ?>

    <?php if(isset($currentChild)): ?>
    <form method="POST">
        <input type="hidden" name="child_id" value="<?php echo $currentChild['child_id']; ?>">
        
        <div class="form-group">
            <label>Name</label>
            <input type="text" name="child_name" value="<?php echo htmlspecialchars($currentChild['child_name']); ?>" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>Age</label>
            <input type="number" name="child_age" value="<?php echo htmlspecialchars($currentChild['child_age']); ?>" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>New Password (leave blank to keep current)</label>
            <input type="text" name="child_password" class="form-control" placeholder="Enter new password">
        </div>
        
        <button type="submit" class="btn btn-success">Save Changes</button>
    </form>
    <?php endif; ?>
</div>

<?php include 'includes/footer.php'; ?>
