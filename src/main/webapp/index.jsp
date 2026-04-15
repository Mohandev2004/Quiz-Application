<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome - Java Quiz Application</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .hero {
                background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%);
                color: white;
                padding: 100px 0;
                margin-bottom: 40px;
            }
        </style>
    </head>

    <body class="bg-light">

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">🎓 QuizMaster</a>
                <div>
                    <a href="login.jsp" class="btn btn-outline-light me-2">Login</a>
                    <a href="register.jsp" class="btn btn-primary me-2">Sign Up</a>
                    <a href="adminLogin.jsp" class="btn btn-link text-white-50 text-decoration-none small">Admin</a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <header class="hero text-center shadow">
            <div class="container">
                <h1 class="display-4 fw-bold mb-3">Master Your Knowledge Today</h1>
                <p class="lead mb-4">Test yourself with our dynamic, timer-based quizzes. Track your progress, review
                    your history, and become an expert.</p>
                <a href="register.jsp" class="btn btn-light btn-lg text-primary fw-bold rounded-pill px-5">Get Started
                    for Free</a>
            </div>
        </header>

        <!-- Features Section -->
        <div class="container mb-5">
            <div class="row text-center g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body py-5">
                            <h1 class="text-primary mb-3">⚡</h1>
                            <h4 class="card-title fw-bold">Dynamic AJAX Quizzes</h4>
                            <p class="card-text text-muted">Experience uninterrupted quizzes that seamlessly fetch
                                questions without page reloads.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body py-5">
                            <h1 class="text-danger mb-3">⏳</h1>
                            <h4 class="card-title fw-bold">Active Timer Countdown</h4>
                            <p class="card-text text-muted">Test your speed under pressure. Our built-in timer
                                automatically tracks and submits your progress.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0">
                        <div class="card-body py-5">
                            <h1 class="text-success mb-3">📊</h1>
                            <h4 class="card-title fw-bold">Track Your History</h4>
                            <p class="card-text text-muted">Instantly view your grades. Check your dashboard to monitor
                                improvements over past attempts.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>