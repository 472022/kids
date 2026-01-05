<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = trim($_POST['subject_name']);
    
    // Handle File Upload
    $iconPath = null;
    if (isset($_FILES['subject_icon']) && $_FILES['subject_icon']['error'] == 0) {
        $targetDir = "../assets/images/subjects/";
        if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);
        
        $fileName = time() . '_' . basename($_FILES['subject_icon']['name']);
        $targetFilePath = $targetDir . $fileName;
        
        if (move_uploaded_file($_FILES['subject_icon']['tmp_name'], $targetFilePath)) {
            $iconPath = "assets/images/subjects/" . $fileName;
        }
    }

    if (empty($name)) {
        $error = "Subject Name is required";
    } else {
        $stmt = $pdo->prepare("INSERT INTO subjects (subject_name, subject_icon) VALUES (?, ?)");
        $stmt->execute([$name, $iconPath]);
        header("Location: subjects_list.php");
        exit;
    }
}

include 'includes/header.php';
?>

<div class="form-container">
    <h2>Add New Subject</h2>
    
    <?php if($error): ?>
        <p style="color:red"><?php echo $error; ?></p>
    <?php endif; ?>

    <form method="POST" enctype="multipart/form-data">
        <div class="form-group">
            <label>Subject Name</label>
            <input type="text" name="subject_name" required>
        </div>
        <div class="form-group">
            <label>Subject Icon</label>
            <input type="file" name="subject_icon" accept="image/*">
        </div>
        <button type="submit" class="btn btn-success">Save Subject</button>
        <a href="subjects_list.php" class="btn btn-secondary" style="background:#6c757d; color:white; text-decoration:none; padding:10px 20px; border-radius:4px;">Cancel</a>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
