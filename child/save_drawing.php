<?php
require_once '../config/db.php';
session_start();

header('Content-Type: application/json');

// Auth Check
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'child') {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);

if (isset($input['image'])) {
    $img = $input['image'];
    
    // Basic validation (check if base64)
    if (strpos($img, 'data:image/png;base64,') === 0) {
        
        // Optional: Decode and save to file system instead of DB base64 string
        // But prompt said "drawings table (drawing_image)" so storing Base64 string is fine for simplicity 
        // or storing a path. Storing Base64 in TEXT/LONGTEXT column is okay for small scale.
        // Let's ensure drawings table has LONGTEXT if images are large. 
        // Default TEXT is 64KB, might be small for detailed PNGs.
        // I'll assume it fits or will alter table if needed.
        // Actually, converting to file is better practice.
        
        $child_id = $_SESSION['user_id'];
        
        // Option A: Save to file (Better)
        $img = str_replace('data:image/png;base64,', '', $img);
        $img = str_replace(' ', '+', $img);
        $data = base64_decode($img);
        
        $dir = '../assets/drawings/';
        if (!is_dir($dir)) mkdir($dir, 0777, true);
        
        $filename = 'drawing_' . $child_id . '_' . time() . '.png';
        $filepath = $dir . $filename;
        
        if(file_put_contents($filepath, $data)) {
            // Store path in DB
            // Note: drawing_image column in schema (TEXT).
            $dbPath = 'assets/drawings/' . $filename;
            
            $stmt = $pdo->prepare("INSERT INTO drawings (child_id, drawing_image, created_at) VALUES (?, ?, NOW())");
            if($stmt->execute([$child_id, $dbPath])) {
                // Log
                $pdo->prepare("INSERT INTO activity_logs (child_id, activity_type, activity_details) VALUES (?, 'drawing', 'Created a new masterpiece!')")->execute([$child_id]);
                
                echo json_encode(['success' => true]);
            } else {
                echo json_encode(['success' => false, 'message' => 'DB Error']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'File Write Error']);
        }
        
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid Image Data']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'No Image Sent']);
}
?>