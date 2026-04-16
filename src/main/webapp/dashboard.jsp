<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.User" %>

<%
User user = (User) session.getAttribute("user");

if(user == null || session.getAttribute("isAdmin") == null || (boolean)session.getAttribute("isAdmin")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Dashboard | QuizMaster</title>

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
    font-family:'Segoe UI',sans-serif;
    background:
    radial-gradient(circle at top right,#2563eb 0%,transparent 28%),
    radial-gradient(circle at bottom left,#06b6d4 0%,transparent 28%),
    #0f172a;
    min-height:100vh;
    color:white;
}

/* Navbar */
.navbar{
    background:rgba(2,6,23,.85);
    backdrop-filter:blur(10px);
    border-bottom:1px solid rgba(255,255,255,.05);
}

.navbar-brand{
    font-weight:700;
    font-size:1.3rem;
}

/* Hero */
.hero-box{
    background:rgba(255,255,255,.06);
    border:1px solid rgba(255,255,255,.08);
    border-radius:24px;
    padding:35px;
    backdrop-filter:blur(15px);
    box-shadow:0 25px 45px rgba(0,0,0,.25);
}

.hero-title{
    font-size:2rem;
    font-weight:700;
}

.hero-sub{
    color:#cbd5e1;
}

/* Cards */
.dashboard-card{
    background:#111827;
    border:1px solid rgba(255,255,255,.06);
    border-radius:22px;
    padding:35px 25px;
    height:100%;
    transition:.3s;
    box-shadow:0 15px 30px rgba(0,0,0,.18);
}

.dashboard-card:hover{
    transform:translateY(-8px);
}

.icon-box{
    width:70px;
    height:70px;
    border-radius:20px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
    margin:auto;
    margin-bottom:18px;
}

.icon-primary{
    background:linear-gradient(135deg,#2563eb,#06b6d4);
}

.icon-secondary{
    background:linear-gradient(135deg,#64748b,#334155);
}

.card-title-custom{
    font-size:1.35rem;
    font-weight:700;
}

.card-text-custom{
    color:#94a3b8;
    min-height:55px;
}

/* Buttons */
.btn-main{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    color:white;
    border-radius:14px;
    padding:12px;
    font-weight:600;
}

.btn-main:hover{
    opacity:.95;
    color:white;
}

.btn-dark2{
    background:#1e293b;
    border:none;
    color:white;
    border-radius:14px;
    padding:12px;
    font-weight:600;
}

.btn-dark2:hover{
    background:#334155;
    color:white;
}
</style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark py-3">
<div class="container">

<a class="navbar-brand" href="#">
<i class="bi bi-mortarboard-fill me-2"></i>QuizMaster
</a>

<div class="d-flex align-items-center">
<span class="me-3 text-light">
Welcome, <strong><%= user.getUsername() %></strong>
</span>

<a href="LogoutServlet" class="btn btn-outline-light btn-sm rounded-pill px-4">
Logout
</a>
</div>

</div>
</nav>

<!-- Main -->
<div class="container py-5">

<!-- Welcome Box -->
<div class="hero-box mb-5">
<div class="row align-items-center">

<div class="col-lg-8">
<h1 class="hero-title mb-2">
Hello, <%= user.getUsername() %> 👋
</h1>

<p class="hero-sub mb-0">
Ready to challenge yourself today? Start a quiz and improve your score.
</p>
</div>

<div class="col-lg-4 text-lg-end mt-4 mt-lg-0">
<a href="QuizServlet?action=start" class="btn btn-main px-4">
Start Quiz Now
</a>
</div>

</div>
</div>

<!-- Cards -->
<div class="row g-4">

<!-- Quiz Card -->
<div class="col-md-6">
<div class="dashboard-card text-center">

<div class="icon-box icon-primary">
<i class="bi bi-lightning-charge-fill"></i>
</div>

<h3 class="card-title-custom mb-3">Take New Quiz</h3>

<p class="card-text-custom">
Attempt a timer-based quiz with smart scoring and instant results.
</p>

<div class="d-grid">
<a href="QuizServlet?action=start" class="btn btn-main">
Start Quiz
</a>
</div>

</div>
</div>

<!-- History Card -->
<div class="col-md-6">
<div class="dashboard-card text-center">

<div class="icon-box icon-secondary">
<i class="bi bi-bar-chart-line-fill"></i>
</div>

<h3 class="card-title-custom mb-3">Your Progress</h3>

<p class="card-text-custom">
Check previous attempts, scores, and track your improvement history.
</p>

<div class="d-grid">
<a href="ResultServlet" class="btn btn-dark2">
View History
</a>
</div>

</div>
</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>