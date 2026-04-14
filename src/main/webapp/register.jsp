<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Java Quiz App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .register-container { max-width: 400px; margin-top: 100px; }
    </style>
</head>
<body>

<div class="container register-container">
    <div class="card shadow">
        <div class="card-header bg-success text-white text-center">
            <h4 class="mb-0">Create an Account</h4>
        </div>
        <div class="card-body p-4">
            
            <% 
                String error = request.getParameter("error");
                if(error != null) { 
            %>
                <div class="alert alert-danger" role="alert"><%= error %></div>
            <% } %>

            <form action="RegisterServlet" method="POST">
                <div class="mb-3">
                    <label for="username" class="form-label">Choose Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Choose Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Register Component</button>
                </div>
            </form>
            
            <div class="mt-3 text-center">
                <p class="mb-0">Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
            
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
