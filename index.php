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
        <title>Kids- Kids Learning Platform</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
        <!-- Place favicon.ico in the root directory -->

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
                                            <li>
                                                <a href="index.php">Home</a>
                                            </li>
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
        <!-- main-area -->
        <main>
            
            <!-- search-popup -->
		<div class="modal fade bs-example-modal-lg search-bg popup1" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content search-popup">
					<div class="text-center">
						<a href="#" class="close2" data-dismiss="modal" aria-label="Close">× close</a>
					</div>
					<div class="row search-outer">
						<div class="col-md-11"><input type="text" placeholder="Search for products..." /></div>
						<div class="col-md-1 text-right"><a href="#"><i class="fa fa-search" aria-hidden="true"></i></a></div>
					</div>
				</div>
			</div>
		</div>
		<!-- /search-popup -->
            <!-- slider-area -->
            <section id="parallax" class="slider-area slider-four fix p-relative">
               <div class="slider-shape ss-one layer" data-depth="0.10"><img src="assets/img/bg/slider_shape01.png" alt="shape"></div>
                <div class="slider-shape ss-two layer" data-depth="0.30"><img src="assets/img/bg/slider_shape02.png" alt="shape"></div>
                <div class="slider-shape ss-three layer" data-depth="0.40"><img src="assets/img/bg/slider_shape03.png" alt="shape"></div>
                <div class="slider-active">
				<div class="single-slider slider-bg d-flex align-items-center" style="background: url(assets/img/slider/slider_img_bg.png) no-repeat; ">
                    <div class="img-main" data-animation="fadeInLeft" data-delay=".2s"> <img src="assets/img/slider/main.png" alt="slider-overlay"></div>
                        <div class="container">
                           <div class="row justify-content-center align-items-center">
                                <div class="col-lg-6 col-md-6">
                                    <div class="slider-content s-slider-content pt-100">
                                        <h5 data-animation="fadeInUp" data-delay=".4s">Welcome To Kids Learning Platform</h5>
                                         <h2 data-animation="fadeInUp" data-delay=".4s">Learn, Play & Grow</h2>
                                        <p data-animation="fadeInUp" data-delay=".6s">The best place for kids to learn new things while having fun! Join our community today.</p>
                                        
                                         <div class="slider-btn mt-30">                                          
                                            <a href="register.php" class="btn mr-15" data-animation="fadeInUp" data-delay=".4s">Get Started</a>                                             
                                        </div>        
                                                              
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                   
                    </div>
                    
               
            </section>
            <!-- slider-area-end -->
            
        <!-- brand-area -->
            <div class="brand-area pt-60 pb-60" style="background: #fe4b7b;">
                <div class="container-fluid">
                    <div class="row brand-active">
                        <div class="col-xl-2">
                            <div class="single-brand">
                                 <img src="assets/img/brand/b-logo1.png" alt="img">
                            </div>
                        </div>
                       <div class="col-xl-2">
                            <div class="single-brand">
                                     <img src="assets/img/brand/b-logo2.png" alt="img">
                            </div>
                        </div>
                        <div class="col-xl-2">
                            <div class="single-brand">
                                  <img src="assets/img/brand/b-logo3.png" alt="img">
                            </div>
                        </div>
                        <div class="col-xl-2">
                            <div class="single-brand">
                                  <img src="assets/img/brand/b-logo4.png" alt="img">
                            </div>
                        </div>
                         <div class="col-xl-2">
                            <div class="single-brand">
                                 <img src="assets/img/brand/b-logo5.png" alt="img">
                            </div>
                        </div>
                        <div class="col-xl-2">
                            <div class="single-brand">
                                 <img src="assets/img/brand/b-logo6.png" alt="img">
                            </div>
                        </div>
                        <div class="col-xl-2">
                            <div class="single-brand">
                                  <img src="assets/img/brand/b-logo3.png" alt="img">
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
            <!-- brand-area-end -->
                <!-- services-area -->
            <section id="services" class="services-area services-bg pt-120 pb-90 p-relative">
                <div class="animations-01"><img src="assets/img/bg/an-img-01.png" alt="an-img-01"></div>
                <div class="animations-02"><img src="assets/img/bg/an-img-02.png" alt="contact-bg-an-01"></div>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-xl-7 col-lg-10">
                            <div class="section-title text-center mb-35">
                                <h5>Our Features</h5>
                                <h2>What We Provide</h2>
                               
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-md-6 mb-30">
                            <div class="s-single-services  text-center">
                                <img src="assets/img/bg/sr-img01.png" alt="feature">
                                <div class="services-hover">
                                    <div class="services-icon">
                                       <img src="assets/img/icon/f-icon1.png"/>
                                    </div>
                                    <div class="second-services-content">
                                        <h5>Interactive Lessons</h5>
                                        <p>Engaging video lessons and content for various subjects.</p>
                                        <a href="#">Read More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-4 col-md-6 mb-30">
                            <div class="s-single-services text-center">
                                <img src="assets/img/bg/sr-img02.png" alt="feature">
                                <div class="services-hover">
                                    <div class="services-icon">
                                       <img src="assets/img/icon/f-icon2.png"/>
                                    </div>
                                    <div class="second-services-content">
                                        <h5>Fun Games</h5>
                                        <p>Learn through play with our collection of educational games.</p>
                                        <a href="#">Read More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="col-lg-4 col-md-6 mb-30">
                            <div class="s-single-services text-center">
                                <img src="assets/img/bg/sr-img03.png" alt="feature">
                                <div class="services-hover">
                                    <div class="services-icon">
                                       <img src="assets/img/icon/f-icon3.png"/>
                                    </div>
                                    <div class="second-services-content">
                                        <h5>Quizzes & Rewards</h5>
                                        <p>Test your knowledge and earn stars and badges!</p>
                                        <a href="#">Read More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                       
                    </div>
                  
                </div>
            </section>
            <!-- services-area-end -->
             <!-- about-area -->
            <section class="about-area about-p pt-120 pb-195 p-relative" style="background: #f7f9ff;">
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
                                    <h2>Get Special Care For Your Kids</h2>                                   
                                </div>
                                   <p>Our platform is designed to make learning a joyful experience for children. We combine education with entertainment to ensure your child stays engaged.</p>
                                  <p>With features like drawing, animated games, and progress tracking, parents can monitor their child's growth while kids have a blast!</p>
                                  <div class="slider-btn mt-15">                                          
                                        <a href="about.php" class="btn">Explore More</a>					
                                    </div>
                            </div>
                        </div>
                     
                    </div>
                </div>
            </section>
            <!-- about-area-end -->
         <!-- counter-area -->
            <div class="counter-area p-relative">
                <div class="container">
                    <div class="row counter-bg p-relative">
                         <div class="col-lg-3 col-md-3 col-sm-12">
                             <div class="single-counter wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="counter p-relative">
                                    <span class="count">385</span><p>Kids Are Happy</p>    
                                </div>
                            </div>
                        </div>
                     <div class="col-lg-3 col-md-3 col-sm-12">
                             <div class="single-counter wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="counter p-relative">
                                    <span class="count">509</span><p>Lessons Completed</p>    
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12">
                             <div class="single-counter wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="counter p-relative">
                                    <span class="count">798</span><p>Games Played</p>    
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12">
                             <div class="single-counter wow fadeInUp animated" data-animation="fadeInDown animated" data-delay=".2s">
                                <div class="counter p-relative">
                                    <span class="count">936</span><p>Happy Parents</p>    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- counter-area-end -->	
            <!-- steps-area -->
            <section class="steps-area fix p-relative"  style="background-color: #12265a;">
                <div class="animations-10"><img src="assets/img/bg/an-img-10.png" alt="an-img-01"></div>
                <div class="animations-11"><img src="assets/img/bg/an-img-11.png" alt="an-img-01"></div>
                <div class="container">
          
                    <div class="row align-items-center">
                        <div class="col-lg-6 col-md-12">
                            <div class="section-title mb-35"> 
                                <h5>How It Work</h5>                         
                                <h2>See Our Steps To Success</h2>
                            </div>
                            <ul>
                                <li>
                                    <div class="step-box">
                                        <div class="dnumber">
                                            <div class="date-box">01</div>
                                        </div>
                                        <div class="text">
                                            <h3>Register</h3>
                                            <p>Create an account for yourself and your child.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="step-box">
                                        <div class="dnumber">
                                            <div class="date-box">02</div>
                                        </div>
                                        <div class="text">
                                            <h3>Learn & Play</h3>
                                            <p>Access lessons, quizzes, and fun games.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="step-box">
                                        <div class="dnumber">
                                            <div class="date-box">03</div>
                                        </div>
                                        <div class="text">
                                            <h3>Track Progress</h3>
                                            <p>Monitor achievements and growth through the dashboard.</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col-lg-6 col-md-12">
                            <div class="step-img">
                                <img src="assets/img/bg/steps-img.png" alt="class image">
                            </div>
                           
                        </div>
                        
                       
						
                    </div>
                    
                </div>
            </section>
            <!-- steps-area-end -->
         
        </main>
        <!-- main-area-end -->
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
                              Copyright © 2026 kids All rights reserved.  
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
