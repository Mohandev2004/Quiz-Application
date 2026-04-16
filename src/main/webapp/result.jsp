<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ page import="com.model.User, com.model.Result, java.util.List" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Quiz Results | QuizMaster</title>

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
    color:white;
    min-height:100vh;
}

/* Navbar */
.navbar{
    background:rgba(2,6,23,.85);
    backdrop-filter:blur(12px);
    border-bottom:1px solid rgba(255,255,255,.05);
}

/* Main Cards */
.glass-card{
    background:rgba(255,255,255,.06);
    border:1px solid rgba(255,255,255,.08);
    border-radius:24px;
    padding:30px;
    backdrop-filter:blur(16px);
    box-shadow:0 25px 45px rgba(0,0,0,.22);
}

.section-title{
    font-size:1.4rem;
    font-weight:700;
}

.sub-text{
    color:#cbd5e1;
}

/* Score Circle */
.score-circle{
    width:170px;
    height:170px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    margin:auto;
    font-size:2rem;
    font-weight:700;
    border:8px solid;
}

/* Review Cards */
.review-card{
    background:#111827;
    border-left:5px solid;
    border-radius:16px;
    padding:18px;
    margin-bottom:15px;
}

.correct{
    border-color:#22c55e;
}

.wrong{
    border-color:#ef4444;
}

/* Table */
.table{
    color:white;
}

.table thead{
    background:#111827;
}

.table tbody tr{
    border-color:rgba(255,255,255,.05);
}

.table tbody tr:hover{
    background:#172033;
}

/* Buttons */
.btn-main{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    color:white;
    border-radius:14px;
    padding:12px 24px;
    font-weight:600;
}

.btn-main:hover{
    opacity:.95;
    color:white;
}
</style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark py-3">
<div class="container">

<a class="navbar-brand fw-bold" href="#">
<i class="bi bi-mortarboard-fill me-2"></i>QuizMaster
</a>

<div class="d-flex">
<a href="dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-4 me-2">
Dashboard
</a>

<a href="LogoutServlet" class="btn btn-outline-light btn-sm rounded-pill px-4">
Logout
</a>
</div>

</div>
</nav>

<!-- Content -->
<div class="container py-5">

<div class="glass-card">

<%
Integer score = (Integer) session.getAttribute("lastScore");
Integer total = (Integer) session.getAttribute("totalQuestions");

if(score != null && total != null){

double percentage = ((double)score / total) * 100;
boolean pass = percentage >= 50;
String borderColor = pass ? "#22c55e" : "#ef4444";
%>

<!-- Result Header -->
<div class="text-center mb-5">

<h2 class="section-title mb-3">Quiz Completed 🎉</h2>

<div class="score-circle mb-3"
style="border-color:<%= borderColor %>;">
<%= score %>/<%= total %>
</div>

<h4 class="<%= pass ? "text-success" : "text-danger" %>">
You scored <%= String.format("%.1f", percentage) %>%
</h4>

<p class="sub-text">
<%= pass ? "Great job! Keep improving." : "Keep practicing. You'll improve fast." %>
</p>

</div>

<!-- Review -->
<%
String feedbackJson = (String) session.getAttribute("lastFeedback");

if(feedbackJson != null){
%>

<h4 class="section-title mb-4">Quiz Review</h4>

<div id="feedbackContainer"></div>

<script>
(function(){

const feedback = <%= feedbackJson %>;
const container = document.getElementById("feedbackContainer");

let html = "";

feedback.forEach(function(item,index){

if(!item) return;

let box = item.isCorrect ? "correct" : "wrong";
let icon = item.isCorrect ? "✅" : "❌";

html += `
<div class="review-card ${box}">
    <div class="fw-bold mb-2">${index+1}. ${item.question || 'N/A'}</div>

    <div>
        <strong>Your Answer:</strong>
        <span class="${item.isCorrect ? 'text-success' : 'text-danger'}">
        ${item.userAnswer || 'None'} ${icon}
        </span>
    </div>

    ${!item.isCorrect ?
    `<div class="mt-1 text-light">
        <strong>Correct Answer:</strong>
        <span class="text-success">${item.correctAnswer || 'N/A'}</span>
    </div>` : ''}
</div>
`;

});

container.innerHTML = html;

})();
</script>

<%
}

session.removeAttribute("lastScore");
session.removeAttribute("totalQuestions");
session.removeAttribute("lastFeedback");
}
%>

<!-- History -->
<%
List<Result> history = (List<Result>) request.getAttribute("history");

if(history != null){
%>

<div class="mt-5">

<h3 class="section-title mb-4">Your Quiz History</h3>

<% if(history.isEmpty()){ %>

<div class="alert alert-info">
You have not taken any quizzes yet.
</div>

<% } else { %>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>
<tr>
<th>Date & Time</th>
<th>Score</th>
<th>Total</th>
<th>Percentage</th>
</tr>
</thead>

<tbody>

<%
for(Result res : history){

double p = ((double)res.getScore() / res.getTotalQuestions()) * 100;

String ts = (res.getTimestamp() != null)
? res.getTimestamp().toString() : "";

if(ts.length() > 16) ts = ts.substring(0,16);
%>

<tr>
<td><%= ts.isEmpty() ? "Recent" : ts %></td>

<td class="fw-bold">
<%= res.getScore() %>
</td>

<td>
<%= res.getTotalQuestions() %>
</td>

<td class="<%= p >= 50 ? "text-success fw-bold" : "text-danger fw-bold" %>">
<%= String.format("%.1f", p) %>%
</td>
</tr>

<%
}
%>

</tbody>
</table>

</div>

<% } %>

</div>

<% } %>

<!-- Footer -->
<div class="text-center mt-5">
<a href="dashboard.jsp" class="btn btn-main">
Back to Dashboard
</a>
</div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>