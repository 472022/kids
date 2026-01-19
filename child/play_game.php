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
$bgImage = ''; // Kept for backward compatibility if needed, but we focus on poster now

if (empty($jsFile) || !strpos($jsFile, '.js')) {
    // Map based on name or ID
    if(strpos($game['game_name'], 'Alphabet') !== false) {
        $jsFile = 'alphabet.js';
    } elseif(strpos($game['game_name'], 'Number') !== false) {
        $jsFile = 'number_jump.js';
    } elseif(strpos($game['game_name'], 'Shape') !== false) {
        $jsFile = 'shape_builder.js';
    } elseif(strpos($game['game_name'], 'Math') !== false) {
        $jsFile = 'math_hero.js';
    } elseif(strpos($game['game_name'], 'Memory') !== false) {
        $jsFile = 'memory_flip.js';
    }
}

// Map Game Name to Poster Image in ../img/ folder
$posterImage = '';
if (strpos($gameNameLower, 'space adventure') !== false) {
    $posterImage = '../img/space_advanture.png';
} elseif (strpos($gameNameLower, 'number jump') !== false) {
    $posterImage = '../img/number_jump.png';
} elseif (strpos($gameNameLower, 'shape') !== false) {
    $posterImage = '../img/shape.png';
} elseif (strpos($gameNameLower, 'math hero') !== false) {
    $posterImage = '../img/math_hero.png';
} elseif (strpos($gameNameLower, 'memory') !== false) {
    $posterImage = '../img/memory_flip.png';
} elseif (strpos($gameNameLower, 'alphabet') !== false) {
    $posterImage = '../img/alphabet_advanture.png';
}

// Define Instructions based on Game Name
$instructions = [
    'title' => 'How to Play',
    'steps' => ['Click Start to begin!'],
    'controls' => []
];

if (strpos($gameNameLower, 'space adventure') !== false) {
    $instructions = [
        'title' => '🚀 Mission Briefing',
        'steps' => [
            '1. Solve the Math Question at the top.',
            '2. Find the asteroid with the correct answer.',
            '3. Move your ship and SHOOT the correct answer!'
        ],
        'controls' => [
            ['icon' => 'fa-mouse-pointer', 'text' => 'Move Mouse to Fly'],
            ['icon' => 'fa-bullseye', 'text' => 'Click/Tap to Shoot']
        ]
    ];
} elseif (strpos($gameNameLower, 'number jump') !== false) {
    $instructions = [
        'title' => '🐸 Froggy Jump',
        'steps' => [
            '1. Look for the Target Number shown at the top.',
            '2. Click on the platform with that number to jump.',
            '3. Don\'t fall into the water!'
        ],
        'controls' => [
            ['icon' => 'fa-mouse-pointer', 'text' => 'Click Platform to Jump']
        ]
    ];
} elseif (strpos($gameNameLower, 'math hero') !== false) {
    $instructions = [
        'title' => '🦸 Math Hero Battle',
        'steps' => [
            '1. A math problem will appear.',
            '2. Select the correct answer to ATTACK the enemy.',
            '3. Wrong answers will let the enemy attack you!'
        ],
        'controls' => [
            ['icon' => 'fa-hand-pointer', 'text' => 'Tap Correct Answer']
        ]
    ];
}

include 'includes/header.php';
?>

<style>
    #gameCanvas, #gamePoster {
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 10px 0 #ddd;
        margin: 20px auto;
        display: block;
        max-width: 100%;
        height: auto; /* Allow scaling */
    }
    #gamePoster {
        object-fit: cover;
        cursor: pointer; /* Suggest interaction */
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
    /* Instruction Card Styles */
    .instruction-card {
        background: #E3F2FD;
        border-radius: 20px;
        padding: 20px;
        margin-bottom: 20px;
        border-left: 5px solid #2196F3;
        text-align: left;
    }
    .instruction-card h3 {
        color: #1565C0;
        margin: 0 0 10px 0;
        font-family: 'Fredoka One';
        font-size: 1.4rem;
    }
    .instruction-body {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        flex-wrap: wrap;
        gap: 20px;
    }
    .steps p { margin: 5px 0; font-size: 1rem; color: #37474F; }
    .controls { display: flex; gap: 15px; flex-wrap: wrap; }
    .control-item {
        background: white;
        padding: 8px 15px;
        border-radius: 15px;
        display: flex; align-items: center; gap: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        font-weight: bold; color: #546E7A;
        font-size: 0.9rem;
    }
    .control-item i { color: #2196F3; }
</style>

<div class="glass-panel game-ui">
    
    <!-- Instruction Card -->
    <div class="instruction-card">
        <h3><?php echo htmlspecialchars($instructions['title']); ?></h3>
        
        <div class="instruction-body">
            <div class="steps">
                <?php foreach($instructions['steps'] as $step): ?>
                    <p><?php echo htmlspecialchars($step); ?></p>
                <?php endforeach; ?>
            </div>
            
            <?php if(!empty($instructions['controls'])): ?>
            <div class="controls">
                <?php foreach($instructions['controls'] as $ctrl): ?>
                    <div class="control-item">
                        <i class="fas <?php echo $ctrl['icon']; ?>"></i>
                        <span><?php echo htmlspecialchars($ctrl['text']); ?></span>
                    </div>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
    </div>

    <div class="stats-bar">
        <span>⭐ Stars: <span id="starDisplay">0</span></span>
        <span>🏆 Score: <span id="scoreDisplay">0</span></span>
        <span>🕒 Level: <span id="levelDisplay">1</span></span>
    </div>

    <!-- Poster Image (Initial View) -->
    <?php if($posterImage): ?>
        <img id="gamePoster" src="<?php echo htmlspecialchars($posterImage); ?>" alt="Game Cover" width="800" height="600">
        <canvas id="gameCanvas" width="800" height="600" style="display:none;"></canvas>
    <?php else: ?>
        <!-- Fallback if no poster -->
        <canvas id="gameCanvas" width="800" height="600"></canvas>
    <?php endif; ?>
    
    <div style="margin-top:20px;">
        <h2 style="color:#2C3E50;"><?php echo htmlspecialchars($game['game_name']); ?></h2>
        <p><?php echo htmlspecialchars($game['description']); ?></p>
        <button id="startGameBtn" style="background:#2ecc71; color:white; border:none; padding:15px 40px; font-size:1.5rem; border-radius:50px; cursor:pointer; font-weight:bold; box-shadow:0 5px 0 #27ae60; margin: 10px;">
            Start Game ▶
        </button>
    </div>
</div>

<script>
    const GAME_ID = <?php echo $game_id; ?>;
    const CHILD_ID = <?php echo $_SESSION['user_id']; ?>;
    
    // Toggle Poster/Canvas on Start
    document.getElementById('startGameBtn').addEventListener('click', function() {
        const poster = document.getElementById('gamePoster');
        const canvas = document.getElementById('gameCanvas');
        if(poster) poster.style.display = 'none';
        if(canvas) canvas.style.display = 'block';
    });
</script>
<script src="assets/js/games/game_engine.js"></script>
<script src="assets/js/games/<?php echo htmlspecialchars($jsFile); ?>"></script>

</body>
</html>
