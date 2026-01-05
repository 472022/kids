<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

$game_id = $_GET['game_id'] ?? null;
if (!$game_id) { header("Location: games.php"); exit; }

$stmt = $pdo->prepare("SELECT * FROM games WHERE game_id = ?");
$stmt->execute([$game_id]);
$game = $stmt->fetch();

if (!$game) { echo "Game not found."; exit; }

// Use 'notes' field for JS filename if available, else map by ID/Name
$jsFile = $game['notes'] ?? 'game_engine.js';
// Fallback mapping if 'notes' is empty or just descriptive text
$gameNameLower = strtolower($game['game_name']);
$bgImage = ''; // Background/Poster image

if (empty($jsFile) || !strpos($jsFile, '.js')) {
    // Map based on name or ID
    if(strpos($game['game_name'], 'Alphabet') !== false) {
        $jsFile = 'alphabet.js';
        $bgImage = '../assets/img/alphabet.jpg';
    } elseif(strpos($game['game_name'], 'Number') !== false) {
        $jsFile = 'number_jump.js';
        $bgImage = '../assets/img/number.jpg';
    } elseif(strpos($game['game_name'], 'Shape') !== false) {
        $jsFile = 'shape_builder.js';
    } elseif(strpos($game['game_name'], 'Math') !== false) {
        $jsFile = 'math_hero.js';
        $bgImage = '../assets/img/math.jpg';
    } elseif(strpos($game['game_name'], 'Memory') !== false) {
        $jsFile = 'memory_flip.js';
        $bgImage = '../assets/img/memory.jpg';
    }
}

include 'includes/header.php';
?>

<style>
    #gameCanvas {
        background: #fff;
        <?php if($bgImage): ?>
        background-image: url('<?php echo $bgImage; ?>');
        background-size: cover;
        background-position: center;
        <?php endif; ?>
        border-radius: 20px;
        box-shadow: 0 10px 0 #ddd;
        margin: 20px auto;
        display: block;
        max-width: 100%;
        height: auto; /* Allow scaling */
    }
    .game-ui {
        text-align: center;
        max-width: 800px;
        margin: 0 auto;
    }
    .stats-bar {
        display: flex;
        justify-content: space-between;
        background: white;
        padding: 15px;
        border-radius: 15px;
        margin-bottom: 20px;
        box-shadow: 0 5px 0 #eee;
        font-weight: bold;
        font-size: 1.2rem;
    }
    
    @media (max-width: 600px) {
        .stats-bar {
            flex-direction: column;
            gap: 10px;
            font-size: 1rem;
        }
    }
</style>

<div class="glass-panel game-ui">
    <div class="stats-bar">
        <span>⭐ Stars: <span id="starDisplay">0</span></span>
        <span>🏆 Score: <span id="scoreDisplay">0</span></span>
        <span>🕒 Level: <span id="levelDisplay">1</span></span>
    </div>

    <canvas id="gameCanvas" width="800" height="600"></canvas>
    
    <div style="margin-top:20px;">
        <h2 style="color:#2C3E50;"><?php echo htmlspecialchars($game['game_name']); ?></h2>
        <p><?php echo htmlspecialchars($game['description']); ?></p>
        <button id="startGameBtn" style="background:#2ecc71; color:white; border:none; padding:15px 40px; font-size:1.5rem; border-radius:50px; cursor:pointer; font-weight:bold; box-shadow:0 5px 0 #27ae60;">
            Start Game ▶
        </button>
    </div>
</div>

<script>
    const GAME_ID = <?php echo $game_id; ?>;
    const CHILD_ID = <?php echo $_SESSION['user_id']; ?>;
    
    // Clear background image when game starts (optional, depending on if game draws its own background)
    document.getElementById('startGameBtn').addEventListener('click', function() {
        // We can keep the background if the game uses transparent canvas, or the game will overwrite it.
        // For now, let's keep it as a nice backdrop if the game elements float on top.
    });
</script>
<script src="assets/js/games/game_engine.js"></script>
<script src="assets/js/games/<?php echo htmlspecialchars($jsFile); ?>"></script>

</body>
</html>
