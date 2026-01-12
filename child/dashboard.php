<?php
require_once '../config/db.php';

// Set header variable
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
// Manually fetch child info to pass to header
if (isset($_SESSION['user_id'])) {
    $stmt = $pdo->prepare("SELECT child_name, child_age, total_stars FROM children WHERE child_id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $child = $stmt->fetch();
    if ($child) {
        $child_name_header = $child['child_name'];
    }
}

// Fetch Progress Stats
$child_id = $_SESSION['user_id'];
$stmt = $pdo->prepare("SELECT COUNT(*) FROM quiz_results WHERE child_id = ? AND is_completed = 1");
$stmt->execute([$child_id]);
$completed_quizzes = $stmt->fetchColumn();

// Fetch Subjects (for the subject row)
$stmt = $pdo->query("SELECT * FROM subjects LIMIT 3");
$subjects = $stmt->fetchAll();

// Include the new unified header
require_once 'includes/header.php';
?>

        <!-- Hero Section -->
        <div class="hero-banner">
            <div class="hero-content">
                <h1>Hello, <?php echo htmlspecialchars($child_name_header ?? 'Explorer'); ?>! 👋</h1>
                <p>Ready for a new adventure today?</p>
            </div>
            <div class="hero-stats">
                <div class="stat-bubble stars">
                    <i class="fas fa-star"></i>
                    <span><?php echo htmlspecialchars($child['total_stars'] ?? 0); ?></span>
                </div>
                <div class="stat-bubble trophies">
                    <i class="fas fa-trophy"></i>
                    <span><?php echo $completed_quizzes; ?></span>
                </div>
            </div>
        </div>

        <!-- Main Activity Grid -->
        <div class="activity-grid">
            <a href="lessons.php" class="activity-card learn">
                <div class="card-icon"><i class="fas fa-book-reader"></i></div>
                <div class="card-text">
                    <h3>Learn</h3>
                    <p>Read & Watch</p>
                </div>
            </a>
            <a href="games.php" class="activity-card play">
                <div class="card-icon"><i class="fas fa-gamepad"></i></div>
                <div class="card-text">
                    <h3>Games</h3>
                    <p>Play & Fun</p>
                </div>
            </a>
            <a href="quizzes.php" class="activity-card quiz">
                <div class="card-icon"><i class="fas fa-brain"></i></div>
                <div class="card-text">
                    <h3>Quiz</h3>
                    <p>Test Yourself</p>
                </div>
            </a>
            <a href="drawing.php" class="activity-card draw">
                <div class="card-icon"><i class="fas fa-palette"></i></div>
                <div class="card-text">
                    <h3>Draw</h3>
                    <p>Be Creative</p>
                </div>
            </a>
        </div>

        <!-- Jump Back In (Subjects) -->
        <div class="section-title">
            <h2><i class="fas fa-rocket"></i> Jump Back In</h2>
            <a href="lessons.php" class="view-all">View All</a>
        </div>

        <div class="mini-subject-grid">
            <?php if ($subjects): ?>
                <?php foreach ($subjects as $subject): ?>
                <?php 
                    // Determine color/icon
                    $colors = ['#FF9800', '#4CAF50', '#2196F3', '#9C27B0'];
                    $bg_color = $colors[$subject['subject_id'] % count($colors)];
                    $icon = 'fa-book';
                    if(strpos(strtolower($subject['subject_name']), 'math') !== false) $icon = 'fa-calculator';
                    if(strpos(strtolower($subject['subject_name']), 'sci') !== false) $icon = 'fa-flask';
                    if(strpos(strtolower($subject['subject_name']), 'eng') !== false) $icon = 'fa-font';
                ?>
                <a href="lessons.php?subject_id=<?php echo $subject['subject_id']; ?>" class="mini-subject-card">
                    <div class="icon-box" style="background: <?php echo $bg_color; ?>;">
                        <i class="fas <?php echo $icon; ?>"></i>
                    </div>
                    <span><?php echo htmlspecialchars($subject['subject_name']); ?></span>
                </a>
                <?php endforeach; ?>
            <?php else: ?>
                <p style="grid-column: 1/-1; text-align: center; color: #90A4AE;">No subjects found.</p>
            <?php endif; ?>
        </div>

    </div> <!-- End Dashboard Container -->

    <style>
        /* Hero Banner */
        .hero-banner {
            background: linear-gradient(135deg, #FF9800, #F57C00);
            border-radius: 25px;
            padding: 30px 40px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            box-shadow: 0 10px 20px rgba(245, 124, 0, 0.3);
            position: relative;
            overflow: hidden;
        }
        .hero-banner::after {
            content: ''; position: absolute; top: -50%; right: -10%; width: 300px; height: 300px;
            background: rgba(255,255,255,0.1); border-radius: 50%;
        }
        .hero-content h1 { font-family: 'Fredoka One'; font-size: 2.5rem; margin: 0 0 5px 0; }
        .hero-content p { font-size: 1.2rem; margin: 0; opacity: 0.9; }
        
        .hero-stats { display: flex; gap: 15px; }
        .stat-bubble {
            background: rgba(255,255,255,0.2);
            padding: 10px 20px;
            border-radius: 50px;
            display: flex; align-items: center; gap: 10px;
            font-weight: bold; font-size: 1.2rem;
            backdrop-filter: blur(5px);
        }
        .stat-bubble i { color: #FFD700; }

        /* Activity Grid */
        .activity-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .activity-card {
            border-radius: 25px;
            padding: 25px;
            text-align: center;
            text-decoration: none;
            color: white;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            aspect-ratio: 1/1;
            position: relative;
            overflow: hidden;
        }
        .activity-card:hover { transform: translateY(-8px) scale(1.03); box-shadow: 0 20px 40px rgba(0,0,0,0.2); }
        
        /* Decorative Background Circles */
        .activity-card::before {
            content: ''; position: absolute; top: -30px; right: -30px; width: 100px; height: 100px;
            background: rgba(255,255,255,0.15); border-radius: 50%;
        }
        .activity-card::after {
            content: ''; position: absolute; bottom: -20px; left: -20px; width: 80px; height: 80px;
            background: rgba(255,255,255,0.1); border-radius: 50%;
        }

        .card-icon {
            font-size: 3rem; margin-bottom: 15px;
            width: 80px; height: 80px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            background: rgba(255,255,255,0.25);
            backdrop-filter: blur(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            animation: float 4s ease-in-out infinite;
        }
        
        /* Specific Card Styles */
        .learn { background: linear-gradient(135deg, #4FC3F7, #2196F3); }
        .learn .card-icon { color: white; }
        
        .play { background: linear-gradient(135deg, #AED581, #7CB342); }
        .play .card-icon { color: white; animation-delay: 1s; }
        
        .quiz { background: linear-gradient(135deg, #FFB74D, #FB8C00); }
        .quiz .card-icon { color: white; animation-delay: 2s; }
        
        .draw { background: linear-gradient(135deg, #BA68C8, #8E24AA); }
        .draw .card-icon { color: white; animation-delay: 3s; }
        
        .card-text h3 { margin: 0; font-family: 'Fredoka One'; font-size: 1.5rem; text-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .card-text p { margin: 5px 0 0; font-size: 1rem; color: rgba(255,255,255,0.9); font-weight: bold; }

        /* Mini Subject Grid */
        .section-title { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .section-title h2 { font-family: 'Fredoka One'; color: #37474F; margin: 0; font-size: 1.5rem; }
        .view-all { color: #90A4AE; text-decoration: none; font-weight: bold; font-size: 0.9rem; }
        
        .mini-subject-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 15px; }
        .mini-subject-card {
            background: white; border-radius: 15px; padding: 15px;
            display: flex; align-items: center; gap: 15px;
            text-decoration: none; color: #37474F; font-weight: bold;
            box-shadow: 0 3px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .mini-subject-card:hover { transform: translateX(5px); }
        .icon-box {
            width: 40px; height: 40px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            color: white; font-size: 1.2rem;
        }
    </style>

</body>
</html>
