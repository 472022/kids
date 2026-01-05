<?php
session_start();
require_once 'config/db.php';

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Parent Data
    $parent_name = trim($_POST['parent_name']);
    $parent_email = trim($_POST['parent_email']);
    $parent_phone = trim($_POST['parent_phone']);
    $parent_password = $_POST['parent_password'];
    
    // Child Data
    $child_name = trim($_POST['child_name']);
    $child_age = (int)$_POST['child_age'];
    $child_password = $_POST['child_password'];

    // Basic Validation
    if (empty($parent_name) || empty($parent_email) || empty($parent_password) || empty($child_name) || empty($child_password)) {
        $error = "All fields are required.";
    } else {
        try {
            // Start Transaction
            $pdo->beginTransaction();

            // 1. Check if email already exists
            $stmt = $pdo->prepare("SELECT parent_id FROM parents WHERE parent_email = ?");
            $stmt->execute([$parent_email]);
            if ($stmt->rowCount() > 0) {
                throw new Exception("Email already registered.");
            }

            // 2. Insert Parent
            $stmt = $pdo->prepare("INSERT INTO parents (parent_name, parent_email, parent_phone, parent_password) VALUES (?, ?, ?, ?)");
            $stmt->execute([$parent_name, $parent_email, $parent_phone, $parent_password]);
            $parent_id = $pdo->lastInsertId();

            // 3. Insert Child
            $stmt = $pdo->prepare("INSERT INTO children (parent_id, child_name, child_age, child_password) VALUES (?, ?, ?, ?)");
            $stmt->execute([$parent_id, $child_name, $child_age, $child_password]);

            // Commit Transaction
            $pdo->commit();
            $success = "Registration successful! You can now <a href='login.php'>Login</a>.";

        } catch (Exception $e) {
            $pdo->rollBack();
            $error = "Registration failed: " . $e->getMessage();
        }
    }
}
?>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Register - Kids Learning Platform</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
        
		<!-- CSS here -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/animate.min.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/fontawesome/css/all.min.css">
        <link rel="stylesheet" href="assets/font-flaticon/flaticon.css">
        <link rel="stylesheet" href="assets/css/dripicons.css">
        <link rel="stylesheet" href="assets/css/slick.css">
        <link rel="stylesheet" href="assets/css/meanmenu.css">
        <link rel="stylesheet" href="assets/css/default.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
    </head>
    <body>
        <!-- header -->
        <header class="header-area header-three">  	
			  <div id="header-sticky" class="menu-area">
                <div class="container">
                    <div class="second-menu">
                        <div class="row align-items-center">
                            <div class="col-xl-2 col-lg-2">
                                <div class="logo">
                                    <a href="index.php"><img src="assets/img/logo/logo.png" alt="logo"></a>
                                </div>
                            </div>
                           <div class="col-xl-6 col-lg-6">
                                <div class="main-menu text-right text-xl-right">
                                    <nav id="mobile-menu">
                                         <ul>
                                            <li><a href="index.php">Home</a></li>
                                            <li><a href="contact.php">Contact Us</a></li>                                               
                                        </ul>
                                    </nav>
                                </div>
                            </div>   
                            <div class="col-xl-4 col-lg-4 text-right d-none d-lg-block mt-30 mb-30 text-right text-xl-right">
                                <div class="login">
                                    <ul>
                                        <li><div class="header-btn second-header-btn">
                                            <a href="login.php" class="btn">Login</a>
                                        </div></li>
                                    </ul>
                                </div>
                            </div>
                             <div class="col-12">
                                <div class="mobile-menu"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- header-end -->

        <main>
             <!-- breadcrumb-area -->
            <section class="breadcrumb-area d-flex align-items-center" style="background-image:url(assets/img/bg/bdrc-bg.jpg)">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-xl-12 col-lg-12">
                            <div class="breadcrumb-wrap text-left">
                                <div class="breadcrumb-title">
                                    <h2>Register</h2>    
                                    <div class="breadcrumb-wrap">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Register</li>
                                    </ol>
                                </nav>
                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- breadcrumb-area-end -->
            
            <!-- contact-area -->
            <section id="contact" class="contact-area after-none contact-bg pt-120 pb-120 p-relative fix"  style="background: #f8f9fe;">
                <div class="animations-12"><img src="assets/img/bg/slider_shape03.png" alt="an-img-01"></div>
                <div class="animations-13"><img src="assets/img/bg/an-img-12.png" alt="contact-bg-an-01"></div>
                <div class="container">
                    <div class="row">
                         <div class="col-lg-5 order-1">
                            <img src="assets/img/bg/contact-img.png" alt="img" style="width:100%;">							
                        </div>
                        <div class="col-lg-7 order-2">
                            <div class="contact-bg02 wow fadeInLeft  animated">
                            <div class="section-title center-align">
                               <h5>Join Us</h5>
                                <h2>Create an Account</h2>
                            </div>
                             
                            <?php if($error): ?>
                                <div class="alert alert-danger" style="margin-top: 20px;">
                                    <?php echo $error; ?>
                                </div>
                            <?php endif; ?>
                            
                            <?php if($success): ?>
                                <div class="alert alert-success" style="margin-top: 20px;">
                                    <?php echo $success; ?>
                                </div>
                            <?php else: ?>

                            <form action="register.php" method="post" class="contact-form mt-35">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>Parent Details</h4>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="contact-field p-relative c-name mb-30">                                    
                                            <input type="text" name="parent_name" placeholder="Parent Name" required>
                                        </div>                               
                                    </div>
                                    <div class="col-lg-6">                               
                                        <div class="contact-field p-relative c-subject mb-30">                                   
                                            <input type="email" name="parent_email" placeholder="Email Address" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">                               
                                        <div class="contact-field p-relative c-subject mb-30">                                   
                                            <input type="text" name="parent_phone" placeholder="Phone Number" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">                               
                                        <div class="contact-field p-relative c-subject mb-30">
                                            <input type="password" name="parent_password" id="parent_password" placeholder="Parent Password" required minlength="8">
                                            <i class="fas fa-eye" id="toggleParentPassword" style="position: absolute; right: 20px; top: 20px; cursor: pointer; color: #666;"></i>
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-12 mt-4">
                                        <h4>Child Details</h4>
                                    </div>
                                    <div class="col-lg-6">                               
                                        <div class="contact-field p-relative c-subject mb-30">                                   
                                            <input type="text" name="child_name" placeholder="Child Name" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">                               
                                        <div class="contact-field p-relative c-subject mb-30">                                   
                                            <input type="number" name="child_age" placeholder="Child Age" min="3" max="18" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">                               
                                        <div class="contact-field p-relative c-subject mb-30">
                                            <input type="password" name="child_password" id="child_password" placeholder="Child Password" required minlength="8">
                                            <i class="fas fa-eye" id="toggleChildPassword" style="position: absolute; right: 20px; top: 20px; cursor: pointer; color: #666;"></i>
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-12">
                                        <div class="slider-btn">                                          
                                            <button class="btn ss-btn active" data-animation="fadeInRight" data-delay=".8s">Register Family</button>				
                                        </div>                             
                                    </div>
                                </div>
                            </form>
                            <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- contact-area-end -->
        </main>
        
         <!-- footer -->
        <footer class="footer-bg footer-p">
            <div class="footer-top pt-120 pb-80  p-relative" style="background-image: url(assets/img/bg/footer-bg.png); background-color: #fff;  background-repeat: no-repeat;background-size: cover;background-position: center;">
                <div class="container">
                    <div class="row justify-content-between">
                          <div class="col-xl-3 col-lg-3 col-sm-6">
                            <div class="footer-widget mb-30">
                                <div class="f-widget-title mb-15">
                                   <img src="assets/img/logo/f_logo.png" alt="img">
                                </div>
                                <div class="footer-text mb-20">
                                    <p>The best learning platform for your kids.</p>
                                </div>
                                <div class="footer-social">                                    
                                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                    <a href="#"><i class="fab fa-instagram"></i></a>
                                </div>        
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           <div class="copyright-wrap text-center">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12">                         
                              Copyright © 2026 Kidso All rights reserved.  
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- footer-end -->

		<!-- JS here -->
        <script src="assets/js/vendor/modernizr-3.5.0.min.js"></script>
        <script src="assets/js/vendor/jquery-3.6.0.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/ajax-form.js"></script>
        <script src="assets/js/paroller.js"></script>
        <script src="assets/js/wow.min.js"></script>
        <script src="assets/js/js_isotope.pkgd.min.js"></script>
        <script src="assets/js/imagesloaded.min.js"></script>
        <script src="assets/js/parallax.min.js"></script>
        <script src="assets/js/jquery.waypoints.min.js"></script>
        <script src="assets/js/jquery.counterup.min.js"></script>
        <script src="assets/js/jquery.scrollUp.min.js"></script>
        <script src="assets/js/jquery.meanmenu.min.js"></script>
        <script src="assets/js/parallax-scroll.js"></script>
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <script src="assets/js/element-in-view.js"></script>
        <script src="assets/js/main.js"></script>
    <script>
    // Toggle Password Visibility Logic
    function setupPasswordToggle(inputId, toggleId) {
        const input = document.getElementById(inputId);
        const toggle = document.getElementById(toggleId);
        
        if(input && toggle) {
            toggle.addEventListener('click', function() {
                const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                input.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        setupPasswordToggle('parent_password', 'toggleParentPassword');
        setupPasswordToggle('child_password', 'toggleChildPassword');
    });

    // Form Validation for Password Length, Phone Number, and Parent Name
    document.querySelector('form').addEventListener('submit', function(e) {
        const parentPass = document.getElementById('parent_password').value;
        const childPass = document.getElementById('child_password').value;
        const parentPhone = document.querySelector('input[name="parent_phone"]').value;
        const parentName = document.querySelector('input[name="parent_name"]').value;
        
        // 1. Password Validation (min 8 chars)
        if (parentPass.length < 8) {
            e.preventDefault();
            alert("Parent Password must be at least 8 characters long.");
            return;
        }
        if (childPass.length < 8) {
            e.preventDefault();
            alert("Child Password must be at least 8 characters long.");
            return;
        }

        // 2. Phone Validation (exactly 10 digits, numbers only)
        const phoneRegex = /^\d{10}$/;
        if (!phoneRegex.test(parentPhone)) {
            e.preventDefault();
            alert("Phone number must be exactly 10 digits (numbers only).");
            return;
        }

        // 3. Parent Name Validation (Characters only, spaces allowed)
        const nameRegex = /^[A-Za-z\s]+$/;
        if (!nameRegex.test(parentName)) {
            e.preventDefault();
            alert("Parent Name must contain only characters (no numbers or special symbols).");
            return;
        }
    });
</script>
</body>
</html>
