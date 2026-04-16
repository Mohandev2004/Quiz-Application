<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | QuizMaster</title>

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
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
    background:
    radial-gradient(circle at top left,#2563eb 0%,transparent 30%),
    radial-gradient(circle at bottom right,#06b6d4 0%,transparent 30%),
    #0f172a;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:20px;
}

/* Login Card */
.login-box{
    width:100%;
    max-width:430px;
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.08);
    backdrop-filter:blur(18px);
    border-radius:24px;
    padding:35px;
    box-shadow:0 25px 50px rgba(0,0,0,.35);
    color:white;
}

.logo-box{
    width:70px;
    height:70px;
    border-radius:20px;
    background:linear-gradient(135deg,#2563eb,#06b6d4);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin:auto;
    margin-bottom:18px;
}

.login-title{
    font-weight:700;
    font-size:1.8rem;
}

.login-sub{
    color:#cbd5e1;
    font-size:0.95rem;
}

/* Inputs */
.form-control{
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.08);
    color:white;
    border-radius:14px;
    padding:12px 15px;
}

.form-control:focus{
    background:rgba(255,255,255,0.10);
    color:white;
    border-color:#38bdf8;
    box-shadow:none;
}

.form-control::placeholder{
    color:#cbd5e1;
}

.form-label{
    font-weight:500;
    margin-bottom:8px;
}

/* Button */
.btn-login{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    border-radius:14px;
    padding:12px;
    font-weight:600;
    color:white;
    transition:0.3s;
}

.btn-login:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 25px rgba(37,99,235,.35);
}

/* Links */
a{
    color:#38bdf8;
    text-decoration:none;
}

a:hover{
    color:#7dd3fc;
}

.bottom-text{
    color:#cbd5e1;
}

/* Alerts */
.alert{
    border:none;
    border-radius:14px;
    font-size:0.95rem;
}
</style>
</head>

<body>

<div class="login-box">

    <!-- Logo -->
    <div class="text-center mb-4">
        <div class="logo-box">
            <i class="bi bi-mortarboard-fill"></i>
        </div>
        <h2 class="login-title mb-1">Welcome Back</h2>
        <p class="login-sub mb-0">Login to continue your quiz journey</p>
    </div>

    <% 
        String error = request.getParameter("error");
        if(error != null) { 
    %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <% 
        String msg = request.getParameter("msg");
        if(msg != null) { 
    %>
        <div class="alert alert-success text-center"><%= msg %></div>
    <% } %>

    <!-- Login Form -->
    <form action="LoginServlet" method="POST">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control"
            placeholder="Enter your username" required>
        </div>

        <div class="mb-4">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control"
            placeholder="Enter your password" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-login">
                <i class="bi bi-box-arrow-in-right me-2"></i>Login
            </button>
        </div>

    </form>

    <!-- Footer Links -->
    <div class="text-center mt-4">
        <p class="bottom-text mb-2">
            Don't have an account?
            <a href="register.jsp">Create Account</a>
        </p>

        <p class="mb-0 small">
            <a href="adminLogin.jsp">Admin Login</a>
        </p>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>