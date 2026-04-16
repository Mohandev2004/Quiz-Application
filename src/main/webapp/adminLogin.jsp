<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Login | QuizMaster</title>

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
    radial-gradient(circle at top left,#334155 0%,transparent 28%),
    radial-gradient(circle at bottom right,#111827 0%,transparent 28%),
    #020617;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:20px;
}

/* Card */
.admin-box{
    width:100%;
    max-width:440px;
    background:rgba(255,255,255,0.07);
    border:1px solid rgba(255,255,255,0.08);
    backdrop-filter:blur(18px);
    border-radius:24px;
    padding:35px;
    box-shadow:0 25px 45px rgba(0,0,0,.45);
    color:white;
}

/* Logo */
.logo-box{
    width:72px;
    height:72px;
    border-radius:22px;
    background:linear-gradient(135deg,#111827,#334155);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:30px;
    margin:auto;
    margin-bottom:18px;
    border:1px solid rgba(255,255,255,0.08);
}

.title{
    font-size:1.9rem;
    font-weight:700;
}

.sub-title{
    color:#cbd5e1;
    font-size:0.95rem;
}

/* Input */
.form-label{
    font-weight:600;
    margin-bottom:8px;
}

.form-control{
    background:rgba(255,255,255,0.06);
    border:1px solid rgba(255,255,255,0.08);
    color:white;
    border-radius:14px;
    padding:12px 15px;
}

.form-control:focus{
    background:rgba(255,255,255,0.09);
    color:white;
    border-color:#94a3b8;
    box-shadow:none;
}

.form-control::placeholder{
    color:#cbd5e1;
}

/* Buttons */
.btn-admin{
    background:linear-gradient(90deg,#111827,#334155);
    border:none;
    color:white;
    border-radius:14px;
    padding:12px;
    font-weight:600;
    transition:0.3s;
}

.btn-admin:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 25px rgba(0,0,0,.35);
}

.btn-user{
    border:1px solid rgba(255,255,255,0.10);
    color:#cbd5e1;
    border-radius:14px;
    padding:11px;
    text-decoration:none;
    display:block;
    transition:0.3s;
}

.btn-user:hover{
    background:rgba(255,255,255,0.06);
    color:white;
}

/* Links */
a{
    text-decoration:none;
}

.back-link{
    color:#94a3b8;
    font-size:0.92rem;
}

.back-link:hover{
    color:white;
}

/* Alert */
.alert{
    border:none;
    border-radius:14px;
}
</style>
</head>

<body>

<div class="admin-box">

    <!-- Header -->
    <div class="text-center mb-4">
        <div class="logo-box">
            <i class="bi bi-shield-lock-fill"></i>
        </div>

        <h2 class="title mb-1">Admin Portal</h2>
        <p class="sub-title mb-0">Secure login for authorized administrators</p>
    </div>

    <% 
        String error = request.getParameter("error");
        if(error != null) { 
    %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <!-- Form -->
    <form action="LoginServlet" method="POST">

        <div class="mb-3">
            <label class="form-label">Admin Username</label>
            <input type="text" name="username" class="form-control"
            placeholder="Enter admin username" required>
        </div>

        <div class="mb-4">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control"
            placeholder="Enter password" required>
        </div>

        <div class="d-grid gap-3">
            <button type="submit" class="btn btn-admin">
                <i class="bi bi-shield-check me-2"></i>Secure Login
            </button>

            <a href="login.jsp" class="btn-user text-center">
                <i class="bi bi-person-circle me-2"></i>User Login
            </a>
        </div>

    </form>

    <!-- Footer -->
    <div class="text-center mt-4">
        <a href="index.jsp" class="back-link">
            <i class="bi bi-arrow-left me-1"></i>Back to Homepage
        </a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>