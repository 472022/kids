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
        <title>Contact Us - Kids Learning Platform</title>
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
                                    <h2>Contact Us</h2>    
                                    <div class="breadcrumb-wrap">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.php">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Contact Us</li>
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
            <section id="contact" class="contact-area after-none contact-bg pt-90 pb-30" style="background: #12275e;" >
                <div class="container">
					<div class="row">
						<div class="col-lg-12">
                         <div class="contact-info">
						<div class="single-cta pb-30 mb-30 wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="f-cta-icon">
                                    <i class="far fa-map"></i>
                                </div>
                                <h5>Office Address</h5>
                                <p>380 St Kilda Road, Melbourne <br>
                                    VIC 3004, Australia</p>
                            </div>
							 <div class="single-cta pb-30 mb-30 wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="f-cta-icon">
                                    <i class="far fa-clock"></i>
                                </div>
                                <h5>Working Hours</h5>
                                <p>Monday to Friday 09:00 to 18:30 <br> 
                                    Saturday 15:30</p>
                            </div>
							 <div class="single-cta pb-30 mb-30 wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="f-cta-icon">
                                    <i class="far fa-envelope-open"></i>
                                </div>
                                <h5>Message Us</h5>
                                <p> <a href="#">support@example.com</a><br><a href="#">info@example.com</a></p>
                            </div>
                            </div>
                            </div>
					</div>
                </div>
            </section>
            <!-- contact-area-end -->
            
            <!-- map-area-end -->
            <div class="map fix" style="background: #f5f5f5;">
                <div class="container-flud">
                    <div class="row">
                        <div class="col-lg-12">
                       <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d212867.83634504632!2d-112.24455686962897!3d33.52582710700138!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x872b743829374b03%3A0xabaac255b1e43fbe!2sPlexus%20Worldwide!5e0!3m2!1sen!2sin!4v1618567685329!5m2!1sen!2sin" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                        </div>
                    </div>
                </div>
            </div>
		     <!-- map-area-end -->
            
            <!-- contact-area -->
            <section id="contact" class="contact-area after-none contact-bg pt-120 pb-120 p-relative fix"  style="background: #f8f9fe;">
                 <div class="animations-12"><img src="assets/img/bg/slider_shape03.png" alt="an-img-01"></div>
                <div class="animations-13"><img src="assets/img/bg/an-img-12.png" alt="contact-bg-an-01"></div>
                <div class="animations-14"><img src="assets/img/bg/slider_shape02.png" alt="contact-bg-an-01"></div>
                <div class="animations-15"><img src="assets/img/bg/an-img-13.png" alt="contact-bg-an-01"></div>
                <div class="container">
					<div class="row">
                         <div class="col-lg-6 order-1">
                            <img src="assets/img/bg/contact-img.png" alt="img">							
                        </div>
                        <div class="col-lg-6 order-2">
                            <div class="contact-bg02 wow fadeInLeft  animated">
                            <div class="section-title center-align">
                               <h5>Contact Us</h5>
                                <h2>
                                  Join Our Best Fun Classes
                                </h2>
                            </div>
						<form action="mail.php" method="post" class="contact-form mt-35">
							<div class="row">
                            <div class="col-lg-12">
                                <div class="contact-field p-relative c-name mb-30">                                    
                                    <input type="text" id="firstn" name="firstn" placeholder="Full Name" required>
                                </div>                               
                            </div>
							<div class="col-lg-12">                               
                                <div class="contact-field p-relative c-subject mb-30">                                   
                                    <input type="text" id="email" name="email" placeholder="Eamil Address" required>
                                </div>
                            </div>		
                            <div class="col-lg-12">                               
                                <div class="contact-field p-relative c-subject mb-30">                                   
                                    <input type="text" id="phone" name="phone" placeholder="Phone No." required>
                                </div>
                            </div>	
                            <div class="col-lg-12">
                                <div class="contact-field p-relative c-message mb-30">                                  
                                    <textarea name="message" id="message" cols="30" rows="10" placeholder="Write comments"></textarea>
                                </div>
                                <div class="slider-btn">                                          
                                            <button class="btn ss-btn active" data-animation="fadeInRight" data-delay=".8s">Submint Now</button>				
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
						<div class="col-xl-2 col-lg-2 col-sm-6">
                            <div class="footer-widget mb-30">
                                <div class="f-widget-title">
                                    <h2>Our Links</h2>
                                </div>
                                <div class="footer-link">
                                    <ul>                                        
                                        <li><a href="index.php">Home</a></li>
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
