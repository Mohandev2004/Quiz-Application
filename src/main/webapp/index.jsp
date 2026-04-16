<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>QuizMaster | Smart Quiz Platform</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family: 'Segoe UI', sans-serif;
    background:#0f172a;
    color:white;
    overflow-x:hidden;
}

/* Navbar */
.navbar{
    background:rgba(255,255,255,0.05);
    backdrop-filter: blur(12px);
    border-bottom:1px solid rgba(255,255,255,0.08);
}

.navbar-brand{
    font-size:1.5rem;
    font-weight:700;
    letter-spacing:1px;
}

/* Hero */
.hero{
    min-height:100vh;
    display:flex;
    align-items:center;
    position:relative;
    background:
    radial-gradient(circle at top right,#2563eb 0%,transparent 35%),
    radial-gradient(circle at bottom left,#06b6d4 0%,transparent 35%),
    #0f172a;
}

.hero-text h1{
    font-size:3.8rem;
    font-weight:800;
    line-height:1.2;
}

.hero-text h1 span{
    color:#38bdf8;
}

.hero-text p{
    color:#cbd5e1;
    font-size:1.1rem;
    margin-top:18px;
    line-height:1.8;
}

.btn-main{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    color:white;
    padding:14px 32px;
    border-radius:50px;
    font-weight:600;
    transition:0.3s;
}

.btn-main:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 20px rgba(37,99,235,.3);
}

.btn-outline-custom{
    border:1px solid rgba(255,255,255,0.25);
    color:white;
    padding:14px 28px;
    border-radius:50px;
}

.btn-outline-custom:hover{
    background:white;
    color:#111827;
}

/* Glass Card */
.hero-card{
    background:rgba(255,255,255,0.07);
    border:1px solid rgba(255,255,255,0.08);
    backdrop-filter: blur(16px);
    border-radius:25px;
    padding:35px;
    box-shadow:0 25px 40px rgba(0,0,0,.25);
}

.hero-card .stat{
    padding:18px;
    border-radius:18px;
    background:rgba(255,255,255,0.04);
}

/* Features */
.features{
    padding:90px 0;
    background:#111827;
}

.section-title{
    font-size:2.2rem;
    font-weight:700;
}

.feature-box{
    background:#1e293b;
    border-radius:22px;
    padding:30px;
    height:100%;
    transition:0.3s;
}

.feature-box:hover{
    transform:translateY(-8px);
    background:#243247;
}

.icon-box{
    width:65px;
    height:65px;
    border-radius:18px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
    margin-bottom:20px;
    background:linear-gradient(135deg,#2563eb,#06b6d4);
}

/* Footer */
footer{
    background:#0b1120;
    padding:25px 0;
    color:#94a3b8;
}

@media(max-width:768px){
.hero-text h1{
    font-size:2.5rem;
}
.hero{
    padding:80px 0;
}
}
</style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark py-3 fixed-top">
<div class="container">
<a class="navbar-brand" href="#">
<i class="bi bi-mortarboard-fill me-2"></i>QuizMaster
</a>

<div>
<a href="login.jsp" class="btn btn-sm btn-outline-light rounded-pill px-4 me-2">Login</a>
<a href="register.jsp" class="btn btn-sm btn-info rounded-pill px-4 me-2 text-white">Sign Up</a>
<a href="adminLogin.jsp" class="text-light text-decoration-none small">Admin</a>
</div>
</div>
</nav>

<!-- Hero -->
<section class="hero">
<div class="container">
<div class="row align-items-center g-5">

<div class="col-lg-6">
<div class="hero-text">
<h1>Learn Faster With <span>Smart Quizzes</span></h1>
<p>
Challenge yourself with real-time quizzes, instant scoring,
performance tracking, and modern learning tools.
</p>

<div class="mt-4">
<a href="register.jsp" class="btn btn-main me-3">Start Free</a>
<a href="login.jsp" class="btn btn-outline-custom">Login</a>
</div>
</div>
</div>

<div class="col-lg-6">
<div class="hero-card">

<h4 class="fw-bold mb-4">Your Progress Dashboard</h4>

<div class="row g-3">

<div class="col-6">
<div class="stat text-center">
<h2 class="text-info fw-bold">10+</h2>
<p class="mb-0 text-light">Live Quizzes</p>
</div>
</div>

<div class="col-6">
<div class="stat text-center">
<h2 class="text-success fw-bold">98%</h2>
<p class="mb-0 text-light">Success Rate</p>
</div>
</div>

<div class="col-6">
<div class="stat text-center">
<h2 class="text-warning fw-bold">100+</h2>
<p class="mb-0 text-light">Questions</p>
</div>
</div>

<div class="col-6">
<div class="stat text-center">
<h2 class="text-danger fw-bold">100+</h2>
<p class="mb-0 text-light">Attempts</p>
</div>
</div>

</div>
</div>
</div>

</div>
</div>
</section>

<!-- Features -->
<section class="features">
<div class="container">

<div class="text-center mb-5">
<h2 class="section-title">Why Students Love QuizMaster</h2>
<p class="text-light-emphasis">Modern tools built for better learning</p>
</div>

<div class="row g-4">

<div class="col-md-4">
<div class="feature-box">
<div class="icon-box">
<i class="bi bi-lightning-charge-fill"></i>
</div>
<h4>Fast Quiz Engine</h4>
<p class="text-secondary">
Questions load instantly with smooth performance.
</p>
</div>
</div>

<div class="col-md-4">
<div class="feature-box">
<div class="icon-box">
<i class="bi bi-stopwatch-fill"></i>
</div>
<h4>Smart Timer</h4>
<p class="text-secondary">
Timed tests to improve speed and focus.
</p>
</div>
</div>

<div class="col-md-4">
<div class="feature-box">
<div class="icon-box">
<i class="bi bi-bar-chart-line-fill"></i>
</div>
<h4>Detailed Reports</h4>
<p class="text-secondary">
Track marks, attempts, and progress history.
</p>
</div>
</div>

</div>
</div>
</section>

<!-- Footer -->
<footer class="text-center">
<div class="container">
© 2026 QuizMaster | Designed for Modern Learning
</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>