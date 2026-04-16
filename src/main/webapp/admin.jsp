<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.User, com.model.Question, java.util.List" %>

<%
User user = (User) session.getAttribute("user");

if(user == null || session.getAttribute("isAdmin") == null || !(boolean)session.getAttribute("isAdmin")){
    response.sendRedirect("login.jsp");
    return;
}

Question editQ = (Question) request.getAttribute("question");
boolean isEdit = (editQ != null);

List<Question> list = (List<Question>) request.getAttribute("questions");
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Panel | QuizMaster</title>

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
    background:#0f172a;
    color:white;
}

/* Navbar */
.navbar{
    background:#020617;
    border-bottom:1px solid rgba(255,255,255,0.06);
}

.navbar-brand{
    font-weight:700;
    font-size:1.3rem;
}

/* Cards */
.panel-card{
    background:#111827;
    border:1px solid rgba(255,255,255,0.06);
    border-radius:20px;
    box-shadow:0 20px 35px rgba(0,0,0,.25);
}

.card-header-custom{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border-radius:20px 20px 0 0;
    padding:18px 22px;
    font-weight:700;
}

.card-header-dark{
    background:#020617;
    border-radius:20px 20px 0 0;
    padding:18px 22px;
    font-weight:700;
}

/* Inputs */
.form-control, .form-select, textarea{
    background:#1e293b !important;
    border:1px solid rgba(255,255,255,0.08);
    color:white !important;
    border-radius:12px;
}

.form-control:focus, textarea:focus{
    border-color:#38bdf8;
    box-shadow:none;
}

.form-label{
    font-weight:600;
    margin-bottom:8px;
}

/* Buttons */
.btn-main{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    color:white;
    border-radius:12px;
    font-weight:600;
}

.btn-main:hover{
    opacity:.95;
}

.btn-cancel{
    border-radius:12px;
}

/* Table */
.table{
    color:white;
}

.table thead{
    background:#1e293b;
}

.table tbody tr{
    border-color:rgba(255,255,255,0.04);
}

.table tbody tr:hover{
    background:#172033;
}

.badge-answer{
    background:#16a34a;
    padding:7px 12px;
    border-radius:10px;
}

.action-btn{
    border-radius:10px;
}

.small-note{
    color:#94a3b8;
    font-size:0.85rem;
}
</style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark py-3">
<div class="container-fluid px-4">
<a class="navbar-brand" href="#">
<i class="bi bi-shield-lock-fill me-2"></i>Admin Control Panel
</a>

<a href="LogoutServlet" class="btn btn-outline-light btn-sm rounded-pill px-4">
Logout
</a>
</div>
</nav>

<!-- Main -->
<div class="container-fluid px-4 py-4">

<div class="row g-4">

<!-- Left Form -->
<div class="col-lg-4">

<div class="panel-card">

<div class="card-header-custom">
<i class="bi bi-pencil-square me-2"></i>
<%= isEdit ? "Edit Question" : "Add New Question" %>
</div>

<div class="p-4">

<form action="AdminServlet" method="POST">

<input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">

<% if(isEdit){ %>
<input type="hidden" name="id" value="<%= editQ.getId() %>">
<% } %>

<div class="mb-3">
<label class="form-label">Question Text</label>
<textarea name="question" rows="3" class="form-control" required><%= isEdit ? editQ.getQuestion() : "" %></textarea>
</div>

<div class="row">
<div class="col-md-6 mb-3">
<label class="form-label">Option 1</label>
<input type="text" name="option1" class="form-control"
value="<%= isEdit ? editQ.getOption1() : "" %>" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Option 2</label>
<input type="text" name="option2" class="form-control"
value="<%= isEdit ? editQ.getOption2() : "" %>" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Option 3</label>
<input type="text" name="option3" class="form-control"
value="<%= isEdit ? editQ.getOption3() : "" %>" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Option 4</label>
<input type="text" name="option4" class="form-control"
value="<%= isEdit ? editQ.getOption4() : "" %>" required>
</div>
</div>

<div class="mb-3">
<label class="form-label">Correct Answer</label>
<input type="text" name="correctAnswer" class="form-control"
value="<%= isEdit ? editQ.getCorrectAnswer() : "" %>"
placeholder="Exact text of correct option" required>

<div class="small-note mt-2">
Must exactly match one of the option values.
</div>
</div>

<div class="d-grid gap-2">
<button type="submit" class="btn btn-main">
<%= isEdit ? "Update Question" : "Save Question" %>
</button>

<% if(isEdit){ %>
<a href="AdminServlet?action=list"
class="btn btn-outline-light btn-cancel">
Cancel
</a>
<% } %>
</div>

</form>

</div>
</div>
</div>

<!-- Right Table -->
<div class="col-lg-8">

<div class="panel-card">

<div class="card-header-dark">
<i class="bi bi-journal-text me-2"></i>Current Question Bank
</div>

<div class="table-responsive">

<table class="table table-hover align-middle mb-0">

<thead>
<tr>
<th>ID</th>
<th style="width:45%">Question</th>
<th>Correct Answer</th>
<th class="text-end">Actions</th>
</tr>
</thead>

<tbody>

<%
if(list != null && !list.isEmpty()){
for(Question q : list){
%>

<tr>
<td><%= q.getId() %></td>

<td><%= q.getQuestion() %></td>

<td>
<span class="badge badge-answer">
<%= q.getCorrectAnswer() %>
</span>
</td>

<td class="text-end text-nowrap">

<a href="AdminServlet?action=edit&id=<%= q.getId() %>"
class="btn btn-sm btn-outline-info action-btn">
Edit
</a>

<a href="AdminServlet?action=delete&id=<%= q.getId() %>"
class="btn btn-sm btn-outline-danger action-btn"
onclick="return confirm('Delete this question?');">
Delete
</a>

</td>
</tr>

<%
}
}else{
%>

<tr>
<td colspan="4" class="text-center py-5 text-secondary">
No questions available. Add your first question now.
</td>
</tr>

<%
}
%>

</tbody>

</table>

</div>
</div>

</div>

</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>