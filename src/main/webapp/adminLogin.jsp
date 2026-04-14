<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - QuizMaster</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="flex-center admin-bg">
    <div class="card auth-card glass-panel admin-panel">
        <h2>Admin Authentication</h2>
        <p class="subtitle text-muted">Restricted access area.</p>

        <% 
            String error = request.getParameter("error");
            if(error != null) { 
        %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="AuthServlet" method="POST" class="auth-form">
            <input type="hidden" name="action" value="login">
            <input type="hidden" name="role" value="ADMIN">
            
            <div class="form-group">
                <label for="username">Admin Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Admin Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn btn-primary btn-block mt-2">Secure Login</button>
        </form>
        
        <div class="auth-footer mt-2">
            <p class="mt-1"><a href="index.jsp" class="text-muted">← Back to Main Home</a></p>
        </div>
    </div>
</body>
</html>
