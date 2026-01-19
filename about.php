<?php
session_start();
$dashboard_link = '#';
if(isset($_SESSION['user_id'])) {
    if($_SESSION['role'] === 'child') $dashboard_link = 'child/dashboard.php';
    elseif($_SESSION['role'] === 'parent') $dashboard_link = 'parent/dashboard.php';
    elseif($_SESSION['role'] === 'admin') $dashboard_link = 'admin/dashboard.php';
}
?>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>About Us - Kids Learning Platform</title>
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
                                            <li><a href="about.php">About Us</a></li>
                                            <li><a href="contact.php">Contact Us</a></li>                                               
                                        </ul>
                                    </nav>
                                </div>
                            </div>   
                            <div class="col-xl-4 col-lg-4 text-right d-none d-lg-block mt-30 mb-30 text-right text-xl-right">
                                <div class="login">
                                    <ul>
                                        <?php if(isset($_SESSION['user_id'])): ?>
                                            <li><div class="header-btn second-header-btn">
                                                <a href="<?php echo $dashboard_link; ?>" class="btn">Dashboard</a>
                                            </div></li>
                                            <li><div class="header-btn second-header-btn" style="margin-left: 10px;">
                                                <a href="logout.php" class="btn">Logout</a>
                                            </div></li>
                                        <?php else: ?>
                                            <li><div class="header-btn second-header-btn">
                                                <a href="login.php" class="btn">Login</a>
                                            </div></li>
                                            <li><div class="header-btn second-header-btn" style="margin-left: 10px;">
                                                <a href="register.php" class="btn">Register</a>
                                            </div></li>
                                        <?php endif; ?>
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
                                    <h2>About Us</h2>    
                                    <div class="breadcrumb-wrap">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">About Us</li>
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
            
            <!-- about-area -->
            <section class="about-area about-p pt-120 pb-120 p-relative" style="background: #f7f9ff;">
                <div class="animations-03"><img src="assets/img/bg/an-img-03.png" alt="an-img-01"></div>
                <div class="animations-04"><img src="assets/img/bg/an-img-04.png" alt="contact-bg-an-01"></div>
                <div class="animations-05"><img src="assets/img/bg/an-img-05.png" alt="contact-bg-an-01"></div>
                <div class="container">
                    <div class="row justify-content-center align-items-center">
                         <div class="col-lg-6 col-md-12 col-sm-12">
                            <div class="s-about-img p-relative  wow fadeInLeft  animated"   data-animation="fadeInLeft" data-delay=".4s">
                                <img src="assets/img/features/about_img.png" alt="img">    
                            </div>
                        </div>
                        
					<div class="col-lg-6 col-md-12 col-sm-12">
                            <div class="about-content s-about-content  wow fadeInRight  animated pl-30" data-animation="fadeInRight" data-delay=".4s">
                                <div class="about-title second-title pb-25">  
                                    <h5>About Us</h5>
                                    <h2>We Are The Best Kids Learning Platform</h2>                                   
                                </div>
                                   <p>Our mission is to provide high-quality educational content that is both fun and effective. We believe that learning should be an adventure, not a chore.</p>
                                  <p>Founded in 2023, we have helped thousands of children improve their math, reading, and logical skills through our interactive games and lessons.</p>
                                  
                                  <ul class="about-list mt-30 mb-30">
                                      <li><i class="fas fa-check"></i> Interactive Lessons</li>
                                      <li><i class="fas fa-check"></i> Fun Educational Games</li>
                                      <li><i class="fas fa-check"></i> Progress Tracking for Parents</li>
                                  </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- about-area-end -->
            
            <!-- team-area -->
            <section class="team-area pt-120 pb-90" style="background: #fff;">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-xl-7 col-lg-10">
                            <div class="section-title text-center mb-50">
                                <h5>Our Team</h5>
                                <h2>Meet Our Expert Teachers</h2>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="single-team text-center mb-30">
                                <div class="team-img">
                                    <img src="assets/img/team/team01.png" alt="team">
                                </div>
                                <div class="team-info">
                                    <h4>Howard Holmes</h4>
                                    <span>Math Teacher</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="single-team text-center mb-30">
                                <div class="team-img">
                                    <img src="assets/img/team/team02.png" alt="team">
                                </div>
                                <div class="team-info">
                                    <h4>Ella Thompson</h4>
                                    <span>English Teacher</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="single-team text-center mb-30">
                                <div class="team-img">
                                    <img src="assets/img/team/team03.png" alt="team">
                                </div>
                                <div class="team-info">
                                    <h4>Vincent Cooper</h4>
                                    <span>Science Teacher</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="single-team text-center mb-30">
                                <div class="team-img">
                                    <img src="assets/img/team/team04.png" alt="team">
                                </div>
                                <div class="team-info">
                                    <h4>Danielle Bryant</h4>
                                    <span>Art Teacher</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- team-area-end -->

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
						<div class="col-xl-2 col-lg-2 col-sm-6">
                            <div class="footer-widget mb-30">
                                <div class="f-widget-title">
                                    <h2>Our Links</h2>
                                </div>
                                <div class="footer-link">
                                    <ul>                                        
                                        <li><a href="index.php">Home</a></li>
                                        <li><a href="about.php"> About Us</a></li>
                                        <li><a href="contact.php"> Contact Us</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 col-sm-6">
                            <div class="footer-widget mb-30">
                                <div class="f-widget-title">
                                    <h2>Contact Us</h2>
                                </div>
                                <div class="f-contact">
                                    <ul>
                                    <li>
                                        <i class="icon fal fa-map-marker-check"></i>
                                        <span>123 Learning Street, <br>City, Country</span>
                                    </li>
                                    <li>
                                        <i class="icon fal fa-phone"></i>
                                        <span>1800-121-3637</span>
                                    </li>
                                   <li><i class="icon fal fa-envelope"></i>
                                        <span>
                                            <a href="mailto:info@example.com">info@example.com</a>
                                       </span>
                                    </li>
                                </ul>
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
    </body>
</html>
