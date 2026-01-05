<?php
require_once 'config/db.php';

// Seed Games
$games = [
    [
        'name' => 'Alphabet Adventure',
        'type' => 'Language',
        'desc' => 'Match letters to objects! Learn your ABCs.',
        'outcome' => 'Alphabet recognition, Phonics',
        'file' => 'alphabet.js'
    ],
    [
        'name' => 'Number Jump',
        'type' => 'Math',
        'desc' => 'Jump on the correct numbers!',
        'outcome' => 'Counting, Number sequencing',
        'file' => 'number_jump.js'
    ],
    [
        'name' => 'Shape Builder',
        'type' => 'Logic',
        'desc' => 'Drag shapes to build objects.',
        'outcome' => 'Shape recognition, Logic',
        'file' => 'shape_builder.js'
    ],
    [
        'name' => 'Math Hero',
        'type' => 'Math',
        'desc' => 'Defeat enemies with math power!',
        'outcome' => 'Addition, Subtraction',
        'file' => 'math_hero.js'
    ],
    [
        'name' => 'Memory Flip',
        'type' => 'Memory',
        'desc' => 'Find the matching pairs.',
        'outcome' => 'Memory, Concentration',
        'file' => 'memory_flip.js'
    ]
];

foreach ($games as $g) {
    // Check if exists
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM games WHERE game_name = ?");
    $stmt->execute([$g['name']]);
    if ($stmt->fetchColumn() == 0) {
        // Insert
        $ins = $pdo->prepare("INSERT INTO games (game_name, game_type, description, learning_outcome, notes) VALUES (?, ?, ?, ?, ?)");
        // Storing filename in 'notes' for now as a quick hack, or just relying on ID mapping. 
        // Ideally schema should have 'game_file' column but I can't change schema easily without user permission request loop.
        // Wait, I can update schema. I already added 'notes'. I'll put the filename in 'notes' or just hardcode mapping in play_game.php.
        // Let's use 'notes' field to store the JS filename for simplicity.
        $ins->execute([$g['name'], $g['type'], $g['desc'], $g['outcome'], $g['file']]);
        echo "Inserted " . $g['name'] . "<br>";
    }
}
echo "Games Seeded.";
?>