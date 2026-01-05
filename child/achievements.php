<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$child_id = $_SESSION['user_id'];

// Get all badges
$allBadges = $pdo->query("SELECT * FROM achievements")->fetchAll();

// Get earned badges
$earned = $pdo->prepare("SELECT achievement_id FROM child_achievements WHERE child_id = ?");
$earned->execute([$child_id]);
$myBadges = $earned->fetchAll(PDO::FETCH_COLUMN);

include 'includes/header.php';
?>

<div class="glass-panel" style="max-width: 1000px; margin: 0 auto;">
    
    <div style="text-align:center; margin-bottom:40px;">
        <h1 style="color:#FFC107; font-size:3.5rem; font-family: 'Fredoka One'; text-shadow: 2px 2px 0 #E65100;">🏆 My Trophy Room</h1>
        <p style="font-size:1.5rem; color:#5D4037; font-weight:bold;">Collect them all!</p>
    </div>

    <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 30px;">
        <?php foreach($allBadges as $badge): ?>
            <?php $isUnlocked = in_array($badge['achievement_id'], $myBadges); ?>
            
            <div style="
                background: <?php echo $isUnlocked ? '#FFFDE7' : '#EEEEEE'; ?>; 
                padding: 25px; 
                border-radius: 25px; 
                width: 250px; 
                text-align: center; 
                box-shadow: <?php echo $isUnlocked ? '0 10px 20px rgba(255, 193, 7, 0.3)' : 'inset 0 0 10px rgba(0,0,0,0.1)'; ?>;
                border: 4px solid <?php echo $isUnlocked ? '#FFC107' : '#E0E0E0'; ?>;
                transform: <?php echo $isUnlocked ? 'scale(1)' : 'scale(0.95)'; ?>;
                opacity: <?php echo $isUnlocked ? '1' : '0.8'; ?>;
                transition: transform 0.2s;
                display: flex; flex-direction: column; align-items: center; justify-content: space-between;
            ">
                <div style="font-size: 5rem; margin-bottom: 15px; filter: <?php echo $isUnlocked ? 'drop-shadow(0 5px 5px rgba(0,0,0,0.2))' : 'grayscale(100%) opacity(0.5)'; ?>;">
                    <?php echo $badge['badge_icon']; ?>
                </div>
                
                <div>
                    <h3 style="color: <?php echo $isUnlocked ? '#E65100' : '#9E9E9E'; ?>; margin: 0 0 10px 0; font-family: 'Fredoka One'; font-size: 1.4rem;">
                        <?php echo htmlspecialchars($badge['title']); ?>
                    </h3>
                    <p style="color: <?php echo $isUnlocked ? '#5D4037' : '#9E9E9E'; ?>; font-size: 0.9rem; line-height: 1.4; margin: 0;">
                        <?php echo htmlspecialchars($badge['description']); ?>
                    </p>
                </div>
                
                <?php if($isUnlocked): ?>
                    <div style="background:#4CAF50; color:white; padding:8px 20px; border-radius:20px; display:inline-block; font-size:0.9rem; font-weight:bold; margin-top:20px; box-shadow: 0 4px 0 #2E7D32;">
                        Unlocked! 🎉
                    </div>
                <?php else: ?>
                    <div style="background:#B0BEC5; color:white; padding:8px 20px; border-radius:20px; display:inline-block; font-size:0.9rem; font-weight:bold; margin-top:20px;">
                        Locked 🔒
                    </div>
                <?php endif; ?>
            </div>
        <?php endforeach; ?>
    </div>

    <div style="text-align:center; margin-top: 50px;">
        <a href="progress.php" class="btn-back" style="display: inline-block;">⬅ Back to Profile</a>
    </div>

</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
