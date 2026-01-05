<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$games = $pdo->query("SELECT * FROM games ORDER BY game_id ASC")->fetchAll();

include 'includes/header.php';
?>

<div class="glass-panel">
    <div style="text-align:center; margin-bottom:40px;">
        <h1 style="font-family:'Fredoka One'; color: var(--secondary-color); font-size: 3rem; margin-bottom:10px;">🎮 Game Center</h1>
        <p style="font-size:1.5rem; color:#5D4037; font-weight:bold;">Choose a game to play!</p>
    </div>

    <div class="subject-row">
        <?php foreach($games as $game): ?>
        <a href="play_game.php?game_id=<?php echo $game['game_id']; ?>" class="subject-card" style="width: 320px; flex-direction: column; text-align: center; padding: 30px;">
            <?php 
                $gameImage = '';
                $gameNameLower = strtolower($game['game_name']);
                
                if (strpos($gameNameLower, 'alphabet adventure') !== false) {
                    $gameImage = '../assets/img/alphabet.jpg';
                } elseif (strpos($gameNameLower, 'number jump') !== false) {
                    $gameImage = '../assets/img/number.jpg';
                } elseif (strpos($gameNameLower, 'math hero') !== false) {
                    $gameImage = '../assets/img/math.jpg';
                } elseif (strpos($gameNameLower, 'memory flip') !== false) {
                    $gameImage = '../assets/img/memory.jpg';
                }
            ?>

            <?php if ($gameImage): ?>
                <div class="subject-icon" style="width: 100px; height: 100px; overflow: hidden; border-radius: 15px; padding: 0; border: 3px solid #eee;">
                    <img src="<?php echo $gameImage; ?>" alt="<?php echo htmlspecialchars($game['game_name']); ?>" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
            <?php else: ?>
                <div class="subject-icon" style="width: 80px; height: 80px; font-size: 3rem; background: #F3E5F5; color: #9C27B0;">
                    <i class="fas fa-gamepad"></i>
                </div>
            <?php endif; ?>

            <div class="subject-info">
                <h3 style="font-size: 1.5rem; color: #6A1B9A;"><?php echo htmlspecialchars($game['game_name']); ?></h3>
                <p style="margin-top: 10px; font-weight: normal; color: #5D4037;"><?php echo htmlspecialchars($game['description']); ?></p>
            </div>
            <div style="margin-top:15px;">
                <span style="background: #9C27B0; color: white; padding: 5px 15px; border-radius: 15px; font-size: 0.8rem; font-weight: bold;">
                    <?php echo htmlspecialchars($game['game_type']); ?>
                </span>
            </div>
        </a>
        <?php endforeach; ?>
        
        <?php if(empty($games)): ?>
            <p style="text-align:center; width:100%;">No games available yet. Check back soon!</p>
        <?php endif; ?>
    </div>
</div>

</div> <!-- End Dashboard Container -->
</body>
</html>
