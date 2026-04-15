<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.model.User" %>
        <% User user=(User) session.getAttribute("user"); if(user==null || session.getAttribute("isAdmin")==null ||
            (boolean)session.getAttribute("isAdmin")) { response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - Java Quiz App</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="bg-light">

                <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                    <div class="container">
                        <a class="navbar-brand" href="#">Quiz Application</a>
                        <div class="d-flex">
                            <span class="navbar-text text-white me-3">
                                Welcome, <%= user.getUsername() %>!
                            </span>
                            <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container mt-5">
                    <div class="row">

                        <div class="col-md-6 mb-4">
                            <div class="card h-100 shadow-sm">
                                <div class="card-body text-center d-flex flex-column justify-content-center py-5">
                                    <h3 class="card-title mb-3">Take a New Quiz</h3>
                                    <p class="text-muted mb-4">Test your knowledge with our dynamic timer-based quiz.
                                        Your progress will be saved automatically.</p>
                                    <a href="QuizServlet?action=start" class="btn btn-primary btn-lg mx-auto w-50">Start
                                        Quiz</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 mb-4">
                            <div class="card h-100 shadow-sm">
                                <div class="card-body text-center d-flex flex-column justify-content-center py-5">
                                    <h3 class="card-title mb-3">Your Progress</h3>
                                    <p class="text-muted mb-4">Review your previous quiz attempts, check your scores,
                                        and see how much you've improved.</p>
                                    <a href="ResultServlet" class="btn btn-secondary btn-lg mx-auto w-50">View
                                        History</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>