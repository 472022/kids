<?php
require_once 'config/db.php';

try {
    // Add quiz_question column
    $pdo->exec("ALTER TABLE lessons ADD COLUMN quiz_question TEXT NULL");
    
    // Add options columns
    $pdo->exec("ALTER TABLE lessons ADD COLUMN option_a VARCHAR(255) NULL");
    $pdo->exec("ALTER TABLE lessons ADD COLUMN option_b VARCHAR(255) NULL");
    $pdo->exec("ALTER TABLE lessons ADD COLUMN option_c VARCHAR(255) NULL");
    
    // Add correct_option column
    $pdo->exec("ALTER TABLE lessons ADD COLUMN correct_option CHAR(1) NULL");
    
    echo "Database migration successful! MCQ columns added to lessons table.";
} catch (PDOException $e) {
    echo "Migration failed (columns might already exist): " . $e->getMessage();
}
?>