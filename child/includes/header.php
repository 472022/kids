<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
// Ensure user is logged in
require_once __DIR__ . '/auth_check.php';

// Fetch Child Name for Header if not set
if (!isset($child_name_header)) {
    if (isset($_SESSION['name'])) {
        $child_name_header = $_SESSION['name'];
    } else {
        $child_name_header = "Friend";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kids Learning Platform</title>
    <!-- FontAwesome -->
    <link rel="stylesheet" href="../assets/fontawesome/css/all.min.css">
    <!-- Custom Child Theme -->
    <link rel="stylesheet" href="assets/css/child_theme.css">
</head>
<body>

    <!-- Video Background -->
    <?php include __DIR__ . '/video_bg.php'; ?>

    <!-- Header -->
    <header class="child-header">
        <div class="logo-text">
            <a href="dashboard.php" style="text-decoration: none; color: inherit;">
                Kids Learning <span>Platform</span>
            </a>
        </div>
        <div class="user-info">
            <span style="font-weight: bold; color: #5D4037;">Hi, <?php echo htmlspecialchars($child_name_header); ?>!</span>
            
            <a href="progress.php" class="logout-btn" style="background: #4CAF50; border-color: #388E3C; box-shadow: 0 4px 0 #2E7D32;">
                <i class="fas fa-user-circle"></i> Profile
            </a>
            
            <a href="../logout.php" class="logout-btn">Logout</a>
        </div>
    </header>

    <!-- Main Content Wrapper -->
    <div class="dashboard-container">
