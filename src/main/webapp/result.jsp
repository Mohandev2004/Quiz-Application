<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<%@ page import="com.model.User, com.model.Result, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Results - Java Quiz App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">Quiz Application</a>
        <div class="d-flex">
            <a href="dashboard.jsp" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
            <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow">
                <div class="card-body p-4 text-center">
                    
                    <% 
                        // Immediate Result 
                        Integer score = (Integer) session.getAttribute("lastScore");
                        Integer total = (Integer) session.getAttribute("totalQuestions");
                        
                        if (score != null && total != null) {
                            double percentage = ((double) score / total) * 100;
                            String alertClass = percentage >= 50 ? "text-success border-success" : "text-danger border-danger";
                    %>
                        <h2 class="mb-4">Quiz Completed!</h2>
                        <div class="d-inline-flex justify-content-center align-items-center rounded-circle border border-5 <%= alertClass %> mb-3" style="width: 150px; height: 150px;">
                            <h3 class="mb-0"><%= score %> / <%= total %></h3>
                        </div>
                        <h4 class="mb-5">You scored <%= String.format("%.1f", percentage) %>%</h4>
                        
                        <!-- Detailed Feedback -->
                        <% 
                            String feedbackJson = (String) session.getAttribute("lastFeedback");
                            if (feedbackJson != null) {
                        %>
                            <div class="text-start mt-4 mb-5">
                                <h5 class="border-bottom pb-2 mb-3">Quiz Review</h5>
                                <div id="feedbackContainer">
                                    <!-- This will be parsed by JS to handle the JSON string safely -->
                                </div>
                                <script>
                                    (function() {
                                        // Pass the JSON string to JS. 
                                        // Note: Use string concatenation to avoid JSP EL conflict with ${}
                                        const feedback = <%= feedbackJson %>;
                                        const container = document.getElementById('feedbackContainer');
                                        let html = '';
                                        feedback.forEach(function(item, index) {
                                            if (!item) return;
                                            var borderClass = item.isCorrect ? 'border-success' : 'border-danger';
                                            var bgClass = item.isCorrect ? 'bg-success-subtle' : 'bg-danger-subtle';
                                            var icon = item.isCorrect ? '✅' : '❌';
                                            
                                            html += '<div class="card mb-3 ' + borderClass + ' ' + bgClass + ' border-start border-4">' +
                                                    '<div class="card-body">' +
                                                        '<p class="fw-bold mb-1">' + (index + 1) + '. ' + (item.question || 'N/A') + '</p>' +
                                                        '<div class="ps-3 mt-2">' +
                                                            '<div class="mb-1"><strong>Your Answer:</strong> <span class="' + (item.isCorrect ? 'text-success' : 'text-danger') + '">' + (item.userAnswer || 'None') + ' ' + icon + '</span></div>' +
                                                            (!item.isCorrect ? '<div class="text-muted"><strong>Correct Answer:</strong> <span class="text-success text-decoration-underline">' + (item.correctAnswer || 'N/A') + '</span></div>' : '') +
                                                        '</div>' +
                                                    '</div>' +
                                                '</div>';
                                        });
                                        container.innerHTML = html;
                                    })();
                                </script>
                            </div>
                        <% } %>
                        
                        <% 
                            // Clear session attributes to only show once
                            session.removeAttribute("lastScore");
                            session.removeAttribute("totalQuestions");
                            session.removeAttribute("lastFeedback");
                        %>
                    <% } %>

                    <% 
                        // Historical Results
                        List<Result> history = (List<Result>) request.getAttribute("history");
                        if (history != null) {
                    %>
                        <h3 class="mt-4 border-bottom pb-2 text-start">Your Quiz History</h3>
                        
                        <% if(history.isEmpty()) { %>
                            <div class="alert alert-info text-start">You have not taken any quizzes yet.</div>
                        <% } else { %>
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered table-striped text-start">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Date & Time</th>
                                            <th>Score</th>
                                            <th>Total Questions</th>
                                            <th>Percentage</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Result res : history) { 
                                            double p = ((double) res.getScore() / res.getTotalQuestions()) * 100;
                                            String ts = (res.getTimestamp() != null) ? res.getTimestamp().toString() : "";
                                            if (ts.length() > 16) ts = ts.substring(0, 16);
                                        %>
                                        <tr>
                                            <td><%= ts.isEmpty() ? "Recent" : ts %></td>
                                            <td class="fw-bold"><%= res.getScore() %></td>
                                            <td><%= res.getTotalQuestions() %></td>
                                            <td class="<%= p >= 50 ? "text-success fw-bold" : "text-danger fw-bold" %>">
                                                <%= String.format("%.1f", p) %>%
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    <% } %>
                    
                    <div class="mt-4">
                        <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>