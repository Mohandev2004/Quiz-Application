<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Java Quiz App</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .login-container { max-width: 400px; margin-top: 100px; }
        .admin-header { background-color: #343a40 !important; }
    </style>
</head>
<body>

<div class="container login-container">
    <div class="card shadow border-0">
        <div class="card-header admin-header text-white text-center py-3">
            <h4 class="mb-0">Admin Portal Login</h4>
        </div>
        <div class="card-body p-4">
            
            <% 
                String error = request.getParameter("error");
                if(error != null) { 
            %>
                <div class="alert alert-danger" role="alert"><%= error %></div>
            <% } %>

            <form action="LoginServlet" method="POST">
                <div class="mb-3">
                    <label for="username" class="form-label fw-bold">Admin Username</label>
                    <input type="text" class="form-control form-control-lg" id="username" name="username" placeholder="Enter admin username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label fw-bold">Password</label>
                    <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Enter password" required>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-dark btn-lg">Secure Login</button>
                    <a href="login.jsp" class="btn btn-link text-muted">User Login?</a>
                </div>
            </form>
            
        </div>
        <div class="card-footer text-center bg-light">
            <a href="index.jsp" class="text-decoration-none text-muted small">← Back to Homepage</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

