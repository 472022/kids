<?php
session_start();
require_once 'config/db.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = trim($_POST['email']);
    $password = $_POST['password'];
    $role = $_POST['role'];

    if (empty($email) || empty($password)) {
        $error = "Please fill in all fields.";
    } else {
        try {
            $user = null;
            
            if ($role === 'parent') {
                $stmt = $pdo->prepare("SELECT * FROM parents WHERE parent_email = ?");
                $stmt->execute([$email]);
                $user = $stmt->fetch();
                $id_col = 'parent_id';
                $pass_col = 'parent_password';
                $name_col = 'parent_name';
            } elseif ($role === 'admin') {
                $stmt = $pdo->prepare("SELECT * FROM admins WHERE admin_email = ?");
                $stmt->execute([$email]);
                $user = $stmt->fetch();
                $id_col = 'admin_id';
                $pass_col = 'admin_password';
                $name_col = 'admin_name';
            } elseif ($role === 'child') {
                $stmt = $pdo->prepare("SELECT * FROM children WHERE child_name = ?");
                $stmt->execute([$email]);
                $user = $stmt->fetch();
                $id_col = 'child_id';
                $pass_col = 'child_password';
                $name_col = 'child_name';
            } else {
                $error = "Invalid role selected.";
            }

            if ($user && $password === $user[$pass_col]) {
                $_SESSION['user_id'] = $user[$id_col];
                $_SESSION['role'] = $role;
                $_SESSION['name'] = $user[$name_col];

                if ($role === 'parent') {
                    header("Location: parent/dashboard.php");
                } elseif ($role === 'child') {
                    header("Location: child/dashboard.php");
                } elseif ($role === 'admin') {
                    header("Location: admin/dashboard.php");
                }
                exit;
            } else {
                $error = "Invalid credentials.";
            }

        } catch (PDOException $e) {
            $error = "System error: " . $e->getMessage();
        }
    }
}
?>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Login - Kids Learning Platform</title>
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
                                            <a href="register.php" class="btn">Register</a>
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
                                    <h2>Login</h2>    
                                    <div class="breadcrumb-wrap">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Login</li>
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
                         <div class="col-lg-6 order-1">
                            <img src="assets/img/bg/contact-img.png" alt="img">							
                        </div>
                        <div class="col-lg-6 order-2">
                            <div class="contact-bg02 wow fadeInLeft  animated">
                            <div class="section-title center-align">
                               <h5>Welcome Back</h5>
                                <h2>Login to Continue</h2>
                            </div>
                             
                            <?php if($error): ?>
                                <div class="alert alert-danger" style="margin-top: 20px;">
                                    <?php echo $error; ?>
                                </div>
                            <?php endif; ?>

                            <form action="login.php" method="post" class="contact-form mt-35">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="contact-field p-relative c-subject mb-30">                                   
                                            <select name="role" id="roleSelect" onchange="updatePlaceholder()" class="form-control" style="background: #fff; height: 60px; border-radius: 10px; padding: 0 20px; border: none; margin-bottom: 0;">
                                                <option value="child">Child</option>
                                                <option value="parent">Parent</option>
                                                <option value="admin">Admin</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="contact-field p-relative c-name mb-30">                                    
                                            <input type="text" id="identityInput" name="email" placeholder="Child Name" required>
                                        </div>                               
                                    </div>
                                    <div class="col-lg-12">                               
                                        <div class="contact-field p-relative c-subject mb-30">
                                            <input type="password" name="password" id="password" placeholder="Password" required>
                                            <i class="fas fa-eye" id="togglePassword" style="position: absolute; right: 20px; top: 20px; cursor: pointer; color: #666;"></i>
                                        </div>
                                    </div>		
                                    
                                    <div class="col-lg-12">
                                        <div class="slider-btn">                                          
                                            <button class="btn ss-btn active" data-animation="fadeInRight" data-delay=".8s">Login Now</button>				
                                        </div>                             
                                    </div>
                                </div>
                            </form>
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
    function updatePlaceholder() {
        const role = document.getElementById('roleSelect').value;
        const input = document.getElementById('identityInput');

        if (role === 'child') {
            input.placeholder = 'Child Name';
            input.type = 'text';
        } else {
            input.placeholder = 'Email Address';
            input.type = 'email';
        }
    }
    
    // Toggle Password Visibility
    document.getElementById('togglePassword').addEventListener('click', function() {
        const input = document.getElementById('password');
        const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
        input.setAttribute('type', type);
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });

    // Run on load
    document.addEventListener('DOMContentLoaded', updatePlaceholder);
</script>
    </body>
</html>
