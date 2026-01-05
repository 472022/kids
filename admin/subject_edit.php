<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$id = $_GET['id'] ?? null;
if (!$id) {
    header("Location: subjects_list.php");
    exit;
}

$stmt = $pdo->prepare("SELECT * FROM subjects WHERE subject_id = ?");
$stmt->execute([$id]);
$subject = $stmt->fetch();

if (!$subject) {
    header("Location: subjects_list.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = trim($_POST['subject_name']);
    $iconPath = $subject['subject_icon'];

    if (isset($_FILES['subject_icon']) && $_FILES['subject_icon']['error'] == 0) {
        $targetDir = "../assets/images/subjects/";
        if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);
        
        $fileName = time() . '_' . basename($_FILES['subject_icon']['name']);
        $targetFilePath = $targetDir . $fileName;
        
        if (move_uploaded_file($_FILES['subject_icon']['tmp_name'], $targetFilePath)) {
            $iconPath = "assets/images/subjects/" . $fileName;
        }
    }

    $stmt = $pdo->prepare("UPDATE subjects SET subject_name = ?, subject_icon = ? WHERE subject_id = ?");
    $stmt->execute([$name, $iconPath, $id]);
    header("Location: subjects_list.php");
    exit;
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Edit Subject</h2>
    <form method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label>Subject Name</label>
            <input type="text" name="subject_name" value="<?php echo htmlspecialchars($subject['subject_name']); ?>" required>
        </div>
        
        <?php if($subject['subject_icon']): ?>
            <div class="form-group">
                <label>Current Icon</label>
                <img src="../<?php echo htmlspecialchars($subject['subject_icon']); ?>" width="100">
            </div>
        <?php endif; ?>

        <div class="form-group">
            <label>Change Icon</label>
            <input type="file" name="subject_icon" accept="image/*">
        </div>
        
        <button type="submit" class="btn btn-warning">Update Subject</button>
        <a href="subjects_list.php" class="btn btn-secondary" style="background:#6c757d; color:white; text-decoration:none; padding:10px 20px; border-radius:4px;">Cancel</a>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
