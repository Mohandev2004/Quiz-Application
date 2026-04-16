<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Register | QuizMaster</title>

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
    radial-gradient(circle at top right,#16a34a 0%,transparent 28%),
    radial-gradient(circle at bottom left,#22c55e 0%,transparent 28%),
    #0f172a;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:20px;
}

/* Card */
.register-box{
    width:100%;
    max-width:440px;
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.08);
    backdrop-filter:blur(18px);
    border-radius:24px;
    padding:35px;
    box-shadow:0 25px 45px rgba(0,0,0,.35);
    color:white;
}

/* Logo */
.logo-box{
    width:72px;
    height:72px;
    border-radius:22px;
    background:linear-gradient(135deg,#16a34a,#22c55e);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin:auto;
    margin-bottom:18px;
}

.title{
    font-size:1.9rem;
    font-weight:700;
}

.sub-title{
    color:#cbd5e1;
    font-size:0.95rem;
}

/* Inputs */
.form-label{
    font-weight:500;
    margin-bottom:8px;
}

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
    border-color:#4ade80;
    box-shadow:none;
}

.form-control::placeholder{
    color:#cbd5e1;
}

/* Button */
.btn-register{
    background:linear-gradient(90deg,#16a34a,#22c55e);
    border:none;
    color:white;
    border-radius:14px;
    padding:12px;
    font-weight:600;
    transition:0.3s;
}

.btn-register:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 25px rgba(34,197,94,.30);
}

/* Links */
a{
    color:#4ade80;
    text-decoration:none;
}

a:hover{
    color:#86efac;
}

.bottom-text{
    color:#cbd5e1;
}

/* Alert */
.alert{
    border:none;
    border-radius:14px;
}
</style>
</head>

<body>

<div class="register-box">

    <!-- Logo -->
    <div class="text-center mb-4">
        <div class="logo-box">
            <i class="bi bi-person-plus-fill"></i>
        </div>

        <h2 class="title mb-1">Create Account</h2>
        <p class="sub-title mb-0">Join QuizMaster and start learning today</p>
    </div>

    <% 
        String error = request.getParameter("error");
        if(error != null) { 
    %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <!-- Form -->
    <form action="RegisterServlet" method="POST">

        <div class="mb-3">
            <label class="form-label">Choose Username</label>
            <input type="text" name="username" class="form-control"
            placeholder="Enter username" required>
        </div>

        <div class="mb-4">
            <label class="form-label">Choose Password</label>
            <input type="password" name="password" class="form-control"
            placeholder="Enter password" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-register">
                <i class="bi bi-check-circle-fill me-2"></i>Create Account
            </button>
        </div>

    </form>

    <!-- Footer -->
    <div class="text-center mt-4">
        <p class="bottom-text mb-0">
            Already have an account?
            <a href="login.jsp">Login Here</a>
        </p>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>