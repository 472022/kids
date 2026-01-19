<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // In a real application, you would send an email here using mail() or PHPMailer
    
    // Simulate successful processing
    http_response_code(200);
    echo "Thank you! Your message has been sent successfully.";
} else {
    http_response_code(403);
    echo "There was a problem with your submission, please try again.";
}
?>