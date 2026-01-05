<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Kids Learning</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* Admin specific styles inline for simplicity or link a separate css */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            display: flex;
        }
        
        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: #fff;
            min-height: 100vh;
            padding-top: 20px;
            position: fixed;
        }
        
        .sidebar-header {
            padding: 10px 20px;
            font-size: 1.2rem;
            font-weight: bold;
            border-bottom: 1px solid #4b545c;
            margin-bottom: 20px;
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .sidebar-menu li a {
            display: block;
            padding: 12px 20px;
            color: #c2c7d0;
            text-decoration: none;
            transition: 0.3s;
        }
        
        .sidebar-menu li a:hover, .sidebar-menu li a.active {
            background-color: #494e53;
            color: #fff;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 250px;
            flex: 1;
            padding: 20px;
            width: calc(100% - 250px);
        }
        
        /* Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            border-left: 5px solid #007bff;
        }
        
        .stat-card h3 { margin: 0; color: #6c757d; font-size: 0.9rem; text-transform: uppercase; }
        .stat-card .stat-number { font-size: 2rem; font-weight: bold; margin: 10px 0 0; color: #343a40; }
        
        /* Tables */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        
        th { background-color: #f8f9fa; color: #495057; }
        
        /* Forms */
        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            color: #fff;
        }
        
        .btn-primary { background-color: #007bff; }
        .btn-danger { background-color: #dc3545; }
        .btn-success { background-color: #28a745; }
        .btn-warning { background-color: #ffc107; color: #212529; }
        
        .charts-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .chart-box {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        Admin Panel
    </div>
    <ul class="sidebar-menu">
        <li><a href="dashboard.php">Dashboard</a></li>
        <li><a href="subjects_list.php">Subjects</a></li>
        <li><a href="lessons_list.php">Lessons</a></li>
        <li><a href="games_list.php">Games</a></li>
        <li><a href="quizzes_list.php">Quizzes</a></li>
        <li><a href="parents_list.php">Parents & Kids</a></li>
        <li><a href="analytics.php">Analytics</a></li>
        <li><a href="activity_logs.php">Activity Logs</a></li>
        <li><a href="../logout.php">Logout</a></li>
    </ul>
</div>

<div class="main-content">
