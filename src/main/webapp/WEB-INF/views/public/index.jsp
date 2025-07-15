<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Real Estate Enterprise Software - REES by RASHI" />
    <meta name="author" content="RASHI" />
    <title>REES - Real Estate Enterprise Software</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/favicon.ico" />

    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet" />

    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
</head>
<body id="page-top">

<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="#page-top">REES by RASHI</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">
            Menu <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                <li class="nav-item"><a class="nav-link" href="#projects">Modules</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Masthead -->
<header class="masthead">
    <div class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
        <div class="text-center">
            <h1 class="mx-auto my-0 text-uppercase">REES</h1>
            <h2 class="text-white-50 mx-auto mt-2 mb-5">Efficient Real Estate Enterprise System crafted by RASHI for streamlined operations.</h2>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Get Started</a>
        </div>
    </div>
</header>

<!-- About Section -->
<section class="about-section text-center" id="about">
    <div class="container px-4 px-lg-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <h2 class="text-white mb-4">Smart, Scalable, Secure</h2>
                <p class="text-white-50">
                    REES is an all-in-one enterprise software tailored for real estate businesses. From project creation to plot bookings, payments, and customer management.
                </p>
            </div>
        </div>
		
		      <img src="assets/img/ipad.jpg" alt="App Preview" class="img-fluid rounded shadow" style="max-width: 600px;">
		
    </div>
</section>

<!-- Modules Section -->
<section class="projects-section bg-light" id="projects">
    <div class="container px-4 px-lg-5">
        <!-- Featured Module -->
		<!-- Featured Module (styled same as Module One) -->
		<div class="row gx-0 mb-5 justify-content-center">
		    <div class="col-lg-6">
		        <img class="img-fluid" src="${pageContext.request.contextPath}/assets/img/bg-masthead.jpg" alt="Dashboard" />
		    </div>
		    <div class="col-lg-6">
		        <div class="bg-black text-center h-100 project">
		            <div class="d-flex h-100">
		                <div class="project-text w-100 my-auto text-center text-lg-left">
		                    <h4 class="text-white">Admin Dashboard</h4>
		                    <p class="mb-0 text-white-50">Visualize insights like project status, plot status, customer activity, and payment tracking — all in one place.</p>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>

        <!-- Module One -->
        <div class="row gx-0 mb-5 justify-content-center">
            <div class="col-lg-6"><img class="img-fluid" src="${pageContext.request.contextPath}/assets/img/demo-image-01.jpg" alt="Plot Management" /></div>
            <div class="col-lg-6">
                <div class="bg-black text-center h-100 project">
                    <div class="d-flex h-100">
                        <div class="project-text w-100 my-auto text-center text-lg-left">
                            <h4 class="text-white">Project & Plot Management</h4>
                            <p class="mb-0 text-white-50">Easily manage multiple real estate projects, plot layouts, availability, and specifications.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Module Two -->
        <div class="row gx-0 justify-content-center">
            <div class="col-lg-6"><img class="img-fluid" src="${pageContext.request.contextPath}/assets/img/demo-image-02.jpg" alt="Customer Management" /></div>
            <div class="col-lg-6 order-lg-first">
                <div class="bg-black text-center h-100 project">
                    <div class="d-flex h-100">
                        <div class="project-text w-100 my-auto text-center text-lg-right">
                            <h4 class="text-white">Customer & Inquiry Tracking</h4>
                            <p class="mb-0 text-white-50">Track customer inquiries, interactions, and sales records efficiently.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section class="contact-section bg-black" id="contact">
    <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5">
            <div class="col-md-4 mb-3">
                <div class="card py-4 h-100 text-center">
                    <i class="fas fa-map-marked-alt text-primary mb-2"></i>
                    <h4 class="text-uppercase">Address</h4>
                    <hr class="my-4 mx-auto" />
                    <div class="small text-black-50">100 Feet Rd, near Rotary Blood Bank, Vinayaka Nagar, Basavanagudi, Shivamogga, Karnataka 577201</div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card py-4 h-100 text-center">
                    <i class="fas fa-envelope text-primary mb-2"></i>
                    <h4 class="text-uppercase">Email</h4>
                    <hr class="my-4 mx-auto" />
                    <div class="small text-black-50"><a href="mailto:rashiinfrait@gmail.com">rashiinfrait@gmail.com</a></div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card py-4 h-100 text-center">
                    <i class="fas fa-mobile-alt text-primary mb-2"></i>
                    <h4 class="text-uppercase">Phone</h4>
                    <hr class="my-4 mx-auto" />
                    <div class="small text-black-50">+91 76764 88888</div>
                </div>
            </div>
        </div>
        <div class="social d-flex justify-content-center mt-4">
            <a class="mx-2" href="#"><i class="fab fa-twitter"></i></a>
            <a class="mx-2" href="#"><i class="fab fa-facebook-f"></i></a>
            <a class="mx-2" href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer bg-black small text-center text-white-50">
    <div class="container px-4 px-lg-5">© 2025 REES - Real Estate Enterprise Software by RASHI</div>
</footer>

<!-- Bootstrap core JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>
