<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$games = $pdo->query("SELECT * FROM games ORDER BY game_id ASC")->fetchAll();

include 'includes/header.php';
?>

<div class="glass-panel" style="background: linear-gradient(to bottom, #ffffff, #f3e5f5);">
    
    <!-- Hero Header -->
    <div class="game-header-banner">
        <div class="header-content">
            <h1>🎮 Game Center</h1>
            <p>Play, Learn & Have Fun!</p>
        </div>
        <div class="header-icon">
            <i class="fas fa-rocket"></i>
        </div>
    </div>

    <div class="game-grid">
        <?php foreach($games as $game): ?>
        <?php 
            // Custom Styling based on game name
            $gameNameLower = strtolower($game['game_name']);
            $cardStyle = '';
            $icon = 'fa-gamepad';
            
            if (strpos($gameNameLower, 'space adventure') !== false) {
                $cardStyle = 'background: linear-gradient(135deg, #303F9F, #1976D2);';
                $icon = 'fa-user-astronaut';
            } elseif (strpos($gameNameLower, 'number jump') !== false) {
                $cardStyle = 'background: linear-gradient(135deg, #66BB6A, #43A047);';
                $icon = 'fa-frog';
            } elseif (strpos($gameNameLower, 'math hero') !== false) {
                $cardStyle = 'background: linear-gradient(135deg, #EF5350, #C62828);';
                $icon = 'fa-mask';
            } elseif (strpos($gameNameLower, 'memory') !== false) {
                $cardStyle = 'background: linear-gradient(135deg, #AB47BC, #7B1FA2);';
                $icon = 'fa-brain';
            } else {
                $cardStyle = 'background: linear-gradient(135deg, #FFA726, #F57C00);';
            }
        ?>

        <a href="play_game.php?game_id=<?php echo $game['game_id']; ?>" class="game-card" style="<?php echo $cardStyle; ?>">
            <div class="game-icon-circle">
                <i class="fas <?php echo $icon; ?>"></i>
            </div>
            
            <div class="game-info">
                <h3><?php echo htmlspecialchars($game['game_name']); ?></h3>
                <p><?php echo htmlspecialchars($game['game_type']); ?></p>
            </div>

            <div class="play-btn">
                <i class="fas fa-play"></i> Play Now
            </div>

            <!-- Decorative circles -->
            <div class="circle c1"></div>
            <div class="circle c2"></div>
        </a>
        <?php endforeach; ?>
        
        <?php if(empty($games)): ?>
            <div class="empty-state">
                <i class="fas fa-gamepad"></i>
                <p>No games available yet. Check back soon!</p>
            </div>
        <?php endif; ?>
    </div>
</div>

<style>
    /* Header */
    .game-header-banner {
        background: linear-gradient(135deg, #8E24AA, #D81B60);
        border-radius: 25px;
        padding: 40px;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 50px;
        box-shadow: 0 10px 25px rgba(142, 36, 170, 0.4);
        position: relative;
        overflow: hidden;
    }
    .header-content h1 { font-family: 'Fredoka One'; font-size: 3rem; margin: 0; text-shadow: 2px 2px 0 rgba(0,0,0,0.1); }
    .header-content p { font-size: 1.3rem; margin: 5px 0 0; opacity: 0.9; }
    .header-icon { font-size: 5rem; opacity: 0.3; transform: rotate(15deg); }

    /* Grid */
    .game-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
        padding-bottom: 20px;
    }

    /* Game Card */
    .game-card {
        border-radius: 30px;
        padding: 30px;
        text-align: center;
        text-decoration: none;
        color: white;
        position: relative;
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
        box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 250px;
        justify-content: space-between;
    }
    .game-card:hover { transform: translateY(-10px) scale(1.02); box-shadow: 0 20px 40px rgba(0,0,0,0.3); }

    .game-icon-circle {
        width: 90px; height: 90px;
        background: rgba(255,255,255,0.2);
        backdrop-filter: blur(5px);
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 3rem;
        margin-bottom: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        z-index: 2;
    }

    .game-info { z-index: 2; }
    .game-info h3 { font-family: 'Fredoka One'; font-size: 1.8rem; margin: 0; line-height: 1.2; text-shadow: 0 2px 4px rgba(0,0,0,0.2); }
    .game-info p { margin: 5px 0 0; font-weight: bold; opacity: 0.9; font-size: 1rem; text-transform: uppercase; letter-spacing: 1px; }

    .play-btn {
        background: white;
        color: #333;
        padding: 10px 25px;
        border-radius: 25px;
        font-weight: bold;
        font-size: 1.1rem;
        margin-top: 20px;
        z-index: 2;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        transition: transform 0.2s;
    }
    .game-card:hover .play-btn { transform: scale(1.1); color: #D81B60; }

    /* Decorative Circles */
    .circle { position: absolute; border-radius: 50%; background: rgba(255,255,255,0.1); z-index: 1; }
    .c1 { width: 150px; height: 150px; top: -50px; right: -50px; }
    .c2 { width: 100px; height: 100px; bottom: -30px; left: -30px; }

    .empty-state { text-align: center; grid-column: 1/-1; padding: 50px; color: #9E9E9E; }
    .empty-state i { font-size: 4rem; margin-bottom: 15px; opacity: 0.5; }
</style>

</div> <!-- End Dashboard Container -->
</body>
</html>
