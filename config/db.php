<?php
// Database credentials
$host = 'localhost';
$dbname = 'kids_learning';
$username = 'root';
$password = '';

try {
    // Create PDO instance
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    
    // Set error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Set default fetch mode to associative array
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
} catch(PDOException $e) {
    // If connection fails, show error
    die("Connection failed: " . $e->getMessage());
}
?>